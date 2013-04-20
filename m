From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 3/8] checkout: Use remote refspecs when DWIMming tracking branches
Date: Sat, 20 Apr 2013 17:05:58 +0200
Message-ID: <1366470363-22309-4-git-send-email-johan@herland.net>
References: <1366470363-22309-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 20 17:06:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTZN5-0008WS-LS
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 17:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394Ab3DTPGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 11:06:30 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:47868 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302Ab3DTPG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 11:06:29 -0400
Received: by mail-lb0-f174.google.com with SMTP id s10so4535464lbi.33
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 08:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=CeLTPCpH7+6QJDXL5XrSn3oOHnuwOIZ/WOKwTWF1vuY=;
        b=gen8RUNFOg5fSPn/oeCuuC7daRUSGFUv1T6yFfjXBtOBN9Xm78Fi70jc8Gbc8At5jh
         SrmBYhjg0gOL/S0ISl++Sm+S3EeRZfideLlWBVp5EQYDV0pJ8qHJIQeR/3eGrXJM6MTx
         HxM7UZ9yINOmQ8t0h2hRnprzsHWga6p/8vleUNHMWDhfDFjJ+gn2GeAjI6fWiJ0BhJDR
         hrE6QYVrrRVnr5RMihpZpAHnRxCBGax+cfbvHjNVtbbJjbsWv7NqPnaqzST2mWx8NcYO
         lzDDwwOmRPJx8/1ADKcehcQot0itbb1olKe9Z8JPYzwptZjY0J5edN+0ezFkvNQ4YTcu
         iWPg==
X-Received: by 10.112.59.103 with SMTP id y7mr9949193lbq.16.1366470387434;
        Sat, 20 Apr 2013 08:06:27 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id sl5sm7539983lbb.10.2013.04.20.08.06.23
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 08:06:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366470363-22309-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221861>

The DWIM mode of checkout allows you to run "git checkout foo" when there
is no existing local ref or path called "foo", and there is exactly _one_
remote with a remote-tracking branch called "foo". Git will automatically
create a new local branch called "foo" using the remote-tracking "foo" as
its starting point and configured upstream.

For example, consider the following unconventional (but perfectly valid)
remote setup:

	[remote "origin"]
		fetch = refs/heads/*:refs/remotes/origin/*
	[remote "frotz"]
		fetch = refs/heads/*:refs/remotes/frotz/nitfol/*

Case 1: Assume both "origin" and "frotz" have remote-tracking branches called
"foo", at "refs/remotes/origin/foo" and "refs/remotes/frotz/nitfol/foo"
respectively. In this case "git checkout foo" should fail, because there is
more than one remote with a "foo" branch.

Case 2: Assume only "frotz" have a remote-tracking branch called "foo". In
this case "git checkout foo" should succeed, and create a local branch "foo"
from "refs/remotes/frotz/nitfol/foo", using remote branch "foo" from "frotz"
as its upstream.

The current code hardcodes the assumption that all remote-tracking branches
must match the "refs/remotes/$remote/*" pattern (which is true for remotes
with "conventional" refspecs, but not true for the "frotz" remote above).
When running "git checkout foo", the current code looks for exactly one ref
matching "refs/remotes/*/foo", hence in the above example, it fails to find
"refs/remotes/frotz/nitfol/foo", which causes it to fail both case #1 and #2.

The better way to handle the above example is to actually study the fetch
refspecs to deduce the candidate remote-tracking branches for "foo"; i.e.
assume "foo" is a remote branch being fetched, and then map "refs/heads/foo"
through the refspecs in order to get the corresponding remote-tracking
branches "refs/remotes/origin/foo" and "refs/remotes/frotz/nitfol/foo".
Finally we check which of these happens to exist in the local repo, and
if there is exactly one, we have an unambiguous match for "git checkout foo",
and may proceed.

This fixes most of the failing tests introduced in the previous patch.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-checkout.txt |  6 +++---
 builtin/checkout.c             | 42 ++++++++++++++++++++++--------------------
 t/t2024-checkout-dwim.sh       |  6 +++---
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 8edcdca..bf0c99c 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -131,9 +131,9 @@ entries; instead, unmerged entries are ignored.
 	"--track" in linkgit:git-branch[1] for details.
 +
 If no '-b' option is given, the name of the new branch will be
