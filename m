Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E7EA92D
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731834867; cv=none; b=qQCKYIAzZrohXfLpEsMXbP0m2M1j5lcTcj0vvSy4GqT7yck4iqsCPPrcAR/cwhaY7D2V/RuBoFrSTKDITIQlv2l9ZhztFbvL52lQRHTdR6/SIoLatn/NMEUWGe1dMMiFojetvZTMkGrnRCnY45J2rqqtPQMbMYhh7xgbF6QMgMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731834867; c=relaxed/simple;
	bh=4izKsYwXmx17YVg8Sxvo+UN/oUwBu7jF2GJVGhZyuqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP+Lu1n3OfVM8FhY3AlbyrdAshDdLU0aDRvZX3muwYcLetKb9pV34dzFIKxJ77eXxCny2QVtOInHAuOzppoQwkdBDJQqqWjIq6O7mvCFxTXCPaFkxKpWNatpdZsh7Gk63yOnllXsRv23/kevzKf5YDlw/FEBKQ7WPj2l3DWwxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Fsri2Xap; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Fsri2Xap"
Received: (qmail 9309 invoked by uid 109); 17 Nov 2024 09:14:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4izKsYwXmx17YVg8Sxvo+UN/oUwBu7jF2GJVGhZyuqI=; b=Fsri2Xap0g6OFrx2f3ONsOMoqKFdO7B4omaMJgr+5Xvw84DKowv5/gPMdHiQ4OLHOywV/AFlR6VffbEFxdYBVY13zU5vdlyBPLSnBX9OFlnGkRv7NPbj6i6VHemKUFH3elERHrmbApqwFovwZkdOukOnakFQ1cjW8vGb+wlyQSoic+cUhgMQL9DojKfKGL8WS0TGSlOy37L5AYo44GtxUl8+PlhuDh65MNfaRC8zT2ok+aV6GzNlntLfIrfKKFHVDPNSjl7feoPScmAcFq2Hq4PQYYgYqMogCOiVWOdhZRrZjPAZv7MFYwqKVt2p2MEmIMF9JSSlh2gaSEI3yLaOKA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 17 Nov 2024 09:14:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2330 invoked by uid 111); 17 Nov 2024 09:14:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 17 Nov 2024 04:14:28 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 17 Nov 2024 04:14:23 -0500
From: Jeff King <peff@peff.net>
To: Sam James <sam@gentoo.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: [PATCH 5/5] object-file: inline empty tree and blob literals
Message-ID: <20241117091423.GE3409496@coredump.intra.peff.net>
References: <20241117090329.GA2341486@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241117090329.GA2341486@coredump.intra.peff.net>

We define macros with the bytes of the empty trees and blobs for sha1
and sha256. But since e1ccd7e2b1 (sha1_file: only expose empty object
constants through git_hash_algo, 2018-05-02), those are used only for
initializing the git_hash_algo entries. Any other code using the macros
directly would be suspicious, since a hash_algo pointer is the level of
indirection we use to make everything work with both sha1 and sha256.

So let's future proof against code doing the wrong thing by dropping the
macros entirely and just initializing the structs directly.

Signed-off-by: Jeff King <peff@peff.net>
---
Sadly you can't use --word-diff to make sense of this one, and
--color-moved is foiled by dropping the trailing backslashes. Anybody is
welcome to verify that the values did not change. :)

We're still left with split-out structs for empty_tree_oid_sha256, etc
(and confusingly the sha1 ones do not even say "sha1"). I think we could
take this all one step further and inline those directly into the
git_hash_algo. But that would have repercussions throughout the tree,
since many spots would switch from:

  repo->hash_algo->empty_tree

to:

  &repo->hash_algo->empty_tree

Not sure if it's worth it (it's also one less pointer chase, but I kind
of doubt that accessing the empty tree oid is ever a hot code path).

 object-file.c | 47 ++++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/object-file.c b/object-file.c
index e461e351ca..e325a52be5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -44,47 +44,40 @@
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
 
