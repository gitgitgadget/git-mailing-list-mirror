From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/12] repack_without_ref(): split list curation and entry writing
Date: Wed, 19 Jun 2013 09:51:22 +0200
Message-ID: <1371628293-28824-2-git-send-email-mhagger@alum.mit.edu>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 09:51:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDBK-00025g-BC
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 09:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618Ab3FSHvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 03:51:51 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57198 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756606Ab3FSHvt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 03:51:49 -0400
X-AuditID: 12074411-b7f296d000001209-e3-51c16315bc4f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 36.5B.04617.51361C15; Wed, 19 Jun 2013 03:51:49 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J7pZWT002453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 03:51:48 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqCuafDDQYEenkkXXlW4mi4beK8wW
	8+7uYrK4vWI+s8WPlh5mi93TFrA5sHn8ff+ByePSy+9sHs969zB6XLyk7PF44glWj8+b5ALY
	orhtkhJLyoIz0/P07RK4M5Zs+MJasEGz4uHHZ0wNjM2KXYycHBICJhKT96xghLDFJC7cW88G
	YgsJXGaUeHrBoIuRC8i+zSTxuOciM0iCTUBXYlFPMxOILSKgJjGx7RALSBGzwG5GieWnT7GD
	JIQFQiXmLr0NVsQioCrxbNt/sDivgIvEuitv2SC2KUhMefgeaCgHB6eAq8TZZZ4Qi10k5p2a
	zDqBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1TvdzMEr3UlNJNjJAwE9zBOOOk3CFG
	AQ5GJR7eG6sPBAqxJpYVV+YeYpTkYFIS5WVPOhgoxJeUn1KZkVicEV9UmpNafIhRgoNZSYRX
	zwEox5uSWFmVWpQPk5LmYFES5+Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4A0DGSpYlJqeWpGW
	mVOCkGbi4AQRXCAbeIA2HEkE2VBckJhbnJkOUXSKUVFKnDcSZIIASCKjNA9uACwhvGIUB/pH
	mNcOpIoHmEzgul8BDWYCGiz0fR/I4JJEhJRUA6OY+7S3MkZZ9678zC5v26m3/aCD1WWbudmS
	Dxh9q1bMKP1bnqOhEOBvPXejZZn7r36fLX+fPMjQ+Pi142Tsio7crrwXHSX/Evjz+Jde4nff
	GnfsDWNrY8mfVh3zK9UaFgfNLDNZPPhF7ks+1L3jrlfy4V/JmbrqQ9Y6X9izf0yO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228357>

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