-derived from the remote-tracking branch.  If "remotes/" or "refs/remotes/"
-is prefixed it is stripped away, and then the part up to the
-next slash (which would be the nickname of the remote) is removed.
+derived from the remote-tracking branch, by looking at the local part of
+the refspec configured for the corresponding remote, and then stripping
+the initial part up to the "*".
 This would tell us to use "hack" as the local branch when branching
 off of "origin/hack" (or "remotes/origin/hack", or even
 "refs/remotes/origin/hack").  If the given name has no slash, or the above
diff --git a/builtin/checkout.c b/builtin/checkout.c
index eb51872..bcb18c8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -822,38 +822,40 @@ static int git_checkout_config(const char *var, const char *value, void *cb)
 }
 
 struct tracking_name_data {
-	const char *name;
-	char *remote;
+	/* const */ char *src_ref;
+	char *dst_ref;
+	unsigned char *dst_sha1;
 	int unique;
 };
 
-static int check_tracking_name(const char *refname, const unsigned char *sha1,
-			       int flags, void *cb_data)
+static int check_tracking_name(struct remote *remote, void *cb_data)
 {
 	struct tracking_name_data *cb = cb_data;
-	const char *slash;
-
-	if (prefixcmp(refname, "refs/remotes/"))
-		return 0;
-	slash = strchr(refname + 13, '/');
-	if (!slash || strcmp(slash + 1, cb->name))
+	struct refspec query;
+	memset(&query, 0, sizeof(struct refspec));
+	query.src = cb->src_ref;
+	if (remote_find_tracking(remote, &query) ||
+	    get_sha1(query.dst, cb->dst_sha1))
 		return 0;
-	if (cb->remote) {
+	if (cb->dst_ref) {
 		cb->unique = 0;
 		return 0;
 	}
-	cb->remote = xstrdup(refname);
+	cb->dst_ref = xstrdup(query.dst);
 	return 0;
 }
 
-static const char *unique_tracking_name(const char *name)
+static const char *unique_tracking_name(const char *name, unsigned char *sha1)
 {
-	struct tracking_name_data cb_data = { NULL, NULL, 1 };
-	cb_data.name = name;
-	for_each_ref(check_tracking_name, &cb_data);
+	struct tracking_name_data cb_data = { NULL, NULL, NULL, 1 };
+	char src_ref[PATH_MAX];
+	snprintf(src_ref, PATH_MAX, "refs/heads/%s", name);
+	cb_data.src_ref = src_ref;
+	cb_data.dst_sha1 = sha1;
+	for_each_remote(check_tracking_name, &cb_data);
 	if (cb_data.unique)
-		return cb_data.remote;
-	free(cb_data.remote);
+		return cb_data.dst_ref;
+	free(cb_data.dst_ref);
 	return NULL;
 }
 
@@ -916,8 +918,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 		if (dwim_new_local_branch_ok &&
 		    !check_filename(NULL, arg) &&
 		    argc == 1) {
-			const char *remote = unique_tracking_name(arg);
-			if (!remote || get_sha1(remote, rev))
+			const char *remote = unique_tracking_name(arg, rev);
+			if (!remote)
 				return argcount;
 			*new_branch = arg;
 			arg = remote;
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 36bf52f..fc6edc9 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -95,15 +95,15 @@ test_expect_success 'setup more remotes with unconventional refspecs' '
 	git fetch repo_d
 '
 
-test_expect_failure 'checkout of branch from multiple remotes fails #2' '
+test_expect_success 'checkout of branch from multiple remotes fails #2' '
 	test_must_fail git checkout bar
 '
 
-test_expect_failure 'checkout of branch from multiple remotes fails #3' '
+test_expect_success 'checkout of branch from multiple remotes fails #3' '
 	test_must_fail git checkout baz
 '
 
-test_expect_failure 'checkout of branch from a single remote succeeds #3' '
+test_expect_success 'checkout of branch from a single remote succeeds #3' '
 	git checkout spam &&
 	test_tracking_branch spam repo_c refs/remotes/extra_dir/repo_c/extra_dir/spam
 '
-- 
1.8.1.3.704.g33f7d4f
