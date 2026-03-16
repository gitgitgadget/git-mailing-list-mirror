Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE30E1F1537
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695983; cv=none; b=ZAQprh/QKTwrayDEQvp/0xiy3rnnseIF5xP2tlV70jV2nyIsVsOimsFWMjPEiArRTLM91LjvH6DPgBKs6EJ58gHRN0ao+wSYsDQLQIWzMFUxwba2CudB8NqCd3ufbGHbmb3sFRfhPe7oTDMb0s/h4R3nf1p3CzP3K8/rvthwoPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695983; c=relaxed/simple;
	bh=rLmRj85bAsq6+uSYqXpeXx0HIQHVM7O+Mq4PO8/ZDTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1YpKJIu9/t9VoT4h9cBuNWspLolnBDoAVxyXWdrYM+V2PvC+jZi6OHDB6SsNDvRiFeh/tilq7opOO/iU4alv2qqCL2XK8lEATFiLc/bKyPAaenaAbNmVOzg1Yt1fjwoOy2PLjuBIOg61SyrKgMD6xeWoabIPUJWJSKzUTVb8AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EwSputpX; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EwSputpX"
Received: (qmail 23802 invoked by uid 106); 16 Mar 2026 21:19:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=rLmRj85bAsq6+uSYqXpeXx0HIQHVM7O+Mq4PO8/ZDTE=; b=EwSputpXUS30VcYGYnHjITUam+4OzEV+WXsWUhF24pAwDgQ2r0EDOY72DQdTbq/KuDWRNjlS4KKir05OGzKj4s+p2UhUHQHhMk/XvQBTkDozV8JV0b6YyVT1iY9jyKsPGvfYBKUpWzJQg0YAN3r/2iExKzLOY6Nw2qhYEEuPj3PKCNm8tK8hOr1OGZGUJR/l33z81TncPGJFSFGIXrtGQJI+JSnpQgZrMVm2wQRte2GLsvubl++yebUeTE+2alTbupiXb91RhfrMaOjykWOq4uxpEXzvDdYbQF4/2m+ZKMhG/3CFj/OAuwGUcqjDmh3nxip3Kbm1KBJv3zwlewv3SA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Mar 2026 21:19:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 33811 invoked by uid 111); 16 Mar 2026 21:19:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Mar 2026 17:19:35 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 16 Mar 2026 17:19:34 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Andrew Au <cshung@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v4] transport-helper, connect: use clean_on_exit to reap
 children on abnormal exit
Message-ID: <20260316211934.GA1042816@coredump.intra.peff.net>
References: <20260311184206.GA1911377@coredump.intra.peff.net>
 <20260312214945.4050010-1-cshung@gmail.com>
 <xmqqsea4aen2.fsf@gitster.g>
 <20260314160814.GA918806@coredump.intra.peff.net>
 <xmqq4imfo6sz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4imfo6sz.fsf@gitster.g>

On Mon, Mar 16, 2026 at 01:31:08PM -0700, Junio C Hamano wrote:

> Regardless of where it goes, we need to change a bit more, it seems?
> 
>     CC transport.o
> transport.c: In function 'transport_color_config':
> transport.c:57:62: error: passing argument 3 of 'repo_config_get_string_tmp' from incompatible pointer type [-Wincompatible-pointer-types]
>    57 |         if (!repo_config_get_string_tmp(the_repository, key, &value))
>       |                                                              ^~~~~~
>       |                                                              |
>       |                                                              char **

Huh. Obviously yes, but how did I manage to bungle this so badly?

I _think_ what happened is that I compiled the topic without -Werror,
because of all of the -Wdiscarded-qualifier errors that happen on
'master' with a recent glibc.

My integration cycle would have caught it, since I have another topic
with fixes for the discarded-qualifier issue. But I hadn't run one yet. ;)

None of that is important for you, but just wondering if there was
something more subtle going on, or if I just screwed up something as
simple as typing 'make'.

> I'll squash an obvious patch in.

Yep, that looks good. Thanks for fixing.

-Peff
