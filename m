Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAAC1420DD
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726172658; cv=none; b=Y7DAaXhH+2NgaGqsZQoDUJjIz/vf8M80Oab+lmkBsWqJkukFUAGKiag2CdSxu8bZq9swIikCdnoq16Gf/lu8/iMQs2ECWRoBOdIhYTuGXQ0UDUbOHhVFGH0racMdTjxaDHBQzT9IPI09fGRluqBQPeh6BCRmg7xcMmQcp9pHLJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726172658; c=relaxed/simple;
	bh=Ta6+QITXQmf8JbWNyn5xojioCmSoG07yArlarw8/qqc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=koNvT5BGnRpVg16iC44AJj/AF1uo/g2XEUNLY9D2QCKnYTN2/TfGcQwTW2QnQfObbONQmMLJKpbzKzbH+7D5CEduYsxwHZM/KtDrYo3XjqYaNMO5OEluYU2WdlOKpxLa/HdE00uSoCKUmJVdtxExO6HUrWQ0mBSakxw7iubgIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ifm/BI/7; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ifm/BI/7"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 125D830048;
	Thu, 12 Sep 2024 16:24:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ta6+QITXQmf8JbWNyn5xojioCmSoG07yArlarw
	8/qqc=; b=Ifm/BI/7JMuJ98cAL3FGY4kxtLZ5cRk7GCw71J/v0GfKuQ360X1YQ7
	Ke1fmxSg+BHPTagVTBUZzILqeKV+fTo9dVo4Hjq2PFozxSPiVEa1HkYlQRQNk0dR
	0aIx55gFSB8pad3WNV9I8PZEjkAQuEXeh2GoVWcZaV8kE7k+xd8GQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09D2330047;
	Thu, 12 Sep 2024 16:24:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6884630044;
	Thu, 12 Sep 2024 16:24:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Brooke Kuhlmann
 <brooke@alchemists.io>
Subject: Re: [PATCH 10/9] ref-filter: fix leak with unterminated %(if) atoms
In-Reply-To: <20240912111858.GA617985@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 12 Sep 2024 07:18:58 -0400")
References: <20240909230758.GA921697@coredump.intra.peff.net>
	<4faf815b780218769520561ecf3abca384a2ee6c.1725951400.git.ps@pks.im>
	<xmqqseu7jvz3.fsf@gitster.g> <ZuLA0SBqhBbBdcd1@pks.im>
	<20240912111858.GA617985@coredump.intra.peff.net>
Date: Thu, 12 Sep 2024 13:24:13 -0700
Message-ID: <xmqqa5gc4o42.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FA6570CE-7144-11EF-AFC9-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> On Thu, Sep 12, 2024 at 12:22:16PM +0200, Patrick Steinhardt wrote:
>
>> > diff --git c/ref-filter.c w/ref-filter.c
>> > index b06e18a569..d2040f5047 100644
>> > --- c/ref-filter.c
>> > +++ w/ref-filter.c
>> > @@ -3471,7 +3471,8 @@ int format_ref_array_item(struct ref_array_item *info,
>> >  		}
>> >  	}
>> >  	if (state.stack->prev) {
>> > -		pop_stack_element(&state.stack);
>> > +		while (state.stack->prev)
>> > +			pop_stack_element(&state.stack);
>> >  		return strbuf_addf_ret(error_buf, -1, _("format: %%(end) atom missing"));
>> >  	}
>> >  	strbuf_addbuf(final_buf, &state.stack->output);
>> 
>> Hm. It certainly feels like we should do that. I couldn't construct a
>> test case that fails with the leak sanitizer though. If it's a leak I'm
>> sure I'll eventually hit it when I continue down the road headed towards
>> leak-free-ness.
>
> Hmm. I think just:
>
>   ./git for-each-ref --format='%(if)%(then)%(if)%(then)%(if)%(then)'
>
> should trigger it, and running it in the debugger I can see that we exit
> the function with multiple entries.
>
> Valgrind claims the memory is still reachable, but I don't see how. The
> "state" variable is accessible only inside that function. The only thing
> we do after returning is die(). I wonder if it is a false negative
> because the stack is left undisturbed (especially because the compiler
> knows that die() does not return).

Yup, the reason why I didn't add any test was because the leak
checker failed to notice the apparent leak.

> At any rate, I think the same would apply to the earlier error returns:
> ...
> All that said, I am content to leave it for now. Even if it's a real
> leak, it's one that happens once per program right before exiting with
> an error. Most of the value in cleaning up trivial leaks like that are
> to reduce the noise from analyzers so that we can find the much more
> important leaks that scale with the input. If the analyzers aren't
> complaining and we think it's trivial, it may not be worth spending a
> lot of time on.

That is good to me, too.
