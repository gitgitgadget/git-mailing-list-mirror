From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Fix random segfaults in pack-objects.
Date: Wed, 27 Dec 2006 02:46:23 -0500
Message-ID: <20061227074623.GA23165@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 08:46:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzTUe-0000Hh-F7
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 08:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932948AbWL0Hq3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 02:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932956AbWL0Hq3
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 02:46:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55279 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932948AbWL0Hq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 02:46:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzTUe-0004nC-Nn; Wed, 27 Dec 2006 02:46:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CCE2920FB65; Wed, 27 Dec 2006 02:46:23 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35451>

Junio noticed that 'non-trivial' pushes were failing if executed
using the sliding window mmap changes.  This was somewhat difficult
to track down as the failure was appearing randomly.

It turns out this was a failure caused by the delta base reference
(either ref or offset format) spanning over the end of a mmap window.

The error in pack-objects was we were not recalling use_pack
after the object header was unpacked, and therefore we did not
get the promise of at least 20 bytes in the buffer for the delta
base parsing.  This would case later memcmp() calls to walk into
unassigned address space at the end of the window.

The reason Junio and I had hard time tracking this down in current
Git repositories is we were both probably packing with offset deltas,
which minimized the odds of the delta base reference spanning over
the end of the mmap window.  Stepping back and repacking with
version 1.3.3 (which only supported reference deltas) increased
the likelyhood of seeing the bug.

The correct technique (as used in sha1_file.c) is to invoke
use_pack() after unpack_object_header_gently to ensure we have
enough data available for the delta base decoding.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Applies to the top of my sp/mmap topic.

 builtin-pack-objects.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 93eefc4..31ebf5c 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -995,8 +995,6 @@ static void check_object(struct object_entry *entry)
 		 */
 		used = unpack_object_header_gently(buf, left,
 						   &entry->in_pack_type, &size);
-		if (!used || left - used <= 20)
-			die("corrupt pack for %s", sha1_to_hex(entry->sha1));
 
 		/* Check if it is delta, and the base is also an object
 		 * we are going to pack.  If so we will reuse the existing
@@ -1008,10 +1006,13 @@ static void check_object(struct object_entry *entry)
 			/* there is at least 20 bytes left in the pack */
 			switch (entry->in_pack_type) {
 			case OBJ_REF_DELTA:
-				base_name = buf + used;
+				base_name = use_pack(p, &w_curs,
+					entry->in_pack_offset + used, NULL);
 				used += 20;
 				break;
 			case OBJ_OFS_DELTA:
+				buf = use_pack(p, &w_curs,
+					entry->in_pack_offset + used, NULL);
 				c = buf[used++];
 				ofs = c & 127;
 				while (c & 128) {
-- 
1.4.4.3.gd2e4
