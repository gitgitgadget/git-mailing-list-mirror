From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] revert: don't print "Finished one cherry-pick." if commit
	failed
Date: Mon, 12 Jul 2010 13:54:54 +0200
Message-ID: <20100712115455.12251.47449.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 16:56:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYKQJ-0007F6-2M
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 16:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874Ab0GLOzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 10:55:53 -0400
Received: from smtp2f.orange.fr ([80.12.242.151]:40438 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755767Ab0GLOzw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 10:55:52 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f08.orange.fr (SMTP Server) with ESMTP id DE5BA800110C;
	Mon, 12 Jul 2010 16:55:50 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f08.orange.fr (SMTP Server) with ESMTP id D12BC8001138;
	Mon, 12 Jul 2010 16:55:50 +0200 (CEST)
Received: from style.boubyland (ANantes-156-1-132-89.w90-12.abo.wanadoo.fr [90.12.251.89])
	by mwinf2f08.orange.fr (SMTP Server) with ESMTP id 3EB3A800110C;
	Mon, 12 Jul 2010 16:55:50 +0200 (CEST)
X-ME-UUID: 20100712145550256.3EB3A800110C@mwinf2f08.orange.fr
X-git-sha1: 651474c77e2ff0bfbb47a0b109ceabe6b5308431 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150817>

And, while at it, refactor commit code into a new run_git_commit()
function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   67 +++++++++++++++++++++++++-----------------------------
 1 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index b082bb4..ec931bd 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -361,6 +361,32 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	return !clean;
 }
 
+/*
+ * If we are cherry-pick, and if the merge did not result in
+ * hand-editing, we will hit this commit and inherit the original
+ * author date and name.
+ * If we are revert, or if our cherry-pick results in a hand merge,
+ * we had better say that the current user is responsible for that.
+ */
+static int run_git_commit(const char *defmsg)
+{
+	/* 6 is max possible length of our args array including NULL */
+	const char *args[6];
+	int i = 0;
+
+	args[i++] = "commit";
+	args[i++] = "-n";
+	if (signoff)
+		args[i++] = "-s";
+	if (!edit) {
+		args[i++] = "-F";
+		args[i++] = defmsg;
+	}
+	args[i] = NULL;
+
+	return run_command_v_opt(args, RUN_GIT_CMD);
+}
+
 static int do_pick_commit(void)
 {
 	unsigned char head[20];
@@ -492,48 +518,17 @@ static int do_pick_commit(void)
 			mebuf.buf, help_msg());
 		rerere(allow_rerere_auto);
 	} else {
-		fprintf(stderr, "Finished one %s.\n", mebuf.buf);
+		if (!no_commit)
+			res = run_git_commit(defmsg);
+		if (!res)
+			fprintf(stderr, "Finished one %s.\n", mebuf.buf);
 	}
 
 	strbuf_release(&mebuf);
 	free_message(&msg);
-
-	if (res)
-		return 1;
-
-	/*
-	 *
-	 * If we are cherry-pick, and if the merge did not result in
-	 * hand-editing, we will hit this commit and inherit the original
-	 * author date and name.
-	 * If we are revert, or if our cherry-pick results in a hand merge,
-	 * we had better say that the current user is responsible for that.
-	 */
-
-	if (!no_commit) {
-		/* 6 is max possible length of our args array including NULL */
-		const char *args[6];
-		int res;
-		int i = 0;
-
-		args[i++] = "commit";
-		args[i++] = "-n";
-		if (signoff)
-			args[i++] = "-s";
-		if (!edit) {
-			args[i++] = "-F";
-			args[i++] = defmsg;
-		}
-		args[i] = NULL;
-		res = run_command_v_opt(args, RUN_GIT_CMD);
-		free(defmsg);
-
-		return res;
-	}
-
 	free(defmsg);
 
-	return 0;
+	return res;
 }
 
 static void prepare_revs(struct rev_info *revs)
-- 
1.7.2.rc1.213.gf3fb81
