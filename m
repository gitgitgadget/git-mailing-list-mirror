Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E319E992
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727911589; cv=none; b=QTFXIwSoyferPPy9YeaXp/5J8Pnt/R0oJxrcnKcpBLPVrh97nWAIxp5WCeemgRbLB7eNpq8MZk8OuKWdE0UCt1f+ZYgB7vEBbvM/s76UT3lVEwvUUjLZGShou2ZzKtxmGkHbSTlqmYmHmHcOue1t/f8zG2QSknj5TzLvgCHcAIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727911589; c=relaxed/simple;
	bh=HQC4Rm6/uwxaMWYzMCmKWyYPKUQFFNpre0BdbwoE5Do=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=btqwk4fG6LKjTuK7yCefo0oFNOLnSvGi3S35uv8M50QDD1ncKUQwjRBHjN4hsNHPwiNwRw9jCh3IQBUiBTxQQpJpBLWG0nUr5sd7FQHOpH+iH7IEWmz+F31B3NRS3Na3/O4Kqe7r8djUBX6P/WNDabfZ9dU8H/f5CJpoZbymtjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QEj5JxSL; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QEj5JxSL"
Received: (qmail 10679 invoked by uid 109); 2 Oct 2024 23:26:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=20240930; bh=HQC4Rm6/uwxaMWYzMCmKWyYPKUQFFNpre0BdbwoE5Do=; b=QEj5JxSLBtS9v5kxnZR8I9TrGqFvWJV8U5sLFyRPxRCkX8aFxQKZV1PK15OPZ67O0DPn9WZijGN5xYhJcIis6WCHmJ2PURdXfbnXnyLoIDU8jP7WN9uLHBpgk5PfzOYvkzy38vA1spk8eqDlTtlQHgVPgC/hg0MQZZfAJMfCH2ogf2W5OX/LSsnsEcP8dzJJs9CybXGg4NusNrR96EEeIZEfh+WeYYmI1TsRGwSwbjaYJOv5vPT7NOswZXFsNbUjNGA+gCRCjBwj+ZZEHGLQE+4h75SLDQas2AZnGLpyZLJG6pxyxFPlxrdEKqh0MDCaUGfu78IWf1TzkikZ2+FqRw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Oct 2024 23:26:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10585 invoked by uid 111); 2 Oct 2024 23:26:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Oct 2024 19:26:18 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Oct 2024 19:26:18 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH (v2.47 regression)] hash.h: set NEEDS_CLONE_HELPER_UNSAFE in
 fallback mode
Message-ID: <20241002232618.GA3442753@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Commit 253ed9ecff (hash.h: scaffolding for _unsafe hashing variants,
2024-09-26) introduced the concept of having two hash algorithms: a safe
and an unsafe one. When the Makefile knobs do not explicitly request an
unsafe one, we fall back to using the safe algorithm.

However, the fallback to do so forgot one case: we should inherit the
NEEDS_CLONE_HELPER flag from the safe variant. Failing to do so means
that we'll end up defining two clone functions (the algorithm specific
one, and the generic one that just calls memcpy). You'll see an error
like this:

  $ make OPENSSL_SHA1=1
  [...]
  sha1/openssl.h:46:29: error: redefinition of ‘openssl_SHA1_Clone’
     46 | #define platform_SHA1_Clone openssl_SHA1_Clone
        |                             ^~~~~~~~~~~~~~~~~~
  hash.h:83:40: note: in expansion of macro ‘platform_SHA1_Clone’
     83 | #    define platform_SHA1_Clone_unsafe platform_SHA1_Clone
        |                                        ^~~~~~~~~~~~~~~~~~~
  hash.h:101:33: note: in expansion of macro ‘platform_SHA1_Clone_unsafe’
    101 | #  define git_SHA1_Clone_unsafe platform_SHA1_Clone_unsafe
        |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
  hash.h:133:20: note: in expansion of macro ‘git_SHA1_Clone_unsafe’
    133 | static inline void git_SHA1_Clone_unsafe(git_SHA_CTX_unsafe *dst,
        |                    ^~~~~~~~~~~~~~~~~~~~~
  sha1/openssl.h:37:20: note: previous definition of ‘openssl_SHA1_Clone’ with type ‘void(struct openssl_SHA1_CTX *, const struct openssl_SHA1_CTX *)’
     37 | static inline void openssl_SHA1_Clone(struct openssl_SHA1_CTX *dst,
        |                    ^~~~~~~~~~~~~~~~~~

This only matters when compiling with openssl as the "safe" variant,
since it's the only algorithm that requires a clone helper (and even
then, only if you are using openssl 3.0+). And you should never do that,
because it's not safe. But still, the invocation above used to work and
should continue to do so until we decide to require a
collision-detecting variant for the safe algorithm entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a regression in v2.47.0-rc0. As mentioned above, I kind of doubt
anybody will hit it in practice (I only did because I was trying to do
some timing tests between the fast and dc variants). And it is almost
tempting to leave it as a wake-up call for anybody who is still not
using a collision-detecting sha1. ;)

 hash.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hash.h b/hash.h
index f97f858307..756166ce5e 100644
--- a/hash.h
+++ b/hash.h
@@ -82,6 +82,9 @@
 #  ifdef platform_SHA1_Clone
 #    define platform_SHA1_Clone_unsafe platform_SHA1_Clone
 #  endif
+#  ifdef SHA1_NEEDS_CLONE_HELPER
+#    define SHA1_NEEDS_CLONE_HELPER_UNSAFE
+#  endif
 #endif
 
 #define git_SHA_CTX		platform_SHA_CTX
-- 
2.47.0.rc1.376.gb58337ca88
