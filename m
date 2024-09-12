Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8551A0BF3
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139941; cv=none; b=mQuMdAhf/1pooxVURUk0j1tsLzviXRnDW8lKpXdctM/i2r3jZW59OAwfvCGhYt+c+xmqOA6cT8i3n23pUIgUKz6IF/409USfxc1ETxn78/5xQBl+HZ9iR36bB4Iwj9hXKVphFJY2RVsiqbQDdttRd42AvLf12NbZioILpRuNcw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139941; c=relaxed/simple;
	bh=LWutX4vsvR0fWvxwkFHyYNFMlIrU73fm8FUt+o2b4+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYvKqwDTdQ/J8+6+L53cDsGvnxFa4oVvYr0ltqVhSgylkj31hyTJ8DtxM61uckBp5oKayGLwfLUuneefntzc/OvKGI/KORLrvXtatbioJi4b/jMmpQA9Lvp57cwb+5y36KxlGxvsEnKXaAKP/5sf2z4C8ddz0wL7Te8Cqs4BAYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17658 invoked by uid 109); 12 Sep 2024 11:18:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Sep 2024 11:18:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24845 invoked by uid 111); 12 Sep 2024 11:18:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2024 07:18:58 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Sep 2024 07:18:58 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brooke Kuhlmann <brooke@alchemists.io>
Subject: Re: [PATCH 10/9] ref-filter: fix leak with unterminated %(if) atoms
Message-ID: <20240912111858.GA617985@coredump.intra.peff.net>
References: <20240909230758.GA921697@coredump.intra.peff.net>
 <4faf815b780218769520561ecf3abca384a2ee6c.1725951400.git.ps@pks.im>
 <xmqqseu7jvz3.fsf@gitster.g>
 <ZuLA0SBqhBbBdcd1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZuLA0SBqhBbBdcd1@pks.im>

On Thu, Sep 12, 2024 at 12:22:16PM +0200, Patrick Steinhardt wrote:

> > diff --git c/ref-filter.c w/ref-filter.c
> > index b06e18a569..d2040f5047 100644
> > --- c/ref-filter.c
> > +++ w/ref-filter.c
> > @@ -3471,7 +3471,8 @@ int format_ref_array_item(struct ref_array_item *info,
> >  		}
> >  	}
> >  	if (state.stack->prev) {
> > -		pop_stack_element(&state.stack);
> > +		while (state.stack->prev)
> > +			pop_stack_element(&state.stack);
> >  		return strbuf_addf_ret(error_buf, -1, _("format: %%(end) atom missing"));
> >  	}
> >  	strbuf_addbuf(final_buf, &state.stack->output);
> 
> Hm. It certainly feels like we should do that. I couldn't construct a
> test case that fails with the leak sanitizer though. If it's a leak I'm
> sure I'll eventually hit it when I continue down the road headed towards
> leak-free-ness.

Hmm. I think just:

  ./git for-each-ref --format='%(if)%(then)%(if)%(then)%(if)%(then)'

should trigger it, and running it in the debugger I can see that we exit
the function with multiple entries.

Valgrind claims the memory is still reachable, but I don't see how. The
"state" variable is accessible only inside that function. The only thing
we do after returning is die(). I wonder if it is a false negative
because the stack is left undisturbed (especially because the compiler
knows that die() does not return).

At any rate, I think the same would apply to the earlier error returns:

diff --git a/ref-filter.c b/ref-filter.c
index b06e18a569..a339f0ab0f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3454,7 +3454,8 @@ int format_ref_array_item(struct ref_array_item *info,
 		pos = parse_ref_filter_atom(format, sp + 2, ep, error_buf);
 		if (pos < 0 || get_ref_atom_value(info, pos, &atomv, error_buf) ||
 		    atomv->handler(atomv, &state, error_buf)) {
-			pop_stack_element(&state.stack);
+			while (state.stack->prev)
+				pop_stack_element(&state.stack);
 			return -1;
 		}
 	}
@@ -3466,7 +3467,8 @@ int format_ref_array_item(struct ref_array_item *info,
 		struct atom_value resetv = ATOM_VALUE_INIT;
 		resetv.s = GIT_COLOR_RESET;
 		if (append_atom(&resetv, &state, error_buf)) {
-			pop_stack_element(&state.stack);
+			while (state.stack->prev)
+				pop_stack_element(&state.stack);
 			return -1;
 		}
 	}

I wasn't sure why the non-error code path wouldn't need the same, but it
looks like there's some popping that happens in the various callbacks?
I'm not very familiar with this code, and it's hard to follow the flow
through the function pointers.

All that said, I am content to leave it for now. Even if it's a real
leak, it's one that happens once per program right before exiting with
an error. Most of the value in cleaning up trivial leaks like that are
to reduce the noise from analyzers so that we can find the much more
important leaks that scale with the input. If the analyzers aren't
complaining and we think it's trivial, it may not be worth spending a
lot of time on.

-Peff
