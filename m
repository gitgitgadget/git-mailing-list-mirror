From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] teach ls-tree how to handle names with embedded LF
Date: Wed, 13 Apr 2005 16:43:03 -0700
Message-ID: <7vd5sytf94.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 01:41:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLrT1-0008HJ-RY
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 01:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVDMXna (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 19:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVDMXna
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 19:43:30 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:28398 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261230AbVDMXnG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2005 19:43:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050413234303.HNBQ1497.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 13 Apr 2005 19:43:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

GIT dircache can represent filenames with embedded newline.
Give ls-tree an option to terminate its output with '\0', so that
its output can be further processed with tools like "sort -z"
(and custom perl/python scripts).

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 ls-tree.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)

ls-tree.c:  3e2a6c7d183a42e41f1073dfec6794e8f8a5e75c
--- ls-tree.c
+++ ls-tree.c	2005-04-13 16:17:29.000000000 -0700
@@ -5,6 +5,8 @@
  */
 #include "cache.h"
 
+int line_termination = '\n';
+
 static int list(unsigned char *sha1)
 {
 	void *buffer;
@@ -31,7 +33,8 @@
 		 * It seems not worth it to read each file just to get this
 		 * and the file size. -- pasky@ucw.cz */
 		type = S_ISDIR(mode) ? "tree" : "blob";
-		printf("%03o\t%s\t%s\t%s\n", mode, type, sha1_to_hex(sha1), path);
+		printf("%03o\t%s\t%s\t%s%c", mode, type, sha1_to_hex(sha1),
+		       path, line_termination);
 	}
 	return 0;
 }
@@ -40,6 +43,10 @@
 {
 	unsigned char sha1[20];
 
+	if (argc == 3 && !strcmp(argv[1], "-z")) {
+	  line_termination = 0;
+	  argc--; argv++;
+	}
 	if (argc != 2)
 		usage("ls-tree <key>");
 	if (get_sha1_hex(argv[1], sha1) < 0)

---
head before this patch: f6803ddd4e97a8b0cc090c546d1ff085ed0a4316
tree after  this patch: 0aa0af6254226f0811c72282c46e7e4d9438371c
head after  this patch: 63582e5e8c40790d6255206d6bde65f4ce3820bf

