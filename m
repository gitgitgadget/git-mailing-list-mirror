From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH WIP] sha1-lookup: more memory efficient search in sorted list of SHA-1
Date: Sun, 30 Dec 2007 02:22:55 -0800
Message-ID: <7vd4soa3cw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 30 11:23:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8vKN-0007NC-TA
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 11:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbXL3KXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 05:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbXL3KXF
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 05:23:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62585 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbXL3KXD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 05:23:03 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A427F64D9;
	Sun, 30 Dec 2007 05:23:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3206564D8;
	Sun, 30 Dec 2007 05:22:58 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69341>

Currently, when looking for a packed object from the pack idx, a
simple binary search is used.

A conventional binary search loop looks like this:

        unsigned lo, hi;
        do {
                unsigned mi = (lo + hi) / 2;
                int cmp = "entry pointed at by mi" minus "target";
                if (!cmp)
                        return (mi is the wanted one)
                if (cmp > 0)
                        hi = mi; "mi is larger than target"
                else
                        lo = mi+1; "mi is smaller than target"
        } while (lo < hi);

The invariants are:

  - When entering the loop, 'lo' points at a slot that is never
    above the target (it could be at the target), 'hi' points at
    a slot that is guaranteed to be above the target (it can
    never be at the target).

  - We find a point 'mi' between 'lo' and 'hi' ('mi' could be
    the same as 'lo', but never can be the same as 'hi'), and
    check if 'mi' hits the target.  There are three cases:

     - if it is a hit, we have found the SHA-1;

     - if it is strictly higher than the target, we set it to
       'hi', and repeat the search.

     - if it is strictly lower than the target, we update 'lo'
       to one slot after it, because we allow 'lo' to be at the
       target.

    If the loop exits, there is no matching entry.

When choosing 'mi', we do not have to take the "middle" but
anywhere in between 'lo' and 'hi', as long as lo <= mi < hi is
satisfied.  When we somehow know that the distance between the
target and 'lo' is much shorter than the target and 'hi', we
could pick 'mi' that is much closer to 'lo' than (hi+lo)/2,
which a conventional binary search would pick.

This patch takes advantage of the fact that the SHA-1 is a good
hash function, and as long as there are enough entries in the
table, we can expect uniform distribution.  An entry that begins
with for example "deadbeef..." is much likely to appear much
later than in the midway of a reasonably populated table.  In
fact, it can be expected to be near 87% (222/256) from the top
of the table.

This is a work-in-progress and has switches to allow easier
experiments and debugging.  Exporting GIT_USE_LOOKUP environment
variable enables this code.

On my admittedly memory starved machine, with a partial KDE
repository (3.0G pack with 95M idx):

    $ GIT_USE_LOOKUP=t git log -800 --stat HEAD >/dev/null
    3.93user 0.16system 0:04.09elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+55588minor)pagefaults 0swaps

Without the patch, the numbers are:

    $ git log -800 --stat HEAD >/dev/null
    4.00user 0.15system 0:04.17elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+60258minor)pagefaults 0swaps

In the same repository:

    $ GIT_USE_LOOKUP=t git log -2000 HEAD >/dev/null
    0.12user 0.00system 0:00.12elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+4241minor)pagefaults 0swaps

Without the patch, the numbers are:

    $ git log -2000 HEAD >/dev/null
    0.05user 0.01system 0:00.07elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
    0inputs+0outputs (0major+8506minor)pagefaults 0swaps

There isn't much time difference, but the number of minor faults
seems to show that we are touching much smaller number of pages,
which is expected.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile      |    6 ++-
 sha1-lookup.c |  153 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sha1-lookup.h |    9 +++
 sha1_file.c   |   35 ++++++++++++-
 4 files changed, 198 insertions(+), 5 deletions(-)
 create mode 100644 sha1-lookup.c
 create mode 100644 sha1-lookup.h

diff --git a/Makefile b/Makefile
index 21c80e6..9cff3ca 100644
--- a/Makefile
+++ b/Makefile
@@ -293,7 +293,8 @@ LIB_H = \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
 	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
