Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7724F61FCE
	for <git@vger.kernel.org>; Fri, 16 May 2025 04:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747370988; cv=none; b=B8We5O5+Wh/dOlY3WR8RDnfgKyYvPtk9d/5nGBNxvob8prELaLVokmKVVLeIxcOc1E06Nj/lzM9yTdIOa4yqjZRzQlmQVlDWRfxVqkKd0L7gxEZWsVMpBUdXW9A6T79VqUlUsEX2vQOmk8S/3KEhNKYexVxwa7go92VjwlITvmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747370988; c=relaxed/simple;
	bh=Zl+iTg1ijn4jKcJnRuelf//6+soMPW7wDv0wwszo5/A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1T8pRZaG6Z4quYI/KSdsriqTNSEVgJHdr9zSBkq6cR+s0B0QmnNfyikX2f0eTvVSvHIhcD0vPolZBpQ9wju16Sp6w00dkLhMGGcHzcVUNrXYQkUO4ko+2y4nBM7jsAGRYGcQhjqmRzeggGiKbZcScr/rHwPB6drH5Dif1ETkUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SxLWqor2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SxLWqor2"
Received: (qmail 5154 invoked by uid 109); 16 May 2025 04:49:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Zl+iTg1ijn4jKcJnRuelf//6+soMPW7wDv0wwszo5/A=; b=SxLWqor2t7kUycl2NeJoPPUdV44rDPH+tI7yMeUlv+ym4n2ry0ci6X6D3sVCR6cnOtu1pLu95+TfzHBD7XkuvRotTIkn0zue9POb9wlXXU9jNW+VaYcHqaY5Cm2E2Gjzp7lX42K7wo8y4x0iWVNRCO4S71ADN8lVmvLRglzbzyEJC8Ap+c2MMbjNvSk3Pl9ULAmfYQqmI+sSh599GCbBcN/778EAN7k+cftfQIKzcpsrzKCVJvg2FcXF82I97WdQiJ4wt9WcoCVm+FXXEkdYKEy44jNMXhXnddn0j3dR7XWpL1fxrhTRiZhVQb/hZGRA5+n/1/U/O0rSyNHmI3SiPQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 May 2025 04:49:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4898 invoked by uid 111); 16 May 2025 04:49:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 May 2025 00:49:49 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 16 May 2025 00:49:45 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 03/13] object-file: drop OBJECT_INFO_ALLOW_UNKNOWN_TYPE flag
Message-ID: <20250516044945.GC22242@coredump.intra.peff.net>
References: <20250516044916.GA21985@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250516044916.GA21985@coredump.intra.peff.net>

Since cat-file dropped its "--allow-unknown-type" option in the previous
commit, there are no more uses of the internal flag that implemented it.
Let's drop it.

That in turn lets us drop the strbuf parameter of unpack_loose_header(),
which now is always NULL. And without that, we can drop all of the
additional code to inflate larger headers into the strbuf.

Arguably we could drop ULHR_TOO_LONG, as no callers really care about
the distinction from ULHR_BAD. But it's easy enough to retain, and it
does let us produce a slightly more specific message in one instance.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c  | 45 +++++++--------------------------------------
 object-file.h  | 10 ++--------
 object-store.h |  2 --
 streaming.c    |  2 +-
 4 files changed, 10 insertions(+), 49 deletions(-)

diff --git a/object-file.c b/object-file.c
index dc56a4766d..1127e154f6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -299,8 +299,7 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 						    unsigned char *map,
 						    unsigned long mapsize,
 						    void *buffer,
