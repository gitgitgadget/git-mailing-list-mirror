Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5BBC20357
	for <e@80x24.org>; Tue, 11 Jul 2017 10:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755693AbdGKKhS (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 06:37:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:36804 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755667AbdGKKhR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 06:37:17 -0400
Received: (qmail 2897 invoked by uid 109); 11 Jul 2017 10:37:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 10:37:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15131 invoked by uid 111); 11 Jul 2017 10:37:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 06:37:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 06:37:15 -0400
Date:   Tue, 11 Jul 2017 06:37:15 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 3/7] git.c: provide setup_auto_pager()
Message-ID: <20170711103715.a4jfbjop227bfuhh@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com>
 <1d639a4c7be5f1c173502f79e85aadd017ef5f7c.1499723297.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d639a4c7be5f1c173502f79e85aadd017ef5f7c.1499723297.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 11:55:16PM +0200, Martin Ågren wrote:

> +void setup_auto_pager(const char *cmd, int def)
> +{
> +	if (use_pager != -1)
> +		return;

I think you probably also want to return early here if pager_in_use()
is true. If a script runs "git tag -l", you wouldn't want to start a new
pager when the outer script has already been paged (either via config,
or via "git -p").

> +	use_pager = check_pager_config(cmd);
> +
> +	if (use_pager == -1) {
> +		struct strbuf buf = STRBUF_INIT;
> +		size_t len;
> +
> +		strbuf_addstr(&buf, cmd);
> +		len = buf.len;
> +		while (use_pager == -1 && len--) {
> +			if (buf.buf[len] == '.') {
> +				strbuf_setlen(&buf, len);
> +				use_pager = check_pager_config(buf.buf);
> +			}
> +		}
> +		strbuf_release(&buf);
> +	}

This looks good. I wondered if we could fold this all into a single
loop, rather than having the extra check_pager_config() beforehand
(which confused me for a half-second at first). But I tried and I don't
think the result ended up any more readable.

-Peff
