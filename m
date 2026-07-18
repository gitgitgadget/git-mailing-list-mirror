Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AAD248F73
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784359905; cv=none; b=CpFKxzd0W+Q6G2DJscSD2/G54yEu31FXiB/W2058Ohp1UOjrf30X4KW7nccvftxaJDEJKlPlsWNfG9m66CZ8eThLQyx7THSRaYgp/Bcopw6vaNI5Lnk4OP7j/cz0ikOkZzLc590MMD9ka2o9UBwQR/UZIYhKncN9n4vCmxq0TFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784359905; c=relaxed/simple;
	bh=EbEwrHXO495+4ziWM/YXw6SzhLeLgUeNkpQsbv8ZaDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9GbQ7gpiScUHNYHJ8gNTgN59I4BNSZqkAy3I70I7O4kUkHLYz/mUzarEj0d1FuRWy9fWk9HgpN2piUSbTM4tzyvdbw/nWeJTyOG1Rwu7aGNeglZeDDOTMNVSxpHa0fXpUZCd7UXFwy19ovbIEbc/8py6IaDj+g5B+jwRFTS1tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TNpKEbFz; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TNpKEbFz"
Received: (qmail 59980 invoked by uid 106); 18 Jul 2026 07:31:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EbEwrHXO495+4ziWM/YXw6SzhLeLgUeNkpQsbv8ZaDQ=; b=TNpKEbFzKlatZsXFbSIr1DeN3FXx2bSiSQ4kr9OAAq2Og2vdh/8zZKaO+KEHmyUVxiZqh7GzmKZEcfcxkUhI1QLDZyJs2Ix2K56RsmsnZUXwJi5ccTraYXfn8gtdfHrkWQOyTMK80GZd81gjWl1CuGn0nubbhs3htHPeD7W8L8dqE4GnF9MhEkszY/eU8zZ7SYfnvDbFBObweGw7uTNj4SHsh9PpJXTy+m0WB9K8AhEbS1l9yOuvahuIeqHFy2wYVBzykuW0VTXcGIP3b+UQoy9pbs8Hj/ZRTUBBeO1YpyckUZK5M5XYLUlPR7lmk+UDusEfl/jpWvjz/leuiPS9eg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Jul 2026 07:31:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 106416 invoked by uid 111); 18 Jul 2026 07:31:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Jul 2026 03:31:40 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Jul 2026 03:31:35 -0400
From: Jeff King <peff@peff.net>
To: Sahitya Chandra <sahityajb@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
	stolee@gmail.com, ps@pks.im
Subject: Re: [PATCH v2] wt-status: avoid repeated insertion for untracked
 paths
Message-ID: <20260718073135.GA22588@coredump.intra.peff.net>
References: <20260716185045.229320-1-sahityajb@gmail.com>
 <20260717144620.259031-1-sahityajb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717144620.259031-1-sahityajb@gmail.com>

On Fri, Jul 17, 2026 at 08:16:20PM +0530, Sahitya Chandra wrote:

> wt_status_collect_untracked() copies entries from dir.entries and
> dir.ignored into string_lists using string_list_insert(). That keeps the
> destination lists sorted and deduplicated, but makes the code harder to
> reason about because it rebuilds sorted lists through repeated sorted
> insertion.
> 
> Collect the entries with string_list_append() instead, then sort and
> deduplicate each list once with string_list_sort_u(). This preserves the
> sorted, duplicate-free result while making the collection strategy explicit.

The patch looks good, and I think this explanation is OK-ish. But IMHO
it is still worth talking about the quadratic issue, because that's
really the motivation here (and what the "harder to reason about" is
getting at).

So maybe something like:

  wt_status_collect_untracked() copies entries from dir.entries and
  dir.ignored into string_lists using string_list_insert(). At first
  glance this seems to be quadratic, because we may shift the backing
  array, incurring O(n) work for each insert.

  In practice, though, the entries in the dir struct are already sorted,
  so each we never have to shift the array (and only pay the log-n
  lookup cost for each insertion). But this is subtle and depends on the
  behavior of fill_directory().

  Collect the entries[...etc...]

?

-Peff
