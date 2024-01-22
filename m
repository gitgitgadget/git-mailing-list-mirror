Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA06482E3
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961084; cv=none; b=AY90mf+BwAfD6u1AJhN9jC0nUEnC9oBcN6TLbxoGNuNmgldL6cuzlmCD9xz+3JNTKrpVRoCP/XEuZ28MfRRmfwqG5IXilDyD4OPhUOZ3jp8jqB9ersYrla5Jc3QJOxNi5fskPZ2v1XlOM85+VwbJNpLZNpbTdS/0oSz54a2+LsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961084; c=relaxed/simple;
	bh=Q1SjjN1rtg7ZGhvSLrA+Cmc3i4PWp3IWs1aZtfVs3S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCeSSZrz169U1//xIlHxFxH6ryzsU0qvWdnb6vLJgBJvKH82kIK0VhRL3gUzcLPMU4maRbdXiXBfe/qqo+vq6LQ55bqLQKn4WrOrB3vgVAOyO2a7LudCLZKsSCbS8WTcA8KMbseErXloch+wyJpG9IV6fHTFi8YXRYN4wvW5m20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11404 invoked by uid 109); 22 Jan 2024 22:04:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Jan 2024 22:04:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9824 invoked by uid 111); 22 Jan 2024 22:04:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jan 2024 17:04:42 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Jan 2024 17:04:40 -0500
From: Jeff King <peff@peff.net>
To: Zsolt Imre <imrexzsolt@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Git Push Always uses Protocol Version 0
Message-ID: <20240122220440.GB811766@coredump.intra.peff.net>
References: <FD545E92-18EF-44B5-A7D5-61ECADD880E6@gmail.com>
 <xmqqa5oxurnj.fsf@gitster.g>
 <E121C312-5771-47EF-9099-BEC8EFC2B9BD@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E121C312-5771-47EF-9099-BEC8EFC2B9BD@gmail.com>

On Mon, Jan 22, 2024 at 07:24:53PM +0000, Zsolt Imre wrote:

> And to answer your question of what I cannot do with the "current
> versions" of the protocol: I could do everything, of course. But, if
> there's protocol 0, 1 and 2 and I wanted to implement only version 2,
> I thought I should be able to. If protocol V2 was complete, I would
> not have to worry about implementing V0 and V1 (saving some time and
> headache), especially because I do not care about supporting old
> clients. I may have misunderstood the word "version" and version 2 is
> more of an "extension" to V1?

I think the main confusion is that there simply isn't a "v2" push
protocol. It has not yet been written.

There was discussion when v2 was being worked on there that might be a
single "git serve" endpoint that would handle both fetch and push. But
in practice the backwards-compatibility technique we use requires asking
for the usual "upload-pack" or "receive-pack". And hence there isn't
really a single protocol, but still a fetch protocol which can be v0 or
v2, and a push protocol which is always v0.

It's possible we'd shift direction there, but IMHO there's value in
having separate per-operation endpoints. There's some more discussion
in this sub-thread:

  https://lore.kernel.org/git/20181213195305.249059-1-jonathantanmy@google.com/

Now of course a v2 push protocol, if it is ever written, will probably
look a lot like the v2 fetch protocol, and they can probably share a lot
of the implementation. But v0 and v2 are not that different either. In a
hypothetical world where v2 push existed and you could get away with
skipping v0 push entirely, I'd expect that "v2 push and v2 fetch" would
be about the same amount of work as the current "v0 push and v2 fetch".

-Peff

PS I saw some mention of "v1" in this thread; I wasn't sure if this was
   meant to refer to "v0" (a mistake I have made lots of times myself).
   But if not, "v1" is not really of any interest. It was a brief
   experimental phase for the client-upgrade mechanisms, and it behaves
   exactly like v0. No version of Git has ever used it by default.
