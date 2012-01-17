From: mhagger@alum.mit.edu
Subject: [PATCH 2/4] ref_array: keep track of whether references are sorted
Date: Tue, 17 Jan 2012 06:50:32 +0100
Message-ID: <1326779434-20106-3-git-send-email-mhagger@alum.mit.edu>
References: <1326779434-20106-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 06:51:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn1wk-0005yX-Rx
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 06:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912Ab2AQFu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 00:50:57 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50012 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab2AQFu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 00:50:56 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEDA74.dip.t-dialin.net [84.190.218.116])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0H5oam4006829;
	Tue, 17 Jan 2012 06:50:40 +0100
X-Mailer: git-send-email 1.7.8.3
In-Reply-To: <1326779434-20106-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188686>

From: Michael Haggerty <mhagger@alum.mit.edu>

Keep track of how many entries in a ref_array are already sorted.  In
sort_ref_array(), only call qsort() if the dir contains unsorted
entries (i.e., if references have been appended to the end of the list
since the last call to sort_ref_array()).

Sort ref_arrays only when needed, namely in search_ref_array() and in
do_for_each_ref().  However, never sort the extra_refs, because
extra_refs can contain multiple entries with the same name.

This change is currently not useful, because entries are not added to
ref_arrays after they are created.  But in a moment they will be...

Implementation note: we could store a binary "sorted" value instead of
an integer, but storing the number of sorted entries leaves the way
open for a couple of possible future optimizations:

* In sort_ref_array(), sort *only* the unsorted entries, then merge
  them with the sorted entries.  This should be faster if most of the
  entries are already sorted.

* Teach search_ref_array() to do a binary search of any sorted
  entries, and if unsuccessful do a linear search of any unsorted
  entries.  This would avoid the need to sort the list every time that
  search_ref_array() is called, and (given some intelligence about how
  often to sort) could significantly improve the speed in certain
  hypothetical usage patterns.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   33 ++++++++++++++++++++++++++-------
 1 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 6f436f1..268816f 100644
--- a/refs.c
+++ b/refs.c
@@ -17,6 +17,15 @@ struct ref_entry {
 
 struct ref_array {
 	int nr, alloc;
+
+	/*
+	 * Entries with index 0 <= i < sorted are sorted by name.  New
+	 * entries are appended to the list unsorted, and are sorted
+	 * only when required; thus we avoid the need to sort the list
+	 * after the addition of every reference.
+	 */
+	int sorted;
+
 	struct ref_entry **refs;
 };
 
@@ -105,12 +114,18 @@ static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2
 	}
 }
 
+/*
+ * Sort the entries in array (if they are not already sorted).
+ */
 static void sort_ref_array(struct ref_array *array)
 {
 	int i, j;
 
-	/* Nothing to sort unless there are at least two entries */
-	if (array->nr < 2)
+	/*
+	 * This check also prevents passing a zero-length array to qsort(),
+	 * which is a problem on some platforms.
+	 */
+	if (array->sorted == array->nr)
 		return;
 
 	qsort(array->refs, array->nr, sizeof(*array->refs), ref_entry_cmp);
@@ -124,7 +139,7 @@ static void sort_ref_array(struct ref_array *array)
 		}
 		array->refs[++i] = array->refs[j];
 	}
-	array->nr = i + 1;
+	array->sorted = array->nr = i + 1;
 }
 
 static struct ref_entry *search_ref_array(struct ref_array *array, const char *refname)
@@ -137,7 +152,7 @@ static struct ref_entry *search_ref_array(struct ref_array *array, const char *r
 
 	if (!array->nr)
 		return NULL;
-
+	sort_ref_array(array);
 	len = strlen(refname) + 1;
 	e = xmalloc(sizeof(struct ref_entry) + len);
 	memcpy(e->name, refname, len);
@@ -168,6 +183,10 @@ static struct ref_cache {
 
 static struct ref_entry *current_ref;
 
+/*
+ * The extra_refs is never sorted, because it is allowed to contain entries
+ * with duplicate names.
+ */
 static struct ref_array extra_refs;
 
 static void clear_ref_array(struct ref_array *array)
@@ -176,7 +195,7 @@ static void clear_ref_array(struct ref_array *array)
 	for (i = 0; i < array->nr; i++)
 		free(array->refs[i]);
 	free(array->refs);
-	array->nr = array->alloc = 0;
+	array->sorted = array->nr = array->alloc = 0;
 	array->refs = NULL;
 }
 
@@ -268,7 +287,6 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 		    !get_sha1_hex(refline + 1, sha1))
 			hashcpy(last->peeled, sha1);
 	}
-	sort_ref_array(array);
 }
 
 void add_extra_ref(const char *refname, const unsigned char *sha1, int flag)
@@ -404,7 +422,6 @@ static struct ref_array *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->did_loose) {
 		get_ref_dir(refs, "refs", &refs->loose);
-		sort_ref_array(&refs->loose);
 		refs->did_loose = 1;
 	}
 	return &refs->loose;
@@ -720,6 +737,8 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 	for (i = 0; i < extra->nr; i++)
 		retval = do_one_ref(base, fn, trim, flags, cb_data, extra->refs[i]);
 
+	sort_ref_array(packed);
+	sort_ref_array(loose);
 	while (p < packed->nr && l < loose->nr) {
 		struct ref_entry *entry;
 		int cmp = strcmp(packed->refs[p]->name, loose->refs[l]->name);
-- 
1.7.8.3
