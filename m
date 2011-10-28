From: mhagger@alum.mit.edu
Subject: [PATCH 04/28] struct ref_entry: nest the value part in a union
Date: Fri, 28 Oct 2011 14:28:17 +0200
Message-ID: <1319804921-17545-5-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:29:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlYw-0003gi-GA
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571Ab1J1M3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:29:16 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55691 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755609Ab1J1M2u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:28:50 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-FR; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184376>

From: Michael Haggerty <mhagger@alum.mit.edu>

This change is obviously silly by itself, but it is a step towards
adding a second member to the union.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 61dfb32..dafb585 100644
--- a/refs.c
+++ b/refs.c
@@ -101,6 +101,11 @@ int check_refname_format(const char *refname, int flags)
 
 struct ref_entry;
 
+struct ref_value {
+	unsigned char sha1[20];
+	unsigned char peeled[20];
+};
+
 struct ref_array {
 	int nr, alloc;
 	struct ref_entry **refs;
@@ -111,8 +116,9 @@ struct ref_array {
 
 struct ref_entry {
 	unsigned char flag; /* ISSYMREF? ISPACKED? */
-	unsigned char sha1[20];
-	unsigned char peeled[20];
+	union {
+		struct ref_value value;
+	} u;
 	/* The full name of the reference (e.g., "refs/heads/master"): */
 	char name[FLEX_ARRAY];
 };
@@ -127,8 +133,8 @@ static struct ref_entry *create_ref_entry(const char *refname,
 		die("Reference has invalid format: '%s'", refname);
 	len = strlen(refname) + 1;
 	ref = xmalloc(sizeof(struct ref_entry) + len);
-	hashcpy(ref->sha1, sha1);
-	hashclr(ref->peeled);
+	hashcpy(ref->u.value.sha1, sha1);
+	hashclr(ref->u.value.peeled);
 	memcpy(ref->name, refname, len);
 	ref->flag = flag;
 	return ref;
@@ -197,7 +203,7 @@ static int is_dup_ref(const struct ref_entry *ref1, const struct ref_entry *ref2
 {
 	if (!strcmp(ref1->name, ref2->name)) {
 		/* Duplicate name; make sure that the SHA1s match: */
-		if (hashcmp(ref1->sha1, ref2->sha1))
+		if (hashcmp(ref1->u.value.sha1, ref2->u.value.sha1))
 			die("Duplicated ref, and SHA1s don't match: %s",
 			    ref1->name);
 		warning("Duplicated ref: %s", ref1->name);
@@ -244,13 +250,13 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
 		if (entry->flag & REF_ISBROKEN)
 			return 0; /* ignore broken refs e.g. dangling symref */
-		if (!has_sha1_file(entry->sha1)) {
+		if (!has_sha1_file(entry->u.value.sha1)) {
 			error("%s does not point to a valid object!", entry->name);
 			return 0;
 		}
 	}
 	current_ref = entry;
-	return fn(entry->name + trim, entry->sha1, entry->flag, cb_data);
+	return fn(entry->name + trim, entry->u.value.sha1, entry->flag, cb_data);
 }
 
 static int do_for_each_ref_in_array(struct ref_array *array, int offset,
@@ -502,7 +508,7 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 		    strlen(refline) == 42 &&
 		    refline[41] == '\n' &&
 		    !get_sha1_hex(refline + 1, sha1))
-			hashcpy(last->peeled, sha1);
+			hashcpy(last->u.value.peeled, sha1);
 	}
 	sort_ref_array(array);
 }
@@ -632,7 +638,7 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
 	if (ref == NULL)
 		return -1;
 
-	memcpy(sha1, ref->sha1, 20);
+	memcpy(sha1, ref->u.value.sha1, 20);
 	return 0;
 }
 
@@ -702,7 +708,7 @@ static int get_packed_ref(const char *refname, unsigned char *sha1)
 	struct ref_array *packed = get_packed_refs(get_ref_cache(NULL));
 	struct ref_entry *entry = search_ref_array(packed, refname);
 	if (entry) {
-		hashcpy(sha1, entry->sha1);
+		hashcpy(sha1, entry->u.value.sha1);
 		return 0;
 	}
 	return -1;
@@ -848,10 +854,10 @@ int peel_ref(const char *refname, unsigned char *sha1)
 	if (current_ref && (current_ref->name == refname
 		|| !strcmp(current_ref->name, refname))) {
 		if (current_ref->flag & REF_KNOWS_PEELED) {
-			hashcpy(sha1, current_ref->peeled);
+			hashcpy(sha1, current_ref->u.value.peeled);
 			return 0;
 		}
-		hashcpy(base, current_ref->sha1);
+		hashcpy(base, current_ref->u.value.sha1);
 		goto fallback;
 	}
 
@@ -863,7 +869,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		struct ref_entry *r = search_ref_array(array, refname);
 
 		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
-			hashcpy(sha1, r->peeled);
+			hashcpy(sha1, r->u.value.peeled);
 			return 0;
 		}
 	}
-- 
1.7.7
