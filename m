Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDD03A2E25
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979750; cv=none; b=tfLj1YBmekyZ4D4PdDXuNbpwUPpOlSVoJ9W8Qra8G45HeLov7zyVrBqZ+L9YeKVBbXhoWiDLXPmMgFVWTMzp5Pn97BiHTRbuwuZxwDKuSJE1Uhap2u3b2vpHZac7BHN1IEAvTE2h4WxXQQaQ32vvepm8Iyv9I5rbNXFmKNW40DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979750; c=relaxed/simple;
	bh=4qQfCMXfkdo4gj4F7f5EBpHMWwVSk9SGwtO3uvCBtmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6uvZawnomQDheNQvU0B8jOV/nO96UjG75O5zNrtqcTguVERwXzN+fhF5GI+W/pNFZAy9dcv452ndABRNM8TfaI5LMkRnxqIdVbMHLlE3VzuRvqBJq3iD/vlDZEzrGI/uQtWEyZLPzZc1ZOkkLWN3wYeIE+Q4valcBk+aFbwAt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PRpejjVX; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PRpejjVX"
Received: (qmail 85704 invoked by uid 106); 2 Jul 2026 08:09:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4qQfCMXfkdo4gj4F7f5EBpHMWwVSk9SGwtO3uvCBtmE=; b=PRpejjVXYlsAGa/mSXWHKVEMP8PYUasi01VyDJts7a98zZ2E1/56CtTf8CMRxiN8Qj+EIJSTvoaAtL+uJK+6vse63TIGzhbqvDE5+820elHZiVdNqr8Px9WN3UPskyhN21AgIfNsbhP7RPQgMkegcsLvKdBYzfANqhxejGFQdpmhBAQrdW1J3630UGIdgTVFX2bna+CwOyO56NENFYHddPFv0rcKLUnWJYfS2vBlhYfMKidqGt/kPkKmggKJyenFzWKQVzA8Agwpb1xDB+YOfzpbxY/VqNFBulM+WZBNpR7rff7s3bHqe/iuJhTWkSYQHO0/Tep74RTFLfl3ZyUaJg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 08:09:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 178296 invoked by uid 111); 2 Jul 2026 08:09:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 04:09:08 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 04:09:07 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 8/9] hash: fix memory leak copying sha256 gcrypt handles
Message-ID: <20260702080907.GH2029434@coredump.intra.peff.net>
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

Our abstracted hash-algorithm API allows for cloning a hash context. By
default this just memcpy()s the bytes, but specific implementations can
provide a custom clone function.

Our API is based around the way that OpenSSL works, which is that you
first initialize the destination context, then copy into it. In our code
that is this:

  algo->init_fn(&dst);
  git_hash_clone(&dst, src);

and that translates into OpenSSL calls like:

  /* init_fn */
  dst->ectx = EVP_MD_CTX_new();
  EVP_DigestInit_ex(dst->ectx, EVP_sha256());
  /* clone */
  EVP_MD_CTX_copy_ex(dst->ectx, src->ectx);

So the allocation happens in the first step, and then the clone is just
copying values (the DigestInit is initializing values that just get
overwritten, but that's not wrong, just a little inefficient).

But libgcrypt doesn't work like that! Its copy function initializes dst
from scratch. So when using the sha256 gcrypt backend, that becomes:

  /* init_fn; this allocates */
  gcry_md_open(&dst, GCRY_MD_SHA256);
  /* clone; this also allocates, leaking the previous value! */
  gcry_md_copy(&dst, src);

You can see the leaks in the test suite by running:

  make \
    SANITIZE=leak \
    GCRYPT_SHA256=1 \
    GIT_TEST_DEFAULT_SHA=256 \
    test

which has many failures, as opposed to building with OPENSSL_SHA256,
which is leak-free.

The easy fix here is for the clone function to close the open context
we're about to overwrite. It's a little inefficient (we did a pointless
open in the init function), but probably not a big deal in practice.

If our API went the other way, assuming that we're always cloning into
garbage bytes, then we could be more efficient. We'd teach OpenSSL's
clone function to do its own new(), skip the DigestInit, and then copy
into it. And gcrypt could stick with just the copy() call.

But look again at the asymmetry in the very first code example. We call
the init function straight from the git_hash_algo struct, and then
subsequent calls are dispatched through our git_hash_* wrappers. If you
wanted to clone into an uninitialized destination, you'd do something
like:

  algo->clone_fn(&dst, src);

instead. That would require changing all of the callers. There's not
that many of them, but I don't know that it's worth changing our calling
conventions to try to reclaim this tiny bit of efficiency.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha256/gcrypt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sha256/gcrypt.h b/sha256/gcrypt.h
index 17a90f1052..694a2b70a1 100644
--- a/sha256/gcrypt.h
+++ b/sha256/gcrypt.h
@@ -27,6 +27,7 @@ static inline void gcrypt_SHA256_Final(unsigned char *digest, gcrypt_SHA256_CTX
 
 static inline void gcrypt_SHA256_Clone(gcrypt_SHA256_CTX *dst, const gcrypt_SHA256_CTX *src)
 {
+	gcry_md_close(*dst);
 	gcry_md_copy(dst, *src);
 }
 
-- 
2.55.0.418.g37da59dd42

