From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [RFC/PATCH 1/2] reset: learn to reset to tree
Date: Thu, 29 Nov 2012 10:32:54 -0800
Message-ID: <1354213975-17866-2-git-send-email-martinvonz@gmail.com>
References: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
 <1354213975-17866-1-git-send-email-martinvonz@gmail.com>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 19:33:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te8vO-0008Nm-6a
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 19:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392Ab2K2SdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 13:33:09 -0500
Received: from mail-vc0-f202.google.com ([209.85.220.202]:54204 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902Ab2K2SdI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 13:33:08 -0500
Received: by mail-vc0-f202.google.com with SMTP id m8so1297214vcd.1
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 10:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=fxizVw8GqTEakkG+fEsKvQ3f5Jv+g1TttwUcnvAt1sY=;
        b=kTy2VaWQgJo8CvRsunjaL4XqvSgmGZzmSvUOY9kKQLVX7SjC4UoWtakVAHejdROXnU
         UkzpaMveP5zGY1H+/uYoG26qfdYBAEaxF2BjfB6ThQxpvpCLB6ncm0VhRV5Gr7ln+djN
         P3Xqe5jpMZyqxr8FKsmNHTImT1QugzSfDbWB71uaisVwlKLZjRkZuj3064u4ITpYEwGY
         21CErnAch0PVXosVBByGIpu1Pc4fBROZ5yahmGK8MfDfsk/77RJxu2lfnlnDKmhwYS0n
         P5Z34dRzsMflACVj3TetgoX6zkenmOMMjuD/vh/gxo4VUtaCbNKZlStZ0YJQlVmVfVsw
         W7rQ==
Received: by 10.236.48.99 with SMTP id u63mr14899819yhb.46.1354213986079;
        Thu, 29 Nov 2012 10:33:06 -0800 (PST)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id h50si162522yhi.3.2012.11.29.10.33.06
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 29 Nov 2012 10:33:06 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id D7B5F100048;
	Thu, 29 Nov 2012 10:33:05 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 8C6701028E4; Thu, 29 Nov 2012 10:33:05 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1.240.ge8a1f5a
In-Reply-To: <1354213975-17866-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQkxntOCc0znF6jHHOmL6nwo6qhLj3apqJ4phHS3mHMeOtMlKq4nxKicdsytadVav7Y9GOLBidhkKiZx2/3TplfDCJBH9IvWkwhY7CZZzll4JWpAEmcJFrNC9FJcW8q7QhfQfVgqMp8CVFT9xl57UfQIzqfIAdbMRHJLGTtPCbnsdbASY9QqEt3qqqf3dZ4Vq/x0DTx0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210856>

In cases where HEAD is not supposed to be updated, there is no reason
that "git reset" should require a commit, a tree should be enough. So
make "git reset $rev^{tree}" work just like "git reset $rev", except
that the former will not update HEAD (since there is no commit to
point it to).

Disallow --soft with trees, since that is about updating only HEAD.

By not updating HEAD, "git reset $rev^{tree}" behaves quite like "git
reset $rev .". One might therefore consider requiring a path when
using reset with a tree to make that similarity more obvious. However,
a future commit will make "git reset" work on an unborn branch by
interpreting it as "git reset $empty_tree" and it would seem
unintuitive to the user to say "git reset ." on an unborn
branch. Requiring a path would also make "git reset --hard $tree"
disallowed.

This commit effectively undoes some of commit 13243c2 (reset: the
command takes committish, 2012-07-03). The command line argument is
now required to be an unambiguous treeish.

---

My implementation of lookup_commit_or_tree looks a little clunky. I'm
not very familiar with the API. Suggestions welcome.

Why is the "HEAD is now at ..." message printed only for --hard reset?
After all, HEAD is updated for all types of reset not involving paths.

 builtin/reset.c                     | 67 +++++++++++++++++++++----------------
 t/t1512-rev-parse-disambiguation.sh |  4 ---
 t/t7102-reset.sh                    | 26 ++++++++++++++
 3 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 915cc9f..cec9874 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -225,6 +225,21 @@ static void die_if_unmerged_cache(int reset_type)
 
 }
 
+static struct object *lookup_commit_or_tree(const char *rev) {
+	unsigned char sha1[20];
+	struct commit *commit;
+	struct tree *tree;
+	if (get_sha1_treeish(rev, sha1))
+		die(_("Failed to resolve '%s' as a valid ref."), rev);
+	commit = lookup_commit_reference_gently(sha1, 1);
+	if (commit)
+		return (struct object *) commit;
+	tree = parse_tree_indirect(sha1);
+	if (tree)
+		return (struct object *) tree;
+	die(_("Could not parse object '%s'."), rev);
+}
+
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
@@ -232,7 +247,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	const char *rev = "HEAD";
 	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
 				*old_orig = NULL, sha1_old_orig[20];
