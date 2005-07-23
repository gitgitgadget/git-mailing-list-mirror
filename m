From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diffcore-pickaxe: switch to "counting" behaviour.
Date: Sat, 23 Jul 2005 16:35:25 -0700
Message-ID: <7v64v1qeo2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 01:36:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwTX5-0006vj-GI
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 01:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVGWXf3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 19:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVGWXf3
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 19:35:29 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:3723 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261853AbVGWXf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 19:35:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723233523.JQOW3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 23 Jul 2005 19:35:23 -0400
To: Linus Torvalds <torvalds@osdl.org>
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
*** This was brought up as a possible improvement for the first
*** question when you asked me two questions a couple of weeks
*** ago.  Interestingly enough, Paul Mackerras independently
*** suggested the same approach to make pickaxe more intuitive
*** for gitk users.

 diffcore-pickaxe.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

d245f19da1e36a70e904f2414d815fc06bfe09d8
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
