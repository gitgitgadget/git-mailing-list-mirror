From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Don't leak file descriptors from unavailable pack files.
Date: Fri, 2 Feb 2007 03:00:03 -0500
Message-ID: <20070202080003.GA21094@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 02 09:00:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCtLC-0003dZ-Av
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 09:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423213AbXBBIAJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 03:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423214AbXBBIAJ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 03:00:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41486 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423213AbXBBIAI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 03:00:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCtL2-000840-JL; Fri, 02 Feb 2007 03:00:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 73FEA20FBAE; Fri,  2 Feb 2007 03:00:03 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38472>

If open_packed_git failed it may have been because the packfile
actually exists and is readable, but some sort of verification
did not pass.  In this case open_packed_git left pack_fd filled
in, as the file descriptor is valid.  We don't want to leak the
file descriptor, nor do we want to allow someone in the future
to use this packed_git.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 37669d6..ba1c799 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1414,6 +1414,10 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, cons
 			 * was loaded!
 			 */
 			if (p->pack_fd == -1 && open_packed_git(p)) {
+				if (p->pack_fd != -1) {
+					close(p->pack_fd);
+					p->pack_fd = -1;
+				}
 				error("packfile %s cannot be accessed", p->pack_name);
 				continue;
 			}
-- 
1.5.0.rc3.1.ge4b0e
