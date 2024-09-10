Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0493213A242
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952345; cv=none; b=ZEfQQozgzPxlQOxuEFABqh7FWLtcfMjYlFSlWAaGvlIaktJVzrEAjSz7kUbSjj8c0Tn/ddDCsacRGTtG9ap1h8V5wAFfSYKogsWEMgrx6dn2xJFQUmmVxrFVG1Aso0VW9s14vYLSMjOW1tGxbGmI4lCepNU2GxdxfkC5KH1Nlig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952345; c=relaxed/simple;
	bh=+X3cdi29mgkl8A+1DozHrbRNwklS4vTe/vP3a6Q95HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzvHzvcNBlzADJYDw24QPY1FZNvf934SxtiouTE6yBLRpkFa90QGDPUI8Foc1q/TtGL59cyGy9dfV+xBABveGS/bK495WTZbySWa9mEe8cTVL18vLBv3dFgQwNM636B97RwSxbw4a+AjrKokvbvP8PuuvlejgFxCFIcMvUxjqGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3440 invoked by uid 109); 10 Sep 2024 07:12:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Sep 2024 07:12:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29384 invoked by uid 111); 10 Sep 2024 07:12:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Sep 2024 03:12:22 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Sep 2024 03:12:22 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Brooke Kuhlmann <brooke@alchemists.io>
Subject: Re: [PATCH 10/9] ref-filter: fix leak with unterminated %(if) atoms
Message-ID: <20240910071222.GA1466029@coredump.intra.peff.net>
References: <20240909230758.GA921697@coredump.intra.peff.net>
 <4faf815b780218769520561ecf3abca384a2ee6c.1725951400.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4faf815b780218769520561ecf3abca384a2ee6c.1725951400.git.ps@pks.im>

On Tue, Sep 10, 2024 at 08:57:15AM +0200, Patrick Steinhardt wrote:

> When parsing `%(if)` atoms we expect a few other atoms to exist to
> complete it, like `%(then)` and `%(end)`. Whether or not we have seen
> these other atoms is tracked in an allocated `if_then_else` structure,
> which gets free'd by the `if_then_else_handler()` once we have parsed
> the complete conditional expression.
> 
> This results in a memory leak when the `%(if)` atom is not terminated
> correctly and thus incomplete. We never end up executing its handler and
> thus don't end up freeing the structure.
> 
> Plug this memory leak by introducing a new `at_end_data_free` callback
> function. If set, we'll execute it in `pop_stack_element()` and pass it
> the `at_end_data` variable with the intent to free its state. Wire it up
> for the `%(if)` atom accordingly.

Ah, thanks for explaining. The patch makes much more sense now. :)

In particular, this:

> @@ -1169,6 +1170,8 @@ static void pop_stack_element(struct ref_formatting_stack **stack)
>  	if (prev)
>  		strbuf_addbuf(&prev->output, &current->output);
>  	strbuf_release(&current->output);
> +	if (current->at_end_data_free)
> +		current->at_end_data_free(current->at_end_data);
>  	free(current);
>  	*stack = prev;
>  }

which frees on pop, replaces the manual:

> @@ -1228,15 +1231,13 @@ static void if_then_else_handler(struct ref_formatting_stack **stack)
>  	}
>  
>  	*stack = cur;
> -	free(if_then_else);
>  }

free that was happening in the success case.

I think putting this on top of my series makes sense.

-Peff
