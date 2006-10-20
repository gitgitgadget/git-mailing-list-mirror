From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] git-pickaxe: introduce heuristics to avoid "trivial" chunks
Date: Fri, 20 Oct 2006 15:41:21 -0700
Message-ID: <7vpscmmwz2.fsf_-_@assigned-by-dhcp.cox.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<45390168.6020502@utoronto.ca>
	<Pine.LNX.4.64.0610201016490.3962@g5.osdl.org>
	<200610201945.43957.jnareb@gmail.com>
	<Pine.LNX.4.64.0610201049250.3962@g5.osdl.org>
	<7v1wp2oi6s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Oct 21 00:41:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb33Q-0000mT-V7
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 00:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423272AbWJTWlY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 18:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423305AbWJTWlY
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 18:41:24 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:3063 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1423272AbWJTWlW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 18:41:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061020224122.ZDHQ6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Oct 2006 18:41:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id cmh71V00N1kojtg0000000
	Fri, 20 Oct 2006 18:41:07 -0400
To: git@vger.kernel.org
In-Reply-To: <7v1wp2oi6s.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 20 Oct 2006 13:17:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29548>

This adds scoring logic to blame_entry to prevent blames on very
trivial chunks (e.g. lots of empty lines, indent followed by a
closing brace) from being passed down to unrelated lines in the
parent.

The current heuristics are quite simple and may need to be
tweaked later, but we need to start from somewhere.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-pickaxe.c |   36 ++++++++++++++++++++++++++++++++----
 1 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/builtin-pickaxe.c b/builtin-pickaxe.c
index 3c73d82..49673a5 100644
--- a/builtin-pickaxe.c
+++ b/builtin-pickaxe.c
@@ -40,6 +40,15 @@ #define PICKAXE_BLAME_MOVE		01
 #define PICKAXE_BLAME_COPY		02
 #define PICKAXE_BLAME_COPY_HARDER	04
 
+/*
+ * blame for a blame_entry with score lower than these threasholds
+ * is not passed to the parent using move/copy logic.
+ */
+static unsigned blame_move_score;
+static unsigned blame_copy_score;
+#define BLAME_DEFAULT_MOVE_SCORE	20
+#define BLAME_DEFAULT_COPY_SCORE	40
+
 /* bits #0..7 in revision.h, #8..11 used for merge_bases() in commit.c */
 #define METAINFO_SHOWN		(1u<<12)
 #define MORE_THAN_ONE_PATH	(1u<<13)
@@ -645,7 +654,8 @@ static int find_move_in_parent(struct sc
 		if (ent->suspect != target || ent->guilty)
 			continue;
 		find_copy_in_blob(sb, ent, parent, split, &file_p);
-		if (split[1].suspect)
+		if (split[1].suspect &&
+		    blame_move_score < ent_score(sb, &split[1]))
 			split_blame(sb, split, ent);
 	}
 	free(blob_p);
@@ -716,7 +726,8 @@ static int find_copy_in_parent(struct sc
 			find_copy_in_blob(sb, ent, norigin, this, &file_p);
 			copy_split_if_better(sb, split, this);
 		}
-		if (split[1].suspect)
+		if (split[1].suspect &&
+		    blame_copy_score < ent_score(sb, &split[1]))
 			split_blame(sb, split, ent);
 	}
 	diff_flush(&diff_opts);
@@ -1177,6 +1188,15 @@ static int has_path_in_work_tree(const c
 	return !lstat(path, &st);
 }
 
+static unsigned parse_score(const char *arg)
+{
+	char *end;
+	unsigned long score = strtoul(arg, &end, 10);
+	if (*end)
+		return 0;
+	return score;
+}
+
 int cmd_pickaxe(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -1206,12 +1226,15 @@ int cmd_pickaxe(int argc, const char **a
 			output_option |= OUTPUT_LONG_OBJECT_NAME;
 		else if (!strcmp("-S", arg) && ++i < argc)
 			revs_file = argv[i];
-		else if (!strcmp("-M", arg))
+		else if (!strncmp("-M", arg, 2)) {
 			opt |= PICKAXE_BLAME_MOVE;
-		else if (!strcmp("-C", arg)) {
+			blame_move_score = parse_score(arg+2);
+		}
+		else if (!strncmp("-C", arg, 2)) {
 			if (opt & PICKAXE_BLAME_COPY)
 				opt |= PICKAXE_BLAME_COPY_HARDER;
 			opt |= PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE;
+			blame_copy_score = parse_score(arg+2);
 		}
 		else if (!strcmp("-L", arg) && ++i < argc) {
 			char *term;
@@ -1249,6 +1272,11 @@ int cmd_pickaxe(int argc, const char **a
 			argv[unk++] = arg;
 	}
 
+	if (!blame_move_score)
+		blame_move_score = BLAME_DEFAULT_MOVE_SCORE;
+	if (!blame_copy_score)
+		blame_copy_score = BLAME_DEFAULT_COPY_SCORE;
+
 	/* We have collected options unknown to us in argv[1..unk]
 	 * which are to be passed to revision machinery if we are
 	 * going to do the "bottom" procesing.
-- 
1.4.3.ge193
