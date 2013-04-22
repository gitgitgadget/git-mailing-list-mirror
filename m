From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 29/33] pack_one_ref(): use function peel_entry()
Date: Mon, 22 Apr 2013 21:52:37 +0200
Message-ID: <1366660361-21831-30-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:54:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMoj-0005cZ-Iz
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196Ab3DVTyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:54:16 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:43668 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755177Ab3DVTyJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:54:09 -0400
X-AuditID: 12074413-b7f226d000000902-5f-51759560e201
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 24.3E.02306.06595715; Mon, 22 Apr 2013 15:54:08 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOg008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:54:07 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqJswtTTQ4OEMQ4uuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M5Y/usVe8E9pYqja5awNzD+
	le5i5OSQEDCRuDrpDiuELSZx4d56ti5GLg4hgcuMEqfnNLNCOBeYJHa3z2QBqWIT0JVY1NPM
	BGKLCKhJTGw7BBZnFnCQ2Py5kRHEFhZwltg2dyPYVBYBVYkn6yeC1fMKuEq0N3YzQWxTkDi+
	fRtYPSdQ/HTHCbA5QgIuEisOTmWZwMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuuV5u
	ZoleakrpJkZIsAjvYNx1Uu4QowAHoxIPr4B7aaAQa2JZcWXuIUZJDiYlUV6OKUAhvqT8lMqM
	xOKM+KLSnNTiQ4wSHMxKIryi+UA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKY
	rAwHh5IE7yuQoYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGg2IgvBkYHSIoHaG8k
	SDtvcUFiLlAUovUUoy7HrK1PXjMKseTl56VKifNWTwIqEgApyijNg1sBSw2vGMWBPhbmPQgy
	igeYVuAmvQJawgS0JDOhBGRJSSJCSqqBcYf2cs/A0Ngtsz/4B0q9yVzw9MekN4f9y66Lz9+Y
	8/fh2t0lLUuviL6UXvf24PHjFss0X911Z0r90epSsmylywajO59nsQdM5NZYOTGotmzPKUGh
	afVeaRdWKHLOD9F+UBt16pu51OrVEQ4PjvbtFDyeX2w5Y0O/Z5mg6QvZ+fJHpqWZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222067>

Change pack_one_ref() to call peel_entry() rather than using its own
code for peeling references.  Aside from sharing code, this lets it
take advantage of the optimization introduced by 6c4a060d7d.

Please note that we *could* use any peeled values that happen to
already be stored in the ref_entries, which would avoid some object
lookups for references that were already packed.  But doing so would
also propagate any peeling errors across runs of "git pack-refs" and
give no way to recover from such errors.  And "git pack-refs" isn't
run often enough that the performance cost is a problem.  So instead,
add a new option to peel_entry() to force the entry to be re-peeled,
and call it with that option set.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index f78e955..f2d83f3 100644
--- a/refs.c
+++ b/refs.c
@@ -1396,7 +1396,9 @@ static enum peel_status peel_object(const unsigned char *name, unsigned char *sh
 }
 
 /*
- * Peel the entry (if possible) and return its new peel_status.
+ * Peel the entry (if possible) and return its new peel_status.  If
+ * repeel is true, re-peel the entry even if there is an old peeled
+ * value that is already stored in it.
  *
  * It is OK to call this function with a packed reference entry that
  * might be stale and might even refer to an object that has since
@@ -1404,13 +1406,19 @@ static enum peel_status peel_object(const unsigned char *name, unsigned char *sh
  * REF_KNOWS_PEELED then leave the status unchanged and return
  * PEEL_PEELED or PEEL_NON_TAG; otherwise, return PEEL_INVALID.
  */
-static enum peel_status peel_entry(struct ref_entry *entry)
+static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 {
 	enum peel_status status;
 
-	if (entry->flag & REF_KNOWS_PEELED)
-		return is_null_sha1(entry->u.value.peeled) ?
-			PEEL_NON_TAG : PEEL_PEELED;
+	if (entry->flag & REF_KNOWS_PEELED) {
+		if (repeel) {
+			entry->flag &= ~REF_KNOWS_PEELED;
+			hashclr(entry->u.value.peeled);
+		} else {
+			return is_null_sha1(entry->u.value.peeled) ?
+				PEEL_NON_TAG : PEEL_PEELED;
+		}
+	}
 	if (entry->flag & REF_ISBROKEN)
 		return PEEL_BROKEN;
 	if (entry->flag & REF_ISSYMREF)
@@ -1429,7 +1437,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 
 	if (current_ref && (current_ref->name == refname
 			    || !strcmp(current_ref->name, refname))) {
-		if (peel_entry(current_ref))
+		if (peel_entry(current_ref, 0))
 			return -1;
 		hashcpy(sha1, current_ref->u.value.peeled);
 		return 0;
@@ -1449,7 +1457,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 	if (flag & REF_ISPACKED) {
 		struct ref_entry *r = get_packed_ref(refname);
 		if (r) {
-			if (peel_entry(r))
+			if (peel_entry(r, 0))
 				return -1;
 			hashcpy(sha1, r->u.value.peeled);
 			return 0;
@@ -1998,7 +2006,7 @@ struct pack_refs_cb_data {
 static int pack_one_ref(struct ref_entry *entry, void *cb_data)
 {
 	struct pack_refs_cb_data *cb = cb_data;
-	struct object *o;
+	enum peel_status peel_status;
 	int is_tag_ref;
 
 	/* Do not pack symbolic or broken refs: */
@@ -2014,13 +2022,12 @@ static int pack_one_ref(struct ref_entry *entry, void *cb_data)
 	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(entry->u.value.sha1),
 		entry->name);
 
-	o = parse_object_or_die(entry->u.value.sha1, entry->name);
-	if (o->type == OBJ_TAG) {
-		o = deref_tag(o, entry->name, 0);
-		if (o)
-			fprintf(cb->refs_file, "^%s\n",
-				sha1_to_hex(o->sha1));
-	}
+	peel_status = peel_entry(entry, 1);
+	if (peel_status == PEEL_PEELED)
+		fprintf(cb->refs_file, "^%s\n", sha1_to_hex(entry->u.value.peeled));
+	else if (peel_status != PEEL_NON_TAG)
+		die("internal error peeling reference %s (%s)",
+		    entry->name, sha1_to_hex(entry->u.value.sha1));
 
 	/* If the ref was already packed, there is no need to prune it. */
 	if ((cb->flags & PACK_REFS_PRUNE) && !(entry->flag & REF_ISPACKED)) {
@@ -2161,7 +2168,7 @@ static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
 		return 0;
 	}
 
-	peel_status = peel_entry(entry);
+	peel_status = peel_entry(entry, 0);
 	write_packed_entry(*fd, entry->name, entry->u.value.sha1,
 			   peel_status == PEEL_PEELED ?
 			   entry->u.value.peeled : NULL);
-- 
1.8.2.1