-	struct commit *commit;
+	struct object *object;
+	struct commit *commit = NULL;
 	struct strbuf msg = STRBUF_INIT;
 	const struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
@@ -276,7 +292,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		 * Otherwise, argv[i] could be either <rev> or <paths> and
 		 * has to be unambiguous.
 		 */
-		else if (!get_sha1_committish(argv[i], sha1)) {
+		else if (!get_sha1_treeish(argv[i], sha1)) {
 			/*
 			 * Ok, argv[i] looks like a rev; it should not
 			 * be a filename.
@@ -289,19 +305,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (get_sha1_committish(rev, sha1))
-		die(_("Failed to resolve '%s' as a valid ref."), rev);
-
-	/*
-	 * NOTE: As "git reset $treeish -- $path" should be usable on
-	 * any tree-ish, this is not strictly correct. We are not
-	 * moving the HEAD to any commit; we are merely resetting the
-	 * entries in the index to that of a treeish.
-	 */
-	commit = lookup_commit_reference(sha1);
-	if (!commit)
-		die(_("Could not parse object '%s'."), rev);
-	hashcpy(sha1, commit->object.sha1);
+	object = lookup_commit_or_tree(rev);
+	if (object->type == OBJ_COMMIT)
+		commit = (struct commit*) object;
+	else if (reset_type == SOFT)
+		die(_("--soft requires a commit, which '%s' is not"), rev);
+	hashcpy(sha1, object->sha1);
 
 	if (patch_mode) {
 		if (reset_type != NONE)
@@ -347,23 +356,25 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			die(_("Could not reset index file to revision '%s'."), rev);
 	}
 
-	/* Any resets update HEAD to the head being switched to,
-	 * saving the previous head in ORIG_HEAD before. */
-	if (!get_sha1("ORIG_HEAD", sha1_old_orig))
-		old_orig = sha1_old_orig;
-	if (!get_sha1("HEAD", sha1_orig)) {
-		orig = sha1_orig;
-		set_reflog_message(&msg, "updating ORIG_HEAD", NULL);
-		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0, MSG_ON_ERR);
+	if (commit) {
+		/* Any resets update HEAD to the head being switched to,
+		 * saving the previous head in ORIG_HEAD before. */
+		if (!get_sha1("ORIG_HEAD", sha1_old_orig))
+			old_orig = sha1_old_orig;
+		if (!get_sha1("HEAD", sha1_orig)) {
+			orig = sha1_orig;
+			set_reflog_message(&msg, "updating ORIG_HEAD", NULL);
+			update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0, MSG_ON_ERR);
+		}
+		else if (old_orig)
+			delete_ref("ORIG_HEAD", old_orig, 0);
+		set_reflog_message(&msg, "updating HEAD", rev);
+		update_ref_status = update_ref(msg.buf, "HEAD", sha1, orig, 0, MSG_ON_ERR);
 	}
-	else if (old_orig)
-		delete_ref("ORIG_HEAD", old_orig, 0);
-	set_reflog_message(&msg, "updating HEAD", rev);
-	update_ref_status = update_ref(msg.buf, "HEAD", sha1, orig, 0, MSG_ON_ERR);
 
 	switch (reset_type) {
 	case HARD:
-		if (!update_ref_status && !quiet)
+		if (commit && !update_ref_status && !quiet)
 			print_new_head_line(commit);
 		break;
 	case SOFT: /* Nothing else to do. */
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 6b3d797..bc1e40c 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -121,10 +121,6 @@ test_expect_success 'git log takes only commit-ish' '
 	git log 000000000
 '
 
-test_expect_success 'git reset takes only commit-ish' '
-	git reset 000000000
-'
-
 test_expect_success 'first tag' '
 	# create one tag 0000000000f8f
 	git tag -a -m j7cp83um v1.0.0
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index b096dc8..d723ef5 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -491,4 +491,30 @@ test_expect_success 'disambiguation (4)' '
 	test ! -f secondfile
 '
 
+test_expect_success 'reset to tree does not update HEAD' '
+	git reset --hard HEAD &&
+	rev_before=$(git rev-parse HEAD) &&
+	git reset HEAD^^{tree} &&
+	test $(git rev-parse HEAD) == $rev_before
+'
+
+test_expect_success 'reset to tree' '
+	# for simpler tests, drop last commit containing added files
+	git reset --hard HEAD^ &&
+	git reset HEAD^^{tree} &&
+	git diff --cached HEAD^ --exit-code &&
+	git diff HEAD --exit-code
+'
+
+test_expect_success 'reset --hard to tree' '
+	git reset --hard &&
+	git reset --hard HEAD^^{tree} &&
+	git diff --cached HEAD^ --exit-code &&
+	git diff HEAD^ --exit-code
+'
+
+test_expect_success 'reset to tree not allowed with --soft}' '
+	test_must_fail git reset --soft HEAD^^{tree}
+'
+
 test_done
-- 
1.8.0.1.240.ge8a1f5a
