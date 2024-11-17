Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6737F61FFE
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731834498; cv=none; b=brtZKYL5FEkrG91o3e+UnU/0XdYBfHt5KCaxMApt+ONbVUNXlbijKwHSHtsSPoF//DJFwV4fHTroeZHsgBgMJbmMR7nJGFhEj0ztyUXhcDyyBDBTvM3s/S24/3eDz24ycrrx6pJXjAWRZjPYmb9rYIVdWCHoOXechMH6NVSVPD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731834498; c=relaxed/simple;
	bh=JQaSB3EnPPdC8RM0ykJU/TDtciVN/dWviX35opkFPLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id8YHbLF4+W9lbr+oxk3C8pXcjwpdU2FF3lcs+5bhdT4twWFW17vJt+rJI2+xUcO1FtWibOk0xpqD/naHSh6jITrTKdPuTXqOJ9jT6urBZaq1DxQx70X/uG+zXfPKs2Ci+QUgy2aaAKz7/J0TYWVy01b/eoOn/sawUVUlvHb7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gWG/Ovc/; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gWG/Ovc/"
Received: (qmail 9263 invoked by uid 109); 17 Nov 2024 09:08:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=JQaSB3EnPPdC8RM0ykJU/TDtciVN/dWviX35opkFPLg=; b=gWG/Ovc/5alUV/rxCodQ7pgrdpIYQ+PPEbuCyGWHoVq6Z3umdKglRnwvXh9ThnqonhwBMYb02dB2yRGD0G2/cQJDXpFIXVu79CX0bfNuFAjfSEePyPuh8XyLNi4ZR3gyVEE39EQ4IXhw5Ctp8A1ugfnTkb7aYrUuAsYv7Cm1mXER3+VIbrI3UxinM/z4xiXkocsOMo99+cwDnI4ETM6ECfQH2+OiewDGYIjwAkoLSLAxo738X+UMxhWGv/XUpjyZNiYfUll/0wKX3fp/7koCJtTCWdgu8oucI29hqDbLvwtesIPPTtyHMfsb769GYUSzF2FQokG6pzwMeeRW6wcstg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 17 Nov 2024 09:08:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2216 invoked by uid 111); 17 Nov 2024 09:08:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 17 Nov 2024 04:08:19 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 17 Nov 2024 04:08:14 -0500
From: Jeff King <peff@peff.net>
To: Sam James <sam@gentoo.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: [PATCH 1/5] object-file: prefer array-of-bytes initializer for hash
 literals
Message-ID: <20241117090814.GA3409496@coredump.intra.peff.net>
References: <20241117090329.GA2341486@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241117090329.GA2341486@coredump.intra.peff.net>

We hard-code a few well-known hash values for empty trees and blobs in
both sha1 and sha256 formats. We do so with string literals like this:

  #define EMPTY_TREE_SHA256_BIN_LITERAL \
         "\x6e\xf1\x9b\x41\x22\x5c\x53\x69\xf1\xc1" \
         "\x04\xd4\x5d\x8d\x85\xef\xa9\xb0\x57\xb5" \
         "\x3b\x14\xb4\xb9\xb9\x39\xdd\x74\xde\xcc" \
         "\x53\x21"

and then use it to initialize the hash field of an object_id struct.
That hash field is exactly 32 bytes long (the size we need for sha256).
But the string literal above is actually 33 bytes long due to the NUL
terminator. It's legal in C to initialize from a longer string literal;
the extra bytes are just ignored.

However, the upcoming gcc 15 will start warning about this:

      CC object-file.o
  object-file.c:52:9: warning: initializer-string for array of ‘unsigned char’ is too long [-Wunterminated-string-initialization]
     52 |         "\x6e\xf1\x9b\x41\x22\x5c\x53\x69\xf1\xc1" \
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  object-file.c:79:17: note: in expansion of macro ‘EMPTY_TREE_SHA256_BIN_LITERAL’

which is understandable. Even though this is not a bug for us, since we
do not care about the NUL terminator (and are just using the literal as
a convenient format), it would be easy to accidentally create an array
that was mistakenly unterminated.

