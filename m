From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 01/12] repack_without_ref(): split list curation and entry writing
Date: Thu, 20 Jun 2013 10:37:43 +0200
Message-ID: <1371717474-28942-2-git-send-email-mhagger@alum.mit.edu>
References: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 10:44:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpaTO-0001aO-SZ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 10:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108Ab3FTIoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 04:44:00 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44060 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755737Ab3FTIiJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 04:38:09 -0400
X-AuditID: 12074414-b7f626d0000001f1-27-51c2bf70ac8d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id B2.D8.00497.07FB2C15; Thu, 20 Jun 2013 04:38:08 -0400 (EDT)
Received: from michael.fritz.box (p57A25408.dip0.t-ipconnect.de [87.162.84.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5K8c0s9001560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jun 2013 04:38:07 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqFuw/1CgwaXnMhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLXZPW8DmwObx9/0HJo9LL7+zeTzr3cPocfGSssfjiSdYPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzliy4QtrwQbNiocfnzE1MDYrdjFyckgImEjcWtTFBmGLSVy4tx7I
	5uIQErjMKPHz1SZWCOcck0RLz0R2kCo2AV2JRT3NTCC2iICaxMS2QywgRcwCuxkllp8+BVYk
	LBAq8bXhGAuIzSKgKnHt+QxmEJtXwEVi76EbLBDrFCSmPHwPFucUcJV4c3gOK4gtBFSzddcO
	1gmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Vro5WaW6KWmlG5ihISayA7GIyflDjEK
	cDAq8fBqXD4YKMSaWFZcmXuIUZKDSUmUd+6+Q4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHhT
	5wDleFMSK6tSi/JhUtIcLErivN8Wq/sJCaQnlqRmp6YWpBbBZGU4OJQkeB+CDBUsSk1PrUjL
	zClBSDNxcIIILpANPEAbloEU8hYXJOYWZ6ZDFJ1iVJQS530MkhAASWSU5sENgCWFV4ziQP8I
	814AqeIBJhS47ldAg5mABu9ZDTa4JBEhJdXAyCxkmHLqsWWdu8f+68d2xF+cuth2VVi9dKNj
	vGDG/rBJy1Jm6st8ryvleLacpeHTNIY5myTeNPdFf5wY5PVOhT0sfUmFXupW76lXfmm5Rd8Q
	9uvlLTSUZ1BTneTjpiUQ/rvrwRkOtgkbPx3/F7Jh/71JLic7rWfHZO5J+7KbR2fx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228463>

The repack_without_ref() function first removes the deleted ref from
the internal packed-refs list, then writes the packed-refs list to
disk, omitting any broken or stale entries.  This patch splits that
second step into multiple passes:

* collect the list of refnames that should be deleted from packed_refs

* delete those refnames from the cache

* write the remainder to the packed-refs file

The purpose of this change is to make the "write the remainder" part
reusable.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 42a7e17..1184b99 100644
--- a/refs.c
+++ b/refs.c
@@ -1998,6 +1998,23 @@ static void write_packed_entry(int fd, char *refname, unsigned char *sha1,
 	}
 }
 
+/*
+ * An each_ref_entry_fn that writes the entry to a packed-refs file.
+ */
+static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
+{
+	int *fd = cb_data;
+	enum peel_status peel_status = peel_entry(entry, 0);
+
+	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
+		error("internal error: %s is not a valid packed reference!",
+		      entry->name);
+	write_packed_entry(*fd, entry->name, entry->u.value.sha1,
+			   peel_status == PEEL_PEELED ?
+			   entry->u.value.peeled : NULL);
+	return 0;
+}
+
 struct ref_to_prune {
 	struct ref_to_prune *next;
 	unsigned char sha1[20];
@@ -2117,14 +2134,25 @@ int pack_refs(unsigned int flags)
 	return 0;
 }
 
-static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
+/*
+ * If entry is no longer needed in packed-refs, add it to the string
+ * list pointed to by cb_data.  Reasons for deleting entries:
+ *
+ * - Entry is broken.
+ * - Entry is overridden by a loose ref.
+ * - Entry does not point at a valid object.
+ *
+ * In the first and third cases, also emit an error message because these
+ * are indications of repository corruption.
+ */
+static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 {
-	int *fd = cb_data;
-	enum peel_status peel_status;
+	struct string_list *refs_to_delete = cb_data;
 
 	if (entry->flag & REF_ISBROKEN) {
 		/* This shouldn't happen to packed refs. */
 		error("%s is broken!", entry->name);
+		string_list_append(refs_to_delete, entry->name);
 		return 0;
 	}
 	if (!has_sha1_file(entry->u.value.sha1)) {
@@ -2134,7 +2162,7 @@ static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
 		if (read_ref_full(entry->name, sha1, 0, &flags))
 			/* We should at least have found the packed ref. */
 			die("Internal error");
-		if ((flags & REF_ISSYMREF) || !(flags & REF_ISPACKED))
+		if ((flags & REF_ISSYMREF) || !(flags & REF_ISPACKED)) {
 			/*
 			 * This packed reference is overridden by a
 			 * loose reference, so it is OK that its value
@@ -2143,9 +2171,11 @@ static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
 			 * collected.  For this purpose we don't even
 			 * care whether the loose reference itself is
 			 * invalid, broken, symbolic, etc.  Silently
-			 * omit the packed reference from the output.
+			 * remove the packed reference.
 			 */
+			string_list_append(refs_to_delete, entry->name);
 			return 0;
+		}
 		/*
 		 * There is no overriding loose reference, so the fact
 		 * that this reference doesn't refer to a valid object
@@ -2154,14 +2184,10 @@ static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
 		 * the output.
 		 */
 		error("%s does not point to a valid object!", entry->name);
+		string_list_append(refs_to_delete, entry->name);
 		return 0;
 	}
 
-	peel_status = peel_entry(entry, 0);
-	write_packed_entry(*fd, entry->name, entry->u.value.sha1,
-			   peel_status == PEEL_PEELED ?
-			   entry->u.value.peeled : NULL);
-
 	return 0;
 }
 
@@ -2169,6 +2195,8 @@ static int repack_without_ref(const char *refname)
 {
 	int fd;
 	struct ref_dir *packed;
+	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
+	struct string_list_item *ref_to_delete;
 
 	if (!get_packed_ref(refname))
 		return 0; /* refname does not exist in packed refs */
@@ -2180,7 +2208,8 @@ static int repack_without_ref(const char *refname)
 	}
 	clear_packed_ref_cache(&ref_cache);
 	packed = get_packed_refs(&ref_cache);
-	/* Remove refname from the cache. */
+
+	/* Remove refname from the cache: */
 	if (remove_entry(packed, refname) == -1) {
 		/*
 		 * The packed entry disappeared while we were
@@ -2189,8 +2218,17 @@ static int repack_without_ref(const char *refname)
 		rollback_lock_file(&packlock);
 		return 0;
 	}
+
+	/* Remove any other accumulated cruft: */
+	do_for_each_entry_in_dir(packed, 0, curate_packed_ref_fn, &refs_to_delete);
+	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
+		if (remove_entry(packed, ref_to_delete->string) == -1)
+			die("internal error");
+	}
+
+	/* Write what remains: */
 	write_or_die(fd, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
-	do_for_each_entry_in_dir(packed, 0, repack_ref_fn, &fd);
+	do_for_each_entry_in_dir(packed, 0, write_packed_entry_fn, &fd);
 	return commit_lock_file(&packlock);
 }
 
-- 
1.8.3.1
