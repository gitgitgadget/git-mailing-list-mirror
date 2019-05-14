Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C0541F461
	for <e@80x24.org>; Tue, 14 May 2019 12:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfENMQy (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 08:16:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:56846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725893AbfENMQy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 08:16:54 -0400
Received: (qmail 4314 invoked by uid 109); 14 May 2019 12:16:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 May 2019 12:16:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12443 invoked by uid 111); 14 May 2019 12:17:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 08:17:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 08:16:52 -0400
Date:   Tue, 14 May 2019 08:16:52 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
Subject: Re: some git confusion (where git's advice didn't help)
Message-ID: <20190514121651.GA27276@sigill.intra.peff.net>
References: <5CDA9063020000A10003131D@gwsmtp.uni-regensburg.de>
 <20190514112115.GA26957@sigill.intra.peff.net>
 <20190514112941.GA23603@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514112941.GA23603@ash>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 06:29:41PM +0700, Duy Nguyen wrote:

> On Tue, May 14, 2019 at 07:21:15AM -0400, Jeff King wrote:
> > I also think the "warning: refname ... is ambiguous" message would
> > probably be a bit more helpful if it showed _which_ candidates it found
> > (and which one it chose!).
> 
> Alternatively, just refuse to resolve ambiguous refs. It's not always
> printed in a short output that stands out to you. Something like this
> perhaps.

Yeah, I actually think that would be much better. I'm not really sure if
there's a reason this is only a warning, except for historical inertia.
In most other cases where the meaning is not perfectly clear, we try to
guide the user into disambiguating for us.

> It could probably use some improvements, suggesting the ambiguous
> candidates too. It's just what I've been using for years.

Yes, I still think it would be nice to do that on top, so the user knows
how to reissue their command with the correct name.

>  core.warnAmbiguousRefs::
>  	If true, Git will warn you if the ref name you passed it is ambiguous
> -	and might match multiple refs in the repository. True by default.
> +	and might match multiple refs in the repository. If set to "fatal",
> +	the program will abort on ambiguous refs. True by default.

I actually wonder if we should switch it to "fatal" by default, but that
can be a follow-on. :)

> diff --git a/config.c b/config.c
> index 0f0cdd8c0f..f314caeb87 100644
> --- a/config.c
> +++ b/config.c
> @@ -1158,7 +1158,10 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
>  	}
>  
>  	if (!strcmp(var, "core.warnambiguousrefs")) {
> -		warn_ambiguous_refs = git_config_bool(var, value);
> +		if (!strcasecmp(value, "fatal"))
> +			warn_ambiguous_refs = 2;
> +		else
> +			warn_ambiguous_refs = git_config_bool(var, value);
>  		return 0;
>  	}

I know you mentioned wanting more cleanup, but I think an enum instead
of a magic 2 would be nice here.

> @@ -817,8 +819,12 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
>  
>  	if (warn_ambiguous_refs && !(flags & GET_OID_QUIETLY) &&
>  	    (refs_found > 1 ||
> -	     !get_short_oid(str, len, &tmp_oid, GET_OID_QUIETLY)))
> -		warning(warn_msg, len, str);
> +	     !get_short_oid(str, len, &tmp_oid, GET_OID_QUIETLY))) {
> +		if (warn_ambiguous_refs > 1)
> +			die(warn_msg, len, str);
> +		else
> +			warning(warn_msg, len, str);
> +	}

This case makes sense. They say "foo", and we say "nope, ambiguous", and
they come back and say "heads/foo" or whatever.

But...

> @@ -760,6 +760,8 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
>  				warning(warn_msg, len, str);
>  				if (advice_object_name_warning)
>  					fprintf(stderr, "%s\n", _(object_name_msg));
> +				if (warn_ambiguous_refs > 1)
> +					die(_("cannot continue with ambiguous refs"));
>  			}
>  			free(real_ref);
>  		}

This one is trickier. Here they said "1234abcd..." and we say "by the
way, there is also a refs/heads/1234abcd...". If they really did mean
the object id, there's no syntax to say that.

-Peff
