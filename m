From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 04/12] pick: move calling check_parent() ouside
	pick_commit()
Date: Sun, 28 Feb 2010 23:21:59 +0100
Message-ID: <20100228222208.2260.36430.chriscool@tuxfamily.org>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 23:24:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlrYP-0006mf-0c
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 23:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032133Ab0B1WWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 17:22:49 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48510 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032121Ab0B1WWs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 17:22:48 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 651AC81808C;
	Sun, 28 Feb 2010 23:22:38 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 519BA818045;
	Sun, 28 Feb 2010 23:22:36 +0100 (CET)
X-git-sha1: f3d9f63414837c74571418fb66935500f1ff2b20 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141287>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |    7 ++++++-
 pick.c           |   12 ++++--------
 pick.h           |    2 +-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 3308de1..764cd41 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -193,6 +193,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	struct strbuf msgbuf;
 	char *reencoded_message = NULL;
 	const char *encoding;
+	struct commit *parent = NULL;
 	int failed;
 
 	git_config(git_default_config, NULL);
@@ -217,7 +218,11 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 					git_commit_encoding, encoding)))
 		commit->buffer = reencoded_message;
 
-	failed = pick_commit(commit, mainline, flags, &msgbuf);
+	failed = check_parent(commit, mainline, flags, &parent);
+	if (failed)
+		return failed;
+
+	failed = pick_commit(commit, parent, flags, &msgbuf);
 	if (failed < 0) {
 		exit(1);
 	} else if (failed > 0) {
diff --git a/pick.c b/pick.c
index 078b78d..d603c5b 100644
--- a/pick.c
+++ b/pick.c
@@ -60,7 +60,7 @@ static struct tree *empty_tree(void)
 }
 
 int check_parent(struct commit *commit, int mainline, int flags,
-			struct commit **parent)
+		 struct commit **parent)
 {
 	if (!commit->parents) {
 		if (flags & PICK_REVERSE)
@@ -110,12 +110,12 @@ int check_parent(struct commit *commit, int mainline, int flags,
  * and a positive value after picking,
  * and return 1 if and only if a conflict occurs but no other error.
  */
-int pick_commit(struct commit *pick_commit, int mainline, int flags,
+int pick_commit(struct commit *pick_commit, struct commit *parent, int flags,
 		struct strbuf *msg)
 {
 	unsigned char head[20];
-	struct commit *base, *next, *parent = NULL;
-	int i, index_fd, clean, err;
+	struct commit *base, *next;
+	int i, index_fd, clean;
 	int ret = 0;
 	char *oneline;
 	const char *message;
@@ -139,10 +139,6 @@ int pick_commit(struct commit *pick_commit, int mainline, int flags,
 		return error("Unable to create locked index: %s",
 			     strerror(errno));
 
-	err = check_parent(commit, mainline, flags, &parent);
-	if (err)
-		return err;
-
 	if (!(message = commit->buffer))
 		return error("Cannot get commit message for %s",
 			     sha1_to_hex(commit->object.sha1));
diff --git a/pick.h b/pick.h
index 39af1de..098f765 100644
--- a/pick.h
+++ b/pick.h
@@ -8,7 +8,7 @@
 #define PICK_ADD_NOTE  2 /* add note about original commit (unless conflict) */
 /* We don't need a PICK_QUIET. This is done by
  *	setenv("GIT_MERGE_VERBOSITY", "0", 1); */
-extern int pick_commit(struct commit *commit, int mainline, int flags, struct strbuf *msg);
+extern int pick_commit(struct commit *commit, struct commit *parent, int flags, struct strbuf *msg);
 extern int check_parent(struct commit *commit, int mainline, int flags, struct commit **parent);
 
 #endif
-- 
1.7.0.321.g2d270
