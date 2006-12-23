From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 9/17] Document why header parsing won't exceed a window.
Date: Sat, 23 Dec 2006 02:34:18 -0500
Message-ID: <20061223073418.GJ9837@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:34:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1Oi-0001sU-UI
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbWLWHeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbWLWHeW
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:34:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38790 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbWLWHeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:34:21 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1OF-00039R-TJ; Sat, 23 Dec 2006 02:33:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 93DE020FB65; Sat, 23 Dec 2006 02:34:18 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35290>

When we parse the object header or the delta base reference we
don't bother to loop over use_pack() calls.  The reason we don't
need to bother with calling use_pack for each byte accessed is that
use_pack will always promise us at least 20 bytes (really the hash
size) after the offset.  This promise from use_pack simplifies a
lot of code in the header parsing logic, as well as helps out the
zlib library by ensuring there's always some data for it to consume
during an inflate call.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 886e3b5..6c34482 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -901,10 +901,12 @@ static unsigned long get_delta_base(struct packed_git *p,
 	unsigned char *base_info = use_pack(p, w_curs, offset, NULL);
 	unsigned long base_offset;
 
-	/* there must be at least 20 bytes left regardless of delta type */
-	if (p->pack_size <= offset + 20)
-		die("truncated pack file");
-
+	/* use_pack() assured us we have [base_info, base_info + 20)
+	 * as a range that we can look at without walking off the
+	 * end of the mapped window.  Its actually the hash size
+	 * that is assured.  An OFS_DELTA longer than the hash size
+	 * is stupid, as then a REF_DELTA would be smaller to store.
+	 */
 	if (kind == OBJ_OFS_DELTA) {
 		unsigned used = 0;
 		unsigned char c = base_info[used++];
@@ -1007,6 +1009,12 @@ static unsigned long unpack_object_header(struct packed_git *p,
 	unsigned int left;
 	unsigned long used;
 
+	/* use_pack() assures us we have [base, base + 20) available
+	 * as a range that we can look at at.  (Its actually the hash
+	 * size that is assurred.)  With our object header encoding
+	 * the maximum deflated object size is 2^137, which is just
+	 * insane, so we know won't exceed what we have been given.
+	 */
 	base = use_pack(p, w_curs, offset, &left);
 	used = unpack_object_header_gently(base, left, type, sizep);
 	if (!used)
-- 
1.4.4.3.g87d8
