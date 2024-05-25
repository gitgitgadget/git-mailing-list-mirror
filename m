Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F652F3B
	for <git@vger.kernel.org>; Sat, 25 May 2024 04:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716611631; cv=none; b=cR4tooC0u1cmy7yJ6Ji+3BQI65d2LcGhdqTWIayadfXX9POmyhfygPgC+jrh4JMD+qjB1+IWXoepofcwU9uGhxhMMemNwDqccl2/mb5VzQJ/SfCgNMbHaLEMs8CwS1r9ps1PfrKMATbSFjoD3MD3Ly2uuQsAnQNUGB4CsxdCRUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716611631; c=relaxed/simple;
	bh=gJ+acl6op6tMLN36XoRz97Jy1Qn6T+mPfJGFwtr3bnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnLsxbCSOTz7KVpdcFcl8J8CgxD4d6LQ3mn330+jPsO/oj2h9eHmBOKqIeV8qEGF0ZtupIoR0gZnGjI+Id+FvgrEieARkkd5EfxgH+HhRuoLrocMhLM005TrtptPKVdJbqu+cPC8EFBLowEQT4ovSywFImMo70YVsb8RV/pwTsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3991 invoked by uid 109); 25 May 2024 04:33:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 May 2024 04:33:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15875 invoked by uid 111); 25 May 2024 04:33:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 May 2024 00:33:51 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 25 May 2024 00:33:47 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/21] config: plug various memory leaks
Message-ID: <20240525043347.GA1895047@coredump.intra.peff.net>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
 <70e8e2651306e9d221e5e472720a7610947580a7.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70e8e2651306e9d221e5e472720a7610947580a7.1716541556.git.ps@pks.im>

On Fri, May 24, 2024 at 12:04:12PM +0200, Patrick Steinhardt wrote:

> diff --git a/alias.c b/alias.c
> index 269892c356..4daafd9bda 100644
> --- a/alias.c
> +++ b/alias.c
> @@ -21,9 +21,11 @@ static int config_alias_cb(const char *key, const char *value,
>  		return 0;
>  
>  	if (data->alias) {
> -		if (!strcasecmp(p, data->alias))
> +		if (!strcasecmp(p, data->alias)) {
> +			FREE_AND_NULL(data->v);
>  			return git_config_string(&data->v,
>  						 key, value);
> +		}
>  	} else if (data->list) {
>  		string_list_append(data->list, p);
>  	}

IMHO this should be done automatically by git_config_string(). The
current design is an accident waiting to happen, and in the long run
every call is going to need this FREE_AND_NULL(). By doing it in the
function the calling code is shorter, and there's no way we'll forget.

I posted a series along those lines a month or so ago:

  https://lore.kernel.org/git/20240407005656.GA436890@coredump.intra.peff.net/

The catch is that you can't do this:

  const char *foo = "bar";
  git_config_string(&foo, ...);

So I introduced a new function that took a non-const pointer with the
new behavior, with the idea that we'd eventually migrate everything
over. It looks like you may have already done that migration earlier in
your series, since the move to "char *" in the previous patch was OK.

  Though as a side note, sadly:

    char *foo = "bar";

  does not produce an error or even a warning without -Wwrite-strings. I
  think in the long run we should enable that, but there's a little
  cleanup required to do so.

The main reason I didn't follow up on that earlier series is that there
was some discussion about maybe moving this stuff over to strbufs (after
teaching it to handle literal initializers). But if you've managed to
remove all of the cases that needed that, I think just sticking with
"char *" is fine.

The other issue raised in that thread is that many of these config
variables are also passed to parse-options, which treats them as const
strings (and we get no compiler support because it goes through a void
pointer). So they may leak if we overwrite them, or in the unusual case
that we load config after parsing options, we may try to free a non-heap
string. The one we discussed was log's signature_file, and it looks like
you split that to use two variables, which works. Junio suggested an
OPT_FILENAME_DUP() option, which I'm also OK with. The main challenge to
me is being sure we found all such spots (and not accidentally
introducing new ones). But I don't have a good solution there.

> @@ -1566,7 +1569,7 @@ static int git_default_core_config(const char *var, const char *value,
>  
>  	if (!strcmp(var, "core.checkroundtripencoding")) {
>  		FREE_AND_NULL(check_roundtrip_encoding);
> -		return git_config_string((const char **) &check_roundtrip_encoding, var, value);
> +		return git_config_string(&check_roundtrip_encoding, var, value);
>  	}

This should have lost its cast in the previous commit, no? Applying up
to patch 12 and building with DEVELOPER=1 gets a warning.

-Peff
