From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 4/5] Cleanup unpack_object_header to use only offsets.
Date: Sat, 26 Aug 2006 04:12:04 -0400
Message-ID: <20060826081204.GF22343@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 10:12:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGtH3-00034F-Ft
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 10:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422904AbWHZIMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 04:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422900AbWHZIMJ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 04:12:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:24001 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964924AbWHZIMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 04:12:08 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GGtGu-0007GN-KL; Sat, 26 Aug 2006 04:12:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DCFE220FB7F; Sat, 26 Aug 2006 04:12:04 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26039>

If we're always incrementing both the offset and the pointer we
aren't gaining anything by keeping both.  Instead just use the
offset since that's what we were given and what we are expected
to return.  Also using offset is likely to make it easier to remap
the pack in the future should partial mapping of very large packs
get implemented.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index b580cee..e6d47c1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -917,23 +917,19 @@ static unsigned long unpack_object_heade
 	enum object_type *type, unsigned long *sizep)
 {
 	unsigned shift;
-	unsigned char *pack, c;
+	unsigned char c;
 	unsigned long size;
 
 	if (offset >= p->pack_size)
 		die("object offset outside of pack file");
-
-	pack =  (unsigned char *) p->pack_base + offset;
-	c = *pack++;
-	offset++;
+	c = *((unsigned char *)p->pack_base + offset++);
 	*type = (c >> 4) & 7;
 	size = c & 15;
 	shift = 4;
 	while (c & 0x80) {
 		if (offset >= p->pack_size)
 			die("object offset outside of pack file");
-		c = *pack++;
-		offset++;
+		c = *((unsigned char *)p->pack_base + offset++);
 		size += (c & 0x7f) << shift;
 		shift += 7;
 	}
-- 
1.4.2.g6580