-
-#define EMPTY_TREE_SHA1_BIN_LITERAL { \
-	 0x4b, 0x82, 0x5d, 0xc6, 0x42, 0xcb, 0x6e, 0xb9, 0xa0, 0x60,  \
-	 0xe5, 0x4b, 0xf8, 0xd6, 0x92, 0x88, 0xfb, 0xee, 0x49, 0x04  \
-}
-#define EMPTY_TREE_SHA256_BIN_LITERAL { \
-	0x6e, 0xf1, 0x9b, 0x41, 0x22, 0x5c, 0x53, 0x69, 0xf1, 0xc1,  \
-	0x04, 0xd4, 0x5d, 0x8d, 0x85, 0xef, 0xa9, 0xb0, 0x57, 0xb5,  \
-	0x3b, 0x14, 0xb4, 0xb9, 0xb9, 0x39, 0xdd, 0x74, 0xde, 0xcc,  \
-	0x53, 0x21 \
-}
-
-#define EMPTY_BLOB_SHA1_BIN_LITERAL { \
-	0xe6, 0x9d, 0xe2, 0x9b, 0xb2, 0xd1, 0xd6, 0x43, 0x4b, 0x8b,  \
-	0x29, 0xae, 0x77, 0x5a, 0xd8, 0xc2, 0xe4, 0x8c, 0x53, 0x91  \
-}
-#define EMPTY_BLOB_SHA256_BIN_LITERAL { \
-	0x47, 0x3a, 0x0f, 0x4c, 0x3b, 0xe8, 0xa9, 0x36, 0x81, 0xa2,  \
-	0x67, 0xe3, 0xb1, 0xe9, 0xa7, 0xdc, 0xda, 0x11, 0x85, 0x43,  \
-	0x6f, 0xe1, 0x41, 0xf7, 0x74, 0x91, 0x20, 0xa3, 0x03, 0x72,  \
-	0x18, 0x13 \
-}
-
 static const struct object_id empty_tree_oid = {
-	.hash = EMPTY_TREE_SHA1_BIN_LITERAL,
+	.hash ={
+		0x4b, 0x82, 0x5d, 0xc6, 0x42, 0xcb, 0x6e, 0xb9, 0xa0, 0x60,
+		0xe5, 0x4b, 0xf8, 0xd6, 0x92, 0x88, 0xfb, 0xee, 0x49, 0x04
+	},
 	.algo = GIT_HASH_SHA1,
 };
 static const struct object_id empty_blob_oid = {
-	.hash = EMPTY_BLOB_SHA1_BIN_LITERAL,
+	.hash = {
+		0xe6, 0x9d, 0xe2, 0x9b, 0xb2, 0xd1, 0xd6, 0x43, 0x4b, 0x8b,
+		0x29, 0xae, 0x77, 0x5a, 0xd8, 0xc2, 0xe4, 0x8c, 0x53, 0x91
+	},
 	.algo = GIT_HASH_SHA1,
 };
 static const struct object_id null_oid_sha1 = {
 	.hash = {0},
 	.algo = GIT_HASH_SHA1,
 };
 static const struct object_id empty_tree_oid_sha256 = {
-	.hash = EMPTY_TREE_SHA256_BIN_LITERAL,
+	.hash = {
+		0x6e, 0xf1, 0x9b, 0x41, 0x22, 0x5c, 0x53, 0x69, 0xf1, 0xc1,
+		0x04, 0xd4, 0x5d, 0x8d, 0x85, 0xef, 0xa9, 0xb0, 0x57, 0xb5,
+		0x3b, 0x14, 0xb4, 0xb9, 0xb9, 0x39, 0xdd, 0x74, 0xde, 0xcc,
+		0x53, 0x21
+	},
 	.algo = GIT_HASH_SHA256,
 };
 static const struct object_id empty_blob_oid_sha256 = {
-	.hash = EMPTY_BLOB_SHA256_BIN_LITERAL,
+	.hash = {
+		0x47, 0x3a, 0x0f, 0x4c, 0x3b, 0xe8, 0xa9, 0x36, 0x81, 0xa2,
+		0x67, 0xe3, 0xb1, 0xe9, 0xa7, 0xdc, 0xda, 0x11, 0x85, 0x43,
+		0x6f, 0xe1, 0x41, 0xf7, 0x74, 0x91, 0x20, 0xa3, 0x03, 0x72,
+		0x18, 0x13
+	},
 	.algo = GIT_HASH_SHA256,
 };
 static const struct object_id null_oid_sha256 = {
-- 
2.47.0.541.ge258d9a1f8
