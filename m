From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] delta micro optimization
Date: Fri, 10 Feb 2006 13:42:05 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602101335160.5397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 19:42:11 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7dDf-0007Yl-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 19:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWBJSmH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 13:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWBJSmH
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 13:42:07 -0500
Received: from relais.videotron.ca ([24.201.245.36]:43254 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750864AbWBJSmG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 13:42:06 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IUH00ERSIM5WKP0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 10 Feb 2006 13:42:05 -0500 (EST)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15876>

My kernel work habit made me look at the generated assembly for the 
delta code, and one obvious albeit small improvement is this patch.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/delta.h b/delta.h
index 31d1820..a15350d 100644
--- a/delta.h
+++ b/delta.h
@@ -19,14 +19,14 @@ extern void *patch_delta(void *src_buf, 
 static inline unsigned long get_delta_hdr_size(const unsigned char **datap)
 {
 	const unsigned char *data = *datap;
-	unsigned char cmd = *data++;
-	unsigned long size = cmd & ~0x80;
-	int i = 7;
-	while (cmd & 0x80) {
+	unsigned char cmd;
+	unsigned long size = 0;
+	int i = 0;
+	do {
 		cmd = *data++;
 		size |= (cmd & ~0x80) << i;
 		i += 7;
-	}
+	} while (cmd & 0x80);
 	*datap = data;
 	return size;
 }
