Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6196C10E0
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 05:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729573244; cv=none; b=AlGqGuSR15AlM7x5/7Xy16g2dT+kzV51G04Vxd1NDP0moJPVttCMWGu4NqI/TSidm3HGYnVmHftBT8kxWirJ/BEHOh5lrCrcLxL9rPTZRL5Nc7BT7n88lNj52R0asj9Lewcampbe42mwOZ/Eu+tX98bMAPbR7yrQIqI4Se2Ot7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729573244; c=relaxed/simple;
	bh=FUWOa6Y4Jx527JRpgGeoxGrSTtSPfPdqTqCyn/CO128=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3ovCOnj06XxYI8S5TOETvYNgicD1+d/rdiTQ1ygGcRpUT8wV7VR3QGXdMnb8vxB4Zvr1bstNZkGztNxska3AhQWhxnteODS5OvgJNNECvXPJiDxpVzupEgsPVAvb28J67/m8u0Vwz6YaMYzvUeK3sjBhpHOqopzgSsZOHQOHp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TRcMFYJJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TRcMFYJJ"
Received: (qmail 27527 invoked by uid 109); 22 Oct 2024 05:00:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FUWOa6Y4Jx527JRpgGeoxGrSTtSPfPdqTqCyn/CO128=; b=TRcMFYJJxoHvBrPxj79xL9op8ixKBDQsStPm/aqSGlt6n3pDVbcDVznCW+YoW/QnRBf5cm6qBSEdQlakncsDCxkiB/xd083T9A0xVT6D0hKH0SmaH9rVsZoeiPxYaPTCbbvogHcDWwK/84F0FaEcz60LP9Hak0+Zpsw+YMokBXaw4U7oMfpoCFLu3SK/wiqeB19OVdwiLp55SEkunkWJ8lCd+AG/dSKnsVKcE95tognzz4yy8ToAV2JoangM4vQrBXOHat5/sgUp8XehswoiVBNtNG9Ipbhj2/XqnP5l2bKfHs6rwpRTalaamYXLUTq+NykscgVSh76geuHsklnfRg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Oct 2024 05:00:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5243 invoked by uid 111); 22 Oct 2024 05:00:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Oct 2024 01:00:40 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 22 Oct 2024 01:00:40 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: Re: Bug report: v2.47.0 cannot fetch version 1 pack indexes
Message-ID: <20241022050040.GA1247135@coredump.intra.peff.net>
References: <BA07EFA0-0793-420D-BED9-ACD7CEBE0112@townlong-yak.com>
 <20241020012455.GA599236@coredump.intra.peff.net>
 <Zxa4XU+j4+SSmk9c@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zxa4XU+j4+SSmk9c@nand.local>

On Mon, Oct 21, 2024 at 04:23:57PM -0400, Taylor Blau wrote:

> On Sat, Oct 19, 2024 at 09:24:55PM -0400, Jeff King wrote:
> > There are a few things I don't like there, though:
> >
> >   - obviously reversing the tempfile name back to the idx is hacky. We
> >     could probably store the original idx that led us to this pack and
> >     use that.
> 
> TBH, I don't think that this is all that hacky, but...

Mostly I was worried that there was some case where the filename would
not be the usual pack-$hash.idx that we expected. But having now looked
at the code quite a bit to produce the follow-on patch, I think these
names are always generated locally from sha1_pack_name(), etc.

Another variant of this approach is to actually teach index-pack a flag
to say "it's OK to overwrite an existing .idx file, even if the bytes
don't match". That's the simplest fix _conceptually_, in that it takes
us back to the pre-2.47 behavior. But plumbing through that option would
require a lot of ugly and confusing boilerplate code.

> > So IMHO a cleaner fix is that we should keep the stuff we download from
> > the remote marked as temporary files, and then throw them away when we
> > complete the fetch (rather than just expecting index-pack to overwrite
> > them).
> 
> ...this seems like a much better idea to me. We shouldn't be keeping the
> provided *.idx file given that we plan on overwriting it later on in the
> process.

I dug on this a little more, and...I don't love the design of the
dumb-http protocol.

A big question here is: what should the life cycle of those downloaded
.idx files be? And how much should we try to avoid re-downloading them
(keeping in mind that the .idx for linux.git is almost 300MB)?

In a normal dumb-http clone, something like this happens with the
current code:

  1. We see we need some object X.

  2. We download _all_ of the .idx files offered by the remote, since we
     have no idea in which one we'll find X. (There's an obvious
     low-hanging optimization to stop when we find X, but in the worst
     case we need all of them anyway).

  3. For each one, we download the matching pack if needed. In most
     cases you need all of them, but there might be some pack P for
     which we only have the .idx. We leave that bare .idx sitting in the
     objects directory.

So now we have all of the other side's .idx files locally, but not
necessarily all of their .packs. And here are some interesting follow-on
cases:

  a. You do a follow-up fetch, and now you need object Y. The saved idx
     of P is useful, because you can avoid downloading it again. Yay.
     You likewise should avoid re-downloading any for which you did get
     the matching pack, because you'll have pack-$hash.idx locally (just
     your generated copy, not the one you got from the other side).

  b. The other side repacks, and then you fetch. Now all their pack
     names are changed. So your saved idx of P is useless. But also you
     end up downloading all of the new .idx files anyway (even though
     you probably already have 99% of the objects).

  c. You repack, then fetch. Now the other side has the same packs, but
     your local copies all have new names. You re-download every idx
     from the other side, not realizing that you already saw them last
     time.

With my patch, case (a) doesn't save P (because now we treat it like a
tempfile), so we re-download it unnecessarily. That's a little worse.
I think the other two cases are largely the same.

But there's a flip side here. What if we kept the .idx files we got from
the other side in objects/pack/remote-idx/, basically as a cache? Now
case (c) avoids a lot of pointless downloading, though it comes at the
cost of storing those extra .idx files (which, before we repack, are
basically duplicates of the .idx files we generated ourselves; if we
really wanted to get clever we could probably hard-link or something).

We didn't improve (b). And in fact, we've created a new issue: we're
still holding on to the old cached .idx files. We'd have to have some
scheme to get rid of them. I suppose that happens when we fetch the
other side's objects/info/packs file and see that they're no longer
mentioned (though if you want to be pedantic, this really should be a
per-remote cache, since in theory two remotes could hold the same pack).

So...what does it all mean for this fix?

I think the patch I posted earlier, to keep the .idx files as separate
tempfiles, is only slightly worse than the status quo (it doesn't keep
P.idx that we didn't need). And given my general feelings towards the
dumb-http protocol, maybe that is the right place to stop.

It just feels like we _could_ be improving things with a better managed
.idx cache system. And that would fix the regression at the same time.
But I'm not sure it's worth sinking time and complexity into this
terribly inefficient protocol.

(Part of why I laid all this out is that until wrote all of the above, I
wasn't completely convinced that case (a) was the only one that
suffered, and that it was so mild).

-Peff
