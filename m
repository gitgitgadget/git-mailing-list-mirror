Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8CB22A1E4
	for <git@vger.kernel.org>; Fri, 16 May 2025 04:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747371016; cv=none; b=uSWG4lZtSoYp5gR8pTlhixcTR6fAotsncuPrJOWF9uOUKysg+tV13aUzx9a+xvTi2ZDBnzcgXOTU2TNMqiLOou6M3TZmtx8zqBsqcnf2/Gzsy8Oiz0HrWBwhDgXgr5ym4MOgBBeAiJPG4O7S1aDZ1blvL+6F7tpxpzLPIA2ISvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747371016; c=relaxed/simple;
	bh=bShpvm41F8OOfqFZJA694R7U0Mb+xo8xasXwsluQG2g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlH9kN9oas2aQPinJuCTI0AJOAVKLG5aS6ZdxXcmW9jbmI1GP6rCyarDlviDm2yPUnLYD8UJnR3XwVgU2v9bOMe4tt+TCMxG7pwpffhNr3FAJucGBuO4o6zN9EUrJSphKs0nbGneGtkCHXpNk/TliBkky1w8TudeDVfxy7TZe0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Gxx6RQeO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Gxx6RQeO"
Received: (qmail 5191 invoked by uid 109); 16 May 2025 04:50:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=bShpvm41F8OOfqFZJA694R7U0Mb+xo8xasXwsluQG2g=; b=Gxx6RQeOt252S5ab4ucZbweM1/5z65HsmS72Fe1MuVzoIxrYQvJB7mmmFQTBF5JuobRYz8Ay39vZ34sqtdMrOBS281w5yYdd8WY0a/arvGvmIv29dJuOUpt7Fe8RX0LxOgHcAsuYmEZnb8eYkXscxTysoUoaAR1I1D4PvRvToFnX01GL1REb5c0RIvt1IsdkeeB/G2nobOjD9nvslyNz9qrmOSocQmoGWRiLna3p9VOH6c0w+Ff//3MTenL8hIWUwWK1+bsqOs//g+G/3EYw8sdgcVhR5Sa7SMXUqXcSCYmQ7hr4bWpTqvwxtf3piZaG0elB+2LNhFH/seU14mJyeQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 May 2025 04:50:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4970 invoked by uid 111); 16 May 2025 04:50:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 May 2025 00:50:17 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 16 May 2025 00:50:13 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 13/13] object-file: drop support for writing objects with
 unknown types
Message-ID: <20250516045013.GM22242@coredump.intra.peff.net>
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

Since "hash-object --literally" no longer supports objects with unknown
types, there are now no callers of write_object_file_literally() and its
helpers. Let's drop them to simplify the code.

In particular, this gets rid of some ugly copy-and-paste code from
write_object_file_literally(), which is a parallel implementation of
write_object_file(). When the split was originally made, the two weren't
that long, but commits like 63a6745a07 (object-file: update the loose
object map when writing loose objects, 2023-10-01) ended up having to
duplicate some tricky code.

This patch drops all of that duplication and should make things less
error-prone going forward.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c | 81 ++++-----------------------------------------------
 object-file.h |  5 +---
 2 files changed, 6 insertions(+), 80 deletions(-)

diff --git a/object-file.c b/object-file.c
index b10e283529..1ac04c2891 100644
--- a/object-file.c
+++ b/object-file.c
@@ -130,12 +130,6 @@ int has_loose_object(const struct object_id *oid)
 	return check_and_freshen(oid, 0);
 }
 
