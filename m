Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE3025B1FF
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312415; cv=none; b=ga9NrNR40vTAv1dKR072g2yUIS0X3s1IQqWXIyuFKUUnuTsKgMFfIzDpSaaut4uN1Eut0+DfgxVLxIvt2xstuVhBZtSN7aqISTrmvFboZkr4z/RZCMInHAlxaQDptE3/w1Md88pPYMMK6OoVZIBhqqpz57n1njeTIpqOTerJFlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312415; c=relaxed/simple;
	bh=Fy0Q2IMj6CeFTSUuTJGz9bZCgCY8jTRGQl2IlIcD1GA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TihiXlUYQtHVMAOQcDkIGijdmjTGdXUtuldM8aqfdpWErNp5+4iY0Lmc1lo6j3lcfmx6K7dVMarj4+Qb7NcGQdHBRp+K0GNX/U4XN+its7gWUd+4Blqi2MmYzrMJfy1fR8smo9BdZBkL2bnO9bRthCK2pSlKxOqPC221VtjwRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bR7mB9fg; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bR7mB9fg"
Received: (qmail 724 invoked by uid 109); 4 Aug 2025 13:00:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=Fy0Q2IMj6CeFTSUuTJGz9bZCgCY8jTRGQl2IlIcD1GA=; b=bR7mB9fgCVdLfRQb3I+Dm/n11FrWeIiNVold+B6uiA6MZFC71QpJhw3RS7/KQXrNR5EVHkoyt2+GORGNl3vg9lPdWdaqhjPVNdBP0U6ISG5DqT1/YBQHtqDLMFnzO9TE1aZYlSVKzjwGs/bWSBmYu3SRDuDh0VwUPzeDmn1CyJ/UuGmCUkIPqQHAS7eDc20SY2woFwKGUKlhcBTwvR9q4rbJLBWpSHVAQDT9OqeNqSWT6xGd3/bIf22lWiKyi3KmaY/bh29y+O5Xv7ijOHcTRMsLaZUPFjP/nKbItGFibHcHRsNjkBYuHyjFX8saYeeQT9ntDLcZv44bhe+nc8A+NQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Aug 2025 13:00:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19090 invoked by uid 111); 4 Aug 2025 13:00:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Aug 2025 09:00:12 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Aug 2025 09:00:11 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] revert: initialize const value
Message-ID: <20250804130011.GA93475@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

When building with clang-22 and DEVELOPER=1 mode, this warning causes us
to fail compilation:

  builtin/revert.c:114:13: error: default initialization of an object of type 'const char' leaves the object uninitialized [-Werror,-Wdefault-const-init-var-unsafe]
    114 |         const char sentinel_value;
        |                    ^

The compiler is right that this code is a bit funny. We declare a const
value without an initializer. It cannot be assigned to because of the
const, but without an initializer it has no predictable value. So as a
variable it can never have any useful function, and if we tried to look
at it, we'd get undefined behavior.

But it does have a function. We never use its value, but rather use its
address as a sentinel value for some other variables:

        const char *gpg_sign = &sentinel_value;

	...maybe set gpg_sign via parse_options...

	if (gpg_sign != &sentinel_value)
		...we got a non-default value...

Normally we'd use NULL as a sentinel value for a pointer, but it doesn't
work here because we also want to detect --no-gpg-sign, which is marked
by setting the pointer to NULL. We need a separate "this was not
touched" value, which is what this sentinel variable gives us.

So the code is correct as-is, but the sentinel variable itself is funny
enough that it's understandable for a compiler warning to flag it. Let's
try to appease the compiler.

There are a few possible options:

  1. Instead of a variable, we could just construct an artificial
     sentinel address like "1", "-1", etc. I think these technically
     fall afoul of the C standard (even if we do not access them, even
     constructing invalid pointers is not always allowed). But it's also
     something we do elsewhere, and even happens in some standard
     interfaces (e.g., mmap()'s MMAP_FAILED value). It does involve some
     annoying casts, though.

  2. We can mark it as static. That gives it a definite value, but
     perhaps makes people wonder if the static-ness is important, when
     it's not.

  3. We can just give it a value to shut the compiler up, even though
     nobody cares about that value.

I went with (3) here as the smallest and most obvious change.

Signed-off-by: Jeff King <peff@peff.net>
---
I dunno, maybe the comment just makes things more mysterious and
doing the casts would make it more clear what is going on.

 builtin/revert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index e07c2217fe..c3f92b585d 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -111,7 +111,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
 	const char *cleanup_arg = NULL;
-	const char sentinel_value;
+	const char sentinel_value = 0; /* value not important */
 	const char *strategy = &sentinel_value;
 	const char *gpg_sign = &sentinel_value;
 	enum empty_action empty_opt = EMPTY_COMMIT_UNSPECIFIED;
-- 
2.50.1.786.g492fc26cdf
