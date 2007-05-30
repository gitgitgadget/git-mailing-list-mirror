From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/3] Ensure the pack index is opened before access
Date: Wed, 30 May 2007 02:13:14 -0400
Message-ID: <20070530061314.GB12738@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 08:13:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtHR2-0000rS-PT
	for gcvg-git@gmane.org; Wed, 30 May 2007 08:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbXE3GNY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 02:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbXE3GNY
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 02:13:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45447 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbXE3GNX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 02:13:23 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtHQp-0003dq-Mb; Wed, 30 May 2007 02:13:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E9F6520FBAE; Wed, 30 May 2007 02:13:14 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48743>

In this particular location of fsck the index should have already
been opened by verify_pack, which is called just before we get
here and loop through the object names.  However, just in case a
future version of that function does not use the index file we'll
double-check its open before we access the num_objects field.

Better safe now than sorry later.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fsck.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index cbbcaf0..9959818 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -668,7 +668,10 @@ int cmd_fsck(int argc, char **argv, const char *prefix)
 			verify_pack(p, 0);
 
 		for (p = packed_git; p; p = p->next) {
-			uint32_t i, num = p->num_objects;
+			uint32_t i, num;
+			if (open_pack_index(p))
+				continue;
+			num = p->num_objects;
 			for (i = 0; i < num; i++)
 				fsck_sha1(nth_packed_object_sha1(p, i));
 		}
-- 
1.5.2.869.g6b3ba
