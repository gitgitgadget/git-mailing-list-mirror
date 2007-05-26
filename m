From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fixes to output of git-verify-pack -v
Date: Fri, 25 May 2007 23:37:40 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705252331130.3366@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 26 05:37:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrn6M-0004qc-Mt
	for gcvg-git@gmane.org; Sat, 26 May 2007 05:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbXEZDhv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 23:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbXEZDhv
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 23:37:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14247 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbXEZDhu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 23:37:50 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIM009KIQ2SYM60@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 25 May 2007 23:37:41 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48445>

Now that the default delta depth is 50, it is a good idea to also bump 
MAX_CHAIN to 50.

While at it, make the display a bit prettier by making the MAX_CHAIN 
limit inclusive, and display the number of deltas that are above that 
limit at the end instead of the beginning.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/pack-check.c b/pack-check.c
index d04536b..c168642 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -73,12 +73,11 @@ static int verify_packfile(struct packed_git *p,
 }
 
 
-#define MAX_CHAIN 40
+#define MAX_CHAIN 50
 
 static void show_pack_info(struct packed_git *p)
 {
-	uint32_t nr_objects, i, chain_histogram[MAX_CHAIN];
-
+	uint32_t nr_objects, i, chain_histogram[MAX_CHAIN+1];
 	nr_objects = p->num_objects;
 	memset(chain_histogram, 0, sizeof(chain_histogram));
 
@@ -109,22 +108,22 @@ static void show_pack_info(struct packed_git *p)
 			printf("%-6s %lu %"PRIuMAX" %u %s\n",
 			       type, size, (uintmax_t)offset,
 			       delta_chain_length, sha1_to_hex(base_sha1));
-			if (delta_chain_length < MAX_CHAIN)
+			if (delta_chain_length <= MAX_CHAIN)
 				chain_histogram[delta_chain_length]++;
 			else
 				chain_histogram[0]++;
 		}
 	}
 
-	for (i = 0; i < MAX_CHAIN; i++) {
+	for (i = 0; i <= MAX_CHAIN; i++) {
 		if (!chain_histogram[i])
 			continue;
-		printf("chain length %s %d: %d object%s\n",
-		       i ? "=" : ">=",
-		       i ? i : MAX_CHAIN,
-		       chain_histogram[i],
-		       1 < chain_histogram[i] ? "s" : "");
+		printf("chain length = %d: %d object%s\n", i,
+		       chain_histogram[i], chain_histogram[i] > 1 ? "s" : "");
 	}
+	if (chain_histogram[0])
+		printf("chain length > %d: %d object%s\n", MAX_CHAIN,
+		       chain_histogram[0], chain_histogram[0] > 1 ? "s" : "");
 }
 
 int verify_pack(struct packed_git *p, int verbose)
