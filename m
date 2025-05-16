Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ADE22A4E6
	for <git@vger.kernel.org>; Fri, 16 May 2025 04:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747371013; cv=none; b=r7iqjy7rCgMqnDyBl6zNnwZWr6SMf771MkDO2cr7a5iI40mX+TC+bVoy2lHfWx7kROIaqTWcLKjGsWlzTkLiWJpCXAk+cFdHa/Drm8wXaWIxm97YIXgDK5CcFKmagpnex+aYvcXHjKXNV8yN4Ea54xxOwZ0YqWExt6SVtFKZrGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747371013; c=relaxed/simple;
	bh=BsCkd7Tfp1F2pEDR6TtxIeXTUp64qaOVdXbMhMmQT0E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTsEahUlvoRP+KVULwCWy5ja3EHmQzRP53KDFFShUnE1CkGjgOnGrGmbVfAJamt6x4Q00z2UnRYWPdLUKZ7zKTEfEyn+AMdSCAyu8Nx2bn5/RRTpMkMmvwzRD4bBurEaAD5JmJkTFyXuLs/OzbWowoCykK6fX7QKpzsn5xtMOtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=V3NkJy1v; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="V3NkJy1v"
Received: (qmail 5187 invoked by uid 109); 16 May 2025 04:50:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=BsCkd7Tfp1F2pEDR6TtxIeXTUp64qaOVdXbMhMmQT0E=; b=V3NkJy1vGdMv0c0pcWg7EcWTTpGhkSzKFMfYZ3J6z2gmua2nGqgBOZ2LE7bgkJykjlkdraW1uApCNiUTz56i7w2/239rqkprSWXF05GR0cMOt0lz3cNxt9NOiO/iD1J/4mYhKdO62iuo/z16egxO6+ukhd7FxuwJHyThkE9+RFFZoyWGcxezYugrtNjYTOfr6LcXngsckqMJ4aM6h/Gy8DeaDJP70nKnLzqQlsmB3vqzIYII1n682598+Ng/Y0CcAaTyo9R1DDoYOnA4s35L49mHNxzXvE1EOa9h99TotkCRPhb+Xntn4llCYSN9Y6Pv/Dj36jF8uMGso0tlv4ISjw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 May 2025 04:50:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4967 invoked by uid 111); 16 May 2025 04:50:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 May 2025 00:50:15 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 16 May 2025 00:50:10 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 12/13] hash-object: handle --literally with OPT_NEGBIT
Message-ID: <20250516045010.GL22242@coredump.intra.peff.net>
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

Since we recently removed the hash_literally() function, the hash-object
--literally option has been simplified to just removing the
INDEX_FORMAT_CHECK flag. Rather than pass it around as a separate bool,
we can just have the option parser remove the bit from the set of flags
directly. This simplifies the helper functions.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/hash-object.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 1ecb70b551..6a99ec250d 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -19,15 +19,11 @@
 #include "strbuf.h"
 #include "write-or-die.h"
 
-static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
-		    int literally)
+static void hash_fd(int fd, const char *type, const char *path, unsigned flags)
 {
 	struct stat st;
 	struct object_id oid;
 
-	if (literally)
-		flags &= ~INDEX_FORMAT_CHECK;
-
 	if (fstat(fd, &st) < 0 ||
 	    index_fd(the_repository->index, &oid, fd, &st,
 		     type_from_string(type), path, flags))
@@ -39,15 +35,14 @@ static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
 }
 
 static void hash_object(const char *path, const char *type, const char *vpath,
-			unsigned flags, int literally)
+			unsigned flags)
 {
 	int fd;
 	fd = xopen(path, O_RDONLY);
-	hash_fd(fd, type, vpath, flags, literally);
+	hash_fd(fd, type, vpath, flags);
 }
 
-static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
-			     int literally)
+static void hash_stdin_paths(const char *type, int no_filters, unsigned flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
@@ -59,8 +54,7 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
 				die("line is badly quoted");
 			strbuf_swap(&buf, &unquoted);
 		}
-		hash_object(buf.buf, type, no_filters ? NULL : buf.buf, flags,
-			    literally);
+		hash_object(buf.buf, type, no_filters ? NULL : buf.buf, flags);
 	}
 	strbuf_release(&buf);
 	strbuf_release(&unquoted);
@@ -81,7 +75,6 @@ int cmd_hash_object(int argc,
 	int hashstdin = 0;
 	int stdin_paths = 0;
 	int no_filters = 0;
-	int literally = 0;
 	int nongit = 0;
 	unsigned flags = INDEX_FORMAT_CHECK;
 	const char *vpath = NULL;
@@ -93,7 +86,9 @@ int cmd_hash_object(int argc,
 		OPT_COUNTUP( 0 , "stdin", &hashstdin, N_("read the object from stdin")),
 		OPT_BOOL( 0 , "stdin-paths", &stdin_paths, N_("read file names from stdin")),
 		OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
-		OPT_BOOL( 0, "literally", &literally, N_("just hash any random garbage to create corrupt objects for debugging Git")),
+		OPT_NEGBIT( 0, "literally", &flags,
+			    N_("just hash any random garbage to create corrupt objects for debugging Git"),
+			    INDEX_FORMAT_CHECK),
 		OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),
 		OPT_END()
 	};
@@ -139,7 +134,7 @@ int cmd_hash_object(int argc,
 	}
 
 	if (hashstdin)
-		hash_fd(0, type, vpath, flags, literally);
+		hash_fd(0, type, vpath, flags);
 
 	for (i = 0 ; i < argc; i++) {
 		const char *arg = argv[i];
@@ -148,12 +143,12 @@ int cmd_hash_object(int argc,
 		if (prefix)
 			arg = to_free = prefix_filename(prefix, arg);
 		hash_object(arg, type, no_filters ? NULL : vpath ? vpath : arg,
-			    flags, literally);
+			    flags);
 		free(to_free);
 	}
 
 	if (stdin_paths)
-		hash_stdin_paths(type, no_filters, flags, literally);
+		hash_stdin_paths(type, no_filters, flags);
 
 	free(vpath_free);
 
-- 
2.49.0.896.g93578ceaaf

