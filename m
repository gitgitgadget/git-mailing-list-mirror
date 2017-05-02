Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34F38207D6
	for <e@80x24.org>; Tue,  2 May 2017 02:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750872AbdEBC43 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 22:56:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:43590 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750831AbdEBC43 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 22:56:29 -0400
Received: (qmail 15805 invoked by uid 109); 2 May 2017 02:56:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 May 2017 02:56:26 +0000
Received: (qmail 8682 invoked by uid 111); 2 May 2017 02:56:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 22:56:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 May 2017 22:56:23 -0400
Date:   Mon, 1 May 2017 22:56:23 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: handle empty config values in -c
Message-ID: <20170502025623.jhs4hyiy6gc5sv7y@sigill.intra.peff.net>
References: <20170502000515.GU28740@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170502000515.GU28740@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 01, 2017 at 05:05:15PM -0700, Jonathan Nieder wrote:

> "git clone --config" uses the following incantation to add an item to
> a config file, instead of replacing an existing value:
> 
> 	git_config_set_multivar_gently(key, value, "^$", 0)
> 
> As long as no existing value matches the regex ^$, that works as
> intended and adds to the config.  When a value is empty, though, it
> replaces the existing value.
> [...]
> ---
> Thoughts?

Yeah, I think this is the exact reason we introduced CONFIG_REGEX_NONE
in the first place. At the time we fixed "config --add", but "clone -c"
needs the same treatment.

Grepping around, it looks like we should probably be using this in other
places, too:

  - writing fetch refspecs in clone

  - throughout remote.c for urls and refspecs

I don't think an empty variable has meaning in those places, so probably
nobody really cares. But passing CONFIG_REGEX_NONE seems to better match
the original intent. And in the long run I think we probably ought to
make an empty "remote.foo.url" mean "reset the url list to empty", as
we've started to do with other multivars (like credential helpers).

So your patch looks fine, but I'd be pleased if you wanted to take it
further and eradicate this "^$" anti-pattern through the code base.

-Peff

PS I notice that the documentation for "config --add" explicitly
   mentions that it behaves like "^$". This isn't accurate anymore. We
   should probably update that. I wondered if callers of git-config
   would need some way to specify "--replace-all --no-value" or
   something, but that is precisely what "--add" is. So I think it's
   just a documentation problem.
