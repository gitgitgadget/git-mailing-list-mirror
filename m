From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 2/6] reset: refactor updating heads into a static function
Date: Mon, 01 Feb 2010 08:55:37 +0100
Message-ID: <20100201075542.3929.82816.chriscool@tuxfamily.org>
References: <20100201074835.3929.11509.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 08:53:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbr5k-0005Tj-9x
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 08:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660Ab0BAHw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 02:52:58 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:49834 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139Ab0BAHw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 02:52:56 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3C2C7818131;
	Mon,  1 Feb 2010 08:52:48 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 38C4E818054;
	Mon,  1 Feb 2010 08:52:46 +0100 (CET)
X-git-sha1: f43b34ca7769c645b6c3e725d23c6ad2815527f7 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100201074835.3929.11509.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138585>


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
