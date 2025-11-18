Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052E8309DAF
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457136; cv=none; b=ANbBefZIpFiLjVS6M1AkGoXe1ALTMDT4rxWMvAf09pK63EVKrK0IJ2eAObN8gYcloyzNpv1eAMRHIxQiCYX/IDCZr5QOTav4DNPJsZ9WS8P0GawNC+zgGhZW9Qiu6cLgzAXQVxnrJ/OyMnJuIoc87lYoYFWdwohoDFBfpRY4joU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457136; c=relaxed/simple;
	bh=B8Y1b7wDJlEjbvcxsSWx0VnVKg2y4s6o/vuUMP2JIg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnNyVEhHqR0n0krfRE8VS9erDeA3V7LJOyk7jtsboJrQS2nQK/C2EEU6q/eUcHZZzPzcxzzWjguPtXAfHGgs0RklneLLVDfRnp6UVPnEvqAkHdcl6577tQOsxZzJz3arhF3u8cn7CZZXXMnIZlT6NQmnaLfjSIxOpIpigMK1vGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=APPF6778; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="APPF6778"
Received: (qmail 19766 invoked by uid 109); 18 Nov 2025 09:12:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=B8Y1b7wDJlEjbvcxsSWx0VnVKg2y4s6o/vuUMP2JIg8=; b=APPF6778ZkrMsCHGk6toe1+HmUTXpknkwH2YaP6vFi/xOsRPl+zudDMGOtfC9QAMRvUU2uzcv1U+I+jlHBaVNH6bzHK+uN6HAwAjZkCsR3rEyiflgT/kSQDyZ/FabL0gyXt89z/YeuRlpvfrWB3Tt9lEVSzz5y3eAZrA+MFbV4Lk/B8xWBdB9t4s/dp3SO9HsH0MQ+qCdi6yX2szgEF3VC3y4lxny0almQiu+29ffxQD7AkcEyItRJcfnFfe4B9/6ynka4YBof38bV7nyy8tn8qolgtZOMR5gVpLs/P3/W3dfp/SyqB2z8LD8/c/Dp3H7/Rw3X6hib06WYx5ArAQ0w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 09:12:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27390 invoked by uid 111); 18 Nov 2025 09:12:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 04:12:18 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 04:12:13 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 3/9] Makefile: turn on NO_MMAP when building with ASan
Message-ID: <20251118091213.GC529192@coredump.intra.peff.net>
References: <20251118091127.GA4175601@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118091127.GA4175601@coredump.intra.peff.net>

Git often uses mmap() to access on-disk files. This leaves a blind spot
in our SANITIZE=address builds, since ASan does not seem to handle mmap
at all. Nor does the OS notice most out-of-bounds access, since it tends
to round up to the nearest page size (so depending on how big the map
is, you might have to overrun it by up to 4095 bytes to trigger a
segfault).

The previous commit demonstrates a memory bug that we missed. We could
have made a new test where the out-of-bounds access was much larger, or
where the mapped file ended closer to a page boundary. But the point of
running the test suite with sanitizers is to catch these problems
without having to construct specific tests.

Let's enable NO_MMAP for our ASan builds by default, which should give
us better coverage. This does increase the memory usage of Git, since
we're copying from the filesystem into heap. But the repositories in the
test suite tend to be small, so the overhead isn't really noticeable
(and ASan already has quite a performance penalty).

There are a few other known bugs that this patch will help flush out.
However, they aren't directly triggered in the test suite (yet). So
it's safe to turn this on now without breaking the test suite, which
will help us add new tests to demonstrate those other bugs as we fix
them.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile    | 1 +
 meson.build | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7e0f77e298..0f44268405 100644
--- a/Makefile
+++ b/Makefile
@@ -1587,6 +1587,7 @@ SANITIZE_LEAK = YesCompiledWithIt
 endif
 ifneq ($(filter address,$(SANITIZERS)),)
 NO_REGEX = NeededForASAN
+NO_MMAP = NeededForASAN
 SANITIZE_ADDRESS = YesCompiledWithIt
 endif
 endif
diff --git a/meson.build b/meson.build
index 1f95a06edb..f1b3615659 100644
--- a/meson.build
+++ b/meson.build
@@ -1411,12 +1411,18 @@ if host_machine.system() == 'windows'
   libgit_c_args += '-DUSE_WIN32_MMAP'
 else
   checkfuncs += {
-    'mmap' : ['mmap.c'],
     # provided by compat/mingw.c.
     'unsetenv' : ['unsetenv.c'],
     # provided by compat/mingw.c.
     'getpagesize' : [],
   }
+
+  if get_option('b_sanitize').contains('address')
+    libgit_c_args += '-DNO_MMAP'
+    libgit_sources += 'compat/mmap.c'
+  else
+    checkfuncs += { 'mmap': ['mmap.c'] }
+  endif
 endif
 
 foreach func, impls : checkfuncs
-- 
2.52.0.278.gadc6434dc3

