Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1569320188
	for <e@80x24.org>; Fri, 12 May 2017 08:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755224AbdELIbi (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 04:31:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:50185 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752111AbdELIbh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 04:31:37 -0400
Received: (qmail 1143 invoked by uid 109); 12 May 2017 08:31:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 08:31:32 +0000
Received: (qmail 22139 invoked by uid 111); 12 May 2017 08:32:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 04:32:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 04:31:31 -0400
Date:   Fri, 12 May 2017 04:31:31 -0400
From:   Jeff King <peff@peff.net>
To:     Brian Malehorn <bmalehorn@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] mailinfo.c: is_scissors_line ends on newline
Message-ID: <20170512083131.nb5zyurmeg6n5auo@sigill.intra.peff.net>
References: <20170512050347.30765-1-bmalehorn@gmail.com>
 <20170512050347.30765-2-bmalehorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170512050347.30765-2-bmalehorn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 10:03:45PM -0700, Brian Malehorn wrote:

> Needed to work with git interpret-trailers. Since "line" is, of course,
> a line, it will always end with "\n\0" and therefore we can safely end
> on "\n".
> [...]
> -	for (c = line; *c; c++) {
> +	for (c = line; *c != '\n'; c++) {
>  		if (isspace(*c)) {

Hrm. So I don't think this is _wrong_ per se, but the first thing we do
in the loop is check isspace(), which a newline should match. And you
can't see it from the diff context, but it always hits a continue, which
would then advance to the NUL and exit the loop.

So I'm puzzled why this change is necessary. Am I missing something?
We would increase the gap and perforation if we're in them, so I guess
it could have an impact on the line-length heuristics that come at the
end of the function. Is that it?

-Peff
