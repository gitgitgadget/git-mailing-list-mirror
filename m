Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC31180056
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472836; cv=none; b=bY5s5CKLAaaErPM46zOiNlYEkUgFnjelv2qEMQQm8+4Bhk5E2JW5DhU1dezSgpusjW43in2kZncvWJP+5jk60fD7JjeFRKc2V8FEDXs0+v+Z2RksD2EXPc/jmSAfgGNuOQrAbTp6hQojbMr8ioLM6sNHWRdTn7t0VHKC8RypzBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472836; c=relaxed/simple;
	bh=U8TYAlW9ctDzhW3eA24goEfUq8xensfHk8ON9SNlgho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYZszx1NBiIJXqtLvWoQ0NC9gk88V9Ex+7v/cXPd2e/nalAWpuogYObnss3BWgsaSzOwzY5qXiTsh+7mwsFRrlTHgI5XGARM0ZtfYv5llqeR4Mh++86Wgy4rHSa+uYCXz9JTQMnpopqAA/HiDt3NwTtz4mcZF9x8mdewuuWUBik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29394 invoked by uid 109); 12 Aug 2024 14:27:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Aug 2024 14:27:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29916 invoked by uid 111); 12 Aug 2024 14:27:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Aug 2024 10:27:13 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 12 Aug 2024 10:27:12 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/19] midx: incremental multi-pack indexes, part one
Message-ID: <20240812142712.GA3800004@coredump.intra.peff.net>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1722958595.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722958595.git.me@ttaylorr.com>

On Tue, Aug 06, 2024 at 11:36:36AM -0400, Taylor Blau wrote:

> As usual, a range-diff is below, but the main changes since last time
> are as follows:
> 
>   - Documentation improvements to clarify what happens when both an
>     incremental- and non-incremental MIDX are both present in a
>     repository.
> 
>   - Commit message typofix on 3/19 to fix an error in one of the
>     technical examples.
> 
>   - Dropped a custom 'local_pack_int_id' in 4/19 to make the remaining
>     diff easier to read.
> 
>   - Minor bugfix in 7/19 where we incorrectly terminated the object
>     abbreviation disambiguation step for incremental MIDXs.
> 
>   - Various additional bits of information in the commit message to
>     explain anything that was subtle.

This all looks good to me.

I read over your responses to my previous review, but as you answered
all of my questions I didn't respond to each individually. :)

I looked over the changes in this iteration and they address all the
small points I brought up. In the bigger picture, I do think there are
probably still issues lurking around the global/local pack and objection
position ids. But where you have the series now seems like a good
cut-off point:

  - I suspect pack_pos_to_midx() might need to be adjusted. But it's not
    an issue that can be triggered until until we support incremental
    midx bitmaps. And that should definitely go in its own series (and
    preparing is kind of pointless because we don't know what the
    correct interface will be until mid-way through that topic).

  - I won't be surprised if there is some global/local bug that shakes
    out in the long run. But I don't have a clever way of preventing it
    or avoiding the need to deal with the distinction. So I think the
    best path is forward, and to let the shaking commence.

    The most important thing to that the new on-disk files are sane,
    since those are hard to walk back later. A simple bug in the code
    can always be fixed. Likewise, the changes here are unlikely to
    create a bug for anybody using a single unchained midx. So even if
    there is a bug, it will only be triggerable for people using the
    experimental mode.

-Peff
