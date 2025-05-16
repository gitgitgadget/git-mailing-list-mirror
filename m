Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1E41AAA1A
	for <git@vger.kernel.org>; Fri, 16 May 2025 04:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747371010; cv=none; b=IIm1Yqj07DLIxyFaefPw8MyVlsTSeO2036SbgxB6KZxc4tfUnn5wARoGo9bLVCuQ4k5IFDa+6VW+FYffAfidZ49KUObILgkm1w4y5iWR1X9EFIgwEXIyexxq1rnmtuAX3Aa3B8UdlsnElmsjzewfs/ICBZjUy8csl/gq1lNc6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747371010; c=relaxed/simple;
	bh=lusswuxUvIRBiumFlBk7RoyKPX5HSGqruaGdXWdSvu0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnBZk3tywzAyXGlXDSHsz3cKx5nnPyBkZvJ/NbP1oAeCRH+yGOGF1s9oPhRA7ATXBpSzUQKIzpwSypSeRT99ryZiccFq9Q0mmK661asMQbicymD/rlr3O8xpa0kUTA3uT0wU7NnbGAbupDVRVQw5bqG8ag7U6I+qrBUs07nOOIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WCCVdbJ1; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WCCVdbJ1"
Received: (qmail 5183 invoked by uid 109); 16 May 2025 04:50:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lusswuxUvIRBiumFlBk7RoyKPX5HSGqruaGdXWdSvu0=; b=WCCVdbJ1AItHss+xoGz2e5ua6R/0pAkalA64rr0dOShQH7ZTkPPiivZkkMVwpCre6/IAL0zS7ACabzLVLJwToyEWTvaOsVm0jMTFtyjeXnABnPPIU6egmuE2O6nxH3GIXKtRz7nQUrM9jIgMbQfvKxfkTAS8TNLrq/VDCpeuf9uPkceBVRRgbvQJk/OMmD3PYvPGbEqjh+m9UZ1l07eLkmsI04q46zwGEITpU5AXVEtegJqjrtBzdNwCqP9ZrwUDsaKgMJmJcYhTd5VM83gabinx+Wgy2zXDalznwpwVDB/uE5eglmB9KQhTi1B8v9kE7Rzdx61u7g5Z0gV2rIlFvA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 May 2025 04:50:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4964 invoked by uid 111); 16 May 2025 04:50:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 May 2025 00:50:12 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 16 May 2025 00:50:08 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 11/13] hash-object: merge HASH_* and INDEX_* flags
Message-ID: <20250516045008.GK22242@coredump.intra.peff.net>
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

The hash-object command has its own custom flag bits that it sets based
on command-line options. But since we dropped hash_literally() in the
previous commit, the only thing we do with those flag bits is convert
them directly into "index_flags" to pass to index_fd().

This extra layer of indirection makes the code harder to read and reason
about. Let's just use the INDEX_* flags directly.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/hash-object.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 3c6949b3fa..1ecb70b551 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -19,30 +19,19 @@
 #include "strbuf.h"
 #include "write-or-die.h"
 
-enum {
-	HASH_OBJECT_CHECK = (1 << 0),
-	HASH_OBJECT_WRITE = (1 << 1),
-};
-
 static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
 		    int literally)
 {
-	unsigned int index_flags = 0;
 	struct stat st;
 	struct object_id oid;
 
-	if (flags & HASH_OBJECT_WRITE)
-		index_flags |= INDEX_WRITE_OBJECT;
-	if (flags & HASH_OBJECT_CHECK)
-		index_flags |= INDEX_FORMAT_CHECK;
-
 	if (literally)
-		index_flags &= ~INDEX_FORMAT_CHECK;
+		flags &= ~INDEX_FORMAT_CHECK;
 
 	if (fstat(fd, &st) < 0 ||
 	    index_fd(the_repository->index, &oid, fd, &st,
-		     type_from_string(type), path, index_flags))
-		die((flags & HASH_OBJECT_WRITE)
+		     type_from_string(type), path, flags))
+		die((flags & INDEX_WRITE_OBJECT)
 		    ? "Unable to add %s to database"
 		    : "Unable to hash %s", path);
 	printf("%s\n", oid_to_hex(&oid));
@@ -94,13 +83,13 @@ int cmd_hash_object(int argc,
 	int no_filters = 0;
 	int literally = 0;
 	int nongit = 0;
-	unsigned flags = HASH_OBJECT_CHECK;
+	unsigned flags = INDEX_FORMAT_CHECK;
 	const char *vpath = NULL;
 	char *vpath_free = NULL;
 	const struct option hash_object_options[] = {
 		OPT_STRING('t', NULL, &type, N_("type"), N_("object type")),
 		OPT_BIT('w', NULL, &flags, N_("write the object into the object database"),
-			HASH_OBJECT_WRITE),
+			INDEX_WRITE_OBJECT),
 		OPT_COUNTUP( 0 , "stdin", &hashstdin, N_("read the object from stdin")),
 		OPT_BOOL( 0 , "stdin-paths", &stdin_paths, N_("read file names from stdin")),
 		OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
@@ -114,7 +103,7 @@ int cmd_hash_object(int argc,
 	argc = parse_options(argc, argv, prefix, hash_object_options,
 			     hash_object_usage, 0);
 
-	if (flags & HASH_OBJECT_WRITE)
+	if (flags & INDEX_WRITE_OBJECT)
 		prefix = setup_git_directory();
 	else
 		prefix = setup_git_directory_gently(&nongit);
-- 
2.49.0.896.g93578ceaaf

