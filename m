From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 14/15] sequencer: add "--cherry-pick" option to "git
	sequencer--helper"
Date: Fri, 28 Aug 2009 06:47:44 +0200
Message-ID: <20090828044746.4307.16842.chriscool@tuxfamily.org>
References: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 07:00:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgtZm-0006Ec-FR
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 07:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbZH1E7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 00:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbZH1E73
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 00:59:29 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49771 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbZH1E7O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 00:59:14 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C3FC9818094;
	Fri, 28 Aug 2009 06:59:06 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 78F628180EA;
	Fri, 28 Aug 2009 06:59:03 +0200 (CEST)
X-git-sha1: 369ef9f6c2a3f6c7de62cb2a8b1263cc39985d29 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127261>

From: Stephan Beyer <s-beyer@gmx.net>

This patch implements a new "do_cherry_pick()" function using the
previously libified "pick_commit()" function and some other functions
(like "do_commit()") previously added to "builtin-sequencer--helper.c".

Like in the "do_commit()" function, the "next_commit" global is
used to store commit related information, so we cannot easily reuse
existing code to perform what "do_cherry_pick()" does.

This patch adds some code that comes from the sequencer GSoC project:

git://repo.or.cz/git/sbeyer.git

(at commit 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079)

Most of the code from do_cherry_pick() is taken from the
sequencer insn_pick_act() function.

Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-sequencer--helper.c |   70 +++++++++++++++++++++++++++++++++++++-----
 1 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
index 014e4ce..291ba18 100644
--- a/builtin-sequencer--helper.c
+++ b/builtin-sequencer--helper.c
@@ -60,6 +60,8 @@ static const char * const git_sequencer_helper_usage[] = {
 		"<verbosity> [<allow-dirty>]",
 	"git sequencer--helper --fast-forward <commit> <reflog-msg> "
 		"<verbosity> [<allow-dirty>]",
+	"git sequencer--helper --cherry-pick <commit> <reflog-msg> "
+		"<verbosity> [<do-not-commit>]",
 	NULL
 };
 
@@ -287,7 +289,7 @@ static int do_commit(unsigned char *parent_sha1)
 
 	if (update_ref(reflog, "HEAD", commit_sha1, NULL, 0, 0))
 		return error("Could not update HEAD to %s.",
-						sha1_to_hex(commit_sha1));
+			     sha1_to_hex(commit_sha1));
 
 	return 0;
 }
@@ -407,6 +409,46 @@ static int write_commit_summary_into(const char *filename)
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
@@ -435,6 +477,7 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 	char *patch_commit = NULL;
 	char *reset_commit = NULL;
 	char *ff_commit = NULL;
+	char *cp_commit = NULL;
 	struct option options[] = {
 		OPT_STRING(0, "make-patch", &patch_commit, "commit",
 			   "create a patch from commit"),
@@ -442,6 +485,8 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 			   "reset to commit"),
 		OPT_STRING(0, "fast-forward", &ff_commit, "commit",
 			   "fast forward to commit"),
+		OPT_STRING(0, "cherry-pick", &cp_commit, "commit",
+			   "cherry pick commit"),
 		OPT_END()
 	};
 
@@ -458,19 +503,15 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
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
@@ -479,7 +520,18 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
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
