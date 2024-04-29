Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65DF10FF
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372829; cv=none; b=s9UIn6OHcPYHfHrxo/AzZBPf0e2Ku1AkxJ9BLL5tDbutdLcMXjB3oZefwmADgq7LMU5e0TKztmHBZfK/NGVHxLlsOu+IBdVN7uK1zB20Z5M7vK7J9OTMqGXH5ciq6V0fxCuoOs07/xlPuOvPO5jOeyWrjq94Y/RiOgvIeUehHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372829; c=relaxed/simple;
	bh=XpluoqclU8XekimkuB2HBdoUOmyFyBY9CMEhFw9O6b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbj8JyIsZj52a91ynsHayX+VQGMkkKXCO3MFIeKFlhkgz06VOoE6yYgUd9OwMEpxFhKSLW0HiD8sXGSpfqkV6iVANO5U/0P3oFMpg4N9nDLnVvji9l/Fr7t4OppGRxmb7WVDI/oFAGBM3O06lzq1A950L7WoDjCm2LInr7Qrlk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18771 invoked by uid 109); 29 Apr 2024 06:40:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Apr 2024 06:40:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26086 invoked by uid 111); 29 Apr 2024 06:40:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Apr 2024 02:40:29 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Apr 2024 02:40:25 -0400
From: Jeff King <peff@peff.net>
To: James Liu <james@jamesliu.io>
Cc: Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] advice: add --no-advice global option
Message-ID: <20240429064025.GA2905826@coredump.intra.peff.net>
References: <20240424035857.84583-1-james@jamesliu.io>
 <20240429010925.93205-1-james@jamesliu.io>
 <20240429010925.93205-2-james@jamesliu.io>
 <37512328b1f3db4e8075bdb4beeb8929@manjaro.org>
 <D0WCCOLSMM9K.24BIGLR6EEJI8@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D0WCCOLSMM9K.24BIGLR6EEJI8@jamesliu.io>

On Mon, Apr 29, 2024 at 03:01:55PM +1000, James Liu wrote:

> > >  int advice_enabled(enum advice_type type)
> > >  {
> > > -	int enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
> > > +	int enabled;
> > > +
> > > +	if (getenv(GIT_NO_ADVICE))
> > > +		return 0;
> >
> > Huh, I was under impression that having an environment
> > variable to control this behavior was frowned upon by
> > Junio? [1]  To me, supporting such a variable would be
> > a somewhat acceptable risk, [2] but of course it's the
> > maintainer's opinion that matters most.
> >
> > [1] https://lore.kernel.org/git/xmqqfrva3k9j.fsf@gitster.g/
> > [2] 
> > https://lore.kernel.org/git/462de4ec1fb1896fa7f26b3515deca57@manjaro.org/
> 
> You're correct. I saw this pattern for a few of the other global CLI
> options and followed it. I'm unsure what the best alternative for
> passing this configuration down to the `advice_enabled()` function is.
> I'd appreciate some guidance here.

You need an environment variable if you want the command-line option to
work consistently across commands that spawn external processes. E.g.:

  git --no-advice fetch --all

is going to spawn fetch sub-processes under the hood. You'd want them to
respect --no-advice, too, so we either have to propagate the
command-line option or use the environment. And when you consider an
external script like git-foo that runs a bunch of underlying Git
commands, then propagating becomes too cumbersome and error-prone.

You should use git_env_bool() to avoid the confusing behavior that
GIT_NO_ADVICE=false still turns off advice. ;)

You can also drop the "NO", which helps avoid awkward double negation.
For example, if you do:

  if (git_env_bool("GIT_ADVICE", 1))
	return 0;

then leaving that variable unset will act as if it is set to "1", but
you can still do GIT_ADVICE=0 to suppress it.

There are some older variables (e.g., GIT_NO_REPLACE_OBJECTS) that made
this mistake and we are stuck with, but I think we should avoid it for
newer ones.

-Peff
