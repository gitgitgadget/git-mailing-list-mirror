Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6D381B9
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 06:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594822; cv=none; b=ilh6sFoGz76Ve4yLAd3gLu2p5FQ+G9jlRcz3d40kALY7o2162HOixzMalR2K1vAD40pqHn9FI4Hd++hmDlvHRmLX+m+9pdzxCwbtBQgZ9sf8PHptt5UFafhafaQb6B98aM0v1db69063xzf7uiC3h8mfTqQWCGP8KAL8Mz/CXYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594822; c=relaxed/simple;
	bh=kWoibuHHSvWobbebSnfRRlMrXqLNYBM1TfIiG+DPU6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJw/ChJT9OTuKkQi6IOZ8UofiSXq+PDghr3tmAqUIZcW+T9uQxT5PrTEDQo74F2BcIpHjhgaWsAHrTlcaeNE/TccOPjlzmDk8tVpR13ZTcC5WLF3RjVf4qFXLzJol7X/kIViSWpNAzuSw1wRYl7uisGrGilG/8xomdvHfell70w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8867 invoked by uid 109); 30 Jan 2024 06:06:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jan 2024 06:06:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29382 invoked by uid 111); 30 Jan 2024 06:07:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jan 2024 01:07:01 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jan 2024 01:06:58 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Wilfred Hughes <me@wilfred.me.uk>, git@vger.kernel.org
Subject: Re: [PATCH] diff: handle NULL meta-info when spawning external diff
Message-ID: <20240130060658.GD166761@coredump.intra.peff.net>
References: <CAFXAjY7XcL1APhLRXU8TO96z=f7957f2ieK56dHVsXUay55vpg@mail.gmail.com>
 <20240129015708.GA1762343@coredump.intra.peff.net>
 <xmqqede0htp2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqede0htp2.fsf@gitster.g>

On Mon, Jan 29, 2024 at 10:37:29AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> $ git diff --no-index foo bar
> >> zsh: segmentation fault (core dumped)  git diff --no-index foo bar
> >
> > Thanks for providing a simple reproduction recipe. There's a pretty
> > straight-forward fix below, though it leaves open some question of
> > whether there's another bug lurking with --no-index (but either way, I
> > think we'd want this simple fix as a first step).
> 
> Yup, I agree with you that the "--no-index" mode violates the basic
> design that "the other path" and "xfrm_msg" go hand-in-hand.  In its
> two tree comparison mode "git diff --no-index A/ B/", it should be
> able to behave sensibly, but in its two files comparison mode to
> compare plain regular files 'foo' and 'bar', there is nothing it can
> do reasonably, I am afraid.  You could say that the change is
> renaming 'foo' to create 'bar', and feed consistent data that is
> aligned with that rename to external diff, which might be slightly
> more logical than showing a change to 'foo' that has no rename
> involved (i.e. omitting "other name"), but neither is satisfying.

Yeah, I think the two-tree mode does behave correctly, and this is
really just about the two-blob mode. I agree that one could think of it
as a rename or not, depending on how much you want to read into the
importance of the names (after all, you could compare a/foo and b/foo,
which is sort of a moral equivalent of the usual two-tree case).

The current behavior is somewhere in between, though. You get an "other"
name passed to the external diff, but the metainfo argument makes no
mention of a rename (it's either blank for an exact rename, or may
contain an "index" line if there was a content change).

I'm not sure anybody really cares that much either way, though. It's
external diff, which I suspect hardly anybody uses, and those extra
fields aren't even documented in the first place.

-Peff
