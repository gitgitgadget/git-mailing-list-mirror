From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Use PRIuMAX instead of 'unsigned long long' in show-index
Date: Sun, 21 Oct 2007 01:25:23 -0400
Message-ID: <20071021052523.GA31927@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 07:25:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjTJn-0001l2-MC
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 07:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbXJUFZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 01:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbXJUFZ1
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 01:25:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33244 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbXJUFZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 01:25:26 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IjTJU-0007Br-RJ
	for git@vger.kernel.org; Sun, 21 Oct 2007 01:25:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 693B020FBAE; Sun, 21 Oct 2007 01:25:23 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61877>

Elsewhere in Git we already use PRIuMAX and cast to uintmax_t when
we need to display a value that is 'very big' and we're not exactly
sure what the largest display size is for this platform.

This particular fix is needed so we can do the incredibly crazy
temporary hack of:

    diff --git a/cache.h b/cache.h
    index e0abcd6..6637fd8 100644
    --- a/cache.h
    +++ b/cache.h
    @@ -6,6 +6,7 @@

     #include SHA1_HEADER
     #include <zlib.h>
    +#define long long long

     #if ZLIB_VERNUM < 0x1200
     #define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)

allowing us to more easily look for locations where we are passing
a pointer to an 8 byte value to a function that expects a 4 byte
value.  This can occur on some platforms where sizeof(long) == 8
and sizeof(size_t) == 4.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 show-index.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/show-index.c b/show-index.c
index 57ed9e8..7253991 100644
--- a/show-index.c
+++ b/show-index.c
@@ -68,7 +68,7 @@ int main(int argc, char **argv)
 						     ntohl(off64[1]);
 				off64_nr++;
 			}
-			printf("%llu %s (%08x)\n", (unsigned long long) offset,
+			printf("%" PRIuMAX " %s (%08x)\n", (uintmax_t) offset,
 			       sha1_to_hex(entries[i].sha1),
 			       ntohl(entries[i].crc));
 		}
-- 
1.5.3.4.1270.g2fe543
