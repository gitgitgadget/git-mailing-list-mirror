From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] 3% tighter packs for free
Date: Fri, 17 Mar 2006 22:45:07 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0603172205490.4889@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 18 04:45:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKSNP-0007EP-6d
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 04:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWCRDpK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 22:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWCRDpK
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 22:45:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:31299 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932210AbWCRDpI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Mar 2006 22:45:08 -0500
Received: from xanadu.home ([74.56.105.38]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IWB00AGR1375260@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 17 Mar 2006 22:45:08 -0500 (EST)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17682>


This patch makes for 3.4% smaller pack with the git repository, and
a bit more than 3% smaller pack with the kernel repository.

And so with _no_ measurable CPU difference.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/diff-delta.c b/diff-delta.c
index aaee7be..1188b31 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -136,7 +136,8 @@ void *diff_delta(void *from_buf, unsigne
 		 unsigned long *delta_size,
 		 unsigned long max_size)
 {
-	unsigned int i, outpos, outsize, inscnt, hash_shift;
+	unsigned int i, outpos, outsize, hash_shift;
+	int inscnt;
 	const unsigned char *ref_data, *ref_top, *data, *top;
 	unsigned char *out;
 	struct index *entry, **hash;
@@ -222,6 +223,20 @@ void *diff_delta(void *from_buf, unsigne
 			unsigned char *op;
 
 			if (inscnt) {
+				while (moff && ref_data[moff-1] == data[-1]) {
+					if (msize == 0x10000)
+						break;
+					/* we can match one byte back */
+					msize++;
+					moff--;
+					data--;
+					outpos--;
+					if (--inscnt)
+						continue;
+					outpos--;  /* remove count slot */
+					inscnt--;  /* make it -1 */
+					break;
+				}
 				out[outpos - inscnt - 1] = inscnt;
 				inscnt = 0;
 			}
