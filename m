From: bosch@gnat.com (Geert Bosch)
Subject: (unknown)
Date: Wed,  4 Apr 2007 12:59:44 -0400 (EDT)
Message-ID: <20070404165944.E4D7848CC08@nile.gnat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 19:33:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ9MS-0004Ul-Qx
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 19:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbXDDRd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 13:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbXDDRd3
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 13:33:29 -0400
Received: from nile.gnat.com ([205.232.38.5]:61085 "EHLO nile.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbXDDRd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 13:33:28 -0400
X-Greylist: delayed 2022 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Apr 2007 13:33:28 EDT
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 1CD9548CC1D
	for <git@vger.kernel.org>; Wed,  4 Apr 2007 12:59:45 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 20844-01-5 for <git@vger.kernel.org>;
 Wed,  4 Apr 2007 12:59:44 -0400 (EDT)
Received: by nile.gnat.com (Postfix, from userid 4190)
	id E4D7848CC08; Wed,  4 Apr 2007 12:59:44 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43760>

From: Geert Bosch <bosch@gnat.com>
Date: Mon, 2 Apr 2007 11:24:46 +0200
Subject: [PATCH] find_pack_entry_one: Use interpolation search for finding objects in the pack index.

Also be careful about avoiding overflow in signed integer arithmetic.

Signed-off-by: Geert Bosch <bosch@gnat.com>
---
This patch is what I used in my experiments before proposing an
alternative file format for the index.  This gives about a 2.5%
speed-up for git-rev-list --all on the Linux repository,
while not changing anything at all for small repositories.
These tests were done on a Core 2 Duo MacBook Pro with Mac OS X.

While this passes the test suite, I'm not sure it should be applied,
because it doesn't really address the issues for very large repositories
with large numbers of pack files.

  -Geert

 sha1_file.c |   37 ++++++++++++++++++++++++++++++++-----
 1 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 9c26038..e463710 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1547,14 +1547,39 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 				  struct packed_git *p)
 {
 	const uint32_t *level1_ofs = p->index_data;
-	int hi = ntohl(level1_ofs[*sha1]);
-	int lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
+	const unsigned char level1_key = sha1[0];
+	const unsigned int level2_key =  (sha1[1] << 16) + (sha1[2] << 8)
+	    + sha1[3];
+	uint32_t hi = ntohl(level1_ofs[level1_key]);
+	uint32_t lo = !level1_key ? 0 : ntohl(level1_ofs[level1_key - 1]);
+	uint32_t mi = ((hi - lo) * (level2_key >> 13) >> 11)  + lo;
 	const unsigned char *index = p->index_data;
+	const int ents = hi - lo;
+
+        uint32_t try;
 
 	index += 4 * 256;
 
-	do {
-		int mi = (lo + hi) / 2;
+        if (ents < 0xffffff)
+        do {
+		int ofs = 24 * mi + 4;
+
+		try = ntohl(*((uint32_t *) (index + ofs))) & 0xffffff;
+
+		if (try < level2_key) {
+			lo = mi + 1;
+			mi = lo + (((level2_key - try) >> 16) * ents >> 8);
+			if (mi >= hi || mi < lo) mi = hi - 1;
+		}
+		else if (try > level2_key)
+		{
+			hi = mi;
+			mi = hi - 1 - (((try - level2_key) >> 16) * ents >> 8);
+			if (mi < lo || mi >= hi) mi = lo;
+		}
+	} while (try != level2_key && lo + (ents >> 8) < hi);
+
+        while (lo < hi) {
 		int cmp = hashcmp(index + 24 * mi + 4, sha1);
 		if (!cmp)
 			return ntohl(*((uint32_t *)((char *)index + (24 * mi))));
@@ -1562,7 +1587,9 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 			hi = mi;
 		else
 			lo = mi+1;
-	} while (lo < hi);
+		mi = lo + (hi - lo) / 2;
+	};
+
 	return 0;
 }
 
-- 
1.4.5-rc0.GIT
