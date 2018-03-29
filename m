Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A423A1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 21:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeC2Vul (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 17:50:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:48050 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750735AbeC2Vuk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 17:50:40 -0400
Received: (qmail 29797 invoked by uid 109); 29 Mar 2018 21:50:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Mar 2018 21:50:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22850 invoked by uid 111); 29 Mar 2018 21:51:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 29 Mar 2018 17:51:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2018 17:50:38 -0400
Date:   Thu, 29 Mar 2018 17:50:38 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 9/9] git_config_set: reuse empty sections
Message-ID: <20180329215038.GI2939@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <29868fec2606f5f6aa1c5de2928580f2ca24e6e2.1522336130.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29868fec2606f5f6aa1c5de2928580f2ca24e6e2.1522336130.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 05:19:09PM +0200, Johannes Schindelin wrote:

> It can happen quite easily that the last setting in a config section is
> removed, and to avoid confusion when there are comments in the config
> about that section, we keep a lone section header, i.e. an empty
> section.
> 
> The code to add new entries in the config tries to be cute by reusing
> the parsing code that is used to retrieve config settings, but that
> poses the problem that the latter use case does *not* care about empty
> sections, therefore even the former user case won't see them.
> 
> Fix this by introducing a mode where the parser reports also empty
> sections (with a trailing '.' as tell-tale), and then using that when
> adding new config entries.

Heh, so it seems we are partway to the "event-stream" suggestion I made
earlier. I agree this is the right way to approach this problem.

I wondered if we allow keys to end in ".", but it seems that we don't.

> diff --git a/config.c b/config.c
> index eb1e0d335fc..b04c40f76bc 100644
> --- a/config.c
> +++ b/config.c
> @@ -653,13 +653,15 @@ static int get_base_var(struct strbuf *name)
>  	}
>  }
>  
> -static int git_parse_source(config_fn_t fn, void *data)
> +static int git_parse_source(config_fn_t fn, void *data,
> +			    int include_section_headers)

We already have a "struct config_options", but we do a terrible job of
passing it around (since it only impacts the include stuff right now,
and that all gets handled at a very outer level).

Rather than plumb this one int through everywhere, should we add it to
that struct and plumb the struct through?

-Peff
