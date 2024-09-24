Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96F96E614
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727211361; cv=none; b=aGhl1Y5TFyY7sNxqmnNlM13qiFIZAYcwlv0j4NM91flSAM68fLvXvAzUTiGaszTCW0cCs53dBaI8DnmZ5nW/dH4OkBjjJ8240NmJHa6EenGUNPlf/g463P5qK16GLafUec4DAQfi2PtfeFzwMkffUGsewGG6W5jI/LXFtijDvbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727211361; c=relaxed/simple;
	bh=q3RFHdcfBQ4RFu/7M5b60rZeoCMmbH2KpDfj7yJUPTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwUW0mUxLr47KT/QOlptRQTELTTMLFzNaFNpmB9atPhIdxs3gidoqhRzRrqSQis3IIfhZ3QBD3GQ/3+YO0hRo04JqmfRJFJIIUbJq0NU2G59Y5u07NXXe7pjwJMZ4MES6StteraOHsyONHw6LNuvVkzrScZs6ILbJGEBDijrrGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14531 invoked by uid 109); 24 Sep 2024 20:55:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 20:55:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17340 invoked by uid 111); 24 Sep 2024 20:55:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 16:55:58 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 16:55:58 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] git-jump: ignore deleted files in diff mode
Message-ID: <20240924205558.GC586150@coredump.intra.peff.net>
References: <20240915111119.GA2017770@coredump.intra.peff.net>
 <20240915112024.GB2017851@coredump.intra.peff.net>
 <ZulEwjnNQet6th8w@nand.local>
 <xmqqed5il3ui.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqed5il3ui.fsf@gitster.g>

On Tue, Sep 17, 2024 at 08:03:33AM -0700, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > On Sun, Sep 15, 2024 at 07:20:24AM -0400, Jeff King wrote:
> >> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> >> index 78e7394406..3f69675961 100755
> >> --- a/contrib/git-jump/git-jump
> >> +++ b/contrib/git-jump/git-jump
> >> @@ -44,7 +44,7 @@ open_editor() {
> >>  mode_diff() {
> >>  	git diff --no-prefix --relative "$@" |
> >>  	perl -ne '
> >> -	if (m{^\+\+\+ (.*)}) { $file = $1; next }
> >> +	if (m{^\+\+\+ (.*)}) { $file = $1 eq "/dev/null" ? undef : $1; next }
> >
> > I was surprised to not see you use `--diff-filter` here, but I think
> > that that makes sense. You only would want to exclude deletions, since
> > that would be the only time the post-image is /dev/null AFAICT.
> 
> So "--diff-filter=d" (lowercase)?

Hmm, yeah, I think that probably would work. In my mind, we are
accepting arbitrary diffs from the user because of the "$@". But anybody
who overrides us with

  git jump diff --diff-filter=D

maybe gets what they want/deserve. I think it's mostly academic, and as
the original has already graduated, I'm inclined to leave it unless
somebody comes back with some use case.

(Sorry for the slow reply, I am quite behind due to travel last week).

-Peff