-static int format_object_header_literally(char *str, size_t size,
-					  const char *type, size_t objsize)
-{
-	return xsnprintf(str, size, "%s %"PRIuMAX, type, (uintmax_t)objsize) + 1;
-}
-
 int format_object_header(char *str, size_t size, enum object_type type,
 			 size_t objsize)
 {
@@ -144,7 +138,7 @@ int format_object_header(char *str, size_t size, enum object_type type,
 	if (!name)
 		BUG("could not get a type name for 'enum object_type' value %d", type);
 
-	return format_object_header_literally(str, size, name, objsize);
+	return xsnprintf(str, size, "%s %"PRIuMAX, name, (uintmax_t)objsize) + 1;
 }
 
 int check_object_signature(struct repository *r, const struct object_id *oid,
@@ -558,17 +552,6 @@ static void write_object_file_prepare(const struct git_hash_algo *algo,
 	hash_object_body(algo, &c, buf, len, oid, hdr, hdrlen);
 }
 
-static void write_object_file_prepare_literally(const struct git_hash_algo *algo,
-				      const void *buf, unsigned long len,
-				      const char *type, struct object_id *oid,
-				      char *hdr, int *hdrlen)
-{
-	struct git_hash_ctx c;
-
-	*hdrlen = format_object_header_literally(hdr, *hdrlen, type, len);
-	hash_object_body(algo, &c, buf, len, oid, hdr, hdrlen);
-}
-
 #define CHECK_COLLISION_DEST_VANISHED -2
 
 static int check_collision(const char *source, const char *dest)
@@ -698,21 +681,14 @@ int finalize_object_file_flags(const char *tmpfile, const char *filename,
 	return 0;
 }
 
-static void hash_object_file_literally(const struct git_hash_algo *algo,
-				       const void *buf, unsigned long len,
-				       const char *type, struct object_id *oid)
-{
-	char hdr[MAX_HEADER_LEN];
-	int hdrlen = sizeof(hdr);
-
-	write_object_file_prepare_literally(algo, buf, len, type, oid, hdr, &hdrlen);
-}
-
 void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 		      unsigned long len, enum object_type type,
 		      struct object_id *oid)
 {
-	hash_object_file_literally(algo, buf, len, type_name(type), oid);
+	char hdr[MAX_HEADER_LEN];
+	int hdrlen = sizeof(hdr);
+
+	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
 }
 
 /* Finalize a file on disk, and close it. */
@@ -1114,53 +1090,6 @@ int write_object_file_flags(const void *buf, unsigned long len,
 	return 0;
 }
 
-int write_object_file_literally(const void *buf, unsigned long len,
-				const char *type, struct object_id *oid,
-				unsigned flags)
-{
-	char *header;
-	struct repository *repo = the_repository;
-	const struct git_hash_algo *algo = repo->hash_algo;
-	const struct git_hash_algo *compat = repo->compat_hash_algo;
-	struct object_id compat_oid;
-	int hdrlen, status = 0;
-	int compat_type = -1;
-
-	if (compat) {
-		compat_type = type_from_string_gently(type, -1, 1);
-		if (compat_type == OBJ_BLOB)
-			hash_object_file(compat, buf, len, compat_type,
-					 &compat_oid);
-		else if (compat_type != -1) {
-			struct strbuf converted = STRBUF_INIT;
-			convert_object_file(the_repository,
-					    &converted, algo, compat,
-					    buf, len, compat_type, 0);
-			hash_object_file(compat, converted.buf, converted.len,
-					 compat_type, &compat_oid);
-			strbuf_release(&converted);
-		}
-	}
-
-	/* type string, SP, %lu of the length plus NUL must fit this */
-	hdrlen = strlen(type) + MAX_HEADER_LEN;
-	header = xmalloc(hdrlen);
-	write_object_file_prepare_literally(the_hash_algo, buf, len, type,
-					    oid, header, &hdrlen);
-
-	if (!(flags & WRITE_OBJECT_FILE_PERSIST))
-		goto cleanup;
-	if (freshen_packed_object(oid) || freshen_loose_object(oid))
-		goto cleanup;
-	status = write_loose_object(oid, header, hdrlen, buf, len, 0, 0);
-	if (compat_type != -1)
-		return repo_add_loose_object_map(repo, oid, &compat_oid);
-
-cleanup:
-	free(header);
-	return status;
-}
-
 int force_object_loose(const struct object_id *oid, time_t mtime)
 {
 	struct repository *repo = the_repository;
diff --git a/object-file.h b/object-file.h
index a979fd5e4d..6f41142452 100644
--- a/object-file.h
+++ b/object-file.h
@@ -159,7 +159,7 @@ int parse_loose_header(const char *hdr, struct object_info *oi);
 
 enum {
 	/*
-	 * By default, `write_object_file_literally()` does not actually write
+	 * By default, `write_object_file()` does not actually write
 	 * anything into the object store, but only computes the object ID.
 	 * This flag changes that so that the object will be written as a loose
 	 * object and persisted.
@@ -187,9 +187,6 @@ struct input_stream {
 	int is_finished;
 };
 
-int write_object_file_literally(const void *buf, unsigned long len,
-				const char *type, struct object_id *oid,
-				unsigned flags);
 int stream_loose_object(struct input_stream *in_stream, size_t len,
 			struct object_id *oid);
 
-- 
2.49.0.896.g93578ceaaf
