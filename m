From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 15/33] refs: change the internal reference-iteration API
Date: Mon, 22 Apr 2013 21:52:23 +0200
Message-ID: <1366660361-21831-16-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:54:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMoU-0005Bt-Rv
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172Ab3DVTyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:54:07 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:53461 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755139Ab3DVTxu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:53:50 -0400
X-AuditID: 1207440f-b7f0e6d000000957-ab-5175954d3e7c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 9A.0D.02391.D4595715; Mon, 22 Apr 2013 15:53:49 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOS008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:48 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqOs7tTTQoHuTpEXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGdcePqfqaAps2L3pzbGBsZr
	wV2MnBwSAiYSk3YuYoOwxSQu3FsPZHNxCAlcZpS4cGgWI4RzgUliTcMqRpAqNgFdiUU9zUwg
	toiAmsTEtkMsIDazgIPE5s+NYDXCAt4Sb2Z9YgaxWQRUJX6cmgVWwyvgKjHh8ERmiG0KEse3
	bwOr5wSKn+44AVYjJOAiseLgVJYJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6OVm
	luilppRuYoQEC/8Oxq71MocYBTgYlXh4MzxLA4VYE8uKK3MPMUpyMCmJ8nJMAQrxJeWnVGYk
	FmfEF5XmpBYfYpTgYFYS4RXNB8rxpiRWVqUW5cOkpDlYlMR51Zeo+wkJpCeWpGanphakFsFk
	ZTg4lCR4M0CGChalpqdWpGXmlCCkmTg4QQQXyAYeoA2RIIW8xQWJucWZ6RBFpxgVpcR53SYB
	JQRAEhmleXADYHH9ilEc6B9hXg+Qdh5gSoDrfgU0mAlocGZCCcjgkkSElFQDY/1Hda72gxy7
	Vtftjr0jxsB1MuFK3iEfx8vZpk77w/6d+25lLiL0PjThPvfzE1O/7nwov/dh9rSMm0KN4suE
	pzxW2871rfkCV9lW+fzz8r7STVMyzW5yC7T9k756VNjenyPVPfOUkAO3rEYaR8P/ksY5f884
	RF/nlrj53M4i4uiTJy8XFWRFKbEUZyQaajEXFScCAGzBldLGAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222062>

Establish an internal API for iterating over references, which gives
the callback functions direct access to the ref_entry structure
describing the reference.  (Do not change the iteration API that is
exposed outside of the module.)

Define a new internal callback signature

   int each_ref_entry_fn(struct ref_entry *entry, void *cb_data)

Change do_for_each_ref_in_dir() and do_for_each_ref_in_dirs() to
accept each_ref_entry_fn callbacks, and rename them to
do_for_each_entry_in_dir() and do_for_each_entry_in_dirs(),
respectively.  Adapt their callers accordingly.

Add a new function do_for_each_entry() analogous to do_for_each_ref()
but using the new callback style.

Change do_one_ref() into an each_ref_entry_fn that does some
bookkeeping and then calls a wrapped each_ref_fn.

Reimplement do_for_each_ref() in terms of do_for_each_entry(), using
do_one_ref() as an adapter.

Please note that the responsibility for setting current_ref remains in
do_one_ref(), which means that current_ref is *not* set when iterating
over references via the new internal API.  This is not a disadvantage,
because current_ref is not needed by callers of the internal API (they
receive a pointer to the current ref_entry anyway).  But more
importantly, this change prevents peel_ref() from returning invalid
results in the following scenario:

When iterating via the external API, the iteration always includes
both packed and loose references, and in particular never presents a
packed ref if there is a loose ref with the same name.  The internal
API, on the other hand, gives the option to iterate over only the
packed references.  During such an iteration, there is no check
whether the packed ref might be hidden by a loose ref of the same
name.  But until now the packed ref was recorded in current_ref during
the iteration.  So if peel_ref() were called with the reference name
corresponding to current ref, it would return the peeled version of
the packed ref even though there might be a loose ref that peels to a
different value.  This scenario doesn't currently occur in the code,
but fix it to prevent things from breaking in a very confusing way in
the future.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 144 +++++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 83 insertions(+), 61 deletions(-)

