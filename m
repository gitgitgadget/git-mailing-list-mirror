From: mhagger@alum.mit.edu
Subject: [PATCH v2 31/51] refs: sort ref_dirs lazily
Date: Mon, 12 Dec 2011 06:38:38 +0100
Message-ID: <1323668338-1764-32-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:41:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZydQ-0000k3-73
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860Ab1LLFke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:34 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34828 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab1LLFkb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:31 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8ai015577;
	Mon, 12 Dec 2011 06:40:21 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186857>

From: Michael Haggerty <mhagger@alum.mit.edu>

Sort ref_dirs lazily, when the ordering is needed: for searching via
search_ref_dir(), and when iterating over the references via
do_for_each_ref_in_dir() and do_for_each_ref_in_dirs().

This change means that we never have to sort directories recursively,
so change sort_ref_dirs() to not recurse.

NOTE: the dirs can now be sorted as a side-effect of other function
calls.  Therefore, it would be problematic to do something from a
each_ref_fn callback that could provoke the sorting of the directory
that is currently being iterated over.  This is not so likely, because
a directory is always sorted just before being iterated over and thus
can be searched through during the iteration without causing a
re-sort.  But if a callback function would add a reference to a parent
directory of the reference in the iteration, then try to resolve a
reference under that directory, inconsistency could result.

Add a comment in refs.h warning against modifications during
iteration.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   35 +++++++++++++++--------------------
 refs.h |    7 +++++--
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/refs.c b/refs.c
index ce141ea..f01da78 100644
--- a/refs.c
+++ b/refs.c
@@ -256,9 +256,14 @@ static struct ref_entry *search_ref_dir(struct ref_dir *dir, const char *refname
 
 	/*
 	 * We need dir to be sorted so that binary search works.
-	 * Calling sort_ref_dir() here is not quite as terribly
-	 * inefficient as it looks, because directories that are
-	 * already sorted are not re-sorted.
+	 * Calling sort_ref_dir() here is not as terribly inefficient
+	 * as it looks.  (1) If the directory is already sorted, it is
+	 * not re-sorted. (2) When adding a reference,
+	 * search_ref_dir() is only called to find the containing
+	 * subdirectories; there is no search of the directory to
+	 * which the reference will be stored.  Thus adding a bunch of
+	 * references one after the other to a single subdirectory
+	 * doesn't require *any* intermediate sorting.
 	 */
 	sort_ref_dir(dir);
 
@@ -364,26 +369,16 @@ static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2
 }
 
 /*
- * Sort the entries in dir and its subdirectories (if they are not
- * already sorted).
+ * Sort the entries in dir (if they are not already sorted).  Sort
+ * only dir itself, not its subdirectories.
  */
 static void sort_ref_dir(struct ref_dir *dir)
 {
 	int i, j;
 	struct ref_entry *last = NULL;
 
-	if (dir->sorted == dir->nr) {
-		/*
-		 * This directory is already sorted and de-duped, but
-		 * we still have to sort subdirectories.
-		 */
-		for (i = 0; i < dir->nr; i++) {
-			struct ref_entry *entry = dir->entries[i];
-			if (entry->flag & REF_DIR)
-				sort_ref_dir(&entry->u.subdir);
-		}
-		return;
-	}
+	if (dir->sorted == dir->nr)
+		return; /* This directory is already sorted and de-duped */
 
 	qsort(dir->entries, dir->nr, sizeof(*dir->entries), ref_entry_cmp);
 
@@ -393,7 +388,6 @@ static void sort_ref_dir(struct ref_dir *dir)
 		if (last && is_dup_ref(last, entry)) {
 			free_ref_entry(entry);
 		} else if (entry->flag & REF_DIR) {
-			sort_ref_dir(&entry->u.subdir);
 			dir->entries[i++] = entry;
 			last = NULL;
 		} else {
@@ -430,6 +424,7 @@ static int do_for_each_ref_in_dir(struct ref_dir *dir, int offset,
 				  each_ref_fn fn, int trim, int flags, void *cb_data)
 {
 	int i;
+	sort_ref_dir(dir);
 	for (i = offset; i < dir->nr; i++) {
 		struct ref_entry *entry = dir->entries[i];
 		int retval;
@@ -453,6 +448,8 @@ static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
 	int retval;
 	int i1 = 0, i2 = 0;
 
+	sort_ref_dir(dir1);
+	sort_ref_dir(dir2);
 	while (1) {
 		struct ref_entry *e1, *e2, *entry;
 		int cmp;
@@ -701,7 +698,6 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 		    !get_sha1_hex(refline + 1, sha1))
 			hashcpy(last->u.value.peeled, sha1);
 	}
-	sort_ref_dir(dir);
 }
 
 void add_extra_ref(const char *refname, const unsigned char *sha1, int flag)
@@ -803,7 +799,6 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 {
 	if (!refs->did_loose) {
 		get_ref_dir(refs, "refs", &refs->loose);
-		sort_ref_dir(&refs->loose);
 		refs->did_loose = 1;
 	}
 	return &refs->loose;
diff --git a/refs.h b/refs.h
index d498291..5bb4678 100644
--- a/refs.h
+++ b/refs.h
@@ -15,8 +15,11 @@ struct ref_lock {
 #define REF_ISBROKEN 0x04
 
 /*
- * Calls the specified function for each ref file until it returns nonzero,
- * and returns the value
+ * Calls the specified function for each ref file until it returns
+ * nonzero, and returns the value.  Please note that it is not safe to
+ * modify references while an iteration is in progress, unless the
+ * same callback function invocation that modifies the reference also
+ * returns a nonzero value to immediately stop the iteration.
  */
 typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
 extern int head_ref(each_ref_fn, void *);
-- 
1.7.8
