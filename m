From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 17/19] reset $sha1 $pathspec: require $sha1 only to be treeish
Date: Wed,  9 Jan 2013 00:16:14 -0800
Message-ID: <1357719376-16406-18-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:23:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsqwP-0000fd-8B
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379Ab3AIIWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:22:54 -0500
Received: from mail-yh0-f73.google.com ([209.85.213.73]:33341 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757216Ab3AIIWw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:22:52 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jan 2013 03:22:52 EST
Received: by mail-yh0-f73.google.com with SMTP id 47so191532yhr.0
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:22:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=SHY9OqMFlkAPIoKps7mJq6yiVKxKXnULaaLzysa40zI=;
        b=R1Lc9WdSfwNC/FKnsT8QsD90MNmpcbIdiE+Of4zydRUxKDT9kZVuxTKLHulxookKa9
         24L3d3VJqtmfwS3AmwUPqzG9VdsD8c/2fssJJp1CG/dj/ov+0l7zqTEN37AqRLr+FuoU
         ZOvaNTBZuphTcgOiQCGmKpslF2pYkivOVCAJa0VTMsJv1kRqY/6lfe6s1LxdDPq+Ozo2
         A9kIl6MBP58NERPgKMH7Sq69PgDBsxHwG4eNadunDGcCdt1OPstqjDnB8ZVgr3UQMpa7
         WN5DuIlUvfqrmwiXRZmp90dXeqeM8KnaqCmCm+MKB4Kur6HVEArlE1GyO1ftXlzTmccd
         3Stw==
X-Received: by 10.236.179.103 with SMTP id g67mr8417388yhm.47.1357719425085;
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id l20si5738243yhi.2.2013.01.09.00.17.05
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id DDDE4820057;
	Wed,  9 Jan 2013 00:17:04 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 93BF4103086; Wed,  9 Jan 2013 00:17:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQkh4vvApDu3k6fXsUfSUU5cgijsQLJvpeeQbnaBQh8aeiwdcupbB0zpz5WYXH9S8EXjceEvIS2CwJJTc0ITvPiabhGaqUnGeb0OW9MAVNb1kfqikYQ5tvR8bTCP6TLSr7e0udj6UDiyHJzYT9pFnhe1gd/PgCg6c7zBqj+8LRjI1LM+iA86RCnb1Sgp7gRS+qnHBkH2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213042>

Resetting with paths does not update HEAD and there is nothing else
that a commit should be needed for. Relax the argument parsing so only
a tree is required.

The sha1 is only passed to read_from_tree(), which already only
requires a tree.

The "rev" variable we pass to run_add_interactive() will resolve to a
tree. This is fine since interactive_reset only needs the parameter to
be a treeish and doesn't use it for display purposes.
---
Is it correct that interactive_reset does not use the revision
specifier for display purposes? Or, worse, that it requires it to be a
commit in some cases? I tried it and didn't see any problem.

Can the two blocks of code that look up commit or tree be made to
share more? I'm not very familiar with what functions are available. I
think I tried keeping a separate "struct object *object" to be able to
put the last three lines outside the blocks, but didn't like the
result.

 builtin/reset.c  | 46 ++++++++++++++++++++++++++--------------------
 t/t7102-reset.sh |  8 ++++++++
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index a2e69eb..4c223bd 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -177,9 +177,10 @@ const char **parse_args(int argc, const char **argv, const char *prefix, const c
 	/*
 	 * Possible arguments are:
 	 *
-	 * git reset [-opts] <rev> <paths>...
-	 * git reset [-opts] <rev> -- <paths>...
-	 * git reset [-opts] -- <paths>...
+	 * git reset [-opts] [<rev>]
+	 * git reset [-opts] <tree> [<paths>...]
+	 * git reset [-opts] <tree> -- [<paths>...]
+	 * git reset [-opts] -- [<paths>...]
 	 * git reset [-opts] <paths>...
 	 *
 	 * At this point, argv points immediately after [-opts].
@@ -194,11 +195,13 @@ const char **parse_args(int argc, const char **argv, const char *prefix, const c
 		}
 		/*
 		 * Otherwise, argv[0] could be either <rev> or <paths> and
-		 * has to be unambiguous.
+		 * has to be unambiguous. If there is a single argument, it
+		 * can not be a tree
 		 */
-		else if (!get_sha1_committish(argv[0], unused)) {
+		else if ((argc == 1 && !get_sha1_committish(argv[0], unused)) ||
+			 (argc > 1 && !get_sha1_treeish(argv[0], unused))) {
 			/*
-			 * Ok, argv[0] looks like a rev; it should not
+			 * Ok, argv[0] looks like a commit/tree; it should not
 			 * be a filename.
 			 */
 			verify_non_filename(prefix, argv[0]);
@@ -240,7 +243,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	const char *rev;
 	unsigned char sha1[20];
 	const char **pathspec = NULL;
-	struct commit *commit;
+	struct commit *commit = NULL;
 	const struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_SET_INT(0, "mixed", &reset_type,
@@ -262,19 +265,22 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 						PARSE_OPT_KEEP_DASHDASH);
 	pathspec = parse_args(argc, argv, prefix, &rev);
 
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
+	if (!pathspec) {
+		if (get_sha1_committish(rev, sha1))
+			die(_("Failed to resolve '%s' as a valid revision."), rev);
+		commit = lookup_commit_reference(sha1);
+		if (!commit)
+			die(_("Could not parse object '%s'."), rev);
+		hashcpy(sha1, commit->object.sha1);
+	} else {
+		struct tree *tree;
+		if (get_sha1_treeish(rev, sha1))
+			die(_("Failed to resolve '%s' as a valid tree."), rev);
+		tree = parse_tree_indirect(sha1);
+		if (!tree)
+			die(_("Could not parse object '%s'."), rev);
+		hashcpy(sha1, tree->object.sha1);
+	}
 
 	if (patch_mode) {
 		if (reset_type != NONE)
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 81b2570..1fa2a5f 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -497,4 +497,12 @@ test_expect_success 'disambiguation (4)' '
 	test ! -f secondfile
 '
 
+test_expect_success 'reset with paths accepts tree' '
+	# for simpler tests, drop last commit containing added files
+	git reset --hard HEAD^ &&
+	git reset HEAD^^{tree} -- . &&
+	git diff --cached HEAD^ --exit-code &&
+	git diff HEAD --exit-code
+'
+
 test_done
-- 
1.8.1.rc3.331.g1ef2165
