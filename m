From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diffcore-pickaxe: switch to "counting" behaviour.
Date: Sun, 17 Jul 2005 01:21:28 -0700
Message-ID: <7vek9x3ks7.fsf_-_@assigned-by-dhcp.cox.net>
References: <17091.59948.453311.980846@cargo.ozlabs.ibm.com>
	<7vpsu33a6z.fsf@assigned-by-dhcp.cox.net>
	<17092.26085.238125.715025@cargo.ozlabs.ibm.com>
	<7v3bqz1mxx.fsf@assigned-by-dhcp.cox.net>
	<17112.46727.581664.508076@cargo.ozlabs.ibm.com>
	<7vy886e1ry.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 10:21:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Du4P3-0003wm-SC
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 10:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVGQIVd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 04:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVGQIVd
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 04:21:33 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:25331 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261181AbVGQIVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 04:21:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050717082129.XCCY8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Jul 2005 04:21:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vy886e1ry.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat, 16 Jul 2005 17:04:17 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Instead of finding old/new pair that one side has and the
other side does not have the specified string, find old/new pair
that contains the specified string as a substring different
number of times.  This would still not catch a case where you
introduce two static variable declarations and remove two static
function definitions from a file with -S"static", but would make
it behave a bit more intuitively.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Linus, the "counting" behaviour that came up in our private
*** exchange was brought up independently by Paul.  I think it
*** is a good compromise.

 diffcore-pickaxe.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

7532cfc15932595d679c16ae007f9a910a5b1d1e
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -5,19 +5,30 @@
 #include "diff.h"
 #include "diffcore.h"
 
-static int contains(struct diff_filespec *one,
-		    const char *needle, unsigned long len)
+static unsigned int contains(struct diff_filespec *one,
+			     const char *needle, unsigned long len)
 {
+	unsigned int cnt;
 	unsigned long offset, sz;
 	const char *data;
 	if (diff_populate_filespec(one, 0))
 		return 0;
+
 	sz = one->size;
 	data = one->data;
-	for (offset = 0; offset + len <= sz; offset++)
-		     if (!strncmp(needle, data + offset, len))
-			     return 1;
-	return 0;
+	cnt = 0;
+
+	/* Yes, I've heard of strstr(), but the thing is *data may
+	 * not be NUL terminated.  Sue me.
+	 */
+	for (offset = 0; offset + len <= sz; offset++) {
+		/* we count non-overlapping occurrences of needle */
+		if (!memcmp(needle, data + offset, len)) {
+			offset += len - 1;
+			cnt++;
+		}
+	}
+	return cnt;
 }
 
 void diffcore_pickaxe(const char *needle, int opts)
