From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/12] pack_refs(): split creation of packed refs and entry writing
Date: Wed, 19 Jun 2013 09:51:23 +0200
Message-ID: <1371628293-28824-3-git-send-email-mhagger@alum.mit.edu>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 09:53:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDCH-0003vK-T9
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 09:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934017Ab3FSHwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 03:52:45 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:51040 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756606Ab3FSHvv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 03:51:51 -0400
X-AuditID: 12074414-b7f626d0000001f1-ef-51c163178ae5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 7E.B3.00497.71361C15; Wed, 19 Jun 2013 03:51:51 -0400 (EDT)
Received: from michael.berlin.jpk.com (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J7pZWU002453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 03:51:49 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqCuefDDQYN5MHouuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFrunLWBzYPP4+/4Dk8ell9/ZPJ717mH0uHhJ2ePxxBOsHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ2xacYm14Lt8xfRpjWwNjLOluhg5OSQETCRWLGpkgrDFJC7cW8/W
	xcjFISRwmVGi+/kKZgjnNpNE46T7bCBVbAK6Eot6msE6RATUJCa2HWIBKWIW2M0osfz0KXaQ
	hLBAmMTrpW/AbBYBVYlru9sZQWxeAReJhrWzodYpSEx5+B5oAwcHp4CrxNllniBhIaCSeacm
	s05g5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdCLzezRC81pXQTIyTQRHYwHjkpd4hR
	gINRiYf3xuoDgUKsiWXFlbmHGCU5mJREec8nHgwU4kvKT6nMSCzOiC8qzUktPsQowcGsJMKr
	5wCU401JrKxKLcqHSUlzsCiJ835brO4nJJCeWJKanZpakFoEk5Xh4FCS4L0KMlSwKDU9tSIt
	M6cEIc3EwQkiuEA28ABtOAJSyFtckJhbnJkOUXSKUVFKnPceSEIAJJFRmgc3AJYSXjGKA/0j
	zNsNUsUDTCdw3a+ABjMBDRb6vg9kcEkiQkqqgZF7Y+UuIzupaUkG3V7FPknvm1jnan681mId
	/UW5oX/rMsEp+ucz58YobRK7kJe15X3CoWMCSsuCGxN2lYpvyDrnu/Gv+c/LfwXE5f2L1rYa
	NG3Mm7Opp/7GW1WLzb0F2zfMMr9dNTk/4uzC/QdTDi974b0kwUTS5bd8G9/0zNz5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228369>

Split pack_refs() into multiple passes:

* Iterate over loose refs.  For each one that can be turned into a
  packed ref, create a corresponding entry in the packed refs cache.

* Write the packed refs to the packed-refs file.

This change isolates the mutation of the packed-refs file to a single
place.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 48 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 1184b99..9f1a007 100644
--- a/refs.c
+++ b/refs.c
@@ -2023,35 +2023,50 @@ struct ref_to_prune {
 
 struct pack_refs_cb_data {
 	unsigned int flags;
+	struct ref_dir *packed_refs;
 	struct ref_to_prune *ref_to_prune;
-	int fd;
 };
 
-static int pack_one_ref(struct ref_entry *entry, void *cb_data)
+/*
+ * An each_ref_entry_fn that is run over loose references only.  If
+ * the loose reference can be packed, add an entry in the packed ref
+ * cache.  If the reference should be pruned, also add it to
+ * ref_to_prune in the pack_refs_cb_data.
+ */
+static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 {
 	struct pack_refs_cb_data *cb = cb_data;
 	enum peel_status peel_status;
+	struct ref_entry *packed_entry;
 	int is_tag_ref = !prefixcmp(entry->name, "refs/tags/");
 
-	/* ALWAYS pack refs that were already packed or are tags */
-	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref &&
-	    !(entry->flag & REF_ISPACKED))
+	/* ALWAYS pack tags */
+	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref)
 		return 0;
 
 	/* Do not pack symbolic or broken refs: */
 	if ((entry->flag & REF_ISSYMREF) || !ref_resolves_to_object(entry))
 		return 0;
 
+	/* Add a packed ref cache entry equivalent to the loose entry. */
 	peel_status = peel_entry(entry, 1);
 	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
 		die("internal error peeling reference %s (%s)",
 		    entry->name, sha1_to_hex(entry->u.value.sha1));
-	write_packed_entry(cb->fd, entry->name, entry->u.value.sha1,
-			   peel_status == PEEL_PEELED ?
-			   entry->u.value.peeled : NULL);
+	packed_entry = find_ref(cb->packed_refs, entry->name);
+	if (packed_entry) {
+		/* Overwrite existing packed entry with info from loose entry */
+		packed_entry->flag = REF_ISPACKED | REF_KNOWS_PEELED;
+		hashcpy(packed_entry->u.value.sha1, entry->u.value.sha1);
+	} else {
+		packed_entry = create_ref_entry(entry->name, entry->u.value.sha1,
+						REF_ISPACKED | REF_KNOWS_PEELED, 0);
+		add_ref(cb->packed_refs, packed_entry);
+	}
+	hashcpy(packed_entry->u.value.peeled, entry->u.value.peeled);
 
-	/* If the ref was already packed, there is no need to prune it. */
-	if ((cb->flags & PACK_REFS_PRUNE) && !(entry->flag & REF_ISPACKED)) {
+	/* Schedule the loose reference for pruning if requested. */
+	if ((cb->flags & PACK_REFS_PRUNE)) {
 		int namelen = strlen(entry->name) + 1;
 		struct ref_to_prune *n = xcalloc(1, sizeof(*n) + namelen);
 		hashcpy(n->sha1, entry->u.value.sha1);
@@ -2118,16 +2133,21 @@ static struct lock_file packlock;
 int pack_refs(unsigned int flags)
 {
 	struct pack_refs_cb_data cbdata;
+	int fd;
 
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.flags = flags;
 
-	cbdata.fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"),
-					      LOCK_DIE_ON_ERROR);
+	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"),
+				       LOCK_DIE_ON_ERROR);
+	cbdata.packed_refs = get_packed_refs(&ref_cache);
 
-	write_or_die(cbdata.fd, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
+	do_for_each_entry_in_dir(get_loose_refs(&ref_cache), 0,
+				 pack_if_possible_fn, &cbdata);
+
+	write_or_die(fd, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
+	do_for_each_entry_in_dir(cbdata.packed_refs, 0, write_packed_entry_fn, &fd);
 
-	do_for_each_entry(&ref_cache, "", pack_one_ref, &cbdata);
 	if (commit_lock_file(&packlock) < 0)
 		die_errno("unable to overwrite old ref-pack file");
 	prune_refs(cbdata.ref_to_prune);
-- 
1.8.3.1
