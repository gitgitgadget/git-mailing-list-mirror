Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550A34776A
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606760; cv=none; b=ian26cYnhDLpmmx7aLP9nVdjVhdnlm36P4mERitN+Ocr4LiyEJiqmIXXGcyFDn0P8NSprYG5Vz/QBnWN+OiQxGnAmF46uOixUXdCP+BKWU9/TEZ4fFP11S2Z33SQ1v8cUAYNzZHhjdNRtttGZE8/zTHpf3bbype8kNV1Dde5QMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606760; c=relaxed/simple;
	bh=2jad6x7FDYomh2Ru9MbyrMCOWC9WDkd2my/rB7JUUWk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XkrJWjqIpKVYHRxxcv4oi09JAzxSm50l+oVsj9UWke4W0x6H1M8cBNWF7AM8c+ApgeIVPZqJ5GFBskYIVg6K4GobwLswBIhq0ePLjWsU/+HhBtruBvQ2dCTHpJczczwQxeUOyv7kJ1BxCoC02Au+YtbTg1XCtd9CUvYRxLCc1f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=udj3LPVa; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="udj3LPVa"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 997BE2563C;
	Wed,  5 Jun 2024 12:59:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2jad6x7FDYomh2Ru9MbyrMCOWC9WDkd2my/rB7
	JUUWk=; b=udj3LPVak0uWOc+iFB2v02Iu1A3BFoLsLxp8Qr3Et0GbdIwwn5ykQj
	tgPt5PTTSUcethg+8fIrFIosYRndpAfBJr2eq6YpjKBaH6huXFKsEWP44pX/G6N6
	W1kW4Xv4FjuQRXciXcQEdScsjK3d3uADCOaBtMMQHLbD9Zg+klrds=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9201B2563B;
	Wed,  5 Jun 2024 12:59:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 98CC82563A;
	Wed,  5 Jun 2024 12:59:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 11/12] refs: implement logic to migrate between ref
 storage formats
In-Reply-To: <20240605100318.GA3436391@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 5 Jun 2024 06:03:18 -0400")
References: <cover.1716451672.git.ps@pks.im> <cover.1717402363.git.ps@pks.im>
	<1f26051eff8b7c18bb7114803454611272f84e19.1717402363.git.ps@pks.im>
	<20240605100318.GA3436391@coredump.intra.peff.net>
Date: Wed, 05 Jun 2024 09:59:14 -0700
Message-ID: <xmqq1q5buxzx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F0D7EA04-235C-11EF-B12C-8F8B087618E4-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> Coverity complains here of a leak of the xstrdup(). The return from
> mkdtemp() should generally point to the same buffer we passed in, but if
> it sees an error it will return NULL and the new heap buffer will be
> lost.
>
> Probably unlikely, but since you are on a leak-checking kick, I thought
> I'd mention it. ;)
>
> Since you have a writable strbuf already, maybe:
>
>   new_gitdir = mkdtemp(buf.buf);
>   if (!new_gitdir)
> 	...
>   new_gitdir = strbuf_detach(&buf, NULL); /* same pointer, but now we own it */
>
> Or since "buf" is not used for anything else, we could just leave it
> attached to the strbuf. And probably give it a better name. Maybe:
> ...

Hmph, I think this is the second one we want to amend on the topic
and it seems that I merged it a bit too prematurely.

I do not mind reverting the topic out of 'next' and actually would
prefer replacing it with a corrected version, which would allow us
to merge the clean copy to the next release.

Thanks.
