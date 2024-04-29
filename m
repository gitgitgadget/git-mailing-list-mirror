Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06E2D530
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714373744; cv=none; b=Pf/B9bhGKTTPEJNhcWyUCQwrbxX1rpnMF7Un+LnNV2LpRroZz9PiQHdQ0eufF4mlPepZOzTetZ8SBoVImnxUJiHQJX0RD7h74QQnhzi/Uu5FDCRdfWzqZX1MZF0ILoVijWJxkMxZxkIUSTxy/d6n8fjzScdK+DK/plzxngTX/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714373744; c=relaxed/simple;
	bh=ilVld2nSCNXdI6vmeQMA7wp8qOK2T44L+xynOAMxWJs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZfdcLG74ELpxyimpLeBTC4Y1NGBBqLnORRv7O6zubfRihlLzy7tlAlaCAy1LBHhAw5OiwhODxS0q+D4t9blbEcKQMR7s8wS+ca0go5hLIQpErNKg+z6n/n7/2ngvmmmaqxPl+0qV2eYr6+nVneTjYBYVBeNKM5OlLdaXL4i3FqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=oPQCRBQN; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="oPQCRBQN"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714373738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kn9xWOe9dk7goP5ULo/o6X7Lbw9PHPodNdHa5kzikc4=;
	b=oPQCRBQNs+TI7iBhldiamJ/LClVG3SMrsySRj8huZ80B5+siN6o/+BC6l++8ZXbR9t+++W
	tGSQczL2PiEH73A/sLNusqFQhUzLniIBCAtM+G5CNCfDkSvs+CzDSMGvwCYSGr3XeAxe2U
	GBSA+E+1V6K5XWpMzd5avGqq0mqWDPn1jRpc/o3/omORR152ygHgPlgllGXAuD9APio51E
	L95VwJR4sdinWzKBOTuUBS0VjcXD6xWYzgGotaV1LqdW/lKSzw6445PwU97ZKPXDxxsFoh
	EjV6sd7RljME7o0PICEEp5nVKwGKk7rx+ZFB6W5mxsLZMGp4zrNDX0gevZQF3A==
Date: Mon, 29 Apr 2024 08:55:38 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jeff King <peff@peff.net>
Cc: James Liu <james@jamesliu.io>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] advice: add --no-advice global option
In-Reply-To: <20240429064025.GA2905826@coredump.intra.peff.net>
References: <20240424035857.84583-1-james@jamesliu.io>
 <20240429010925.93205-1-james@jamesliu.io>
 <20240429010925.93205-2-james@jamesliu.io>
 <37512328b1f3db4e8075bdb4beeb8929@manjaro.org>
 <D0WCCOLSMM9K.24BIGLR6EEJI8@jamesliu.io>
 <20240429064025.GA2905826@coredump.intra.peff.net>
Message-ID: <c75dc8184b005161f0b9cd0cd84f7ce2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Jeff,

On 2024-04-29 08:40, Jeff King wrote:
> On Mon, Apr 29, 2024 at 03:01:55PM +1000, James Liu wrote:
> 
>> > >  int advice_enabled(enum advice_type type)
>> > >  {
>> > > -	int enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
>> > > +	int enabled;
>> > > +
>> > > +	if (getenv(GIT_NO_ADVICE))
>> > > +		return 0;
>> >
>> > Huh, I was under impression that having an environment
>> > variable to control this behavior was frowned upon by
>> > Junio? [1]  To me, supporting such a variable would be
>> > a somewhat acceptable risk, [2] but of course it's the
>> > maintainer's opinion that matters most.
>> >
>> > [1] https://lore.kernel.org/git/xmqqfrva3k9j.fsf@gitster.g/
>> > [2] https://lore.kernel.org/git/462de4ec1fb1896fa7f26b3515deca57@manjaro.org/
>> 
>> You're correct. I saw this pattern for a few of the other global CLI
>> options and followed it. I'm unsure what the best alternative for
>> passing this configuration down to the `advice_enabled()` function is.
>> I'd appreciate some guidance here.
> 
> You need an environment variable if you want the command-line option to
> work consistently across commands that spawn external processes. E.g.:
> 
>   git --no-advice fetch --all
> 
> is going to spawn fetch sub-processes under the hood. You'd want them 
> to
> respect --no-advice, too, so we either have to propagate the
> command-line option or use the environment. And when you consider an
> external script like git-foo that runs a bunch of underlying Git
> commands, then propagating becomes too cumbersome and error-prone.

Well described, thanks.  Though, I'm afraid Junio isn't going
to like this new environment variable, but we'll see.

> You should use git_env_bool() to avoid the confusing behavior that
> GIT_NO_ADVICE=false still turns off advice. ;)
> 
> You can also drop the "NO", which helps avoid awkward double negation.
> For example, if you do:
> 
>   if (git_env_bool("GIT_ADVICE", 1))
> 	return 0;
> 
> then leaving that variable unset will act as if it is set to "1", but
> you can still do GIT_ADVICE=0 to suppress it.
> 
> There are some older variables (e.g., GIT_NO_REPLACE_OBJECTS) that made
> this mistake and we are stuck with, but I think we should avoid it for
> newer ones.

Makes sense to me.
