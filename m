Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D82731F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 12:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbcHOMC2 (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 08:02:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:55331 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752684AbcHOMC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 08:02:27 -0400
Received: (qmail 12202 invoked by uid 109); 15 Aug 2016 12:02:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 12:02:26 +0000
Received: (qmail 13560 invoked by uid 111); 15 Aug 2016 12:02:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 08:02:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 08:02:23 -0400
Date:	Mon, 15 Aug 2016 08:02:23 -0400
From:	Jeff King <peff@peff.net>
To:	Christian Hesse <list@eworm.de>
Cc:	git@vger.kernel.org, Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] do not add common-main to lib
Message-ID: <20160815120223.4lr23aiqmqzjprch@sigill.intra.peff.net>
References: <20160815075207.31280-1-list@eworm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160815075207.31280-1-list@eworm.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 09:52:07AM +0200, Christian Hesse wrote:

> From: Christian Hesse <mail@eworm.de>
> 
> Commit 08aade70 (mingw: declare main()'s argv as const) changed
> declaration of main function. This breaks linking external projects
> (e.g. cgit) to libgit.a with:
> 
> error: Multiple definition of `main'

I'd expect the culprit is actually 3f2e229 (add an extra level of
indirection to main(), 2016-07-01).

> So do not add common-main to lib and let projects have their own
> main function.

That is certainly an option, but I think it means that those projects
are potentially buggy in the same way that some git commands were prior
to the common-main series. Namely, the common main() may do some
run-time setup that parts of libgit.a assume has been done.

I would not be surprised if cgit crashes on Windows, for instance, for
the reasons detailed in 650c449 (common-main: call
git_extract_argv0_path(), 2016-07-01). I would also not be surprised if
nobody actually builds cgit on Windows. :)

The "right" way to do it (according to the way libgit.a views the world)
is for cgit's main to become cmd_main(), and let libgit.a do its
run-time startup before getting there.

-Peff