-	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h
+	mailmap.h remote.h parse-options.h transport.h diffcore.h hash.h \
+	sha1-lookup.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -316,7 +317,8 @@ LIB_OBJS = \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
-	transport.o bundle.o walker.o parse-options.o ws.o
+	transport.o bundle.o walker.o parse-options.o ws.o \
+	sha1-lookup.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/sha1-lookup.c b/sha1-lookup.c
new file mode 100644
index 0000000..f5c9094
--- /dev/null
+++ b/sha1-lookup.c
@@ -0,0 +1,153 @@
+#include "cache.h"
+#include "sha1-lookup.h"
+
+/*
+ * Conventional binary search loop looks like this:
+ *
+ *	unsigned lo, hi;
+ *      do {
+ *              unsigned mi = (lo + hi) / 2;
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
+ *   as lo, but never can be as same as hi), and check if it hits
+ *   the target.  There are three cases:
+ *
+ *    - if it is a hit, we are happy.
+ *
+ *    - if it is strictly higher than the target, we set it to hi,
+ *      and repeat the search.
+ *
+ *    - if it is strictly lower than the target, we update lo to
+ *      one slot after it, because we allow lo to be at the target.
+ *
+ *   If the loop exits, there is no matching entry.
+ *
+ * When choosing 'mi', we do not have to take the "middle" but
+ * anywhere in between lo and hi, as long as lo <= mi < hi is
+ * satisfied.  When we somehow know that the distance between the
+ * target and lo is much shorter than the target and hi, we could
+ * pick mi that is much closer to lo than the midway.
+ *
+ * Now, we can take advantage of the fact that SHA-1 is a good hash
+ * function, and as long as there are enough entries in the table, we
+ * can expect uniform distribution.  An entry that begins with for
+ * example "deadbeef..." is much likely to appear much later than in
+ * the midway of the table.  It can reasonably be expected to be near
+ * 87% (222/256) from the top of the table.
+ *
+ * The table at "table" holds at least "nr" entries of "elem_size"
+ * bytes each.  Each entry has the SHA-1 key at "key_offset".  The
+ * table is sorted by the SHA-1 key of the entries.  The caller wants
+ * to find the entry with "key", and knows that the entry at "lo" is
+ * not higher than the entry it is looking for, and that the entry at
+ * "hi" is higher than the entry it is looking for.
+ */
+int sha1_entry_pos(const void *table,
+		   size_t elem_size,
+		   size_t key_offset,
+		   unsigned lo, unsigned hi, unsigned nr,
+		   const unsigned char *key)
+{
+	const unsigned char *base = table;
+	const unsigned char *hi_key, *lo_key;
+	unsigned ofs_0;
+	static int debug_lookup = -1;
+
+	if (debug_lookup < 0)
+		debug_lookup = !!getenv("GIT_DEBUG_LOOKUP");
+
+	if (!nr || lo >= hi)
+		return -1;
+
+	if (nr == hi)
+		hi_key = NULL;
+	else
+		hi_key = base + elem_size * hi + key_offset;
+	lo_key = base + elem_size * lo + key_offset;
+
+	ofs_0 = 0;
+	do {
+		int cmp;
+		unsigned ofs, mi, range;
+		unsigned lov, hiv, kyv;
+		const unsigned char *mi_key;
+
+		range = hi - lo;
+		if (hi_key) {
+			for (ofs = ofs_0; ofs < 20; ofs++)
+				if (lo_key[ofs] != hi_key[ofs])
+					break;
+			ofs_0 = ofs;
+			/*
+			 * byte 0 thru (ofs-1) are the same between
+			 * lo and hi; ofs is the first byte that is
+			 * different.
+			 */
+			hiv = hi_key[ofs_0];
+			if (ofs_0 < 19)
+				hiv = (hiv << 8) | hi_key[ofs_0+1];
+		} else {
+			hiv = 256;
+			if (ofs_0 < 19)
+				hiv <<= 8;
+		}
+		lov = lo_key[ofs_0];
+		kyv = key[ofs_0];
+		if (ofs_0 < 19) {
+			lov = (lov << 8) | lo_key[ofs_0+1];
+			kyv = (kyv << 8) | key[ofs_0+1];
+		}
+		assert(lov < hiv);
+
+		if (kyv < lov)
+			return -1 - lo;
+		if (hiv < kyv)
+			return -1 - hi;
+
+		if (kyv == lov && lov < hiv - 1)
+			kyv++;
+		else if (kyv == hiv - 1 && lov < kyv)
+			kyv--;
+
+		mi = (range - 1) * (kyv - lov) / (hiv - lov) + lo;
+
+		if (debug_lookup) {
+			printf("lo %u hi %u rg %u mi %u ", lo, hi, range, mi);
+			printf("ofs %u lov %x, hiv %x, kyv %x\n",
+			       ofs_0, lov, hiv, kyv);
+		}
+		if (!(lo <= mi && mi < hi))
+			die("assertion failure lo %u mi %u hi %u %s",
+			    lo, mi, hi, sha1_to_hex(key));
+
+		mi_key = base + elem_size * mi + key_offset;
+		cmp = memcmp(mi_key + ofs_0, key + ofs_0, 20 - ofs_0);
+		if (!cmp)
+			return mi;
+		if (cmp > 0) {
+			hi = mi;
+			hi_key = mi_key;
+		}
+		else {
+			lo = mi + 1;
+			lo_key = mi_key + elem_size;
+		}
+	} while (lo < hi);
+	return -lo-1;
+}
+
diff --git a/sha1-lookup.h b/sha1-lookup.h
new file mode 100644
index 0000000..3249a81
--- /dev/null
+++ b/sha1-lookup.h
@@ -0,0 +1,9 @@
+#ifndef SHA1_LOOKUP_H
+#define SHA1_LOOKUP_H
+
+extern int sha1_entry_pos(const void *table,
+			  size_t elem_size,
+			  size_t key_offset,
+			  unsigned lo, unsigned hi, unsigned nr,
+			  const unsigned char *key);
+#endif
diff --git a/sha1_file.c b/sha1_file.c
index b0c2435..e99136a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -14,6 +14,7 @@
 #include "tag.h"
 #include "tree.h"
 #include "refs.h"
