Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EDC1AB500
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989552; cv=none; b=SX42FP5y/1Ob8IGvKf4rb3bAP+dyfE9zDY1fj1RIafKjkyTCzOusWf/+fUlu8+fPxnTV67jvZ6Vd6v/8P12cvpJehIHIdUTTE49tJviITDSKWESwSOqj2bCzd8oIa1Bphh/Yc2NT/YdGNgEcDNuUtLmVj28VZAJF6zMgbtRk22c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989552; c=relaxed/simple;
	bh=A/AgZ0VehFeLtkwbRCUoRTcdx+TPpaPZEwm8g8x5r3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meyg+nJncs3JNAiM4fKGRocAJA89WTf54dvS2WbVit5dCAwzqhWK98abymFUTg5Nkm8lskPhwx6/oLJrWYYSHAQKQm25ZLO877w8lb8tq2CsCAHApRTsuS8hh2xccfxhs6Wm2aLAJkcyfABGDiyOhCMtnE4rXrOqWt0N7XYAc7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=R9K6ny+q; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="R9K6ny+q"
Received: (qmail 19305 invoked by uid 109); 3 Oct 2024 21:05:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=A/AgZ0VehFeLtkwbRCUoRTcdx+TPpaPZEwm8g8x5r3M=; b=R9K6ny+qS0rfuRnANPHT5cu5tO1bAIINbMc6THKGYkzuJNaWqkGFm2EXJsO5pv/sfb1jpXT8tW8m2wIgyvjc35ptMFCSK/XhEtikjK/EK1457wCEdUr0t1dfPzCL5Z++C4tcdv/ogF9cwwj1KYvs/v8X4azc/GRf4dFfNYvj6M7PIIuIxDTpBcyxTfRh1M/FhBjzJByOowg9i9YHCGXhKB4nGOtNhSXt1TP4Z+AQGqSA1RMDkjacUim63BkDcIwFGtz10FdizKOcE5AYhJjpqwK2+QfCoxp5QCAD1czL7WDOEhH42Vj2KLWRUEXUaeyrubJSFeAEz9A/t6KY0nOVYQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Oct 2024 21:05:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21739 invoked by uid 111); 3 Oct 2024 21:05:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Oct 2024 17:05:49 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 3 Oct 2024 17:05:48 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Subject: [PATCH 0/5] diff output_prefix cleanups
Message-ID: <20241003210548.GB11180@coredump.intra.peff.net>
References: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
 <pull.1806.v2.git.1727956724.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1806.v2.git.1727956724.gitgitgadget@gmail.com>

On Thu, Oct 03, 2024 at 11:58:41AM +0000, Derrick Stolee via GitGitGadget wrote:

> This fixes a regression introduced in 2.46.0.
> 
> The change made in 394affd46d (line-log: always allocate the output prefix,
> 2024-06-07) made the method more consistent in that it did not return a
> static empty string that would fail to free(), but it does lead to
> double-frees when a strbuf buffer is freed multiple times.
> 
> In v2, I add Peff's test to the first patch. I also split his diff into two
> more follow-up patches because the additional clarity seems valuable to me.
> I have forged his sign-off in all three patches.
> 
> Note to the maintainer: feel free to take only the first patch, as Peff
> replied that he may work on the remaining cleanup independently (but I had
> already prepared patches 2 & 3).

Oh, I wasn't expecting you to go to that trouble, and had already
polished them up myself. :)

So certainly your patch 1 looks good to me now. Here's what I would
put on top (but I would suggest making it a separate branch, since yours
is a fairly urgent fix and mine is all cleanup).

  [1/5]: line-log: use diff_line_prefix() instead of custom helper
  [2/5]: diff: drop line_prefix_length field
  [3/5]: diff: return const char from output_prefix callback
  [4/5]: diff: return line_prefix directly when possible
  [5/5]: diff: store graph prefix buf in git_graph struct

 diff-lib.c   |  4 ++--
 diff.c       | 10 +++-------
 diff.h       |  3 +--
 graph.c      | 29 +++++++++++++++++------------
 line-log.c   | 14 ++------------
 log-tree.c   |  7 +------
 range-diff.c |  4 ++--
 7 files changed, 28 insertions(+), 43 deletions(-)

-Peff
