From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 12/15] pick: libify "pick_help_msg()"
Date: Fri, 28 Aug 2009 06:47:42 +0200
Message-ID: <20090828044746.4307.53125.chriscool@tuxfamily.org>
References: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 07:00:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgtZk-0006Ec-W4
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 07:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbZH1E7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 00:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbZH1E73
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 00:59:29 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49768 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807AbZH1E7O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 00:59:14 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B6C238180F9;
	Fri, 28 Aug 2009 06:59:05 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B19AE818042;
	Fri, 28 Aug 2009 06:59:02 +0200 (CEST)
X-git-sha1: 8868cedbe255fbd2036dda8453abce6ec38ca2b6 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127266>

This function gives an help message when pick or revert failed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-revert.c |   23 +----------------------
 pick.c           |   22 ++++++++++++++++++++++
 pick.h           |    1 +
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 4797ac5..e5250bd 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -142,27 +142,6 @@ static void set_author_ident_env(const char *message)
 			sha1_to_hex(commit->object.sha1));
 }
 
-static char *help_msg(const unsigned char *sha1)
-{
-	static char helpbuf[1024];
-	char *msg = getenv("GIT_CHERRY_PICK_HELP");
-
-	if (msg)
-		return msg;
-
-	strcpy(helpbuf, "  After resolving the conflicts,\n"
-	       "mark the corrected paths with 'git add <paths>' "
-	       "or 'git rm <paths>' and commit the result.");
-
-	if (!(flags & PICK_REVERSE)) {
-		sprintf(helpbuf + strlen(helpbuf),
-			"\nWhen commiting, use the option "
-			"'-c %s' to retain authorship and message.",
-			find_unique_abbrev(sha1, DEFAULT_ABBREV));
-	}
-	return helpbuf;
-}
-
 static void write_message(struct strbuf *msgbuf, const char *filename)
 {
 	struct lock_file msg_file;
@@ -211,7 +190,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		exit(1);
 	} else if (failed > 0) {
 		fprintf(stderr, "Automatic %s failed.%s\n",
-			me, help_msg(commit->object.sha1));
+			me, pick_help_msg(commit->object.sha1, flags));
 		write_message(&msgbuf, git_path("MERGE_MSG"));
 		rerere();
 		exit(1);
diff --git a/pick.c b/pick.c
index bb04c68..e1242f6 100644
--- a/pick.c
+++ b/pick.c
@@ -216,3 +216,25 @@ int pick_commit(struct commit *pick_commit, int mainline, int flags,
 
 	return ret;
 }
+
+char *pick_help_msg(const unsigned char *sha1, int flags)
+{
+	static char helpbuf[1024];
+	char *msg = getenv("GIT_CHERRY_PICK_HELP");
+
+	if (msg)
+		return msg;
+
+	strcpy(helpbuf, "  After resolving the conflicts,\n"
+	       "mark the corrected paths with 'git add <paths>' "
+	       "or 'git rm <paths>' and commit the result.");
+
+	if (!(flags & PICK_REVERSE)) {
+		sprintf(helpbuf + strlen(helpbuf),
+			"\nWhen commiting, use the option "
+			"'-c %s' to retain authorship and message.",
+			find_unique_abbrev(sha1, DEFAULT_ABBREV));
+	}
+	return helpbuf;
+}
+
diff --git a/pick.h b/pick.h
index 7a74ad8..115541a 100644
--- a/pick.h
+++ b/pick.h
@@ -9,5 +9,6 @@
 /* We don't need a PICK_QUIET. This is done by
  *	setenv("GIT_MERGE_VERBOSITY", "0", 1); */
 extern int pick_commit(struct commit *commit, int mainline, int flags, struct strbuf *msg);
+extern char *pick_help_msg(const unsigned char *sha1, int flags);
 
 #endif
-- 
1.6.4.271.ge010d
