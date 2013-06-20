From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 02/12] pack_refs(): split creation of packed refs and entry writing
Date: Thu, 20 Jun 2013 10:37:44 +0200
Message-ID: <1371717474-28942-3-git-send-email-mhagger@alum.mit.edu>
References: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 10:38:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpaNo-0006N9-HE
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 10:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934752Ab3FTIiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 04:38:13 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57456 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756096Ab3FTIiK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 04:38:10 -0400
X-AuditID: 12074413-b7f136d000006de1-6f-51c2bf7286bc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 78.03.28129.27FB2C15; Thu, 20 Jun 2013 04:38:10 -0400 (EDT)
Received: from michael.fritz.box (p57A25408.dip0.t-ipconnect.de [87.162.84.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5K8c0sA001560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jun 2013 04:38:08 -0400
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371717474-28942-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqFu0/1CgwZS3ghZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLXZPW8DmwObx9/0HJo9LL7+zeTzr3cPocfGSssfjiSdYPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzti04hJrwXf5iunTGtkaGGdLdTFyckgImEj0zJ7FBGGLSVy4t56t
	i5GLQ0jgMqNE6+oVjBDOOSaJo133WUCq2AR0JRb1NIN1iAioSUxsO8QCUsQssJtRYvnpU+wg
	CWGBMIlvk96xgtgsAqoS53c0gtm8Ai4S+672s0GsU5CY8vA9M4jNKeAq8ebwHLAaIaCarbt2
	sE5g5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdcLzezRC81pXQTIyTUhHcw7jopd4hR
	gINRiYdX8/LBQCHWxLLiytxDjJIcTEqivHP3HQoU4kvKT6nMSCzOiC8qzUktPsQowcGsJMKb
	Ogcox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4E0DGSpYlJqeWpGW
	mVOCkGbi4AQRXCAbeIA2LAMp5C0uSMwtzkyHKDrFqCglzrsKJCEAksgozYMbAEsKrxjFgf4R
	5o0GqeIBJhS47ldAg5mABu9ZDTa4JBEhJdXAqL5qwv4Xy3897ZgoLbkxacfHxJ+Xb61foru1
	rOzKup5yP/fZ/iKuiY+nvv2+7FJoslfEOQ2ZT79KnnnPMlWVdRDZvEEle/P7na5LNCZ8lTDN
	8/bZfXFX67/reukFAY9/2VUGpDBxR2yTkFP0S03dbCPqnNzg4XNYxiHKf3Jje/j/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228451>

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
