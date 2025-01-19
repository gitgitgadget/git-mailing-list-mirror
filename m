Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9FA1DA3D
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737293151; cv=none; b=XAr8vDxJnqJ/hen4/DsR5xUbhuS/7JPwR7AeYFprCvql64AyLTtsO1V4lkLUpNDJ8r/02827BtBKEaSSjUyqD83z0/0rDD4j72kipAP8lYeSrD9p6psf+WdFnoMl42tkjQGNZ5a3SCqzNfst3vTLE4UtuS4KhLU8ZUuMoP5B+6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737293151; c=relaxed/simple;
	bh=A113ll2crsf8XC3UOLfcyOZi2Ch4MBypyXRHvPzlOvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npAgR6wyOkWFR4xOL7ccRvXFdJ+gMd6zosaPP9BL7oUkUkFq5488bWd4u9Qt9oszFqBqT+MbefBqt3ID5+li3aUGOcpg28+jAQ4eeKOQ1Be8mxUniTbG73oCriu76fBJI0BZBQ9JePHQItEj8PCTfjHQoGl2nlgt/jyvl4cIKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hhmmYmiq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hhmmYmiq"
Received: (qmail 7996 invoked by uid 109); 19 Jan 2025 13:25:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=A113ll2crsf8XC3UOLfcyOZi2Ch4MBypyXRHvPzlOvI=; b=hhmmYmiqA2HKBwqS9IU51b7I2UPKW9gkE5+812boTyz16CyHU2adbimhpYn7KWj+KeonX7ZYPp6cmyELCDB1l5eRrX02F+8BiOrvesfw6CqWl95+EbrtnwPKlBmDVXvFhlL3skJMtBkOrjwYwfr9VkiEusQJl37anHFmI6mDLkPV/nLR0jmaRiaolYf56FVZGZsssJBhrOW+0coQVtl/6JF1ivHJbyRYT0GIUWPphbP75AaQQUN0SUCSYsR33jc20o25fzu5LpuTq16zc5W1Zzds3pLgpxvsFVRz8qfUcBWRqA7f0nkPWTuWSn44PE+37LMWs9ALJm18AdSfQm0EuQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 19 Jan 2025 13:25:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 786 invoked by uid 111); 19 Jan 2025 13:25:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 19 Jan 2025 08:25:47 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 19 Jan 2025 08:25:47 -0500
From: Jeff King <peff@peff.net>
To: Koakuma <koachan@protonmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v2 4/5] index-pack, unpack-objects: use get_be32() for
 reading pack header
Message-ID: <20250119132547.GD1552263@coredump.intra.peff.net>
References: <20250119131224.GA1541095@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250119131224.GA1541095@coredump.intra.peff.net>

Both of these commands read the incoming pack into a static unsigned
char buffer in BSS, and then parse it by casting the start of the buffer
to a struct pack_header. This can result in SIGBUS on some platforms if
the compiler doesn't place the buffer in a position that is properly
aligned for 4-byte integers.

This reportedly happens with unpack-objects (but not index-pack) on
sparc64 when compiled with clang (but not gcc). But we are definitely in
the wrong in both spots; since the buffer's type is unsigned char, we
can't depend on larger alignment. When it works it is only because we
are lucky.

We'll fix this by switching to get_be32() to read the headers (just like
the last few commits similarly switched us to put_be32() for writing
into the same buffer).

It would be nice to factor this out into a common helper function, but
the interface ends up quite awkward. Either the caller needs to hardcode
how many bytes we'll need, or it needs to pass us its fill()/use()
functions as pointers. So I've just fixed both spots in the same way;
this is not code that is likely to be repeated a third time (most of the
pack reading code uses an mmap'd buffer, which should be properly
aligned).

I did make one tweak to the shared code: our pack_version_ok() macro
expects us to pass the big-endian value we'd get by casting. We can
introduce a "native" variant which uses the host integer ordering.

Reported-by: Koakuma <koachan@protonmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
New in v2.

I did write the function-pointer version, and it's not even _too_ bad to
read. But while trying to write a comment documenting the helper, it
was just too gross to justify.

 builtin/index-pack.c     | 12 +++++++-----
 builtin/unpack-objects.c | 13 +++++++------
 pack.h                   |  3 ++-
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 75b84f78f4..d6fd4bbde6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -379,16 +379,18 @@ static const char *open_pack_file(const char *pack_name)
 
 static void parse_pack_header(void)
 {
-	struct pack_header *hdr = fill(sizeof(struct pack_header));
+	unsigned char *hdr = fill(sizeof(struct pack_header));
 
 	/* Header consistency check */
-	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
+	if (get_be32(hdr) != PACK_SIGNATURE)
 		die(_("pack signature mismatch"));
-	if (!pack_version_ok(hdr->hdr_version))
+	hdr += 4;
+	if (!pack_version_ok_native(get_be32(hdr)))
 		die(_("pack version %"PRIu32" unsupported"),
-			ntohl(hdr->hdr_version));
+		    get_be32(hdr));
+	hdr += 4;
 
-	nr_objects = ntohl(hdr->hdr_entries);
+	nr_objects = get_be32(hdr);
 	use(sizeof(struct pack_header));
 }
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index cf2bc5c531..76c6a9031b 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -579,15 +579,16 @@ static void unpack_one(unsigned nr)
 static void unpack_all(void)
 {
 	int i;
-	struct pack_header *hdr = fill(sizeof(struct pack_header));
+	unsigned char *hdr = fill(sizeof(struct pack_header));
 
-	nr_objects = ntohl(hdr->hdr_entries);
-
-	if (ntohl(hdr->hdr_signature) != PACK_SIGNATURE)
+	if (get_be32(hdr) != PACK_SIGNATURE)
 		die("bad pack file");
-	if (!pack_version_ok(hdr->hdr_version))
+	hdr += 4;
+	if (!pack_version_ok_native(get_be32(hdr)))
 		die("unknown pack file version %"PRIu32,
-			ntohl(hdr->hdr_version));
+		    get_be32(hdr));
+	hdr += 4;
+	nr_objects = get_be32(hdr);
 	use(sizeof(struct pack_header));
 
 	if (!quiet)
diff --git a/pack.h b/pack.h
index a8da040629..78f8d8b213 100644
--- a/pack.h
+++ b/pack.h
@@ -13,7 +13,8 @@ struct repository;
  */
 #define PACK_SIGNATURE 0x5041434b	/* "PACK" */
 #define PACK_VERSION 2
-#define pack_version_ok(v) ((v) == htonl(2) || (v) == htonl(3))
+#define pack_version_ok(v) pack_version_ok_native(ntohl(v))
+#define pack_version_ok_native(v) ((v) == 2 || (v) == 3)
 struct pack_header {
 	uint32_t hdr_signature;
 	uint32_t hdr_version;
-- 
2.48.1.466.g22b8cfd1fa

