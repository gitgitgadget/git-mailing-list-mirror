From: Jay Soffian <jaysoffian@gmail.com>
Subject: [RFC/PATCH] rev-list: new --cherry-pick=loose option
Date: Mon, 21 Feb 2011 14:49:29 -0500
Message-ID: <1298317769-65830-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 21 20:49:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrblW-0003pL-9n
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 20:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608Ab1BUTtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 14:49:45 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57685 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab1BUTto (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 14:49:44 -0500
Received: by qwd7 with SMTP id 7so2302261qwd.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 11:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=HB3Zq7fV1VYifLKzX4ZH49kHIOQ83nK8m4nDwn1Q3hU=;
        b=edcuWpqQO522UTzTr+rs+nqkNtG/e0EW3itgAZdu1vPWr0Tuag39TlMS/KYdtxLFMx
         0oSjhXJTVMtzOUwHDmHtgFjtzDW8ojBDhnTR7Y/1GZ5JVMoldiwktxmPzpnaog70nzLR
         NPyXnyNX0CZ6X3vepvClcJ5v9+mj+YllnfPIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Bmmb1SokhaqPa9wjCShm0C+sY77oXXArTgenPqrL8x+LVOk/hV8slcNm1pafxSojNU
         fsrTxD5HXTPwfwgdflqa2j9N7VggpuVDRGMIZjPJJmxBa2tIpmNyy8EQU6cd6ErqI8A6
         ZRn5bbumIihjm6yZ002Ogusjo4wA+r2itZvnI=
Received: by 10.224.2.208 with SMTP id 16mr1460944qak.315.1298317783556;
        Mon, 21 Feb 2011 11:49:43 -0800 (PST)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id g32sm3985400qck.10.2011.02.21.11.49.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 11:49:38 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.51.g2cc0c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167502>

rev-list --cherry-pick may be used in combination with the
symmetric difference operator (A...B) to squelch showing commits
which are identical in content.

Sometimes this is too strict of a test, for example if the
cherry-picked commits required conflict resolution, altering
their patch-ids. However, it is still useful to be able to squelch
such commits as they need not be cherry-picked again.

Using --cherry-pick=loose tells git to ignore the patch content
and instead examine its metadata. Specifically, commits with
identical authorship (name and timestamp) and subject are not
shown in the output.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---

This is a bit of a hack just to stimulate conversation. My use
case for this is that I'm cherry-picking commits from a release branch
onto a development branch. (I cannot use a different branching strategy
that would allow me to merge instead.) Sometimes those cherry-picks require
conflict resolution. The current --cherry-pick behavior requires that I
maintain (externally to git) a list of commits which have already been
cherry-picked.

So I started experimenting with a wrapper around rev-list A...B that
looks at commit metadata to determine what's been cherry-picked and
what not, and it works quite well for me.

The functionality in this patch would let me get rid of that wrapper.

Thoughts?

 patch-ids.c |   23 +++++++++++++++++++++--
 patch-ids.h |    2 +-
 revision.c  |    9 +++++++++
 revision.h  |    1 +
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/patch-ids.c b/patch-ids.c
index 5717257..6a1f3e3 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -16,6 +16,20 @@ static int commit_patch_id(struct commit *commit, struct diff_options *options,
 	return diff_flush_patch_id(options, sha1);
 }
 
+static int commit_patch_id_loose(struct commit *commit, unsigned char *sha1)
+{
+	git_SHA_CTX ctx;
+	struct strbuf buf = STRBUF_INIT;
+	struct pretty_print_context pctx = {0};
+
+	git_SHA1_Init(&ctx);
+	format_commit_message(commit, "%an %ae %at %s", &buf, &pctx);
+	git_SHA1_Update(&ctx, buf.buf, buf.len);
+	strbuf_release(&buf);
+	git_SHA1_Final(sha1, &ctx);
+	return 0;
+}
+
 static const unsigned char *patch_id_access(size_t index, void *table)
 {
 	struct patch_id **id_table = table;
@@ -65,8 +79,13 @@ static struct patch_id *add_commit(struct commit *commit,
 	unsigned char sha1[20];
 	int pos;
 
-	if (commit_patch_id(commit, &ids->diffopts, sha1))
-		return NULL;
+	if (ids->loose) {
+		if (commit_patch_id_loose(commit, sha1))
+			return NULL;
+	} else {
+		if (commit_patch_id(commit, &ids->diffopts, sha1))
+			return NULL;
+	}
 	pos = patch_pos(ids->table, ids->nr, sha1);
 	if (0 <= pos)
 		return ids->table[pos];
diff --git a/patch-ids.h b/patch-ids.h
index c8c7ca1..f54b0ee 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -8,7 +8,7 @@ struct patch_id {
 
 struct patch_ids {
 	struct diff_options diffopts;
-	int nr, alloc;
+	int nr, alloc, loose;
 	struct patch_id **table;
 	struct patch_id_bucket *patches;
 };
diff --git a/revision.c b/revision.c
index 7b9eaef..6dbbf5d 100644
--- a/revision.c
+++ b/revision.c
@@ -558,6 +558,8 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 		ids.diffopts.paths = revs->diffopt.paths;
 		ids.diffopts.pathlens = revs->diffopt.pathlens;
 	}
+	if (revs->cherry_pick_loose)
+		ids.loose = 1;
 
 	/* Compute patch-ids for one side */
 	for (p = list; p; p = p->next) {
@@ -1268,6 +1270,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--cherry-pick")) {
 		revs->cherry_pick = 1;
 		revs->limited = 1;
+	} else if (!prefixcmp(arg, "--cherry-pick=")) {
+		revs->cherry_pick = 1;
+		revs->limited = 1;
+		if (!strcmp(arg+14, "loose"))
+			revs->cherry_pick_loose = 1;
+		else if (strcmp(arg+14, "strict"))
+			return error("bad --cherry-pick argument");
 	} else if (!strcmp(arg, "--objects")) {
 		revs->tag_objects = 1;
 		revs->tree_objects = 1;
diff --git a/revision.h b/revision.h
index 05659c6..3f94b27 100644
--- a/revision.h
+++ b/revision.h
@@ -66,6 +66,7 @@ struct rev_info {
 			reverse:1,
 			reverse_output_stage:1,
 			cherry_pick:1,
+			cherry_pick_loose:1,
 			bisect:1,
 			ancestry_path:1,
 			first_parent_only:1;
-- 
1.7.4.1.51.g2cc0c.dirty
