Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F2EC433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 17:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6CC20671
	for <git@archiver.kernel.org>; Thu, 14 May 2020 17:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgENR4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 13:56:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:46612 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725965AbgENR4s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 13:56:48 -0400
Received: (qmail 16462 invoked by uid 109); 14 May 2020 17:56:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 May 2020 17:56:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3019 invoked by uid 111); 14 May 2020 17:56:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 May 2020 13:56:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 May 2020 13:56:46 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 4/8] builtin/commit-graph.c: extract
 'read_one_commit()'
Message-ID: <20200514175646.GA2430834@coredump.intra.peff.net>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1589407014.git.me@ttaylorr.com>
 <c37e94907b140f3d2e5a44293f2c1faa6d473712.1589407014.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c37e94907b140f3d2e5a44293f2c1faa6d473712.1589407014.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 03:59:41PM -0600, Taylor Blau wrote:

> @@ -209,44 +220,35 @@ static int graph_write(int argc, const char **argv)
>  		return 0;
>  	}
>  
> -	string_list_init(&lines, 0);
> -	if (opts.stdin_packs || opts.stdin_commits) {
> -		struct strbuf buf = STRBUF_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	if (opts.stdin_packs) {

This is a decl-after-statement, isn't it? It should fail with
DEVELOPER=1.

The strbuf could be local in each block of the conditional, though that
makes your cleanup label trickier. Only the stdin_commits side needs to
clean up the buf, so we could just do it there. Or I'd be OK with having
the strbuf declared at the top of the function, and using the
whole-function cleanup label.

-Peff
