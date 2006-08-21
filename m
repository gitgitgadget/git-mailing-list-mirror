From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Verify we know how to read a pack before trying to using it.
Date: Mon, 21 Aug 2006 03:10:02 -0400
Message-ID: <20060821071002.GA26029@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 09:10:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GF3vK-0004iS-Sv
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 09:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWHUHKK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 03:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbWHUHKK
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 03:10:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:27881 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964966AbWHUHKI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 03:10:08 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GF3vA-0002Hw-LP; Mon, 21 Aug 2006 03:10:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 70DB420FB7D; Mon, 21 Aug 2006 03:10:02 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25783>

If the pack format were to ever change or be extended in the future
there is no assurance that just because the pack file lives in
objects/pack and doesn't end in .idx that we can read and decompress
its contents properly.

If we encounter what we think is a pack file and it isn't or we don't
recognize its version then die and suggest to the user that they
upgrade to a newer version of GIT which can handle that pack file.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d6eb9b3..bb9fa8b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -481,6 +481,7 @@ int use_packed_git(struct packed_git *p)
 		int fd;
 		struct stat st;
 		void *map;
+		struct pack_header *hdr;
 
 		pack_mapped += p->pack_size;
 		while (PACK_MAX_SZ < pack_mapped && unuse_one_packed_git())
@@ -500,6 +501,17 @@ int use_packed_git(struct packed_git *p)
 			die("packfile %s cannot be mapped.", p->pack_name);
 		p->pack_base = map;
 
+		/* Check if we understand this pack file.  If we don't we're
+		 * likely too old to handle it.
+		 */
+		hdr = map;
+		if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
+			die("packfile %s isn't actually a pack.", p->pack_name);
+		if (!pack_version_ok(hdr->hdr_version))
+			die("packfile %s is version %i and not supported"
+				" (try upgrading GIT to a newer version)",
+				p->pack_name, ntohl(hdr->hdr_version));
+
 		/* Check if the pack file matches with the index file.
 		 * this is cheap.
 		 */
-- 
1.4.2.g0dcb
