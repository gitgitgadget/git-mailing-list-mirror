From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 12/13] sequencer: add "--cherry-pick" option to "git
	sequencer--helper"
Date: Wed, 12 Aug 2009 07:15:50 +0200
Message-ID: <20090812051552.18155.34161.chriscool@tuxfamily.org>
References: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 07:28:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb6O3-0003mw-7S
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 07:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbZHLF2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 01:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbZHLF2W
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 01:28:22 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47775 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbZHLF2J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 01:28:09 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 68A5F818076;
	Wed, 12 Aug 2009 07:27:59 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 272FB8180E3;
	Wed, 12 Aug 2009 07:27:57 +0200 (CEST)
X-git-sha1: 4a48d5fca56f71a72358df6181cef6486e1f3f98 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125660>

From: Stephan Beyer <s-beyer@gmx.net>

This patch adds some code that comes from the sequencer GSoC project:

git://repo.or.cz/git/sbeyer.git

(commit e7b8dab0c2a73ade92017a52bb1405ea1534ef20)

Most of the code is taken from the insn_pick_act() function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-sequencer--helper.c |   52 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
index 61a8f2e..0f2255a 100644
--- a/builtin-sequencer--helper.c
+++ b/builtin-sequencer--helper.c
@@ -288,7 +288,7 @@ static int do_commit(unsigned char *parent_sha1)
 
 	if (update_ref(reflog, "HEAD", commit_sha1, NULL, 0, 0))
 		return error("Could not update HEAD to %s.",
-						sha1_to_hex(commit_sha1));
+			     sha1_to_hex(commit_sha1));
 
 	return 0;
 }
@@ -436,6 +436,7 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 	char *patch_commit = NULL;
 	char *reset_commit = NULL;
 	char *ff_commit = NULL;
+	char *cp_commit = NULL;
 	struct option options[] = {
 		OPT_STRING(0, "make-patch", &patch_commit, "commit",
 			   "create a patch from commit"),
@@ -443,6 +444,8 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 			   "reset to commit"),
 		OPT_STRING(0, "fast-forward", &ff_commit, "commit",
 			   "fast forward to commit"),
+		OPT_STRING(0, "cherry-pick", &cp_commit, "commit",
+			   "cherry pick commit"),
 		OPT_END()
 	};
 
@@ -488,5 +491,52 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 			return reset_almost_hard(sha1);
 	}
 
+	if (cp_commit) {
+		struct commit *commit;
+		int failed;
+		const char *author;
+		int no_commit = 0;
+
+		if (argc != 0 && argc != 1)
+			usage_with_options(git_sequencer_helper_usage,
+					   options);
+
+		if (argc == 1 && *argv[0] && strcmp(argv[0], "0"))
+			no_commit = 1;
+
+		if (get_sha1("HEAD", head_sha1))
+			return error("You do not have a valid HEAD.");
+
+		commit = get_commit(cp_commit);
+		if (!commit)
+			return 1;
+
+		set_pick_subject(cp_commit, commit);
+
+		failed = pick_commit(commit, 0, 0, &next_commit.summary);
+
+		set_message_source(sha1_to_hex(commit->object.sha1));
+		author = strstr(commit->buffer, "\nauthor ");
+		if (author)
+			set_author_info(author + 8);
+
+		/* We do not want extra Conflicts: lines on cherry-pick,
+		   so just take the old commit message. */
+		if (failed) {
+			strbuf_setlen(&next_commit.summary, 0);
+			strbuf_addstr(&next_commit.summary,
+				      strstr(commit->buffer, "\n\n") + 2);
+			rerere();
+			make_patch(commit);
+			write_commit_summary_into(MERGE_MSG);
+			return error(pick_help_msg(commit->object.sha1, 0));
+		}
+
+		if (!no_commit && do_commit(head_sha1))
+			return error("Could not commit.");
+
+		return 0;
+	}
+
 	usage_with_options(git_sequencer_helper_usage, options);
 }
-- 
1.6.4.271.ge010d
