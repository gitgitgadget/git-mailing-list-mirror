Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB4F1D86F1
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 22:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733093052; cv=none; b=WjxQrbm6SyNNUcUxqIjQgt9pRE7RkURUGeZoWASlWLyRNeuQsfxrqMWxRKzkuoSa9InAfYfADYnfQTbeGUMXzcL49VSZpvoOjKc4YYmcPJNIPr4yTQlRoc3FmbrEYu1YNjV1dvGAHH+CSnyWqM9ikqJEV5c/9t80v3awXKjI7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733093052; c=relaxed/simple;
	bh=wEQgS0CMVfMRk2NSR9Z3uzWdFun+DBT8Y7xjR0mAx1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0/TjhX/QZcWm0GbL6Rn53ZoAuRTgrB2wlZhGu2PW11CwP7F2mRe4C/uS8pWWHtQh2LgM+v8/IWRw/N0E7wFerQANplzc6g0w3hdn0i3KCqKwZssJyEgtiTFcbriBzazDHfIDcHQn+eEl1gVaoQrsRq7pt3AEeuorVgn0uY4iws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PomERZz6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PomERZz6"
Received: (qmail 4512 invoked by uid 109); 1 Dec 2024 22:44:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wEQgS0CMVfMRk2NSR9Z3uzWdFun+DBT8Y7xjR0mAx1w=; b=PomERZz6aZ4PBQildPibJ5JN6mUbnDoU/7V7uKxHB/3RMX99R606ns6j01CC5rlYRpgwtrve/HOs4NGTjFbCHsd8rTPW65aiPFg8MvfRLQE9ZzH1vTY92ZiGQpJTnY+g+cNNq1B5odMmoTx6gmc7ZBrJ4SRohTny/evtNajNhNxZ1CVPw9PxhQLy21kbyNFGtDit8qdHCyN1Hc/gcsLUDrgiDwj/is6nM6JjwojG4dKrPmaMav6c/ELjZ6vH8FsI15McnlNq4CvRXvhOvWjTPhI+WoohxaJFYkmrSaFErZ8r3P/xET7L7kJYU5hGJRO+LwJ5NQI9FMIWz65NrlijFw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 01 Dec 2024 22:44:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14808 invoked by uid 111); 1 Dec 2024 22:44:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 01 Dec 2024 17:44:09 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 1 Dec 2024 17:44:08 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@jowil.de, git@vger.kernel.org
Subject: Re: git tag -a HEAD leads to ambiguous branch name
Message-ID: <20241201224408.GJ145938@coredump.intra.peff.net>
References: <47cdf937-6192-4c83-a0e5-700e98f36c1e@jowil.de>
 <20241127142711.GB1712@coredump.intra.peff.net>
 <xmqqh67ss1a5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh67ss1a5.fsf@gitster.g>

On Thu, Nov 28, 2024 at 08:30:10AM +0900, Junio C Hamano wrote:

> diff --git c/builtin/tag.c w/builtin/tag.c
> index 93d10d5915..c91aba5e26 100644
> --- c/builtin/tag.c
> +++ w/builtin/tag.c
> @@ -449,7 +449,7 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
>  
>  static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
>  {
> -	if (name[0] == '-')
> +	if (name[0] == '-' || !strcmp(name, "HEAD"))
>  		return -1;
>  
>  	strbuf_reset(sb);
> 
> but this (together with what "git branch" uses) is unsatisfactory
> for at least two reasons.
> 
>  - This helper function and object-name.c:strbuf_check_branch_ref()
>    should not be named with "strbuf_" prefix. 

Agreed here.

>  - The right place to do these checks is check_refname_format(), but
>    it would retroactively forbid porcelains from using HEAD as the
>    name of a branch or a tag (which is technically allowed, but it
>    is dubious anybody wants to do so because it is so cumbersome to
>    use).

But I don't know about this. I thought when we outlawed "git branch
HEAD" that it was quite intentional _not_ to forbid these names at the
lowest level in order to retain backwards compatibility. They are just
about preventing common UI mistakes.

I'm OK with revisiting that decision, but:

  1. I think it's orthogonal to adding a similar UI-level check for
     git-tag.

  2. We'd probably need some deprecation period or breaking-changes
     moment to do the switch.

> There is a dubious test in t5604 that expects you can create such a
> tag.  t5604.22 wants to create one:
> 
> test_expect_success 'clone with reference from a tagged repository' '
> 	(
> 		cd A && git tag -a -m tagged HEAD
> 	) &&
> 	git clone --reference=A A I
> '
> 
> and t5604.24 wants to use it.

Weird. Comes from 09116a1c31 (refs: loosen over-strict "format" check,
2011-11-16). I don't see any reason it could not just be "foo".

-Peff
