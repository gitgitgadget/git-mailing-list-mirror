From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Ignore end-of-line style when computing similarity score for rename detection
Date: Wed, 27 Jun 2007 23:04:16 -0700
Message-ID: <20070628060416.GA13162@midwinter.com>
References: <7vtzssog5i.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 08:04:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3n75-0007OT-5v
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 08:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539AbXF1GER (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 02:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754627AbXF1GER
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 02:04:17 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:60788
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1754433AbXF1GER (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 02:04:17 -0400
Received: (qmail 13578 invoked by uid 1001); 28 Jun 2007 06:04:16 -0000
Content-Disposition: inline
In-Reply-To: <7vtzssog5i.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51083>

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
Junio rightly points out that it would be a mistake to discard \r
characters from binary files when computing similarity scores. So now we
only do it if the file contents test as non-binary.

The file attributes aren't available at this level of the code, but they
could be propagated down from the higher levels if we don't trust
buffer_is_binary() to make an adequately accurate decision.


 diffcore-delta.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/diffcore-delta.c b/diffcore-delta.c
index 7338a40..52e648f 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "xdiff-interface.h"
 
 /*
  * Idea here is very simple.
@@ -125,7 +126,8 @@ static struct spanhash_top *add_spanhash(struct spanhash_top *top,
 	}
 }
 
-static struct spanhash_top *hash_chars(unsigned char *buf, unsigned int sz)
+static struct spanhash_top *hash_chars(unsigned char *buf, unsigned int sz,
+				       int is_binary)
 {
 	int i, n;
 	unsigned int accum1, accum2, hashval;
@@ -143,9 +145,12 @@ static struct spanhash_top *hash_chars(unsigned char *buf, unsigned int sz)
 		unsigned int c = *buf++;
 		unsigned int old_1 = accum1;
 		sz--;
-		accum1 = (accum1 << 7) ^ (accum2 >> 25);
-		accum2 = (accum2 << 7) ^ (old_1 >> 25);
-		accum1 += c;
+		/* Ignore \r\n vs. \n when computing text file similarity. */
+		if (c != '\r' && ! is_binary) {
+			accum1 = (accum1 << 7) ^ (accum2 >> 25);
+			accum2 = (accum2 << 7) ^ (old_1 >> 25);
+			accum1 += c;
+		}
 		if (++n < 64 && c != '\n')
 			continue;
 		hashval = (accum1 + accum2 * 0x61) % HASHBASE;
@@ -172,14 +177,16 @@ int diffcore_count_changes(void *src, unsigned long src_size,
 	if (src_count_p)
 		src_count = *src_count_p;
 	if (!src_count) {
-		src_count = hash_chars(src, src_size);
+		int src_is_binary = buffer_is_binary(src, src_size);
+		src_count = hash_chars(src, src_size, src_is_binary);
 		if (src_count_p)
 			*src_count_p = src_count;
 	}
 	if (dst_count_p)
 		dst_count = *dst_count_p;
 	if (!dst_count) {
-		dst_count = hash_chars(dst, dst_size);
+		int dst_is_binary = buffer_is_binary(dst, dst_size);
+		dst_count = hash_chars(dst, dst_size, dst_is_binary);
 		if (dst_count_p)
 			*dst_count_p = dst_count;
 	}
-- 
1.5.2.2.571.ge134
