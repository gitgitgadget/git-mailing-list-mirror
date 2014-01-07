From: Jeff King <peff@peff.net>
Subject: [PATCH v2 3/5] refs: teach for_each_ref a flag to avoid recursion
Date: Tue, 7 Jan 2014 18:58:50 -0500
Message-ID: <20140107235850.GC10657@sigill.intra.peff.net>
References: <20140107235631.GA10503@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brodie Rao <brodie@sf.io>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 00:59:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0gXw-0007o8-Oy
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 00:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbaAGX6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 18:58:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:56842 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753999AbaAGX6w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 18:58:52 -0500
Received: (qmail 1770 invoked by uid 102); 7 Jan 2014 23:58:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 17:58:52 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 18:58:50 -0500
Content-Disposition: inline
In-Reply-To: <20140107235631.GA10503@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240185>

The normal for_each_ref traversal descends into
subdirectories, returning each ref it finds. However, in
some cases we may want to just iterate over the top-level of
a certain part of the tree.

The introduction of the "flags" option is a little
mysterious. We already have a "flags" option that gets stuck
in a callback struct and ends up interpreted in do_one_ref.
But the traversal itself does not currently have any flags,
and it needs to know about this new flag.

We _could_ introduce this as a completely separate flag
parameter. But instead, we simply put both flag types into a
single namespace, and make it available at both sites. This
is simple, and given that we do not have a proliferation of
flags (we have had exactly one until now), it is probably
sufficient.

Signed-off-by: Jeff King <peff@peff.net>
---
I think the flags thing is OK as explained above, but Michael may have a
different suggestion for refactoring.

 refs.c | 61 ++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/refs.c b/refs.c
