Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C83D3485
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979630; cv=none; b=nLDrICSeRqWHZ6v2ArczcRJyayiw9OpMW5j5DprkwVYd9rxt037d941I2hjS4HTwmqKO073DxYQg8I8rJ1HHZ0KfKfFm0Va6u4DhqEHBP2ahir93jb3oekcxcw9CGQ4mieRd9b9eKey7oOCkdCTV+sSE0F2XUjw8P2uHYCSt5f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979630; c=relaxed/simple;
	bh=Poo6zzgAMtrpnIwEIg0Zijkj7YKTY9Jdir0QWaWC3iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrUZVzAcgkCplT/ivBLCndCJY5xz6JF3v/MrD0TRR/nULNT3snw856tuKKrPw2Jmfp/Mk8xNyLkOgEy82oiZhdbP/3/ci8Mo9JfDV3X48N3q4XoF5Co1NcTyO+arXrmJ5pNDETbao+h285N8+jXTBBHE3Wilx6i+2pXOmnQ2nS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=c6+gyUGQ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="c6+gyUGQ"
Received: (qmail 85680 invoked by uid 106); 2 Jul 2026 08:07:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Poo6zzgAMtrpnIwEIg0Zijkj7YKTY9Jdir0QWaWC3iA=; b=c6+gyUGQvcxfFuzW+VXK4LT3LDWI9hr3AwUofHxKiVPo4qcJM/Bc5VBcHnudVyCpaZRO+A6xkq6Lys0eIAyAJyvUUS8QyGFSYBzGPovv2ju8O+JvD8qY16RkajRIMydCN0uq5GOgul2idEun1iLdOzq+W2wfMgLFCuxxENKY+HnOYOeL4JD2z3W/xL25MhD/9+4oujQqeAR2PrqKruERc75Cw3lrbquVayddqPK5hs0Bm3HlALECZzTkeMIVjTs7HVsXssr0miGwWehyI5NDCARb00Zdhd2xIZ1tJ+4E3x09+6iEnmQNASXIXOp7n4JNlK2pKw8u2vq2NZ63hXe6JA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 08:07:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 178287 invoked by uid 111); 2 Jul 2026 08:07:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 04:07:07 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 04:07:07 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 7/9] http: discard hash in dumb-http http_object_request
Message-ID: <20260702080707.GG2029434@coredump.intra.peff.net>
References: <20260702075234.GA1548258@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702075234.GA1548258@coredump.intra.peff.net>

Usually an object request results in finish_http_object_request()
calling git_hash_final_oid(), after we've received all of the data. But
if we hit an error, we'll bail early and free the http_object_request,
dropping the git_hash_ctx entirely.  This can cause a leak for hash
implementations that allocate memory in their context, like OpenSSL >=
3.0.

The obvious fix is for abort_http_object_request() to call
git_hash_discard(), under the assumption that every request is either
finished or aborted. But that's not quite true:

  1. Not everybody calls the abort function. Sometimes they jump
     straight to release_http_object_request(). So we'd have to put it
     there.

  2. After the finish function finalizes the hash, we can still
     encounter errors! In that case we end up aborting or releasing,
     and they must not discard that hash (since that would be a
     double-free).

So we'll keep a flag marking the validity of the hash_ctx field of the
request. The lifetime is simple: it is valid immediately after creation,
up until we call finalize. And then our release function can just
conditionally discard the hash based on that flag.

This fixes test failures in t5550 and t5619 when run with:

  make SANITIZE=leak \
       OPENSSL_SHA256=1 \
       GIT_TEST_DEFAULT_HASH=sha256 \
       test

The flag handling could be removed if the hash-discard function were
idempotent. This could be done easily-ish by having the underlying
hash functions (like the ones in sha256/openssl.h) set the context
pointer to NULL after free-ing. But it's something that every platform
implementation would have to remember to do, and the benefit for the
callers is not that huge (it would let us shave a few lines here and
probably in a few other spots).

Signed-off-by: Jeff King <peff@peff.net>
---
I think the "set to NULL" thing gets weird with gcrypt, too, which does
not even use a pointer (we typedef their libgcrypt handle into our own
context struct).

 http.c | 4 ++++
 http.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/http.c b/http.c
index b4e7b8d00b..63abbaae8a 100644
--- a/http.c
+++ b/http.c
@@ -2880,6 +2880,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	git_inflate_init(&freq->stream);
 
 	the_hash_algo->init_fn(&freq->c);
+	freq->hash_ctx_valid = 1;
 
 	freq->url = get_remote_object_url(base_url, hex, 0);
 
@@ -2988,6 +2989,7 @@ int finish_http_object_request(struct http_object_request *freq)
 	}
 
 	git_hash_final_oid(&freq->real_oid, &freq->c);
+	freq->hash_ctx_valid = 0;
 	if (freq->zret != Z_STREAM_END) {
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
@@ -3028,6 +3030,8 @@ void release_http_object_request(struct http_object_request **freq_p)
 	curl_slist_free_all(freq->headers);
 	strbuf_release(&freq->tmpfile);
 	git_inflate_end(&freq->stream);
+	if (freq->hash_ctx_valid)
+		git_hash_discard(&freq->c);
 
 	free(freq);
 	*freq_p = NULL;
diff --git a/http.h b/http.h
index 729c51904d..6b0639150f 100644
--- a/http.h
+++ b/http.h
@@ -255,6 +255,7 @@ struct http_object_request {
 	struct object_id oid;
 	struct object_id real_oid;
 	struct git_hash_ctx c;
+	int hash_ctx_valid;
 	git_zstream stream;
 	int zret;
 	int rename;
-- 
2.55.0.418.g37da59dd42

