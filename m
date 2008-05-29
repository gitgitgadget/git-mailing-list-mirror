From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] make verify-pack a bit more useful with bad packs
Date: Thu, 29 May 2008 17:34:50 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805291716470.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 23:36:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1pn0-0007iA-Ll
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 23:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756489AbYE2VfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 17:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754813AbYE2VfJ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 17:35:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13851 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087AbYE2VfI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 17:35:08 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K1N00IV5FY2G540@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 May 2008 17:34:51 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83245>

When a pack gets corrupted, its SHA1 checksum will fail.  However, this
is more useful to let the test go on in order to find the actual 
problem location than only complain about the SHA1 mismatch and
bail out.

Also, it is more useful to compare the stored pack SHA1 with the one in 
the index file instead of the computed SHA1 since the computed SHA1
from a corrupted pack won't match the one stored in the index either.

Finally a few code and message cleanups were thrown in as a bonus.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

Yes, I just had my first real usage Git repository corruption...
Still investigating.

diff --git a/pack-check.c b/pack-check.c
index 0f8ad2c..c03525e 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -25,10 +25,10 @@ static int verify_packfile(struct packed_git *p,
 	off_t index_size = p->index_size;
 	const unsigned char *index_base = p->index_data;
 	SHA_CTX ctx;
-	unsigned char sha1[20];
-	off_t offset = 0, pack_sig = p->pack_size - 20;
+	unsigned char sha1[20], *pack_sig;
+	off_t offset = 0, pack_sig_ofs = p->pack_size - 20;
 	uint32_t nr_objects, i;
-	int err;
+	int err = 0;
 	struct idx_entry *entries;
 
 	/* Note that the pack header checks are actually performed by
@@ -38,21 +38,22 @@ static int verify_packfile(struct packed_git *p,
 	 */
 
 	SHA1_Init(&ctx);
-	while (offset < pack_sig) {
+	while (offset < pack_sig_ofs) {
 		unsigned int remaining;
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
 		offset += remaining;
-		if (offset > pack_sig)
-			remaining -= (unsigned int)(offset - pack_sig);
+		if (offset > pack_sig_ofs)
+			remaining -= (unsigned int)(offset - pack_sig_ofs);
 		SHA1_Update(&ctx, in, remaining);
 	}
 	SHA1_Final(sha1, &ctx);
-	if (hashcmp(sha1, use_pack(p, w_curs, pack_sig, NULL)))
-		return error("Packfile %s SHA1 mismatch with itself",
-			     p->pack_name);
-	if (hashcmp(sha1, index_base + index_size - 40))
-		return error("Packfile %s SHA1 mismatch with idx",
-			     p->pack_name);
+	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
+	if (hashcmp(sha1, pack_sig))
+		err = error("%s SHA1 checksum mismatch",
+			    p->pack_name);
+	if (hashcmp(index_base + index_size - 40, pack_sig))
+		err = error("%s SHA1 does not match its inddex",
+			    p->pack_name);
 	unuse_pack(w_curs);
 
 	/* Make sure everything reachable from idx is valid.  Since we
@@ -72,22 +73,23 @@ static int verify_packfile(struct packed_git *p,
 	}
 	qsort(entries, nr_objects, sizeof(*entries), compare_entries);
 
-	for (i = 0, err = 0; i < nr_objects; i++) {
+	for (i = 0; i < nr_objects; i++) {
 		void *data;
 		enum object_type type;
 		unsigned long size;
 
 		data = unpack_entry(p, entries[i].offset, &type, &size);
 		if (!data) {
-			err = error("cannot unpack %s from %s",
-				    sha1_to_hex(entries[i].sha1), p->pack_name);
-			continue;
+			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
+				    sha1_to_hex(entries[i].sha1), p->pack_name,
+				    (uintmax_t)entries[i].offset);
+			break;
 		}
 		if (check_sha1_signature(entries[i].sha1, data, size, typename(type))) {
 			err = error("packed %s from %s is corrupt",
 				    sha1_to_hex(entries[i].sha1), p->pack_name);
 			free(data);
-			continue;
+			break;
 		}
 		free(data);
 	}
@@ -158,31 +160,28 @@ int verify_pack(struct packed_git *p, int verbose)
 	const unsigned char *index_base;
 	SHA_CTX ctx;
 	unsigned char sha1[20];
-	int ret;
+	int err = 0;
+	struct pack_window *w_curs = NULL;
 
 	if (open_pack_index(p))
 		return error("packfile %s index not opened", p->pack_name);
 	index_size = p->index_size;
 	index_base = p->index_data;
 
-	ret = 0;
 	/* Verify SHA1 sum of the index file */
 	SHA1_Init(&ctx);
 	SHA1_Update(&ctx, index_base, (unsigned int)(index_size - 20));
 	SHA1_Final(sha1, &ctx);
 	if (hashcmp(sha1, index_base + index_size - 20))
-		ret = error("Packfile index for %s SHA1 mismatch",
+		err = error("Packfile index for %s SHA1 mismatch",
 			    p->pack_name);
 
-	if (!ret) {
-		/* Verify pack file */
-		struct pack_window *w_curs = NULL;
-		ret = verify_packfile(p, &w_curs);
-		unuse_pack(&w_curs);
-	}
+	/* Verify pack file */
+	err = verify_packfile(p, &w_curs);
+	unuse_pack(&w_curs);
 
 	if (verbose) {
-		if (ret)
+		if (err)
 			printf("%s: bad\n", p->pack_name);
 		else {
 			show_pack_info(p);
@@ -190,5 +189,5 @@ int verify_pack(struct packed_git *p, int verbose)
 		}
 	}
 
-	return ret;
+	return err;
 }