index 3926136..ca854d6 100644
--- a/refs.c
+++ b/refs.c
@@ -589,6 +589,8 @@ static void sort_ref_dir(struct ref_dir *dir)
 
 /* Include broken references in a do_for_each_ref*() iteration: */
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
+/* Do not recurse into subdirs, just iterate at a single level. */
+#define DO_FOR_EACH_NO_RECURSE     0x02
 
 /*
  * Return true iff the reference described by entry can be resolved to
@@ -661,7 +663,8 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
  * called for all references, including broken ones.
  */
 static int do_for_each_entry_in_dir(struct ref_dir *dir, int offset,
-				    each_ref_entry_fn fn, void *cb_data)
+				    each_ref_entry_fn fn, void *cb_data,
+				    int flags)
 {
 	int i;
 	assert(dir->sorted == dir->nr);
@@ -669,9 +672,13 @@ static int do_for_each_entry_in_dir(struct ref_dir *dir, int offset,
 		struct ref_entry *entry = dir->entries[i];
 		int retval;
 		if (entry->flag & REF_DIR) {
-			struct ref_dir *subdir = get_ref_dir(entry);
-			sort_ref_dir(subdir);
-			retval = do_for_each_entry_in_dir(subdir, 0, fn, cb_data);
+			if (flags & DO_FOR_EACH_NO_RECURSE) {
+				struct ref_dir *subdir = get_ref_dir(entry);
+				sort_ref_dir(subdir);
+				retval = do_for_each_entry_in_dir(subdir, 0,
+								  fn, cb_data,
+								  flags);
+			}
 		} else {
 			retval = fn(entry, cb_data);
 		}
@@ -691,7 +698,8 @@ static int do_for_each_entry_in_dir(struct ref_dir *dir, int offset,
  */
 static int do_for_each_entry_in_dirs(struct ref_dir *dir1,
 				     struct ref_dir *dir2,
-				     each_ref_entry_fn fn, void *cb_data)
+				     each_ref_entry_fn fn, void *cb_data,
+				     int flags)
 {
 	int retval;
 	int i1 = 0, i2 = 0;
@@ -702,10 +710,12 @@ static int do_for_each_entry_in_dirs(struct ref_dir *dir1,
 		struct ref_entry *e1, *e2;
 		int cmp;
 		if (i1 == dir1->nr) {
-			return do_for_each_entry_in_dir(dir2, i2, fn, cb_data);
+			return do_for_each_entry_in_dir(dir2, i2, fn, cb_data,
+							flags);
 		}
 		if (i2 == dir2->nr) {
-			return do_for_each_entry_in_dir(dir1, i1, fn, cb_data);
+			return do_for_each_entry_in_dir(dir1, i1, fn, cb_data,
+							flags);
 		}
 		e1 = dir1->entries[i1];
 		e2 = dir2->entries[i2];
@@ -713,12 +723,15 @@ static int do_for_each_entry_in_dirs(struct ref_dir *dir1,
 		if (cmp == 0) {
 			if ((e1->flag & REF_DIR) && (e2->flag & REF_DIR)) {
 				/* Both are directories; descend them in parallel. */
-				struct ref_dir *subdir1 = get_ref_dir(e1);
-				struct ref_dir *subdir2 = get_ref_dir(e2);
-				sort_ref_dir(subdir1);
-				sort_ref_dir(subdir2);
-				retval = do_for_each_entry_in_dirs(
-						subdir1, subdir2, fn, cb_data);
+				if (!(flags & DO_FOR_EACH_NO_RECURSE)) {
+					struct ref_dir *subdir1 = get_ref_dir(e1);
+					struct ref_dir *subdir2 = get_ref_dir(e2);
+					sort_ref_dir(subdir1);
+					sort_ref_dir(subdir2);
+					retval = do_for_each_entry_in_dirs(
+							subdir1, subdir2,
+							fn, cb_data, flags);
+				}
 				i1++;
 				i2++;
 			} else if (!(e1->flag & REF_DIR) && !(e2->flag & REF_DIR)) {
@@ -743,7 +756,7 @@ static int do_for_each_entry_in_dirs(struct ref_dir *dir1,
 				struct ref_dir *subdir = get_ref_dir(e);
 				sort_ref_dir(subdir);
 				retval = do_for_each_entry_in_dir(
-						subdir, 0, fn, cb_data);
+						subdir, 0, fn, cb_data, flags);
 			} else {
 				retval = fn(e, cb_data);
 			}
@@ -817,7 +830,7 @@ static int is_refname_available(const char *refname, const char *oldrefname,
 	data.conflicting_refname = NULL;
 
 	sort_ref_dir(dir);
-	if (do_for_each_entry_in_dir(dir, 0, name_conflict_fn, &data)) {
+	if (do_for_each_entry_in_dir(dir, 0, name_conflict_fn, &data, 0)) {
 		error("'%s' exists; cannot create '%s'",
 		      data.conflicting_refname, refname);
 		return 0;
@@ -1651,7 +1664,8 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
  * 0.
  */
 static int do_for_each_entry(struct ref_cache *refs, const char *base,
-			     each_ref_entry_fn fn, void *cb_data)
+			     each_ref_entry_fn fn, void *cb_data,
+			     int flags)
 {
 	struct packed_ref_cache *packed_ref_cache;
 	struct ref_dir *loose_dir;
@@ -1684,15 +1698,15 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
 		sort_ref_dir(packed_dir);
 		sort_ref_dir(loose_dir);
 		retval = do_for_each_entry_in_dirs(
-				packed_dir, loose_dir, fn, cb_data);
+				packed_dir, loose_dir, fn, cb_data, flags);
 	} else if (packed_dir) {
 		sort_ref_dir(packed_dir);
 		retval = do_for_each_entry_in_dir(
-				packed_dir, 0, fn, cb_data);
+				packed_dir, 0, fn, cb_data, flags);
 	} else if (loose_dir) {
 		sort_ref_dir(loose_dir);
 		retval = do_for_each_entry_in_dir(
-				loose_dir, 0, fn, cb_data);
+				loose_dir, 0, fn, cb_data, flags);
 	}
 
 	release_packed_ref_cache(packed_ref_cache);
@@ -1718,7 +1732,7 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
 	data.fn = fn;
 	data.cb_data = cb_data;
 
-	return do_for_each_entry(refs, base, do_one_ref, &data);
+	return do_for_each_entry(refs, base, do_one_ref, &data, flags);
 }
 
 static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
@@ -2200,7 +2214,7 @@ int commit_packed_refs(void)
 
 	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
 				 0, write_packed_entry_fn,
-				 &packed_ref_cache->lock->fd);
+				 &packed_ref_cache->lock->fd, 0);
 	if (commit_lock_file(packed_ref_cache->lock))
 		error = -1;
 	packed_ref_cache->lock = NULL;
@@ -2345,7 +2359,7 @@ int pack_refs(unsigned int flags)
 	cbdata.packed_refs = get_packed_refs(&ref_cache);
 
 	do_for_each_entry_in_dir(get_loose_refs(&ref_cache), 0,
-				 pack_if_possible_fn, &cbdata);
+				 pack_if_possible_fn, &cbdata, 0);
 
 	if (commit_packed_refs())
 		die_errno("unable to overwrite old ref-pack file");
@@ -2447,7 +2461,8 @@ static int repack_without_refs(const char **refnames, int n)
 	}
 
 	/* Remove any other accumulated cruft */
-	do_for_each_entry_in_dir(packed, 0, curate_packed_ref_fn, &refs_to_delete);
+	do_for_each_entry_in_dir(packed, 0, curate_packed_ref_fn,
+				 &refs_to_delete, 0);
 	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
 		if (remove_entry(packed, ref_to_delete->string) == -1)
 			die("internal error");
-- 
1.8.5.2.500.g8060133
