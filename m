From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 06/12] reset: refactor reseting in its own function
Date: Sun, 28 Feb 2010 23:22:01 +0100
Message-ID: <20100228222208.2260.93974.chriscool@tuxfamily.org>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 23:24:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlrYQ-0006mf-3p
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 23:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032163Ab0B1WXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 17:23:24 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48547 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032116Ab0B1WWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 17:22:51 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5DCB681807F;
	Sun, 28 Feb 2010 23:22:39 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0D0508180D0;
	Sun, 28 Feb 2010 23:22:37 +0100 (CET)
X-git-sha1: cb64b5d3575a7f7f681e782f64033a816df5aa66 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141289>

This splits the reseting logic away from the argument parsing.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/reset.c |  140 +++++++++++++++++++++++++++++--------------------------
 1 files changed, 74 insertions(+), 66 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 7af1cb1..b2239d2 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -255,70 +255,13 @@ static int update_heads(unsigned char *sha1)
 	return update_ref(msg, "HEAD", sha1, orig, 0, MSG_ON_ERR);
 }
 
-int cmd_reset(int argc, const char **argv, const char *prefix)
+static int reset(const char *rev, const char *prefix,
+		 int reset_type, int quiet, int patch_mode,
+		 int argc, const char **argv)
 {
-	int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
-	int patch_mode = 0;
-	const char *rev = "HEAD";
-	unsigned char sha1[20];
 	struct commit *commit;
-	char *reflog_action;
-	const struct option options[] = {
-		OPT__QUIET(&quiet),
-		OPT_SET_INT(0, "mixed", &reset_type,
-						"reset HEAD and index", MIXED),
-		OPT_SET_INT(0, "soft", &reset_type, "reset only HEAD", SOFT),
-		OPT_SET_INT(0, "hard", &reset_type,
-				"reset HEAD, index and working tree", HARD),
-		OPT_SET_INT(0, "merge", &reset_type,
-				"reset HEAD, index and working tree", MERGE),
-		OPT_SET_INT(0, "keep", &reset_type,
-				"reset HEAD but keep local changes", KEEP),
-		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
-		OPT_END()
-	};
-
-	git_config(git_default_config, NULL);
-
-	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
-						PARSE_OPT_KEEP_DASHDASH);
-	reflog_action = args_to_str(argv);
-	setenv("GIT_REFLOG_ACTION", reflog_action, 0);
-
-	/*
-	 * Possible arguments are:
-	 *
-	 * git reset [-opts] <rev> <paths>...
-	 * git reset [-opts] <rev> -- <paths>...
-	 * git reset [-opts] -- <paths>...
-	 * git reset [-opts] <paths>...
-	 *
-	 * At this point, argv[i] points immediately after [-opts].
-	 */
-
-	if (i < argc) {
-		if (!strcmp(argv[i], "--")) {
-			i++; /* reset to HEAD, possibly with paths */
-		} else if (i + 1 < argc && !strcmp(argv[i+1], "--")) {
-			rev = argv[i];
-			i += 2;
-		}
-		/*
-		 * Otherwise, argv[i] could be either <rev> or <paths> and
-		 * has to be unambiguous.
-		 */
-		else if (!get_sha1(argv[i], sha1)) {
-			/*
-			 * Ok, argv[i] looks like a rev; it should not
-			 * be a filename.
-			 */
-			verify_non_filename(prefix, argv[i]);
-			rev = argv[i++];
-		} else {
-			/* Otherwise we treat this as a filename */
-			verify_filename(prefix, argv[i]);
-		}
-	}
+	unsigned char sha1[20];
+	int update_ref_status;
 
 	if (get_sha1(rev, sha1))
 		die("Failed to resolve '%s' as a valid ref.", rev);
@@ -331,19 +274,19 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die("--patch is incompatible with --{hard,mixed,soft}");
-		return interactive_reset(rev, argv + i, prefix);
+		return interactive_reset(rev, argv, prefix);
 	}
 
 	/* git reset tree [--] paths... can be used to
 	 * load chosen paths from the tree into the index without
 	 * affecting the working tree nor HEAD. */
-	if (i < argc) {
+	if (argc > 0) {
 		if (reset_type == MIXED)
 			warning("--mixed option is deprecated with paths.");
 		else if (reset_type != NONE)
 			die("Cannot do %s reset with paths.",
 					reset_type_names[reset_type]);
-		return read_from_tree(prefix, argv + i, sha1,
+		return read_from_tree(prefix, argv, sha1,
 				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
 	}
 	if (reset_type == NONE)
@@ -389,7 +332,72 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	remove_branch_state();
 
+	return update_ref_status;
+}
+
+int cmd_reset(int argc, const char **argv, const char *prefix)
+{
+	int i = 0, reset_type = NONE, quiet = 0;
+	int patch_mode = 0;
+	const char *rev = "HEAD";
+	unsigned char sha1[20];
+	char *reflog_action;
+	const struct option options[] = {
+		OPT__QUIET(&quiet),
+		OPT_SET_INT(0, "mixed", &reset_type,
+						"reset HEAD and index", MIXED),
+		OPT_SET_INT(0, "soft", &reset_type, "reset only HEAD", SOFT),
+		OPT_SET_INT(0, "hard", &reset_type,
+				"reset HEAD, index and working tree", HARD),
+		OPT_SET_INT(0, "merge", &reset_type,
+				"reset HEAD, index and working tree", MERGE),
+		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
+		OPT_END()
+	};
+
+	git_config(git_default_config, NULL);
+
+	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
+						PARSE_OPT_KEEP_DASHDASH);
+	reflog_action = args_to_str(argv);
+	setenv("GIT_REFLOG_ACTION", reflog_action, 0);
 	free(reflog_action);
 
-	return update_ref_status;
+	/*
+	 * Possible arguments are:
+	 *
+	 * git reset [-opts] <rev> <paths>...
+	 * git reset [-opts] <rev> -- <paths>...
+	 * git reset [-opts] -- <paths>...
+	 * git reset [-opts] <paths>...
+	 *
+	 * At this point, argv[i] points immediately after [-opts].
+	 */
+
+	if (i < argc) {
+		if (!strcmp(argv[i], "--")) {
+			i++; /* reset to HEAD, possibly with paths */
+		} else if (i + 1 < argc && !strcmp(argv[i+1], "--")) {
+			rev = argv[i];
+			i += 2;
+		}
+		/*
+		 * Otherwise, argv[i] could be either <rev> or <paths> and
+		 * has to be unambiguous.
+		 */
+		else if (!get_sha1(argv[i], sha1)) {
+			/*
+			 * Ok, argv[i] looks like a rev; it should not
+			 * be a filename.
+			 */
+			verify_non_filename(prefix, argv[i]);
+			rev = argv[i++];
+		} else {
+			/* Otherwise we treat this as a filename */
+			verify_filename(prefix, argv[i]);
+		}
+	}
+
+	return reset(rev, prefix, reset_type, quiet, patch_mode,
+		     argc - i, argv + i);
 }
-- 
1.7.0.321.g2d270
