From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/3] Attempt to delay prepare_alt_odb during get_sha1
Date: Sat, 26 May 2007 01:25:11 -0400
Message-ID: <20070526052511.GC11957@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 26 07:25:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HromH-0000mT-Ud
	for gcvg-git@gmane.org; Sat, 26 May 2007 07:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbXEZFZQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 01:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbXEZFZQ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 01:25:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40417 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbXEZFZP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 01:25:15 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hrom8-00061Q-2d; Sat, 26 May 2007 01:25:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 730AE20FBAE; Sat, 26 May 2007 01:25:11 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48451>

Not every input value passed to get_sha1 is an abbreviated SHA-1.
Its actually quite common for refs to be passed and for those
refs to resolve to full SHA-1s, in which case we may not need to
initialize the alternate object database list in this process.

I'm relocating the call to prepare_alt_odb closer to the code
that actually needs it to maintain the fix first introduced by
Junio in 99a19b43 (to avoid ambiguous SHA-1 abbreviations from
being accepted).  This allows us to avoid the alt_odb list setup
if we won't actually need it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_name.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 55f25a2..8dfceb2 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -133,6 +133,7 @@ static int find_unique_short_object(int len, char *canonical,
 	int has_unpacked, has_packed;
 	unsigned char unpacked_sha1[20], packed_sha1[20];
 
+	prepare_alt_odb();
 	has_unpacked = find_short_object_filename(len, canonical, unpacked_sha1);
 	has_packed = find_short_packed_object(len, res, packed_sha1);
 	if (!has_unpacked && !has_packed)
@@ -654,7 +655,6 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 	const char *cp;
 
 	*mode = S_IFINVALID;
-	prepare_alt_odb();
 	ret = get_sha1_1(name, namelen, sha1);
 	if (!ret)
 		return ret;
-- 
1.5.2.789.g8ee1