diff --git a/refs.c b/refs.c
index 777a4b7..ed54ed4 100644
--- a/refs.c
+++ b/refs.c
@@ -556,22 +556,34 @@ static int ref_resolves_to_object(struct ref_entry *entry)
  */
 static struct ref_entry *current_ref;
 
+typedef int each_ref_entry_fn(struct ref_entry *entry, void *cb_data);
+
+struct ref_entry_cb {
+	const char *base;
+	int trim;
+	int flags;
+	each_ref_fn *fn;
+	void *cb_data;
+};
+
 /*
- * Handle one reference in a do_for_each_ref*()-style iteration.
+ * Handle one reference in a do_for_each_ref*()-style iteration,
+ * calling an each_ref_fn for each entry.
  */
-static int do_one_ref(const char *base, each_ref_fn fn, int trim,
-		      int flags, void *cb_data, struct ref_entry *entry)
+static int do_one_ref(struct ref_entry *entry, void *cb_data)
 {
+	struct ref_entry_cb *data = cb_data;
 	int retval;
-	if (prefixcmp(entry->name, base))
+	if (prefixcmp(entry->name, data->base))
 		return 0;
 
-	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+	if (!(data->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
 	      !ref_resolves_to_object(entry))
 		return 0;
 
 	current_ref = entry;
-	retval = fn(entry->name + trim, entry->u.value.sha1, entry->flag, cb_data);
+	retval = data->fn(entry->name + data->trim, entry->u.value.sha1,
+			  entry->flag, data->cb_data);
 	current_ref = NULL;
 	return retval;
 }
@@ -580,11 +592,11 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
  * Call fn for each reference in dir that has index in the range
  * offset <= index < dir->nr.  Recurse into subdirectories that are in
  * that index range, sorting them before iterating.  This function
- * does not sort dir itself; it should be sorted beforehand.
+ * does not sort dir itself; it should be sorted beforehand.  fn is
+ * called for all references, including broken ones.
  */
-static int do_for_each_ref_in_dir(struct ref_dir *dir, int offset,
-				  const char *base,
-				  each_ref_fn fn, int trim, int flags, void *cb_data)
+static int do_for_each_entry_in_dir(struct ref_dir *dir, int offset,
+				    each_ref_entry_fn fn, void *cb_data)
 {
 	int i;
 	assert(dir->sorted == dir->nr);
@@ -594,10 +606,9 @@ static int do_for_each_ref_in_dir(struct ref_dir *dir, int offset,
 		if (entry->flag & REF_DIR) {
 			struct ref_dir *subdir = get_ref_dir(entry);
 			sort_ref_dir(subdir);
-			retval = do_for_each_ref_in_dir(subdir, 0,
-							base, fn, trim, flags, cb_data);
+			retval = do_for_each_entry_in_dir(subdir, 0, fn, cb_data);
 		} else {
-			retval = do_one_ref(base, fn, trim, flags, cb_data, entry);
+			retval = fn(entry, cb_data);
 		}
 		if (retval)
 			return retval;
@@ -610,12 +621,12 @@ static int do_for_each_ref_in_dir(struct ref_dir *dir, int offset,
  * by refname.  Recurse into subdirectories.  If a value entry appears
  * in both dir1 and dir2, then only process the version that is in
  * dir2.  The input dirs must already be sorted, but subdirs will be
- * sorted as needed.
+ * sorted as needed.  fn is called for all references, including
+ * broken ones.
  */
-static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
-				   struct ref_dir *dir2,
-				   const char *base, each_ref_fn fn, int trim,
-				   int flags, void *cb_data)
+static int do_for_each_entry_in_dirs(struct ref_dir *dir1,
+				     struct ref_dir *dir2,
+				     each_ref_entry_fn fn, void *cb_data)
 {
 	int retval;
 	int i1 = 0, i2 = 0;
@@ -626,12 +637,10 @@ static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
 		struct ref_entry *e1, *e2;
 		int cmp;
 		if (i1 == dir1->nr) {
-			return do_for_each_ref_in_dir(dir2, i2,
-						      base, fn, trim, flags, cb_data);
+			return do_for_each_entry_in_dir(dir2, i2, fn, cb_data);
 		}
 		if (i2 == dir2->nr) {
-			return do_for_each_ref_in_dir(dir1, i1,
-						      base, fn, trim, flags, cb_data);
+			return do_for_each_entry_in_dir(dir1, i1, fn, cb_data);
 		}
 		e1 = dir1->entries[i1];
 		e2 = dir2->entries[i2];
@@ -643,14 +652,13 @@ static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
 				struct ref_dir *subdir2 = get_ref_dir(e2);
 				sort_ref_dir(subdir1);
 				sort_ref_dir(subdir2);
-				retval = do_for_each_ref_in_dirs(
-						subdir1, subdir2,
-						base, fn, trim, flags, cb_data);
+				retval = do_for_each_entry_in_dirs(
+						subdir1, subdir2, fn, cb_data);
 				i1++;
 				i2++;
 			} else if (!(e1->flag & REF_DIR) && !(e2->flag & REF_DIR)) {
 				/* Both are references; ignore the one from dir1. */
-				retval = do_one_ref(base, fn, trim, flags, cb_data, e2);
+				retval = fn(e2, cb_data);
 				i1++;
 				i2++;
 			} else {
@@ -669,11 +677,10 @@ static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
 			if (e->flag & REF_DIR) {
 				struct ref_dir *subdir = get_ref_dir(e);
 				sort_ref_dir(subdir);
-				retval = do_for_each_ref_in_dir(
-						subdir, 0,
-						base, fn, trim, flags, cb_data);
+				retval = do_for_each_entry_in_dir(
+						subdir, 0, fn, cb_data);
 			} else {
-				retval = do_one_ref(base, fn, trim, flags, cb_data, e);
+				retval = fn(e, cb_data);
 			}
 		}
 		if (retval)
@@ -702,14 +709,13 @@ struct name_conflict_cb {
 	const char *conflicting_refname;
 };
 
-static int name_conflict_fn(const char *existingrefname, const unsigned char *sha1,
-			    int flags, void *cb_data)
+static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
 {
 	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
-	if (data->oldrefname && !strcmp(data->oldrefname, existingrefname))
+	if (data->oldrefname && !strcmp(data->oldrefname, entry->name))
 		return 0;
-	if (names_conflict(data->refname, existingrefname)) {
-		data->conflicting_refname = existingrefname;
+	if (names_conflict(data->refname, entry->name)) {
+		data->conflicting_refname = entry->name;
 		return 1;
 	}
 	return 0;
@@ -717,7 +723,7 @@ static int name_conflict_fn(const char *existingrefname, const unsigned char *sh
 
 /*
  * Return true iff a reference named refname could be created without
- * conflicting with the name of an existing reference in array.  If
+ * conflicting with the name of an existing reference in dir.  If
  * oldrefname is non-NULL, ignore potential conflicts with oldrefname
  * (e.g., because oldrefname is scheduled for deletion in the same
  * operation).
@@ -731,9 +737,7 @@ static int is_refname_available(const char *refname, const char *oldrefname,
 	data.conflicting_refname = NULL;
 
 	sort_ref_dir(dir);
-	if (do_for_each_ref_in_dir(dir, 0, "", name_conflict_fn,
-				   0, DO_FOR_EACH_INCLUDE_BROKEN,
-				   &data)) {
+	if (do_for_each_entry_in_dir(dir, 0, name_conflict_fn, &data)) {
 		error("'%s' exists; cannot create '%s'",
 		      data.conflicting_refname, refname);
 		return 0;
@@ -1421,16 +1425,14 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
 }
 
 /*
- * Call fn for each reference in the specified submodule for which the
- * refname begins with base.  If trim is non-zero, then trim that many
- * characters off the beginning of each refname before passing the
- * refname to fn.  flags can be DO_FOR_EACH_INCLUDE_BROKEN to include
- * broken references in the iteration.  If fn ever returns a non-zero
+ * Call fn for each reference in the specified submodule, omitting
+ * references not in the containing_dir of base.  fn is called for all
+ * references, including broken ones.  If fn ever returns a non-zero
  * value, stop the iteration and return that value; otherwise, return
  * 0.
  */
-static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
-			   int trim, int flags, void *cb_data)
+static int do_for_each_entry(const char *submodule, const char *base,
+			     each_ref_entry_fn fn, void *cb_data)
 {
 	struct ref_cache *refs = get_ref_cache(submodule);
 	struct ref_dir *packed_dir = get_packed_refs(refs);
@@ -1445,24 +1447,43 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 	if (packed_dir && loose_dir) {
 		sort_ref_dir(packed_dir);
 		sort_ref_dir(loose_dir);
-		retval = do_for_each_ref_in_dirs(
-				packed_dir, loose_dir,
-				base, fn, trim, flags, cb_data);
+		retval = do_for_each_entry_in_dirs(
+				packed_dir, loose_dir, fn, cb_data);
 	} else if (packed_dir) {
 		sort_ref_dir(packed_dir);
-		retval = do_for_each_ref_in_dir(
-				packed_dir, 0,
-				base, fn, trim, flags, cb_data);
+		retval = do_for_each_entry_in_dir(
+				packed_dir, 0, fn, cb_data);
 	} else if (loose_dir) {
 		sort_ref_dir(loose_dir);
-		retval = do_for_each_ref_in_dir(
-				loose_dir, 0,
-				base, fn, trim, flags, cb_data);
+		retval = do_for_each_entry_in_dir(
+				loose_dir, 0, fn, cb_data);
 	}
 
 	return retval;
 }
 
+/*
+ * Call fn for each reference in the specified submodule for which the
+ * refname begins with base.  If trim is non-zero, then trim that many
+ * characters off the beginning of each refname before passing the
+ * refname to fn.  flags can be DO_FOR_EACH_INCLUDE_BROKEN to include
+ * broken references in the iteration.  If fn ever returns a non-zero
+ * value, stop the iteration and return that value; otherwise, return
+ * 0.
+ */
+static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
+			   int trim, int flags, void *cb_data)
+{
+	struct ref_entry_cb data;
+	data.base = base;
+	data.trim = trim;
+	data.flags = flags;
+	data.fn = fn;
+	data.cb_data = cb_data;
+
+	return do_for_each_entry(submodule, base, do_one_ref, &data);
+}
+
 static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	unsigned char sha1[20];
@@ -1872,20 +1893,21 @@ struct repack_without_ref_sb {
 	int fd;
 };
 
-static int repack_without_ref_fn(const char *refname, const unsigned char *sha1,
-				 int flags, void *cb_data)
+static int repack_without_ref_fn(struct ref_entry *entry, void *cb_data)
 {
 	struct repack_without_ref_sb *data = cb_data;
 	char line[PATH_MAX + 100];
 	int len;
 
-	if (!strcmp(data->refname, refname))
+	if (!strcmp(data->refname, entry->name))
 		return 0;
+	if (!ref_resolves_to_object(entry))
+		return 0; /* Skip broken refs */
 	len = snprintf(line, sizeof(line), "%s %s\n",
-		       sha1_to_hex(sha1), refname);
+		       sha1_to_hex(entry->u.value.sha1), entry->name);
 	/* this should not happen but just being defensive */
 	if (len > sizeof(line))
-		die("too long a refname '%s'", refname);
+		die("too long a refname '%s'", entry->name);
 	write_or_die(data->fd, line, len);
 	return 0;
 }
@@ -1909,7 +1931,7 @@ static int repack_without_ref(const char *refname)
 	}
 	clear_packed_ref_cache(refs);
 	packed = get_packed_refs(refs);
-	do_for_each_ref_in_dir(packed, 0, "", repack_without_ref_fn, 0, 0, &data);
+	do_for_each_entry_in_dir(packed, 0, repack_without_ref_fn, &data);
 	return commit_lock_file(&packlock);
 }
 
-- 
1.8.2.1
