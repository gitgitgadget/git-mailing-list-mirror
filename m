Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7DA21F404
	for <e@80x24.org>; Sat,  3 Mar 2018 04:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750992AbeCCEnl (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 23:43:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:45266 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750892AbeCCEnk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 23:43:40 -0500
Received: (qmail 4033 invoked by uid 109); 3 Mar 2018 04:43:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Mar 2018 04:43:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2968 invoked by uid 111); 3 Mar 2018 04:44:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Mar 2018 23:44:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Mar 2018 23:43:38 -0500
Date:   Fri, 2 Mar 2018 23:43:38 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 13/35] ls-refs: introduce ls-refs server command
Message-ID: <20180303044338.GD27689@sigill.intra.peff.net>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-14-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228232252.102167-14-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 03:22:30PM -0800, Brandon Williams wrote:

> +static void add_pattern(struct pattern_list *patterns, const char *pattern)
> +{
> +	struct ref_pattern p;
> +	const char *wildcard;
> +
> +	p.pattern = strdup(pattern);

xstrdup?

> +	wildcard = strchr(pattern, '*');
> +	if (wildcard) {
> +		p.wildcard_pos = wildcard - pattern;
> +	} else {
> +		p.wildcard_pos = -1;
> +	}

Hmm, so this would accept stuff like "refs/heads/*/foo" but quietly
ignore the "/foo" part.

It also accepts "refs/h*" to get "refs/heads" and "refs/hello".  I think
it's worth going for the most-restrictive thing to start with, since
that enables a lot more server operations without worrying about
breaking compatibility.

-Peff
