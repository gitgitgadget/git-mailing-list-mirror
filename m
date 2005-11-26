From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 5/8] hash-object: work within subdirectory.
Date: Sat, 26 Nov 2005 01:57:00 -0800
Message-ID: <7vveyf4tqr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
	<200511210026.30280.Josef.Weidendorfer@gmx.de>
	<200511221831.03954.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 10:58:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efwnt-0002Ro-GK
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 10:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVKZJ5E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 04:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVKZJ5E
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 04:57:04 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:1236 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750828AbVKZJ5C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 04:57:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126095533.GESW20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 26 Nov 2005 04:55:33 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12777>

When -w is given, it needs to find out where the .git directory
is, so run the setup_git_directory() when we see a -w.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 hash-object.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

applies-to: b0041c758e0fc01e5ec05bd0543d04d1a9cb17f5
61fdef6a50c99c98feebd71f499450cf97a8c169
diff --git a/hash-object.c b/hash-object.c
index c8c9adb..3075328 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -6,6 +6,9 @@
  */
 #include "cache.h"
 
+static const char *prefix;
+static int prefix_length = -1;
+
 static void hash_object(const char *path, const char *type, int write_object)
 {
 	int fd;
@@ -36,10 +39,20 @@ int main(int argc, char **argv)
 				die(hash_object_usage);
 			type = argv[i];
 		}
-		else if (!strcmp(argv[i], "-w"))
+		else if (!strcmp(argv[i], "-w")) {
+			if (prefix_length < 0) {
+				prefix = setup_git_directory();
+				prefix_length = prefix ? strlen(prefix) : 0;
+			}
 			write_object = 1;
-		else
-			hash_object(argv[i], type, write_object);
+		}
+		else {
+			char *arg = argv[i];
+			if (0 <= prefix_length)
+				arg = prefix_filename(prefix, prefix_length,
+						      arg);
+			hash_object(arg, type, write_object);
+		}
 	}
 	return 0;
 }
---
0.99.9.GIT