+#include "sha1-lookup.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -1655,7 +1656,12 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 {
 	const uint32_t *level1_ofs = p->index_data;
 	const unsigned char *index = p->index_data;
-	unsigned hi, lo;
+	unsigned hi, lo, stride;
+	static int use_lookup = -1;
+	static int debug_lookup = -1;
+
+	if (debug_lookup < 0)
+		debug_lookup = !!getenv("GIT_DEBUG_LOOKUP");
 
 	if (!index) {
 		if (open_pack_index(p))
@@ -1670,11 +1676,34 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 	index += 4 * 256;
 	hi = ntohl(level1_ofs[*sha1]);
 	lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
+	if (p->index_version > 1) {
+		stride = 20;
+	} else {
+		stride = 24;
+		index += 4;
+	}
+
+	if (debug_lookup)
+		printf("%02x%02x%02x... lo %u hi %u nr %u\n",
+		       sha1[0], sha1[1], sha1[2], lo, hi, p->num_objects);
+
+	if (use_lookup < 0)
+		use_lookup = !!getenv("GIT_USE_LOOKUP");
+	if (use_lookup) {
+		int pos = sha1_entry_pos(index, stride, 0,
+					 lo, hi, p->num_objects, sha1);
+		if (pos < 0)
+			return 0;
+		return nth_packed_object_offset(p, pos);
+	}
 
 	do {
 		unsigned mi = (lo + hi) / 2;
-		unsigned x = (p->index_version > 1) ? (mi * 20) : (mi * 24 + 4);
-		int cmp = hashcmp(index + x, sha1);
+		int cmp = hashcmp(index + mi * stride, sha1);
+
+		if (debug_lookup)
+			printf("lo %u hi %u rg %u mi %u\n",
+			       lo, hi, hi - lo, mi);
 		if (!cmp)
 			return nth_packed_object_offset(p, mi);
 		if (cmp > 0)
-- 
1.5.4.rc2.3.g441ed