-						    unsigned long bufsiz,
-						    struct strbuf *header)
+						    unsigned long bufsiz)
 {
 	int status;
 
@@ -325,32 +324,9 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 		return ULHR_OK;
 
 	/*
-	 * We have a header longer than MAX_HEADER_LEN. The "header"
-	 * here is only non-NULL when we run "cat-file
-	 * --allow-unknown-type".
+	 * We have a header longer than MAX_HEADER_LEN.
 	 */
-	if (!header)
-		return ULHR_TOO_LONG;
-
-	/*
-	 * buffer[0..bufsiz] was not large enough.  Copy the partial
-	 * result out to header, and then append the result of further
-	 * reading the stream.
-	 */
-	strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
-
-	do {
-		stream->next_out = buffer;
-		stream->avail_out = bufsiz;
-
-		obj_read_unlock();
-		status = git_inflate(stream, 0);
-		obj_read_lock();
-		strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
-		if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
-			return 0;
-	} while (status == Z_OK);
-	return ULHR_BAD;
+	return ULHR_TOO_LONG;
 }
 
 static void *unpack_loose_rest(git_zstream *stream,
@@ -476,10 +452,8 @@ int loose_object_info(struct repository *r,
 	void *map;
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
-	struct strbuf hdrbuf = STRBUF_INIT;
 	unsigned long size_scratch;
 	enum object_type type_scratch;
-	int allow_unknown = flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
 	if (oi->delta_base_oid)
 		oidclr(oi->delta_base_oid, the_repository->hash_algo);
@@ -521,18 +495,15 @@ int loose_object_info(struct repository *r,
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
 
-	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
-				    allow_unknown ? &hdrbuf : NULL)) {
+	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr))) {
 	case ULHR_OK:
-		if (parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi) < 0)
+		if (parse_loose_header(hdr, oi) < 0)
 			status = error(_("unable to parse %s header"), oid_to_hex(oid));
-		else if (!allow_unknown && *oi->typep < 0)
+		else if (*oi->typep < 0)
 			die(_("invalid object type"));
 
 		if (!oi->contentp)
 			break;
-		if (hdrbuf.len)
-			BUG("unpacking content with unknown types not yet supported");
 		*oi->contentp = unpack_loose_rest(&stream, hdr, *oi->sizep, oid);
 		if (*oi->contentp)
 			goto cleanup;
@@ -558,7 +529,6 @@ int loose_object_info(struct repository *r,
 	munmap(map, mapsize);
 	if (oi->sizep == &size_scratch)
 		oi->sizep = NULL;
-	strbuf_release(&hdrbuf);
 	if (oi->typep == &type_scratch)
 		oi->typep = NULL;
 	oi->whence = OI_LOOSE;
@@ -1682,8 +1652,7 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
-				NULL) != ULHR_OK) {
+	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) != ULHR_OK) {
 		error(_("unable to unpack header of %s"), path);
 		goto out_inflate;
 	}
diff --git a/object-file.h b/object-file.h
index fd715663fb..a979fd5e4d 100644
--- a/object-file.h
+++ b/object-file.h
@@ -133,12 +133,7 @@ int format_object_header(char *str, size_t size, enum object_type type,
  * - ULHR_BAD on error
  * - ULHR_TOO_LONG if the header was too long
  *
- * It will only parse up to MAX_HEADER_LEN bytes unless an optional
- * "hdrbuf" argument is non-NULL. This is intended for use with
- * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
- * reporting. The full header will be extracted to "hdrbuf" for use
- * with parse_loose_header(), ULHR_TOO_LONG will still be returned
- * from this function to indicate that the header was too long.
+ * It will only parse up to MAX_HEADER_LEN bytes.
  */
 enum unpack_loose_header_result {
 	ULHR_OK,
@@ -149,8 +144,7 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 						    unsigned char *map,
 						    unsigned long mapsize,
 						    void *buffer,
-						    unsigned long bufsiz,
-						    struct strbuf *hdrbuf);
+						    unsigned long bufsiz);
 
 /**
  * parse_loose_header() parses the starting "<type> <len>\0" of an
diff --git a/object-store.h b/object-store.h
index c2fe5a1960..cf908fe68e 100644
--- a/object-store.h
+++ b/object-store.h
@@ -240,8 +240,6 @@ struct object_info {
 
 /* Invoke lookup_replace_object() on the given hash */
 #define OBJECT_INFO_LOOKUP_REPLACE 1
-/* Allow reading from a loose object file of unknown/bogus type */
-#define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
 /* Do not retry packed storage after checking packed and loose storage */
 #define OBJECT_INFO_QUICK 8
 /*
diff --git a/streaming.c b/streaming.c
index 127d6b5d6a..6d6512e2e0 100644
--- a/streaming.c
+++ b/streaming.c
@@ -238,7 +238,7 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 		return -1;
 	switch (unpack_loose_header(&st->z, st->u.loose.mapped,
 				    st->u.loose.mapsize, st->u.loose.hdr,
-				    sizeof(st->u.loose.hdr), NULL)) {
+				    sizeof(st->u.loose.hdr))) {
 	case ULHR_OK:
 		break;
 	case ULHR_BAD:
-- 
2.49.0.896.g93578ceaaf

