Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B41E1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 19:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932760AbcLATU7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 14:20:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:50027 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932662AbcLATU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 14:20:58 -0500
Received: (qmail 10615 invoked by uid 109); 1 Dec 2016 19:20:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 19:20:57 +0000
Received: (qmail 2299 invoked by uid 111); 1 Dec 2016 19:21:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 14:21:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 14:20:55 -0500
Date:   Thu, 1 Dec 2016 14:20:55 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: bw/transport-protocol-policy
Message-ID: <20161201192055.44mtvtacyhpbqbqu@sigill.intra.peff.net>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161201083005.dui572o4jxsqacas@sigill.intra.peff.net>
 <20161201181415.GA54082@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161201181415.GA54082@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 10:14:15AM -0800, Brandon Williams wrote:

> >   1. The new policy config lets you say "only allow this protocol when
> >      the user specifies it". But when http.c calls is_transport_allowed(),
> >      the latter has no idea that we are asking it about potential
> >      redirects (which obviously do _not_ come from the user), and would
> >      erroneously allow them.
> > 
> >      I think this needs fixed before the topic is merged. It's not a
> >      regression, as it only comes into play if you use the new policy
> >      config. But it is a minor security hole in the new feature.
> 
> I agree and it should be an easy fix.  We can just add a parameter like
> so:
> 
> diff --git a/transport.c b/transport.c
> index 2c0ec76..d38d50f 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -723,7 +723,7 @@ static enum protocol_allow_config get_protocol_config(const char *type)
>  	return PROTOCOL_ALLOW_USER_ONLY;
>  }
>  
> -int is_transport_allowed(const char *type)
> +int is_transport_allowed(const char *type, int redirect)
>  {
>  	const struct string_list *whitelist = protocol_whitelist();
>  	if (whitelist)
> @@ -735,7 +735,7 @@ int is_transport_allowed(const char *type)
>  	case PROTOCOL_ALLOW_NEVER:
>  		return 0;
>  	case PROTOCOL_ALLOW_USER_ONLY:
> -		return git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
> +		return git_env_bool("GIT_PROTOCOL_FROM_USER", !redirect);
>  	}
>  
>  	die("BUG: invalid protocol_allow_config type");
> 
> That way the libcurl code can say it is asking if it is ok to redirect
> to that protocol.

I wouldn't expect anyone to ever set GIT_PROTOCOL_FROM_USER=1, but it
does behave in a funny way here, overriding the "redirect" flag. I think
we'd want something more like:

  if (redirect < 0)
	redirect = git_env_bool("GIT_PROTOCOL_FROM_USER", 1);

and then pass in "-1" from transport_check_allowed().

I think that's sufficient to fix the topic as-is. However, the http
redirect series adds an extra complication, because with http-alternates
we resolve some of the redirects ourselves. So in those cases we'd want
to restrict CURLOPT_PROTOCOLS as if they were redirects. We may need to
set up two CURLOPT values: ones from the user and ones from redirects,
and then feed them to CURLOPT_PROTOCOLS and CURLOPT_REDIR_PROTOCOLS as
appropriate depending on the request context.

> We should switch to warning all the time since this series adds in
> default whitelisted/blacklisted protocols anyways.

Yeah, good point. As a bonus it makes the code simpler.

-Peff
