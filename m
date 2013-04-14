From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 29/33] pack_one_ref(): use function peel_entry()
Date: Sun, 14 Apr 2013 14:54:44 +0200
Message-ID: <1365944088-10588-30-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMTq-00057m-UV
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab3DNM4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:56:19 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:54971 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752040Ab3DNM4D (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:56:03 -0400
X-AuditID: 1207440f-b7f0e6d000000957-98-516aa762a50c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 6E.7A.02391.267AA615; Sun, 14 Apr 2013 08:56:02 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAkQ007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:56:01 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqJu0PCvQ4OZrEYuuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M74utq9YLtaxarfP1kbGP/KdTFyckgImEh8b7zGBmGLSVy4tx7I5uIQErjMKDFz0Wsm
	COcsk8TTw3OZQarYBHQlFvU0AyU4OEQEsiV2r5UHCTMLOEhs/tzICBIWBrLX/wMLswioSvQu
	OQnWySvgKjGp8yY7xC4FiePbtzGC2JxA8enPj4HFhQRcJGZtns06gZF3ASPDKka5xJzSXN3c
	xMyc4tRk3eLkxLy81CJdE73czBK91JTSTYyQcOLfwdi1XuYQowAHoxIPrwNLVqAQa2JZcWXu
	IUZJDiYlUd6FS4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHgdW4FyvCmJlVWpRfkwKWkOFiVx
	XvUl6n5CAumJJanZqakFqUUwWRkODiUJXo1lQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmp
	RYmlJRnxoKiILwbGBUiKB2jvW5CbeIsLEnOBohCtpxh1OWZtffKaUYglLz8vVUqc9yNIkQBI
	UUZpHtwKWPJ4xSgO9LEwryLIJTzAxAM36RXQEiagJT5700GWlCQipKQaGOXka7pEX30oXapd
	5PpJ4v/i0hy+hdpJKbvZCn4VCRdo1uU8mv+E5VbzW+bHK/54flOsDDtXc77e4n2+W9Qmiaty
	u2ddX9lhFHX7+4ym4zL1C16JH642TL6hm6D7afvuc5c57y70S1xqJ/KOh+0Rw+81 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221118>

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

I am not so familiar with the object DB API so it would be good for
somebody to verify that the slightly different method that pack-refs
now uses to peel references is equivalent to the old method.

Please note that this version of the patch series (in contrast to one
I shared before via github) re-peels all references when pack-refs is
run rather than reusing any available peeled values.

 refs.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index e1b8a56..6397e29 100644
--- a/refs.c
+++ b/refs.c
@@ -1398,7 +1398,9 @@ static enum peel_status peel_object(const unsigned char *name, unsigned char *sh
 }
 
 /*
- * Peel the entry (if possible) and return its new peel_status.
+ * Peel the entry (if possible) and return its new peel_status.  If
+ * repeel is true, re-peel the entry even if there is an old peeled
+ * value that is already stored in it.
  *
  * It is OK to call this function with a packed reference entry that
  * might be stale and might even refer to an object that has since
@@ -1406,13 +1408,19 @@ static enum peel_status peel_object(const unsigned char *name, unsigned char *sh
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
@@ -1431,7 +1439,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 
 	if (current_ref && (current_ref->name == refname
 			    || !strcmp(current_ref->name, refname))) {
-		if (peel_entry(current_ref))
+		if (peel_entry(current_ref, 0))
 			return -1;
 		hashcpy(sha1, current_ref->u.value.peeled);
 		return 0;
@@ -1451,7 +1459,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 	if (flag & REF_ISPACKED) {
 		struct ref_entry *r = get_packed_ref(refname);
 		if (r) {
-			if (peel_entry(r))
+			if (peel_entry(r, 0))
 				return -1;
 			hashcpy(sha1, r->u.value.peeled);
 			return 0;
@@ -1996,7 +2004,7 @@ struct pack_refs_cb_data {
 static int pack_one_ref(struct ref_entry *entry, void *cb_data)
 {
 	struct pack_refs_cb_data *cb = cb_data;
-	struct object *o;
+	enum peel_status peel_status;
 	int is_tag_ref;
 
 	/* Do not pack symbolic or broken refs: */
@@ -2012,13 +2020,12 @@ static int pack_one_ref(struct ref_entry *entry, void *cb_data)
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
@@ -2127,7 +2134,7 @@ static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
 	/* Silently skip broken refs: */
 	if (!ref_resolves_to_object(entry, 0))
 		return 0;
-	peel_status = peel_entry(entry);
+	peel_status = peel_entry(entry, 0);
 	write_packed_entry(*fd, entry->name, entry->u.value.sha1,
 			   peel_status == PEEL_PEELED ?
 			   entry->u.value.peeled : NULL);
-- 
1.8.2.1
