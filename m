From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] Implement the patience diff algorithm
Date: Thu, 1 Jan 2009 17:38:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901011738240.30769@pacific.mpi-cbg.de>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp>
 <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: davidel@xmailserver.org, Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jan 01 17:39:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIQaB-00076f-3d
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 17:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251AbZAAQiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 11:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756245AbZAAQiR
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 11:38:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:38518 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756203AbZAAQiP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 11:38:15 -0500
Received: (qmail invoked by alias); 01 Jan 2009 16:38:12 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp031) with SMTP; 01 Jan 2009 17:38:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+wiM4d4w6wrKBqEcWRRSJRD+Gzau1jaEkYW+lQ3+
	dmI7J/+oPrMuZC
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104299>


The patience diff algorithm produces slightly more intuitive output
than the classic Myers algorithm, as it does not try to minimize the
number of +/- lines first, but tries to preserve the lines that are
unique.

To this end, it first determines lines that are unique in both files,
then the maximal sequence which preserves the order (relative to both
files) is extracted.

Starting from this initial set of common lines, the rest of the lines
is handled recursively, with Myers' algorithm as a fallback when
the patience algorithm fails (due to no common unique lines).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 xdiff/xdiff.h     |    1 +
 xdiff/xdiffi.c    |    3 +
 xdiff/xdiffi.h    |    2 +
 xdiff/xpatience.c |  374 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 380 insertions(+), 0 deletions(-)
 create mode 100644 xdiff/xpatience.c

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 361f802..4da052a 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -32,6 +32,7 @@ extern "C" {
 #define XDF_IGNORE_WHITESPACE (1 << 2)
 #define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
 #define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
+#define XDF_PATIENCE_DIFF (1 << 5)
 #define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
 
 #define XDL_PATCH_NORMAL '-'
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 9d0324a..3e97462 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -329,6 +329,9 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	xdalgoenv_t xenv;
 	diffdata_t dd1, dd2;
 
+	if (xpp->flags & XDF_PATIENCE_DIFF)
+		return xdl_do_patience_diff(mf1, mf2, xpp, xe);
+
 	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0) {
 
 		return -1;
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
index 3e099dc..ad033a8 100644
--- a/xdiff/xdiffi.h
+++ b/xdiff/xdiffi.h
@@ -55,5 +55,7 @@ int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr);
 void xdl_free_script(xdchange_t *xscr);
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg);
+int xdl_do_patience_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
+		xdfenv_t *env);
 
 #endif /* #if !defined(XDIFFI_H) */
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
new file mode 100644
index 0000000..6687940
--- /dev/null
+++ b/xdiff/xpatience.c
@@ -0,0 +1,374 @@
+/*
+ *  LibXDiff by Davide Libenzi ( File Differential Library )
+ *  Copyright (C) 2003-2009 Davide Libenzi, Johannes E. Schindelin
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *  Davide Libenzi <davidel@xmailserver.org>
+ *
+ */
+#include "xinclude.h"
+#include "xtypes.h"
+#include "xdiff.h"
+
+/*
+ * The basic idea of patience diff is to find lines that are unique in
+ * both files.  These are intuitively the ones that we want to see as
+ * common lines.
+ *
+ * The maximal ordered sequence of such line pairs (where ordered means
+ * that the order in the sequence agrees with the order of the lines in
+ * both files) naturally defines an initial set of common lines.
+ *
+ * Now, the algorithm tries to extend the set of common lines by growing
+ * the line ranges where the files have identical lines.
+ *
+ * Between those common lines, the patience diff algorithm is applied
+ * recursively, until no unique line pairs can be found; these line ranges
+ * are handled by the well-known Myers algorithm.
+ */
+
+#define NON_UNIQUE ULONG_MAX
+
+/*
+ * This is a hash mapping from line hash to line numbers in the first and
+ * second file.
+ */
+struct hashmap {
+	int nr, alloc;
+	struct entry {
+		unsigned long hash;
+		/*
+		 * 0 = unused entry, 1 = first line, 2 = second, etc.
+		 * line2 is NON_UNIQUE if the line is not unique
+		 * in either the first or the second file.
+		 */
+		unsigned long line1, line2;
+		/*
+		 * "next" & "previous" are used for the longest common
+		 * sequence;
+		 * initially, "next" reflects only the order in file1.
+		 */
+		struct entry *next, *previous;
+	} *entries, *first, *last;
+	/* were common records found? */
+	unsigned long has_matches;
+	mmfile_t *file1, *file2;
+	xdfenv_t *env;
+	xpparam_t const *xpp;
+};
+
+/* The argument "pass" is 1 for the first file, 2 for the second. */
+static void insert_record(int line, struct hashmap *map, int pass)
+{
+	xrecord_t **records = pass == 1 ?
+		map->env->xdf1.recs : map->env->xdf2.recs;
+	xrecord_t *record = records[line - 1], *other;
+	/*
+	 * After xdl_prepare_env() (or more precisely, due to
+	 * xdl_classify_record()), the "ha" member of the records (AKA lines)
+	 * is _not_ the hash anymore, but a linearized version of it.  In
+	 * other words, the "ha" member is guaranteed to start with 0 and
+	 * the second record's ha can only be 0 or 1, etc.
+	 *
+	 * So we multiply ha by 2 in the hope that the hashing was
+	 * "unique enough".
+	 */
+	int index = (int)((record->ha << 1) % map->alloc);
+
+	while (map->entries[index].line1) {
+		other = map->env->xdf1.recs[map->entries[index].line1 - 1];
+		if (map->entries[index].hash != record->ha ||
+				!xdl_recmatch(record->ptr, record->size,
+					other->ptr, other->size,
+					map->xpp->flags)) {
+			if (++index >= map->alloc)
+				index = 0;
+			continue;
+		}
+		if (pass == 2)
+			map->has_matches = 1;
+		if (pass == 1 || map->entries[index].line2)
+			map->entries[index].line2 = NON_UNIQUE;
+		else
+			map->entries[index].line2 = line;
+		return;
+	}
+	if (pass == 2)
+		return;
+	map->entries[index].line1 = line;
+	map->entries[index].hash = record->ha;
+	if (!map->first)
+		map->first = map->entries + index;
+	if (map->last) {
+		map->last->next = map->entries + index;
+		map->entries[index].previous = map->last;
+	}
+	map->last = map->entries + index;
+	map->nr++;
+}
+
+/*
+ * This function has to be called for each recursion into the inter-hunk
+ * parts, as previously non-unique lines can become unique when being
+ * restricted to a smaller part of the files.
+ *
+ * It is assumed that env has been prepared using xdl_prepare().
+ */
+static int fill_hashmap(mmfile_t *file1, mmfile_t *file2,
+		xpparam_t const *xpp, xdfenv_t *env,
+		struct hashmap *result,
+		int line1, int count1, int line2, int count2)
+{
+	result->file1 = file1;
+	result->file2 = file2;
+	result->xpp = xpp;
+	result->env = env;
+
+	/* We know exactly how large we want the hash map */
+	result->alloc = count1 * 2;
+	result->entries = (struct entry *)
+		xdl_malloc(result->alloc * sizeof(struct entry));
+	if (!result->entries)
+		return -1;
+	memset(result->entries, 0, result->alloc * sizeof(struct entry));
+
+	/* First, fill with entries from the first file */
+	while (count1--)
+		insert_record(line1++, result, 1);
+
+	/* Then search for matches in the second file */
+	while (count2--)
+		insert_record(line2++, result, 2);
+
+	return 0;
+}
+
+/*
+ * Find the longest sequence with a smaller last element (meaning a smaller
+ * line2, as we construct the sequence with entries ordered by line1).
+ */
+static int binary_search(struct entry **sequence, int longest,
+		struct entry *entry)
+{
+	int left = -1, right = longest;
+
+	while (left + 1 < right) {
+		int middle = (left + right) / 2;
+		/* by construction, no two entries can be equal */
+		if (sequence[middle]->line2 > entry->line2)
+			right = middle;
+		else
+			left = middle;
+	}
+	/* return the index in "sequence", _not_ the sequence length */
+	return left;
+}
+
+/*
+ * The idea is to start with the list of common unique lines sorted by
+ * the order in file1.  For each of these pairs, the longest (partial)
+ * sequence whose last element's line2 is smaller is determined.
+ *
+ * For efficiency, the sequences are kept in a list containing exactly one
+ * item per sequence length: the sequence with the smallest last
+ * element (in terms of line2).
+ */
+static struct entry *find_longest_common_sequence(struct hashmap *map)
+{
+	struct entry **sequence = xdl_malloc(map->nr * sizeof(struct entry *));
+	int longest = 0, i;
+	struct entry *entry;
+
+	for (entry = map->first; entry; entry = entry->next) {
+		if (!entry->line2 || entry->line2 == NON_UNIQUE)
+			continue;
+		i = binary_search(sequence, longest, entry);
+		entry->previous = i < 0 ? NULL : sequence[i];
+		sequence[++i] = entry;
+		if (i == longest)
+			longest++;
+	}
+
+	/* No common unique lines were found */
+	if (!longest)
+		return NULL;
+
+	/* Iterate starting at the last element, adjusting the "next" members */
+	entry = sequence[longest - 1];
+	entry->next = NULL;
+	while (entry->previous) {
+		entry->previous->next = entry;
+		entry = entry->previous;
+	}
+	return entry;
+}
+
+static int match(struct hashmap *map, int line1, int line2)
+{
+	xrecord_t *record1 = map->env->xdf1.recs[line1 - 1];
+	xrecord_t *record2 = map->env->xdf2.recs[line2 - 1];
+	return xdl_recmatch(record1->ptr, record1->size,
+		record2->ptr, record2->size, map->xpp->flags);
+}
+
+static int patience_diff(mmfile_t *file1, mmfile_t *file2,
+		xpparam_t const *xpp, xdfenv_t *env,
+		int line1, int count1, int line2, int count2);
+
+static int walk_common_sequence(struct hashmap *map, struct entry *first,
+		int line1, int count1, int line2, int count2)
+{
+	int end1 = line1 + count1, end2 = line2 + count2;
+	int next1, next2;
+
+	for (;;) {
+		/* Try to grow the line ranges of common lines */
+		if (first) {
+			next1 = first->line1;
+			next2 = first->line2;
+			while (next1 > line1 && next2 > line2 &&
+					match(map, next1 - 1, next2 - 1)) {
+				next1--;
+				next2--;
+			}
+		} else {
+			next1 = end1;
+			next2 = end2;
+		}
+		while (line1 < next1 && line2 < next2 &&
+				match(map, line1, line2)) {
+			line1++;
+			line2++;
+		}
+
+		/* Recurse */
+		if (next1 > line1 || next2 > line2) {
+			struct hashmap submap;
+
+			memset(&submap, 0, sizeof(submap));
+			if (patience_diff(map->file1, map->file2,
+					map->xpp, map->env,
+					line1, next1 - line1,
+					line2, next2 - line2))
+				return -1;
+		}
+
+		if (!first)
+			return 0;
+
+		while (first->next &&
+				first->next->line1 == first->line1 + 1 &&
+				first->next->line2 == first->line2 + 1)
+			first = first->next;
+
+		line1 = first->line1 + 1;
+		line2 = first->line2 + 1;
+
+		first = first->next;
+	}
+}
+
+static int fall_back_to_classic_diff(struct hashmap *map,
+		int line1, int count1, int line2, int count2)
+{
+	/*
+	 * This probably does not work outside Git, since
+	 * we have a very simple mmfile structure.
+	 *
+	 * Note: ideally, we would reuse the prepared environment, but
+	 * the libxdiff interface does not (yet) allow for diffing only
+	 * ranges of lines instead of the whole files.
+	 */
+	mmfile_t subfile1, subfile2;
+	xpparam_t xpp;
+	xdfenv_t env;
+
+	subfile1.ptr = (char *)map->env->xdf1.recs[line1 - 1]->ptr;
+	subfile1.size = map->env->xdf1.recs[line1 + count1 - 2]->ptr +
+		map->env->xdf1.recs[line1 + count1 - 2]->size - subfile1.ptr;
+	subfile2.ptr = (char *)map->env->xdf2.recs[line2 - 1]->ptr;
+	subfile2.size = map->env->xdf2.recs[line2 + count2 - 2]->ptr +
+		map->env->xdf2.recs[line2 + count2 - 2]->size - subfile2.ptr;
+	xpp.flags = map->xpp->flags & ~XDF_PATIENCE_DIFF;
+	if (xdl_do_diff(&subfile1, &subfile2, &xpp, &env) < 0)
+		return -1;
+
+	memcpy(map->env->xdf1.rchg + line1 - 1, env.xdf1.rchg, count1);
+	memcpy(map->env->xdf2.rchg + line2 - 1, env.xdf2.rchg, count2);
+
+	return 0;
+}
+
+/*
+ * Recursively find the longest common sequence of unique lines,
+ * and if none was found, ask xdl_do_diff() to do the job.
+ *
+ * This function assumes that env was prepared with xdl_prepare_env().
+ */
+static int patience_diff(mmfile_t *file1, mmfile_t *file2,
+		xpparam_t const *xpp, xdfenv_t *env,
+		int line1, int count1, int line2, int count2)
+{
+	struct hashmap map;
+	struct entry *first;
+	int result = 0;
+
+	/* trivial case: one side is empty */
+	if (!count1) {
+		while(count2--)
+			env->xdf2.rchg[line2++ - 1] = 1;
+		return 0;
+	} else if (!count2) {
+		while(count1--)
+			env->xdf1.rchg[line1++ - 1] = 1;
+		return 0;
+	}
+
+	memset(&map, 0, sizeof(map));
+	if (fill_hashmap(file1, file2, xpp, env, &map,
+			line1, count1, line2, count2))
+		return -1;
+
+	/* are there any matching lines at all? */
+	if (!map.has_matches) {
+		while(count1--)
+			env->xdf1.rchg[line1++ - 1] = 1;
+		while(count2--)
+			env->xdf2.rchg[line2++ - 1] = 1;
+		return 0;
+	}
+
+	first = find_longest_common_sequence(&map);
+	if (first)
+		result = walk_common_sequence(&map, first,
+			line1, count1, line2, count2);
+	else
+		result = fall_back_to_classic_diff(&map,
+			line1, count1, line2, count2);
+
+	return result;
+}
+
+int xdl_do_patience_diff(mmfile_t *file1, mmfile_t *file2,
+		xpparam_t const *xpp, xdfenv_t *env)
+{
+	if (xdl_prepare_env(file1, file2, xpp, env) < 0)
+		return -1;
+
+	/* environment is cleaned up in xdl_diff() */
+	return patience_diff(file1, file2, xpp, env,
+			1, env->xdf1.nrec, 1, env->xdf2.nrec);
+}
-- 
1.6.1.rc3.412.ga72b
