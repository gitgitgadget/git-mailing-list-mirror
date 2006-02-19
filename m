From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] send-pack --thin: use "thin pack" delta transfer.
Date: Sun, 19 Feb 2006 15:28:07 -0800
Message-ID: <7v7j7rexo8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 00:28:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAxyT-0005NX-6j
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 00:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWBSX2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 18:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWBSX2K
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 18:28:10 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:19689 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932387AbWBSX2J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 18:28:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060219232437.KGJW20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 19 Feb 2006 18:24:37 -0500
To: "Martin Langhoff" <martin.langhoff@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16459>

The new flag loosens the usual "self containedness" requirment
of packfiles, and sends deltified representation of objects when
we know the other side has the base objects needed to unpack
them.  This would help reducing the transfer size.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Together with the other two patches, this allows you to say
   "git-send-pack --thin" to implement the "delta transfer" we
   discussed earlier.

 send-pack.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

7830d82ec3103e3e4c099750620626b3d53530be
diff --git a/send-pack.c b/send-pack.c
index 990be3f..ad22da5 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -12,6 +12,7 @@ static const char *exec = "git-receive-p
 static int verbose = 0;
 static int send_all = 0;
 static int force_update = 0;
+static int use_thin_pack = 0;
 
 static int is_zero_sha1(const unsigned char *sha1)
 {
@@ -41,7 +42,10 @@ static void exec_rev_list(struct ref *re
 	int i = 0;
 
 	args[i++] = "rev-list";	/* 0 */
-	args[i++] = "--objects";	/* 1 */
+	if (use_thin_pack)	/* 1 */
+		args[i++] = "--objects-edge";
+	else
+		args[i++] = "--objects";
 	while (refs) {
 		char *buf = malloc(100);
 		if (i > 900)
@@ -361,6 +365,10 @@ int main(int argc, char **argv)
 				verbose = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--thin")) {
+				use_thin_pack = 1;
+				continue;
+			}
 			usage(send_pack_usage);
 		}
 		if (!dest) {
-- 
1.2.2.g0d27
