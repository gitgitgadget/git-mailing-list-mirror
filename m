Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4486F36E
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532234; cv=none; b=BtTjoCnFvmJ0w1WJYT5GLUtiTGDopybqeen/QZpr1tgmthAZnrCqE9BDjZcKCGTM34aur8guSvBKx++9q5PE/BOz5gfIq+mI0UhSwmLA7bvgGWC8w18lmpY+a5CVzv/7IHQ0GpOySVykPgHh0Fje2pRceN+tSNfeTzMTEyyLcMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532234; c=relaxed/simple;
	bh=+2lgGXdF2pB3xNanrNJ25vqrHHCLylHREMFk58L510M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXrxjNFgpxRtZ/CMQgtAWhqK9A/ggdZygkfe4s1RalAYKWXyqiHQo6I6CHjCDoFRw616Y5Wuh4MjLuGwKF+djF/QnLXRfU/AjrEhdSU5NmPtM1f1rJMJblN6B3Yk0lgfXK0OMMG3OUqOgXcbpYBEM2JpmvEsqkveq3aAvjWAqs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23009 invoked by uid 109); 27 Mar 2024 09:37:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Mar 2024 09:37:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25136 invoked by uid 111); 27 Mar 2024 09:37:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Mar 2024 05:37:16 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 Mar 2024 05:37:10 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] treewide: switch to khashl for memory savings
Message-ID: <20240327093710.GA847433@coredump.intra.peff.net>
References: <20240325230704.262272-1-e@80x24.org>
 <20240325230704.262272-3-e@80x24.org>
 <xmqqttksanpj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttksanpj.fsf@gitster.g>

On Tue, Mar 26, 2024 at 10:48:40AM -0700, Junio C Hamano wrote:

> $ make builtin/fast-import.sp ;# part of make sparse
>     SP builtin/fast-import.c
> builtin/fast-import.c: note: in included file (through oidset.h, packfile.h):
> khashl.h:516:1: error: Using plain integer as NULL pointer
> khashl.h:516:1: error: Using plain integer as NULL pointer
> make: *** [Makefile:3237: builtin/fast-import.sp] Error 1
> 
> I found IMPL_GET and IMPL_DEL's use of (h->keys == 0) were giving
> one of these two, and managed to reduce the error to just one with
> the attached patch, but I don't know what the other error is coming
> from.

Probably:

diff --git a/khashl.h b/khashl.h
index 8fcebed237..1e724bbf88 100644
--- a/khashl.h
+++ b/khashl.h
@@ -116,7 +116,7 @@ static kh_inline khint_t __kh_h2b(khint_t hash, khint_t bits) { return hash * 26
 
 #define __KHASHL_IMPL_RESIZE(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
 	SCOPE void prefix##_resize(HType *h, khint_t new_n_buckets) { \
-		khint32_t *new_used = 0; \
+		khint32_t *new_used = NULL; \
 		khint_t j = 0, x = new_n_buckets, n_buckets, new_bits, new_mask; \
 		while ((x >>= 1) != 0) ++j; \
 		if (new_n_buckets & (new_n_buckets - 1)) ++j; \

-Peff
