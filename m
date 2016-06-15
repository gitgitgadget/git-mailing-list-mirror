From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 01/56] refs: convert struct ref_entry to use struct object_id
Date: Mon, 25 May 2015 18:38:27 +0000
Message-ID: <1432579162-411464-2-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:40:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxIK-0000kV-QL
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbbEYSkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:07 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50583 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750837AbbEYSkF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:05 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 30C9E28092;
	Mon, 25 May 2015 18:40:03 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269850>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/refs.c b/refs.c
index 8480d8d..9ca4651 100644
--- a/refs.c
+++ b/refs.c
@@ -161,7 +161,7 @@ struct ref_value {
 	 * null.  If REF_ISSYMREF, then this is the name of the object
 	 * referred to by the last reference in the symlink chain.
 	 */
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	/*
 	 * If REF_KNOWS_PEELED, then this field holds the peeled value
@@ -169,7 +169,7 @@ struct ref_value {
 	 * be peelable.  See the documentation for peel_ref() for an
 	 * exact definition of "peelable".
 	 */
-	unsigned char peeled[20];
+	struct object_id peeled;
 };
 
 struct ref_cache;
@@ -351,8 +351,8 @@ static struct ref_entry *create_ref_entry(const char *refname,
 		die("Reference has invalid format: '%s'", refname);
 	len = strlen(refname) + 1;
 	ref = xmalloc(sizeof(struct ref_entry) + len);
-	hashcpy(ref->u.value.sha1, sha1);
-	hashclr(ref->u.value.peeled);
+	hashcpy(ref->u.value.oid.hash, sha1);
+	oidclr(&ref->u.value.peeled);
 	memcpy(ref->name, refname, len);
 	ref->flag = flag;
 	return ref;
@@ -626,7 +626,7 @@ static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2
 		/* This is impossible by construction */
 		die("Reference directory conflict: %s", ref1->name);
 
-	if (hashcmp(ref1->u.value.sha1, ref2->u.value.sha1))
+	if (oidcmp(&ref1->u.value.oid, &ref2->u.value.oid))
 		die("Duplicated ref, and SHA1s don't match: %s", ref1->name);
 
 	warning("Duplicated ref: %s", ref1->name);
@@ -674,7 +674,7 @@ static int ref_resolves_to_object(struct ref_entry *entry)
 {
 	if (entry->flag & REF_ISBROKEN)
 		return 0;
-	if (!has_sha1_file(entry->u.value.sha1)) {
+	if (!has_sha1_file(entry->u.value.oid.hash)) {
 		error("%s does not point to a valid object!", entry->name);
 		return 0;
 	}
@@ -722,7 +722,7 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
 	/* Store the old value, in case this is a recursive call: */
 	old_current_ref = current_ref;
 	current_ref = entry;
-	retval = data->fn(entry->name + data->trim, entry->u.value.sha1,
+	retval = data->fn(entry->name + data->trim, entry->u.value.oid.hash,
 			  entry->flag, data->cb_data);
 	current_ref = old_current_ref;
 	return retval;
@@ -1258,7 +1258,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 		    line.len == PEELED_LINE_LENGTH &&
 		    line.buf[PEELED_LINE_LENGTH - 1] == '\n' &&
 		    !get_sha1_hex(line.buf + 1, sha1)) {
-			hashcpy(last->u.value.peeled, sha1);
+			hashcpy(last->u.value.peeled.hash, sha1);
 			/*
 			 * Regardless of what the file header said,
 			 * we definitely know the value of *this*
@@ -1439,7 +1439,7 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
 	if (ref == NULL)
 		return -1;
 
-	hashcpy(sha1, ref->u.value.sha1);
+	hashcpy(sha1, ref->u.value.oid.hash);
 	return 0;
 }
 
@@ -1526,7 +1526,7 @@ static int resolve_missing_loose_ref(const char *refname,
 	 */
 	entry = get_packed_ref(refname);
 	if (entry) {
-		hashcpy(sha1, entry->u.value.sha1);
+		hashcpy(sha1, entry->u.value.oid.hash);
 		if (flags)
 			*flags |= REF_ISPACKED;
 		return 0;
@@ -1836,9 +1836,9 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 	if (entry->flag & REF_KNOWS_PEELED) {
 		if (repeel) {
 			entry->flag &= ~REF_KNOWS_PEELED;
-			hashclr(entry->u.value.peeled);
+			oidclr(&entry->u.value.peeled);
 		} else {
-			return is_null_sha1(entry->u.value.peeled) ?
+			return is_null_oid(&entry->u.value.peeled) ?
 				PEEL_NON_TAG : PEEL_PEELED;
 		}
 	}
@@ -1847,7 +1847,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 	if (entry->flag & REF_ISSYMREF)
 		return PEEL_IS_SYMREF;
 
-	status = peel_object(entry->u.value.sha1, entry->u.value.peeled);
+	status = peel_object(entry->u.value.oid.hash, entry->u.value.peeled.hash);
 	if (status == PEEL_PEELED || status == PEEL_NON_TAG)
 		entry->flag |= REF_KNOWS_PEELED;
 	return status;
@@ -1862,7 +1862,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 			    || !strcmp(current_ref->name, refname))) {
 		if (peel_entry(current_ref, 0))
 			return -1;
-		hashcpy(sha1, current_ref->u.value.peeled);
+		hashcpy(sha1, current_ref->u.value.peeled.hash);
 		return 0;
 	}
 
@@ -1882,7 +1882,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		if (r) {
 			if (peel_entry(r, 0))
 				return -1;
-			hashcpy(sha1, r->u.value.peeled);
+			hashcpy(sha1, r->u.value.peeled.hash);
 			return 0;
 		}
 	}
@@ -2496,9 +2496,9 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
 		error("internal error: %s is not a valid packed reference!",
 		      entry->name);
-	write_packed_entry(cb_data, entry->name, entry->u.value.sha1,
+	write_packed_entry(cb_data, entry->name, entry->u.value.oid.hash,
 			   peel_status == PEEL_PEELED ?
-			   entry->u.value.peeled : NULL);
+			   entry->u.value.peeled.hash : NULL);
 	return 0;
 }
 
@@ -2615,24 +2615,24 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	peel_status = peel_entry(entry, 1);
 	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
 		die("internal error peeling reference %s (%s)",
-		    entry->name, sha1_to_hex(entry->u.value.sha1));
+		    entry->name, oid_to_hex(&entry->u.value.oid));
 	packed_entry = find_ref(cb->packed_refs, entry->name);
 	if (packed_entry) {
 		/* Overwrite existing packed entry with info from loose entry */
 		packed_entry->flag = REF_ISPACKED | REF_KNOWS_PEELED;
-		hashcpy(packed_entry->u.value.sha1, entry->u.value.sha1);
+		oidcpy(&packed_entry->u.value.oid, &entry->u.value.oid);
 	} else {
-		packed_entry = create_ref_entry(entry->name, entry->u.value.sha1,
+		packed_entry = create_ref_entry(entry->name, entry->u.value.oid.hash,
 						REF_ISPACKED | REF_KNOWS_PEELED, 0);
 		add_ref(cb->packed_refs, packed_entry);
 	}
-	hashcpy(packed_entry->u.value.peeled, entry->u.value.peeled);
+	oidcpy(&packed_entry->u.value.peeled, &entry->u.value.peeled);
 
 	/* Schedule the loose reference for pruning if requested. */
 	if ((cb->flags & PACK_REFS_PRUNE)) {
 		int namelen = strlen(entry->name) + 1;
 		struct ref_to_prune *n = xcalloc(1, sizeof(*n) + namelen);
-		hashcpy(n->sha1, entry->u.value.sha1);
+		hashcpy(n->sha1, entry->u.value.oid.hash);
 		strcpy(n->name, entry->name);
 		n->next = cb->ref_to_prune;
 		cb->ref_to_prune = n;
-- 
2.4.0
