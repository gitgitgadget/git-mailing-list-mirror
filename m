Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834D8C35669
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D4620658
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgBXEgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:36:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:52336 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727186AbgBXEgc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 23:36:32 -0500
Received: (qmail 5232 invoked by uid 109); 24 Feb 2020 04:36:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 04:36:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6967 invoked by uid 111); 24 Feb 2020 04:45:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Feb 2020 23:45:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Feb 2020 23:36:31 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 07/10] pack-check: push oid lookup into loop
Message-ID: <20200224043631.GG1018190@coredump.intra.peff.net>
References: <20200224042625.GA1015553@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224042625.GA1015553@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're checking a pack with fsck or verify-pack, we first sort the
idx entries by offset, since accessing them in pack order is more
efficient. To do so, we loop over them and fill in an array of structs
with the offset, object_id, and index position of each, sort the result,
and only then do we iterate over the sorted array and process each
entry.

In order to avoid the memory cost of storing the hash of each object, we
just store a pointer into the copy in the mmap'd pack index file. To
keep that property even as the rest of the code converted to "struct
object_id", commit 9fd750461b (Convert the verify_pack callback to
struct object_id, 2017-05-06) introduced a union in order to type-pun
the pointer-to-hash into an object_id struct.

But we can make this even simpler by observing that the sort operation
doesn't need the object id at all! We only need them one at a time while
we actually process each entry. So we can just omit the oid from the
struct entirely and load it on the fly into a local variable in the
second loop.

This gets rid of the type-punning, and lets us directly use the more
type-safe nth_packed_object_id(), simplifying the code. And as a bonus,
it saves 8 bytes of memory per object.

Note that this does mean we'll do the offset lookup for each object
before the oid lookup. The oid lookup has more safety checks in it
(e.g., for looking past p->num_objects) which in theory protected the
offset lookup. But since violating those checks was already a BUG()
condition (as described in the previous commit), it's not worth worrying
about.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-check.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/pack-check.c b/pack-check.c
index 39196ecfbc..dad6d8ae7f 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -8,10 +8,6 @@
 
 struct idx_entry {
 	off_t                offset;
-	union idx_entry_object {
-		const unsigned char *hash;
-		struct object_id *oid;
-	} oid;
 	unsigned int nr;
 };
 
@@ -97,30 +93,31 @@ static int verify_packfile(struct repository *r,
 	entries[nr_objects].offset = pack_sig_ofs;
 	/* first sort entries by pack offset, since unpacking them is more efficient that way */
 	for (i = 0; i < nr_objects; i++) {
-		entries[i].oid.hash = nth_packed_object_sha1(p, i);
-		if (!entries[i].oid.hash)
-			BUG("unable to get oid of object %lu from %s",
-			    (unsigned long)i, p->pack_name);
 		entries[i].offset = nth_packed_object_offset(p, i);
 		entries[i].nr = i;
 	}
 	QSORT(entries, nr_objects, compare_entries);
 
 	for (i = 0; i < nr_objects; i++) {
 		void *data;
+		struct object_id oid;
 		enum object_type type;
 		unsigned long size;
 		off_t curpos;
 		int data_valid;
 
+		if (nth_packed_object_id(&oid, p, entries[i].nr) < 0)
+			BUG("unable to get oid of object %lu from %s",
+			    (unsigned long)entries[i].nr, p->pack_name);
+
 		if (p->index_version > 1) {
 			off_t offset = entries[i].offset;
 			off_t len = entries[i+1].offset - offset;
 			unsigned int nr = entries[i].nr;
 			if (check_pack_crc(p, w_curs, offset, len, nr))
 				err = error("index CRC mismatch for object %s "
 					    "from %s at offset %"PRIuMAX"",
-					    oid_to_hex(entries[i].oid.oid),
+					    oid_to_hex(&oid),
 					    p->pack_name, (uintmax_t)offset);
 		}
 
@@ -143,14 +140,14 @@ static int verify_packfile(struct repository *r,
 
 		if (data_valid && !data)
 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
-				    oid_to_hex(entries[i].oid.oid), p->pack_name,
+				    oid_to_hex(&oid), p->pack_name,
 				    (uintmax_t)entries[i].offset);
-		else if (check_object_signature(r, entries[i].oid.oid, data, size, type_name(type)))
+		else if (check_object_signature(r, &oid, data, size, type_name(type)))
 			err = error("packed %s from %s is corrupt",
-				    oid_to_hex(entries[i].oid.oid), p->pack_name);
+				    oid_to_hex(&oid), p->pack_name);
 		else if (fn) {
 			int eaten = 0;
-			err |= fn(entries[i].oid.oid, type, size, data, &eaten);
+			err |= fn(&oid, type, size, data, &eaten);
 			if (eaten)
 				data = NULL;
 		}
-- 
2.25.1.823.g95c5488cf7

