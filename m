From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 05/12] reset: refactor updating heads into a static function
Date: Sun, 28 Feb 2010 23:22:00 +0100
Message-ID: <20100228222208.2260.41082.chriscool@tuxfamily.org>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 23:24:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlrYQ-0006mf-Kq
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 23:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032166Ab0B1WX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 17:23:26 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48546 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032129Ab0B1WWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 17:22:51 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id F140381808E;
	Sun, 28 Feb 2010 23:22:39 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A95298180EC;
	Sun, 28 Feb 2010 23:22:36 +0100 (CET)
X-git-sha1: a7ba9847536b688d069c88e921171d69422190f7 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141290>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/reset.c |   42 ++++++++++++++++++++++++++----------------
 1 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 2c3a69a..7af1cb1 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -229,7 +229,30 @@ static void die_if_unmerged_cache(int reset_type)
 	if (is_merge() || read_cache() < 0 || unmerged_cache())
 		die("Cannot do a %s reset in the middle of a merge.",
 		    reset_type_names[reset_type]);
+}
+
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
 
+	return update_ref(msg, "HEAD", sha1, orig, 0, MSG_ON_ERR);
 }
 
 int cmd_reset(int argc, const char **argv, const char *prefix)
@@ -237,10 +260,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
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
@@ -350,19 +372,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			die("Could not reset index file to revision '%s'.", rev);
 	}
 
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
1.7.0.321.g2d270
