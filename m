Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3D89207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 10:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2998571AbdDZKpa (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 06:45:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:40425 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2998448AbdDZKp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 06:45:29 -0400
Received: (qmail 8737 invoked by uid 109); 26 Apr 2017 10:45:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Apr 2017 10:45:13 +0000
Received: (qmail 4936 invoked by uid 111); 26 Apr 2017 10:45:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Apr 2017 06:45:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Apr 2017 06:45:11 -0400
Date:   Wed, 26 Apr 2017 06:45:11 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 1/9] rebase -i: generate the script via rebase--helper
Message-ID: <20170426104511.nuk3fcxofhrtxsma@sigill.intra.peff.net>
References: <cover.1472833365.git.johannes.schindelin@gmx.de>
 <cover.1493128210.git.johannes.schindelin@gmx.de>
 <361682a84f421ff16a8c6b7120f132cd6b61f1fa.1493128210.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <361682a84f421ff16a8c6b7120f132cd6b61f1fa.1493128210.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 03:51:49PM +0200, Johannes Schindelin wrote:

> --- a/sequencer.c
> +++ b/sequencer.c
> [...]
> +int sequencer_make_script(int keep_empty, FILE *out,
> +		int argc, const char **argv)
> +{
> +	char *format = "%s";

I'm surprised the compiler doesn't complain about assigning a string
literal to a non-const pointer. It makes me worried that we would call
free() on it later. We don't, but that means...

> +	git_config_get_string("rebase.instructionFormat", &format);

...that this assignment to "format" leaks.

So perhaps you'd want to xstrdup the literal, and then make sure the
result is freed? Or alternatively use an extra level of indirection (a
to_free pointer to store the config value, and then a const pointer for
"format").

-Peff
