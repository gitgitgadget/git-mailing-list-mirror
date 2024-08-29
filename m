Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672A21311B5
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962197; cv=none; b=NpZEt0OOes12mFEDauFcdwdJ/lE2OwZqo9U4TONla16fxxIYR9GCfwKYBdqH2NolohYiUi8WX4Han15cA75J7FGm5zZGeFw+snwUl8UXggIlH6dX6I7dEi8ExEuPtFV29PCG596/xM3Rr59TeUM4qT3dY1MYHDind5EaUdPH1eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962197; c=relaxed/simple;
	bh=2sHOigIrCj+i20poQ8LwVPvxF3b64ZXQdJJon0jL7sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfKcp7Ard1VbrnuPOOD8O7SJ0ExWGzeAEzboB29pXKzWuOhHV43Kl8yTjmQqrt6USIBpk4F5mO81msdPmnDkMs2WbzmzYwHiJ9kdQjvXa2vESF1Ox1EXarJR81YQthrc82ocsajDOqTmP9ZhckhCqxyxDv8DJcHyCZ0sIf2HUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5946 invoked by uid 109); 29 Aug 2024 20:09:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Aug 2024 20:09:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10754 invoked by uid 111); 29 Aug 2024 20:09:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2024 16:09:55 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Aug 2024 16:09:53 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] grep: prefer UNUSED to MAYBE_UNUSED for pcre allocators
Message-ID: <20240829200953.GB432235@coredump.intra.peff.net>
References: <20240829200807.GA430283@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829200807.GA430283@coredump.intra.peff.net>

We prove custom malloc/free callbacks for the pcre library to use. Those
take an extra "data" parameter, but we don't use it. Back when these
were added in 513f2b0bbd (grep: make PCRE2 aware of custom allocator,
2019-10-16), we only had MAYBE_UNUSED. But these days we have UNUSED,
which we should prefer, as it will let the compiler inform us if the
code changes to actually use the parameters.

I also moved the annotations to come after the variable name, which is
how we typically spell it.

Signed-off-by: Jeff King <peff@peff.net>
---
Where "how we typically spell it" is "me", because I wrote 99% of the
annotations we have. ;) I'm open to debate, but only if it is
accompanied by a patch to change all of them to be consistent.

 grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 2f8b9553df..e5761426e4 100644
--- a/grep.c
+++ b/grep.c
@@ -245,7 +245,7 @@ static int is_fixed(const char *s, size_t len)
 #ifdef USE_LIBPCRE2
 #define GREP_PCRE2_DEBUG_MALLOC 0
 
-static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data)
+static void *pcre2_malloc(PCRE2_SIZE size, void *memory_data UNUSED)
 {
 	void *pointer = malloc(size);
 #if GREP_PCRE2_DEBUG_MALLOC
@@ -255,7 +255,7 @@ static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data)
 	return pointer;
 }
 
-static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
+static void pcre2_free(void *pointer, void *memory_data UNUSED)
 {
 #if GREP_PCRE2_DEBUG_MALLOC
 	static int count = 1;
-- 
2.46.0.761.g18aface1ae
