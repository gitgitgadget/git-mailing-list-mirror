From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/12] repack_without_ref(): split list curation and entry writing
Date: Tue, 11 Jun 2013 23:48:21 +0200
Message-ID: <1370987312-6761-2-git-send-email-mhagger@alum.mit.edu>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 23:49:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmWR6-0003kk-3a
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 23:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328Ab3FKVsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 17:48:55 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:49380 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753253Ab3FKVsx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 17:48:53 -0400
X-AuditID: 1207440d-b7f006d000000adf-30-51b79b45d009
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 78.4B.02783.54B97B15; Tue, 11 Jun 2013 17:48:53 -0400 (EDT)
Received: from michael.fritz.box (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BLmbip015717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 17:48:51 -0400
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqOs6e3ugwcpDvBZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTvj9uUm9oKFShUTp99mbmDcLN3FyMkhIWAi8eL1cxYIW0ziwr31bF2MXBxCApcZJX5f
	fscO4VxgknjQtJMVpIpNQFdiUU8zE4gtIqAmMbHtEAtIEbNAO6PEu+Z9zCAJYYEgifevW9hB
	bBYBVYnWzbPAmnkFnCXWTj/CBLFOTuL9nV1gqzkFXCQ2bt4M1isEVPO9p4lxAiPvAkaGVYxy
	iTmlubq5iZk5xanJusXJiXl5qUW6Rnq5mSV6qSmlmxghYcW7g/H/OplDjAIcjEo8vAfMtgcK
	sSaWFVfmHmKU5GBSEuVlmwYU4kvKT6nMSCzOiC8qzUktPsQowcGsJMKrmwuU401JrKxKLcqH
	SUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8IbMAmoULEpNT61Iy8wpQUgzcXCCCC6Q
	DTxAG/hACnmLCxJzizPTIYpOMSpKifOmgCQEQBIZpXlwA2AJ4BWjONA/wrzeIFU8wOQB1/0K
	aDAT0OCiDLDBJYkIKakGRrOjcydO3zKRy3TB7041881614vtHLQOvw/99Cj+ue6sZ3I7D3ce
	DHX9o+SYUyTKyv9C+N0UP7btzzsv95YIPtg404RZ2uMfa8Sdqorp3Es+V4pfOnRtq79ntuLr
	JYGTXpXeEBR482hXfHaVqNq6sqaJU+p+8bUv2H6Qb9ulxBgW3vuKmbXT2ZRYijMS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227520>

Split repack_without_ref() into multiple passes:

* collect the list of refnames that should be deleted from packed_refs

* delete those refnames from the cache

* write the remainder to the packed-refs file

The purpose of this change is to make the "write the remainder" part
reusable.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 48 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index d17931a..dccfe14 100644
--- a/refs.c
+++ b/refs.c
@@ -1994,6 +1994,23 @@ static void write_packed_entry(int fd, char *refname, unsigned char *sha1,
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
@@ -2113,14 +2130,18 @@ int pack_refs(unsigned int flags)
 	return 0;
 }
 
-static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
+/*
+ * If entry should be deleted from packed-refs, add it to the string
+ * list pointed to by cb_data.
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
@@ -2130,7 +2151,7 @@ static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
 		if (read_ref_full(entry->name, sha1, 0, &flags))
 			/* We should at least have found the packed ref. */
 			die("Internal error");
-		if ((flags & REF_ISSYMREF) || !(flags & REF_ISPACKED))
+		if ((flags & REF_ISSYMREF) || !(flags & REF_ISPACKED)) {
 			/*
 			 * This packed reference is overridden by a
 			 * loose reference, so it is OK that its value
@@ -2139,9 +2160,11 @@ static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
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
@@ -2150,14 +2173,10 @@ static int repack_ref_fn(struct ref_entry *entry, void *cb_data)
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
 
@@ -2165,6 +2184,8 @@ static int repack_without_ref(const char *refname)
 {
 	int fd;
 	struct ref_dir *packed;
+	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
+	struct string_list_item *ref_to_delete;
 
 	if (!get_packed_ref(refname))
 		return 0; /* refname does not exist in packed refs */
@@ -2185,8 +2206,13 @@ static int repack_without_ref(const char *refname)
 		rollback_lock_file(&packlock);
 		return 0;
 	}
+	do_for_each_entry_in_dir(packed, 0, curate_packed_ref_fn, &refs_to_delete);
+	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
+		if (remove_entry(packed, ref_to_delete->string) == -1)
+			die("internal error");
+	}
 	write_or_die(fd, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
-	do_for_each_entry_in_dir(packed, 0, repack_ref_fn, &fd);
+	do_for_each_entry_in_dir(packed, 0, write_packed_entry_fn, &fd);
 	return commit_lock_file(&packlock);
 }
 
-- 
1.8.3
