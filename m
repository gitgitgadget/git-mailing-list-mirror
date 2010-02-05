From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/9] reset: refactor updating heads into a static function
Date: Sat, 06 Feb 2010 00:11:04 +0100
Message-ID: <20100205231112.3689.95767.chriscool@tuxfamily.org>
References: <20100205231028.3689.12228.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:12:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXM3-0008WA-1a
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757699Ab0BEXMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:12:05 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53949 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757629Ab0BEXL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:11:59 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D62A7818045;
	Sat,  6 Feb 2010 00:11:50 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 93F84818093;
	Sat,  6 Feb 2010 00:11:47 +0100 (CET)
X-git-sha1: ac17cb21e8598462c4664acd39bf2cce3fcff5d3 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100205231028.3689.12228.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139116>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-reset.c |   43 +++++++++++++++++++++++++++----------------
 1 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index 0f5022e..3569695 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -211,15 +211,38 @@ static void prepend_reflog_action(const char *action, char *buf, size_t size)
 		warning("Reflog action message too long: %.*s...", 50, buf);
 }
 
+/*
+ * Any resets update HEAD to the head being switched to,
+ * saving the previous head in ORIG_HEAD before.
+ */
+static int update_heads(unsigned char *sha1)
+{
+	unsigned char sha1_orig[20], *orig = NULL,
+		sha1_old_orig[20], *old_orig = NULL;
+	char msg[1024];
+
+	if (!get_sha1("ORIG_HEAD", sha1_old_orig))
+		old_orig = sha1_old_orig;
+	if (!get_sha1("HEAD", sha1_orig)) {
+		orig = sha1_orig;
+		prepend_reflog_action("updating ORIG_HEAD", msg, sizeof(msg));
+		update_ref(msg, "ORIG_HEAD", orig, old_orig, 0, MSG_ON_ERR);
+	}
+	else if (old_orig)
+		delete_ref("ORIG_HEAD", old_orig, 0);
+	prepend_reflog_action("updating HEAD", msg, sizeof(msg));
+
+	return update_ref(msg, "HEAD", sha1, orig, 0, MSG_ON_ERR);
+}
+
 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
 	int patch_mode = 0;
 	const char *rev = "HEAD";
-	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
-				*old_orig = NULL, sha1_old_orig[20];
+	unsigned char sha1[20];
 	struct commit *commit;
-	char *reflog_action, msg[1024];
+	char *reflog_action;
 	const struct option options[] = {
 		OPT__QUIET(&quiet),
 		OPT_SET_INT(0, "mixed", &reset_type,
@@ -321,19 +344,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	else if (reset_index_file(sha1, reset_type, quiet))
 		die("Could not reset index file to revision '%s'.", rev);
 
-	/* Any resets update HEAD to the head being switched to,
-	 * saving the previous head in ORIG_HEAD before. */
-	if (!get_sha1("ORIG_HEAD", sha1_old_orig))
-		old_orig = sha1_old_orig;
-	if (!get_sha1("HEAD", sha1_orig)) {
-		orig = sha1_orig;
-		prepend_reflog_action("updating ORIG_HEAD", msg, sizeof(msg));
-		update_ref(msg, "ORIG_HEAD", orig, old_orig, 0, MSG_ON_ERR);
-	}
-	else if (old_orig)
-		delete_ref("ORIG_HEAD", old_orig, 0);
-	prepend_reflog_action("updating HEAD", msg, sizeof(msg));
-	update_ref_status = update_ref(msg, "HEAD", sha1, orig, 0, MSG_ON_ERR);
+	update_ref_status = update_heads(sha1);
 
 	switch (reset_type) {
 	case HARD:
-- 
1.6.6.1.557.g77031
