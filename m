From: Petr Baudis <pasky@ucw.cz>
Subject: [GIT PATCH] Fix git-mktag to take the object input spliced arbitrarily
Date: Sun, 29 May 2005 20:52:30 +0200
Message-ID: <20050529185230.GN1036@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 20:51:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcSrR-00039T-3u
	for gcvg-git@gmane.org; Sun, 29 May 2005 20:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVE2Swf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 14:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVE2Swf
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 14:52:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34944 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261402AbVE2Swb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 14:52:31 -0400
Received: (qmail 14999 invoked by uid 2001); 29 May 2005 18:52:30 -0000
To: torvalds@osdl.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Before, git-mktag would just try to get all the input through a single
read(), which is obviously broken, since the I/O layer may give you
only part of the input through such a read(). This made it basically
impossible to type the input in manually, for example.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---
commit f67b8ea0f157813d50371bed494452160c47744d
tree e29e13f259279737dd62ca1b10ede1f8d5e2adb8
parent bf36ee6ccc0dae5725edd7f5d56844a0eae158ad
author Petr Baudis <pasky@ucw.cz> Sun, 29 May 2005 01:39:04 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Sun, 29 May 2005 01:39:04 +0200

 mktag.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

Index: mktag.c
===================================================================
--- 01d01f6cebf110348cfa23c86d521118a00336ba/mktag.c  (mode:100644)
+++ e29e13f259279737dd62ca1b10ede1f8d5e2adb8/mktag.c  (mode:100644)
@@ -98,7 +98,7 @@
 
 int main(int argc, char **argv)
 {
-	unsigned long size;
+	unsigned long size, readsize;
 	char buffer[MAXSIZE];
 	unsigned char result_sha1[20];
 
@@ -106,7 +106,11 @@
 		usage("cat <signaturefile> | git-mktag");
 
 	// Read the signature
-	size = read(0, buffer, MAXSIZE);
+	size = 0;
+	do {
+		readsize = read(0, buffer + size, MAXSIZE - size);
+		size += readsize;
+	} while (readsize);
 
 	// Verify it for some basic sanity: it needs to start with "object <sha1>\ntype "
 	if (verify_tag(buffer, size) < 0)


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
