From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH/RFC] builtin-checkout: suggest creating local branch when appropriate to do so
Date: Mon,  5 Oct 2009 16:46:23 -0400
Message-ID: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 22:57:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muucp-0006iX-Hy
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 22:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761AbZJEUw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 16:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753554AbZJEUw1
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 16:52:27 -0400
Received: from mail-qy0-f173.google.com ([209.85.221.173]:55932 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315AbZJEUw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 16:52:26 -0400
Received: by qyk3 with SMTP id 3so2891975qyk.4
        for <git@vger.kernel.org>; Mon, 05 Oct 2009 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=casqOcmpB5pX7JY0dWl3ZWcO+dzxcgoH8HPtGWYq11M=;
        b=ugEUyjKVvF4SL8NZWy9QYtfjLLuPLwpsIcJ6WZdJhumMsZkgLonqfzVW/x0anTggyn
         a2uxPn8bUd4JVTq6S2VcDtUlltJJxUn8iGAE7cs49TBpENshd2of2PBe4aavHNF8ceSN
         jXSQuUZd2oFUfuHYs1ORIjLHEycX1M3MCimko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ICirEWq5UK5HjBM1n9hIcatb5Qj4DpJXJ4zG0sTwtQVeDUzAiBaqJta+eVNDFlATJn
         nDq9PrU5154KnC2aB9+8wQsdjBdWR9iczoyy+AFGixKCMABGyvaKDLtwSkGRlstTXlSl
         8kedakrOOH8qyYpC3x/gZyOCG+D3f6FdJDPSw=
Received: by 10.224.16.131 with SMTP id o3mr652725qaa.18.1254775586504;
        Mon, 05 Oct 2009 13:46:26 -0700 (PDT)
Received: from localhost (cpe-069-134-096-008.nc.res.rr.com [69.134.96.8])
        by mx.google.com with ESMTPS id 4sm24920qwe.38.2009.10.05.13.46.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Oct 2009 13:46:25 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129587>

A user who has just cloned a remote repository and wishes to then work on a
branch other than master may not realize they first need to create the local
branch. e.g.:

$ git clone git://git.kernel.org/pub/scm/git/git.git
$ cd git
$ git checkout next
error: pathspec 'next' did not match any file(s) known to git.

This commit teaches git to make a suggestion to the user:

$ git clone git://git.kernel.org/pub/scm/git/git.git
$ cd git
$ git checkout next
error: pathspec 'next' did not match any file(s) known to git.
To create a local branch from the same named remote branch, use
  git checkout -b next origin/next

Motivated by http://article.gmane.org/gmane.comp.version-control.git/129528

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-checkout.c |   43 +++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 41 insertions(+), 2 deletions(-)

I dunno, this seems like a lot of code just to make a suggestion to the
user. Is it worth it?

Also, I initially was going to use for_each_remote_ref and compare every
remote ref name to see if it tail matched what the user gave us, but it was
easier to use for_each_remote and build up the remote ref name and then check
for its existence. Not sure if either approach is preferable.

Thoughts/comments?

diff --git a/builtin-checkout.c b/builtin-checkout.c
index d050c37..7f2e215 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -145,6 +145,38 @@ static void fill_mm(const unsigned char *sha1, mmfile_t *mm)
 	mm->size = size;
 }
 
+struct suggest_new_branch_name_data {
+	const char *name, *found;
+	int matches;
+};
+
+static int suggest_new_branch_name_compare(struct remote *remote, void *priv)
+{
+	struct suggest_new_branch_name_data *data = priv;
+	unsigned char sha1[20];
+	struct strbuf buf = STRBUF_INIT;
+	strbuf_addf(&buf, "refs/remotes/%s/%s", remote->name, data->name);
+	if (resolve_ref(buf.buf, sha1, 1, NULL)) {
+		data->matches++;
+		if (data->found)
+			strbuf_release(&buf);
+		else
+			data->found = strbuf_detach(&buf, NULL);
+	}
+	return 0;
+}
+
+static void suggest_new_branch_name(const char *name)
+{
+	struct suggest_new_branch_name_data data;
+	data.name = name;
+	data.found = NULL;
+	data.matches = 0;
+	for_each_remote(suggest_new_branch_name_compare, &data);
+	if (data.matches == 1)
+		fprintf(stderr, "To create a local branch from the same named remote branch, use\n  git checkout -b %s %s\n", name, prettify_refname(data.found));
+}
+
 static int checkout_merged(int pos, struct checkout *state)
 {
 	struct cache_entry *ce = active_cache[pos];
@@ -231,8 +263,13 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, ps_matched);
 	}
 
-	if (report_path_error(ps_matched, pathspec, 0))
+	if (report_path_error(ps_matched, pathspec, 0)) {
+		for (pos = 0; pathspec[pos]; pos++)
+			;
+		if (pos == 1)
+			suggest_new_branch_name(pathspec[0]);
 		return 1;
+	}
 
 	/* Any unmerged paths? */
 	for (pos = 0; pos < active_nr; pos++) {
@@ -675,8 +712,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			arg = "@{-1}";
 
 		if (get_sha1(arg, rev)) {
-			if (has_dash_dash)          /* case (1) */
+			if (has_dash_dash) {         /* case (1) */
+				suggest_new_branch_name(arg);
 				die("invalid reference: %s", arg);
+			}
 			goto no_reference;          /* case (3 -> 2) */
 		}
 
-- 
1.6.4.2
