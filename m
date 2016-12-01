Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2730D1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 19:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933977AbcLATuf (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 14:50:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:50082 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932479AbcLATue (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 14:50:34 -0500
Received: (qmail 12404 invoked by uid 109); 1 Dec 2016 19:50:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 19:50:34 +0000
Received: (qmail 2816 invoked by uid 111); 1 Dec 2016 19:51:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 14:51:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 14:50:31 -0500
Date:   Thu, 1 Dec 2016 14:50:31 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v6 4/4] transport: check if protocol can be used on a
 redirect
Message-ID: <20161201195031.fd4uwmvkyhk4so7i@sigill.intra.peff.net>
References: <1478555462-132573-1-git-send-email-bmwill@google.com>
 <1480621447-52399-1-git-send-email-bmwill@google.com>
 <1480621447-52399-5-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1480621447-52399-5-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 11:44:07AM -0800, Brandon Williams wrote:

> Add a the 'redirect' parameter to 'is_transport_allowed' which allows
> callers to query if a transport protocol can be used on a redirect.

s/a the/a/

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

This has the older logic still.

I'm not sure if we should call this "redirect" here. That's how it's
used by the curl code, but I think from the perspective of the transport
whitelist, it is really "are you overriding the from_user environment".

Calling it "from_user" may be confusing though, as the default value
would become "1", even though it means only "as far as I know this is
from the user, but maybe the environment says otherwise". So bizarrely,
I think calling it "not_from_user" is the clearest value.

-Peff