We can avoid this warning by switching the initializer to an actual
array of unsigned values. That arguably demonstrates our intent more
clearly anyway.

Reported-by: Sam James <sam@gentoo.org>
Signed-off-by: Jeff King <peff@peff.net>
---
I actually didn't find exact wording in the standard for using a
longer literal. But C99 section 6.7.8 (Initialization), para 32 shows
this exact case as "example 8".

You can view the diff with "--color-words --word-diff-regex=." to more
clearly see that the values themselves weren't changed.

 object-file.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/object-file.c b/object-file.c
index b1a3463852..25ba54594b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -45,23 +45,27 @@
 #define MAX_HEADER_LEN 32
 
 
-#define EMPTY_TREE_SHA1_BIN_LITERAL \
-	 "\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60" \
-	 "\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04"
-#define EMPTY_TREE_SHA256_BIN_LITERAL \
-	"\x6e\xf1\x9b\x41\x22\x5c\x53\x69\xf1\xc1" \
-	"\x04\xd4\x5d\x8d\x85\xef\xa9\xb0\x57\xb5" \
-	"\x3b\x14\xb4\xb9\xb9\x39\xdd\x74\xde\xcc" \
-	"\x53\x21"
-
-#define EMPTY_BLOB_SHA1_BIN_LITERAL \
-	"\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b" \
-	"\x29\xae\x77\x5a\xd8\xc2\xe4\x8c\x53\x91"
-#define EMPTY_BLOB_SHA256_BIN_LITERAL \
-	"\x47\x3a\x0f\x4c\x3b\xe8\xa9\x36\x81\xa2" \
-	"\x67\xe3\xb1\xe9\xa7\xdc\xda\x11\x85\x43" \
-	"\x6f\xe1\x41\xf7\x74\x91\x20\xa3\x03\x72" \
-	"\x18\x13"
+#define EMPTY_TREE_SHA1_BIN_LITERAL { \
+	 0x4b, 0x82, 0x5d, 0xc6, 0x42, 0xcb, 0x6e, 0xb9, 0xa0, 0x60,  \
+	 0xe5, 0x4b, 0xf8, 0xd6, 0x92, 0x88, 0xfb, 0xee, 0x49, 0x04  \
+}
+#define EMPTY_TREE_SHA256_BIN_LITERAL { \
+	0x6e, 0xf1, 0x9b, 0x41, 0x22, 0x5c, 0x53, 0x69, 0xf1, 0xc1,  \
+	0x04, 0xd4, 0x5d, 0x8d, 0x85, 0xef, 0xa9, 0xb0, 0x57, 0xb5,  \
+	0x3b, 0x14, 0xb4, 0xb9, 0xb9, 0x39, 0xdd, 0x74, 0xde, 0xcc,  \
+	0x53, 0x21 \
+}
+
+#define EMPTY_BLOB_SHA1_BIN_LITERAL { \
+	0xe6, 0x9d, 0xe2, 0x9b, 0xb2, 0xd1, 0xd6, 0x43, 0x4b, 0x8b,  \
+	0x29, 0xae, 0x77, 0x5a, 0xd8, 0xc2, 0xe4, 0x8c, 0x53, 0x91  \
+}
+#define EMPTY_BLOB_SHA256_BIN_LITERAL { \
+	0x47, 0x3a, 0x0f, 0x4c, 0x3b, 0xe8, 0xa9, 0x36, 0x81, 0xa2,  \
+	0x67, 0xe3, 0xb1, 0xe9, 0xa7, 0xdc, 0xda, 0x11, 0x85, 0x43,  \
+	0x6f, 0xe1, 0x41, 0xf7, 0x74, 0x91, 0x20, 0xa3, 0x03, 0x72,  \
+	0x18, 0x13 \
+}
 
 static const struct object_id empty_tree_oid = {
 	.hash = EMPTY_TREE_SHA1_BIN_LITERAL,
-- 
2.47.0.541.ge258d9a1f8

