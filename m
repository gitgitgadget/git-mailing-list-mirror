Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B1D37E2E7
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785055052; cv=none; b=kDHMNTTqOfNhPDA2Pb2hApxHhQWfz3DhGHuRj4K/bbDdGNor87fXW/UIQxv3o4tmiwLn40dmNq/9uQaI69hn/vxBolzlK/toLrF5GOQhAX+mm/YqAUwQOnd06+4Nwqo4yhSkXfvprEvV5oCtoaGLEPJ0XAMgfEhNzCJUeEWf6zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785055052; c=relaxed/simple;
	bh=7eh6hhdS7R+K6YisxgkvorxzCClmcj/oU5m+sdxUzXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZ2Vq0g9XCbZ6nVfzCJw6KVmqmkccM5iV3HXAfunljQl7Mk4RVtDbqay/MUf63766s8XeVh2MGc9Fi5S79zPvqGHkX1c6Gt7QIdK7tp+PoOU3HIL7rLzJ8bn1cXqs31eJIgvJI4jf1HbfDV+gZheyBPsfRnYoyk50Blrd8/H0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MQcmlB0D; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MQcmlB0D"
Received: (qmail 56914 invoked by uid 106); 26 Jul 2026 08:37:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7eh6hhdS7R+K6YisxgkvorxzCClmcj/oU5m+sdxUzXw=; b=MQcmlB0DPhPjUNK32LL3cfglixDP+DvC0u2zlMITCP12l3mhBB9xMetDuaGuEyWMCN+AcjrfYBs0bMgq6WO/BnywjIcuebgMWfkPuYsZywEq/JNrL56ibL4xtSSdv+r5Oxq48ypp/V8Ajvg+N9F496pxtV0yvgiE52Zm4tl9U2hoW24vdZeOFc8rnYdykCIUTHaTJZkOSUuU8PuvNy+pKBLTuq9KTHU3IuMyFk8mwVpwgJ+ZF0GG8De8lS+/yryPSWPXoln3aP/RZ4L/DfrDuRJPaGRUU4UCSavNVTOBnYNrV57oKP99pTS3d5o3TkDQamFdgp2CtS7Lh6bkZJ9IwQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Jul 2026 08:37:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 57842 invoked by uid 111); 26 Jul 2026 08:37:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Jul 2026 04:37:33 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Jul 2026 04:37:27 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: tnyman@openai.com, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/2] bloom: silence CHECK_ASSERTION_SIDE_EFFECTS false
 positive
Message-ID: <20260726083727.GA3529069@coredump.intra.peff.net>
References: <20260726083254.GA3528497@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260726083254.GA3528497@coredump.intra.peff.net>

Using gcc 15, compiling with CHECK_ASSERTION_SIDE_EFFECTS=1 causes a
complaint about this line in bloom.c having a side effect:

	assert(version == 1 || version == 2);

I think this is pretty clearly a false positive, as those comparisons
should not have side effects. The side-effect checker uses a magic
definition of assert() that relies on the compiler's optimizer to drop a
reference to an otherwise unused variable. And for whatever reason, gcc
chooses not to do so here under -O2 (side note: if you have -O0 in your
CFLAGS, that naturally creates many more false positives!).

This code has been around for a while, but nobody seems to have noticed
because we use an older version of the compiler in our static-analysis
ci job, and it does not complain. Presumably very few people run this
check locally on their more modern compilers.

Let's silence the false positive to avoid confusion for anyone running
locally, and to make it possible to upgrade the image we use for our
static-analysis job.

We could just switch to our custom ASSERT() here, but I think we can
improve the code by integrating the assertion into the if/else cascade.
That avoids repeating the logic about which versions are acceptable.

Signed-off-by: Jeff King <peff@peff.net>
---
Building with clang or with "gcc -flto" seems to also silence the false
positive. We might consider using those for the static-analysis job.
But since in this instance we can both silence it and (IMHO) make the
code nicer to read, I think it's reasonable to do so. We can leave
tinkering with the assert() magic as a separate topic for anyone
interested.

 bloom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bloom.c b/bloom.c
index c98d1672ad..caf22f9831 100644
--- a/bloom.c
+++ b/bloom.c
@@ -610,10 +610,10 @@ int bloom_filter_contains_vec(const struct bloom_filter *filter,
 uint32_t test_bloom_murmur3_seeded(uint32_t seed, const char *data, size_t len,
 				   int version)
 {
-	assert(version == 1 || version == 2);
-
 	if (version == 2)
 		return murmur3_seeded_v2(seed, data, len);
-	else
+	else if (version == 1)
 		return murmur3_seeded_v1(seed, data, len);
+	else
+		BUG("unexpected bloom version: %d", version);
 }
-- 
2.55.0.742.gf2bff09aa6

