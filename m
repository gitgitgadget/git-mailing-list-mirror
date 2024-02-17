Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6087014AAD
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 05:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708147776; cv=none; b=VdOo+0rxsdHhytjoSSJYIjH7FVDm0+NblEm4QiYFtAQZefYA188INH+2S92LII2tFwozsBlvOIxVKWXwXmIc2a2a5/mTRbDERiO8spnWyceVdDpi6vAw6UvZ5ulMl3eToiyoHMIrKkthRmfHquHJ2B1WyJ/JYuCDaaNFNnLRfp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708147776; c=relaxed/simple;
	bh=m0YXx9kqP0JNrXwKuJZbwkdHHhUmTPC/TmZsuIFA76k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra4m/RzhAUySj8QBZoSe+wKtUuZqIYBkhrxq5D6uVh6ryfcUrFISsMvwYwdwJUfZjL3LNo1FV07LOjRrDXdiuBbGnmPgeIUOqWhibh1/V0yUWZ08EY6M6tMHFhqMjitzzr/Edy8PtD//rNBS955tBXRBw4ukKMejPpC9i1lA25Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2255 invoked by uid 109); 17 Feb 2024 05:29:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Feb 2024 05:29:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20775 invoked by uid 111); 17 Feb 2024 05:29:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Feb 2024 00:29:37 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Feb 2024 00:29:32 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git: --no-lazy-fetch option
Message-ID: <20240217052932.GC539459@coredump.intra.peff.net>
References: <xmqq1q9mmtpw.fsf@gitster.g>
 <20240215053056.GD2821179@coredump.intra.peff.net>
 <xmqqv86pslos.fsf@gitster.g>
 <xmqq1q9cl3xv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1q9cl3xv.fsf@gitster.g>

On Fri, Feb 16, 2024 at 09:22:20AM -0800, Junio C Hamano wrote:

> Here is a preliminary clean-up only for Documentation.  Will not be
> queuing before the final, but just so that I won't forget.

I think this is an improvement, but two small comments...

> ------- >8 ------------- >8 ------------- >8 -------
> Subject: [PATCH] git: document GIT_NO_REPLACE_OBJECTS environment variable
> 
> This variable is used as the primary way to disable the object
> replacement mechanism, with the "--no-replace-objects" command line
> option as an end-user visible way to set it, but has not been
> documented.
> 
> The original reason why it was left undocumented might be because it
> was meant as an internal implementation detail, but the thing is,
> that our tests use the environment variable directly without the
> command line option, and there certainly are folks who learned its
> use from there, making it impossible to deprecate or change its
> behaviour by now.

I agree that we should document these sorts of variables; they really
are part of the public interface since it's so easy for users to see
them in their own scripts, aliases, etc, when we set them.

But in fact do document this environment variable in git-replace(1), and
have for a long time. So I don't think we need to even make claims about
its undocumented state. :)

>  --no-replace-objects::
> -	Do not use replacement refs to replace Git objects. See
> -	linkgit:git-replace[1] for more information.
> +	Do not use replacement refs to replace Git objects.
> +	This is equivalent to exporting the `GIT_NO_REPLACE_OBJECTS`
> +	environment variable with any value.
> +	See linkgit:git-replace[1] for more information.

The text both before and after your patch links to git-replace, which
covers the variable. So I think the "before" state is actually not that
bad. But I still think mentioning it explicitly is better still.

However, should it get an entry in the "ENVIRONMENT VARIABLES" section?
We cover stuff there like GIT_LITERAL_PATHSPECS, which is triggered in
the same way.

> Add documentation and note that for this variable, unlike many
> boolean-looking environment variables, only the presence matters,
> not what value it is set to.

Yuck. IMHO depending on GIT_NO_REPLACE_OBJECTS=0 is somewhat crazy, and
we could consider the current behavior a bug. It's probably not _that_
big a deal either way (because I would not expect anybody to set it that
way in the first place). But I wonder if being consistent across
variables trumps retaining weird historical compatibility for such a
far-fetched case. I dunno. I guess this is https://xkcd.com/1172/. :)

-Peff
