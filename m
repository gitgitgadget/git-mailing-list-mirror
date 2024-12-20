Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2017B401
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734680483; cv=none; b=H2Xgu+GkaqUB9b+KfIW37Tn0ONsoX44U51NcqG5ydYwRfVQ9g4oRjW+ZSOQ2a4DHBhsI0YZWHmBt6KTC6DTbgGeUgzw+0JoWV/gUcYdNGhviokEmfszkh69Qd79m7mk9WgskRcg+KecixwXL/fRtSvKBHfNaZUO4caru7+WB58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734680483; c=relaxed/simple;
	bh=JtWND20vtSqMzSdp3MCXhsNKV/OSbhDCgay5itnKH3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joHbkmffW7WRuw+JJr13jATa0vo829QcrVKYCcOeJQoaWQ2trFlGVYLPI8Ce38Uy01i/pyz6KycAUwy2MicytJDkPt4HP2CoZn5hmJ7Te+9afaGD2k212PxN8i7s9nJU5t8Mf2RUtRfGuXJrzbJvateWLv2TQr2Xg8mKvO3jbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JTDfjGoT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JTDfjGoT"
Received: (qmail 7166 invoked by uid 109); 20 Dec 2024 07:34:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=JtWND20vtSqMzSdp3MCXhsNKV/OSbhDCgay5itnKH3s=; b=JTDfjGoTgNmEo7FJXjW3oA0F9jiyh14GS+EfmCSJe52dXswNsx4JOXd+VMIfhnh7HlqXek8pQTlUEaxbQbIZnslg0TEWkHa5rJ3c1THwyNhO5kUszmlQqhEriiK4OEWTJ0rpg4uA00pdNrnneQIhMwxGrUabJT5PR5JoeQZGX+6vIlHFvnfT6e94MkkInXJE5D0NBw+vKXKxXWdE9E6DKAd1v7hEc3albA+hEPm1mqo/6Ne0RkqOGnSUOMSZXfEtpScyGfvJCoClW+lVpqrXHrmPEZYudhZlwnA7lVfSxCfJmug0ecf1U9/L2daKdzSP5AB4gohIeD2HZlotyqwe3g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Dec 2024 07:34:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13760 invoked by uid 111); 20 Dec 2024 07:34:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2024 02:34:37 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Dec 2024 02:34:37 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH 1/2] GIT-VERSION-GEN: fix overriding version via
 environment
Message-ID: <20241220073437.GA2389154@coredump.intra.peff.net>
References: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
 <20241219-b4-pks-git-version-via-environment-v1-1-9393af058240@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241219-b4-pks-git-version-via-environment-v1-1-9393af058240@pks.im>

On Thu, Dec 19, 2024 at 04:53:36PM +0100, Patrick Steinhardt wrote:

> But that subtle mechanism broke with 4838deab65 (Makefile: refactor
> GIT-VERSION-GEN to be reusable, 2024-12-06) and subsequent commits
> because the version information is not propagated via the Makefile
> variable anymore, but instead via the files that `GIT-VERSION-GEN`
> started to write. And as the script never knew about the `GIT_VERSION`
> environment variable in the first place it uses one of the values listed
> above instead of the overridden value.
> 
> Fix this issue by making `GIT-VERSION-GEN` handle the case where
> `GIT_VERSION` has been set via the environment.

I think this is the right direction, but there are two subtleties we
might want to address. The first is that you are adjusting $VN and not
$GIT_VERSION itself:

> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index de0e63bdfbac263884e2ea328cc2ef11ace7a238..787c6cfd04f0a43d0c1c8a6690185d26ccf2fc2f 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -29,7 +29,10 @@ export GIT_CEILING_DIRECTORIES
>  
>  # First see if there is a version file (included in release tarballs),
>  # then try git-describe, then default.
> -if test -f "$SOURCE_DIR"/version
> +if test -n "$GIT_VERSION"
> +then
> +    VN="$GIT_VERSION"
> +elif test -f "$SOURCE_DIR"/version
>  then
>  	VN=$(cat "$SOURCE_DIR"/version) || VN="$DEF_VER"
>  elif {

Later we process $VN into $GIT_VERSION, but after removing the leading
"v" (which would usually be there from the tag name):

  GIT_VERSION=$(expr "$VN" : v*'\(.*\)')

So if I do:

  make GIT_VERSION=very-special

with v2.47 I'd end up with the version "very-special". But after your
patch, it is "ery-special".

I'd guess it's unlikely to come up in practice, but if we are trying to
restore the old behavior, that's one difference.


The second is that the value is read from the environment, but make will
not always put its variables into the environment. Ones given on the
command line are, so:

  make GIT_VERSION=foo

works as before. But:

  echo 'GIT_VERSION = foo' >config.mak
  make

will not, as the variable isn't set in the environment. The invocation
of GIT-VERSION-GEN already passes along GIT_USER_AGENT explicitly:

  version-def.h: version-def.h.in GIT-VERSION-GEN GIT-VERSION-FILE GIT-USER-AGENT
          $(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" $< $@+
          @if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi

Should we do the same thing for GIT_VERSION? And GIT_DATE, etc? If we're
going to do many of these, it might also be easier to just add "export
GIT_VERSION", etc, in the Makefile.

-Peff

PS I don't know if meson.build would need something similar. It does not
   even pass through GIT_USER_AGENT now.
