Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B7B61FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 17:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbdCXR1m (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 13:27:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:51114 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbdCXR1f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 13:27:35 -0400
Received: (qmail 17651 invoked by uid 109); 24 Mar 2017 17:26:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 17:26:43 +0000
Received: (qmail 1885 invoked by uid 111); 24 Mar 2017 17:26:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 13:26:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 13:26:40 -0400
Date:   Fri, 24 Mar 2017 13:26:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/4] encode_in_pack_object_header: respect output buffer
 length
Message-ID: <20170324172640.s6esvcbxfj2x63eb@sigill.intra.peff.net>
References: <20170324172246.fy5drvhzqxghu44a@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170324172246.fy5drvhzqxghu44a@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The encode_in_pack_object_header() writes a variable-length
header to an output buffer, but it doesn't actually know
long the buffer is. At first glance, this looks like it
might be possible to overflow.

In practice, this is probably impossible. The smallest
buffer we use is 10 bytes, which would hold the header for
an object up to 2^67 bytes. Obviously we're not likely to
see such an object, but we might worry that an object could
lie about its size (causing us to overflow before we realize
it does not actually have that many bytes). But the argument
is passed as a uintmax_t. Even on systems that have __int128
available, uintmax_t is typically restricted to 64-bit by
the ABI.

So it's unlikely that a system exists where this could be
exploited. Still, it's easy enough to use a normal out/len
pair and make sure we don't write too far. That protects the
hypothetical 128-bit system, makes it harder for callers to
accidentally specify a too-small buffer, and makes the
resulting code easier to audit.

Note that the one caller in fast-import tried to catch such
a case, but did so _after_ the call (at which point we'd
have already overflowed!). This check can now go away.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c |  6 ++++--
 bulk-checkin.c         |  2 +-
 fast-import.c          | 10 +++++-----
 pack-write.c           |  5 ++++-
 pack.h                 |  3 ++-
 5 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 16517f263..cf3fc50a2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -286,7 +286,8 @@ static unsigned long write_no_reuse_object(struct sha1file *f, struct object_ent
 	 * The object header is a byte of 'type' followed by zero or
 	 * more bytes of length.
 	 */
-	hdrlen = encode_in_pack_object_header(type, size, header);
+	hdrlen = encode_in_pack_object_header(header, sizeof(header),
+					      type, size);
 
 	if (type == OBJ_OFS_DELTA) {
 		/*
@@ -358,7 +359,8 @@ static off_t write_reuse_object(struct sha1file *f, struct object_entry *entry,
 	if (entry->delta)
 		type = (allow_ofs_delta && entry->delta->idx.offset) ?
 			OBJ_OFS_DELTA : OBJ_REF_DELTA;
-	hdrlen = encode_in_pack_object_header(type, entry->size, header);
+	hdrlen = encode_in_pack_object_header(header, sizeof(header),
+					      type, entry->size);
 
 	offset = entry->in_pack_offset;
 	revidx = find_pack_revindex(p, offset);
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 991b4a13e..ddb6070c4 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -105,7 +105,7 @@ static int stream_to_pack(struct bulk_checkin_state *state,
 
 	git_deflate_init(&s, pack_compression_level);
 
-	hdrlen = encode_in_pack_object_header(type, size, obuf);
+	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), type, size);
 	s.next_out = obuf + hdrlen;
 	s.avail_out = sizeof(obuf) - hdrlen;
 
diff --git a/fast-import.c b/fast-import.c
index 4a057e81f..f6f416f20 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1173,7 +1173,8 @@ static int store_object(
 		delta_count_by_type[type]++;
 		e->depth = last->depth + 1;
 
-		hdrlen = encode_in_pack_object_header(OBJ_OFS_DELTA, deltalen, hdr);
+		hdrlen = encode_in_pack_object_header(hdr, sizeof(hdr),
+						      OBJ_OFS_DELTA, deltalen);
 		sha1write(pack_file, hdr, hdrlen);
 		pack_size += hdrlen;
 
@@ -1184,7 +1185,8 @@ static int store_object(
 		pack_size += sizeof(hdr) - pos;
 	} else {
 		e->depth = 0;
-		hdrlen = encode_in_pack_object_header(type, dat->len, hdr);
+		hdrlen = encode_in_pack_object_header(hdr, sizeof(hdr),
+						      type, dat->len);
 		sha1write(pack_file, hdr, hdrlen);
 		pack_size += hdrlen;
 	}
@@ -1246,9 +1248,7 @@ static void stream_blob(uintmax_t len, unsigned char *sha1out, uintmax_t mark)
 
 	git_deflate_init(&s, pack_compression_level);
 
-	hdrlen = encode_in_pack_object_header(OBJ_BLOB, len, out_buf);
-	if (out_sz <= hdrlen)
-		die("impossibly large object header");
+	hdrlen = encode_in_pack_object_header(out_buf, out_sz, OBJ_BLOB, len);
 
 	s.next_out = out_buf + hdrlen;
 	s.avail_out = out_sz - hdrlen;
diff --git a/pack-write.c b/pack-write.c
index 88bc7f9f7..c057513f1 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -304,7 +304,8 @@ char *index_pack_lockfile(int ip_out)
  *  - each byte afterwards: low seven bits are size continuation,
  *    with the high bit being "size continues"
  */
-int encode_in_pack_object_header(enum object_type type, uintmax_t size, unsigned char *hdr)
+int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
+				 enum object_type type, uintmax_t size)
 {
 	int n = 1;
 	unsigned char c;
@@ -315,6 +316,8 @@ int encode_in_pack_object_header(enum object_type type, uintmax_t size, unsigned
 	c = (type << 4) | (size & 15);
 	size >>= 4;
 	while (size) {
+		if (n == hdr_len)
+			die("object size is too enormous to format");
 		*hdr++ = c | 0x80;
 		c = size & 0x7f;
 		size >>= 7;
diff --git a/pack.h b/pack.h
index 0e77429df..87e456d5e 100644
--- a/pack.h
+++ b/pack.h
@@ -84,7 +84,8 @@ extern int verify_pack(struct packed_git *, verify_fn fn, struct progress *, uin
 extern off_t write_pack_header(struct sha1file *f, uint32_t);
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
-extern int encode_in_pack_object_header(enum object_type, uintmax_t, unsigned char *);
+extern int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
+					enum object_type, uintmax_t);
 
 #define PH_ERROR_EOF		(-1)
 #define PH_ERROR_PACK_SIGNATURE	(-2)
-- 
2.12.1.843.g1937c56c2

