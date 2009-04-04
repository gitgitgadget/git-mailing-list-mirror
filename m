From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to efficiently
 lookup sha1
Date: Sat, 4 Apr 2009 22:59:26 +0200
Message-ID: <20090404225926.a9ad50e0.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 23:02:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqD06-0001lq-N4
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 23:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678AbZDDVAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 17:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbZDDVAg
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 17:00:36 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:43035 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754514AbZDDVAf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 17:00:35 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id F1DDA4B003B;
	Sat,  4 Apr 2009 23:00:26 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with SMTP id AF4434B0121;
	Sat,  4 Apr 2009 23:00:23 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115596>

This function has been copied from the "patch_pos" function in
"patch-ids.c" but an additional parameter has been added.

The new parameter is a function pointer, that is used to access the
sha1 of an element in the table.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 sha1-lookup.c |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sha1-lookup.h |    7 ++++
 2 files changed, 108 insertions(+), 0 deletions(-)

diff --git a/sha1-lookup.c b/sha1-lookup.c
index da35747..055dd87 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -1,6 +1,107 @@
 #include "cache.h"
 #include "sha1-lookup.h"
 
+static uint32_t take2(const unsigned char *sha1)
+{
+	return ((sha1[0] << 8) | sha1[1]);
+}
+
+/*
+ * Conventional binary search loop looks like this:
+ *
+ *      do {
+ *              int mi = (lo + hi) / 2;
+ *              int cmp = "entry pointed at by mi" minus "target";
+ *              if (!cmp)
+ *                      return (mi is the wanted one)
+ *              if (cmp > 0)
+ *                      hi = mi; "mi is larger than target"
+ *              else
+ *                      lo = mi+1; "mi is smaller than target"
+ *      } while (lo < hi);
+ *
+ * The invariants are:
+ *
+ * - When entering the loop, lo points at a slot that is never
+ *   above the target (it could be at the target), hi points at a
+ *   slot that is guaranteed to be above the target (it can never
+ *   be at the target).
+ *
+ * - We find a point 'mi' between lo and hi (mi could be the same
+ *   as lo, but never can be the same as hi), and check if it hits
+ *   the target.  There are three cases:
+ *
+ *    - if it is a hit, we are happy.
+ *
+ *    - if it is strictly higher than the target, we update hi with
+ *      it.
+ *
+ *    - if it is strictly lower than the target, we update lo to be
+ *      one slot after it, because we allow lo to be at the target.
+ *
+ * When choosing 'mi', we do not have to take the "middle" but
+ * anywhere in between lo and hi, as long as lo <= mi < hi is
+ * satisfied.  When we somehow know that the distance between the
+ * target and lo is much shorter than the target and hi, we could
+ * pick mi that is much closer to lo than the midway.
+ */
+/*
+ * The table should contain "nr" elements.
+ * The sha1 of element i (between 0 and nr - 1) should be returned
+ * by "fn(i, table)".
+ */
+int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
+	     sha1_access_fn fn)
+{
+	size_t hi = nr;
+	size_t lo = 0;
+	size_t mi = 0;
+
+	if (!nr)
+		return -1;
+
+	if (nr != 1) {
+		size_t lov, hiv, miv, ofs;
+
+		for (ofs = 0; ofs < 18; ofs += 2) {
+			lov = take2(fn(0, table) + ofs);
+			hiv = take2(fn(nr - 1, table) + ofs);
+			miv = take2(sha1 + ofs);
+			if (miv < lov)
+				return -1;
+			if (hiv < miv)
+				return -1 - nr;
+			if (lov != hiv) {
+				/*
+				 * At this point miv could be equal
+				 * to hiv (but sha1 could still be higher);
+				 * the invariant of (mi < hi) should be
+				 * kept.
+				 */
+				mi = (nr - 1) * (miv - lov) / (hiv - lov);
+				if (lo <= mi && mi < hi)
+					break;
+				die("oops");
+			}
+		}
+		if (18 <= ofs)
+			die("cannot happen -- lo and hi are identical");
+	}
+
+	do {
+		int cmp;
+		cmp = hashcmp(fn(mi, table), sha1);
+		if (!cmp)
+			return mi;
+		if (cmp > 0)
+			hi = mi;
+		else
+			lo = mi + 1;
+		mi = (hi + lo) / 2;
+	} while (lo < hi);
+	return -lo-1;
+}
+
 /*
  * Conventional binary search loop looks like this:
  *
diff --git a/sha1-lookup.h b/sha1-lookup.h
index 3249a81..20af285 100644
--- a/sha1-lookup.h
+++ b/sha1-lookup.h
@@ -1,6 +1,13 @@
 #ifndef SHA1_LOOKUP_H
 #define SHA1_LOOKUP_H
 
+typedef const unsigned char *sha1_access_fn(size_t index, void *table);
+
+extern int sha1_pos(const unsigned char *sha1,
+		    void *table,
+		    size_t nr,
+		    sha1_access_fn fn);
+
 extern int sha1_entry_pos(const void *table,
 			  size_t elem_size,
 			  size_t key_offset,
-- 
1.6.2.2.404.ge96f3.dirty
