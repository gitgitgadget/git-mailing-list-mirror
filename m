From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 8/9] sequencer: add "--cherry-pick" option to "git
	sequencer--helper"
Date: Sat, 22 Aug 2009 06:16:14 +0200
Message-ID: <20090822041616.4261.14355.chriscool@tuxfamily.org>
References: <20090822041157.4261.92491.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 06:51:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeiZb-0005aq-Ia
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 06:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbZHVEuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 00:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbZHVEuy
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 00:50:54 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:38334 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932277AbZHVEus (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 00:50:48 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6FDB7818085;
	Sat, 22 Aug 2009 06:50:39 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id CACE18180A0;
	Sat, 22 Aug 2009 06:50:36 +0200 (CEST)
X-git-sha1: ce191f5ef20ed8434974011587c8b4dd2657bc82 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090822041157.4261.92491.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126791>

From: Stephan Beyer <s-beyer@gmx.net>

This patch adds some code that comes from the sequencer GSoC project:

git://repo.or.cz/git/sbeyer.git

(commit 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079)

Most of the code from do_cherry_pick() is taken from the
sequencer insn_pick_act() function.

Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-sequencer--helper.c |   71 +++++++++++++++++++++++++++++++++++++------
 1 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
index 61a8f2e..291ba18 100644
--- a/builtin-sequencer--helper.c
+++ b/builtin-sequencer--helper.c
@@ -60,7 +60,8 @@ static const char * const git_sequencer_helper_usage[] = {
 		"<verbosity> [<allow-dirty>]",
 	"git sequencer--helper --fast-forward <commit> <reflog-msg> "
 		"<verbosity> [<allow-dirty>]",
-	"git sequencer--helper --cherry-pick <commit> [<do-not-commit>]",
+	"git sequencer--helper --cherry-pick <commit> <reflog-msg> "
+		"<verbosity> [<do-not-commit>]",
 	NULL
 };
 
@@ -288,7 +289,7 @@ static int do_commit(unsigned char *parent_sha1)
 
 	if (update_ref(reflog, "HEAD", commit_sha1, NULL, 0, 0))
 		return error("Could not update HEAD to %s.",
-						sha1_to_hex(commit_sha1));
+			     sha1_to_hex(commit_sha1));
 
 	return 0;
 }
@@ -408,6 +409,46 @@ static int write_commit_summary_into(const char *filename)
 	return 0;
 }
 
+static int do_cherry_pick(char *cp_commit, int no_commit)
+{
+	struct commit *commit;
+	int failed;
+	const char *author;
+
+	if (get_sha1("HEAD", head_sha1))
+		return error("You do not have a valid HEAD.");
+
+	commit = get_commit(cp_commit);
+	if (!commit)
+		return 1;
+
+	set_pick_subject(cp_commit, commit);
+
+	failed = pick_commit(commit, 0, 0, &next_commit.summary);
+
+	set_message_source(sha1_to_hex(commit->object.sha1));
+	author = strstr(commit->buffer, "\nauthor ");
+	if (author)
+		set_author_info(author + 8);
+
+	/* We do not want extra Conflicts: lines on cherry-pick,
+	   so just take the old commit message. */
+	if (failed) {
+		strbuf_setlen(&next_commit.summary, 0);
+		strbuf_addstr(&next_commit.summary,
+			      strstr(commit->buffer, "\n\n") + 2);
+		rerere();
+		make_patch(commit);
+		write_commit_summary_into(MERGE_MSG);
+		return error(pick_help_msg(commit->object.sha1, 0));
+	}
+
+	if (!no_commit && do_commit(head_sha1))
+		return error("Could not commit.");
+
+	return 0;
+}
+
 /**********************************************************************
  * Builtin sequencer helper functions
  */
@@ -436,6 +477,7 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 	char *patch_commit = NULL;
 	char *reset_commit = NULL;
 	char *ff_commit = NULL;
+	char *cp_commit = NULL;
 	struct option options[] = {
 		OPT_STRING(0, "make-patch", &patch_commit, "commit",
 			   "create a patch from commit"),
@@ -443,6 +485,8 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 			   "reset to commit"),
 		OPT_STRING(0, "fast-forward", &ff_commit, "commit",
 			   "fast forward to commit"),
+		OPT_STRING(0, "cherry-pick", &cp_commit, "commit",
+			   "cherry pick commit"),
 		OPT_END()
 	};
 
@@ -459,19 +503,15 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
-	if (ff_commit || reset_commit) {
+	if (cp_commit || ff_commit || reset_commit) {
 		unsigned char sha1[20];
-		char *commit = ff_commit ? ff_commit : reset_commit;
+		char *commit;
+		int opt_arg = 0;
 
 		if (argc != 2 && argc != 3)
 			usage_with_options(git_sequencer_helper_usage,
 					   options);
 
-		if (get_sha1(commit, sha1)) {
-			error("Could not find '%s'", commit);
-			return 1;
-		}
-
 		reflog = (char *)argv[0];
 
 		if (parse_verbosity(argv[1])) {
@@ -480,7 +520,18 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 		}
 
 		if (argc == 3 && *argv[2] && strcmp(argv[2], "0"))
-			allow_dirty = 1;
+			opt_arg = 1;
+
+		if (cp_commit)
+			return do_cherry_pick(cp_commit, opt_arg);
+
+		allow_dirty = opt_arg;
+
+		commit = ff_commit ? ff_commit : reset_commit;
+		if (get_sha1(commit, sha1)) {
+			error("Could not find '%s'", commit);
+			return 1;
+		}
 
 		if (ff_commit)
 			return do_fast_forward(sha1);
-- 
1.6.4.271.ge010d
