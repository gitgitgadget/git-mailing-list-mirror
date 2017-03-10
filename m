Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C7E21FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 12:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936495AbdCJMm4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 07:42:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:41925 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932881AbdCJMmx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 07:42:53 -0500
Received: (qmail 309 invoked by uid 109); 10 Mar 2017 12:42:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 12:42:50 +0000
Received: (qmail 14410 invoked by uid 111); 10 Mar 2017 12:42:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 07:42:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Mar 2017 07:42:48 -0500
Date:   Fri, 10 Mar 2017 07:42:48 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: "git branch --contains <commit> <name>" does nothing,
 silently fails
Message-ID: <20170310124247.jvrmmcz2pbv4qf3o@sigill.intra.peff.net>
References: <CACBZZX7OSH_dSJ+kswbv2g1Hv6JieDxHHRmqazppgih0d1+hVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7OSH_dSJ+kswbv2g1Hv6JieDxHHRmqazppgih0d1+hVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 11:43:15AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Ran into this when preparing my --no-contains series, this is a long
> standing bug:
> 
>     $ ./git branch -D test; ./git branch --contains v2.8.0 test; echo
> $?; git rev-parse test
>     error: branch 'test' not found.
>     0
>     test
>     fatal: ambiguous argument 'test': unknown revision or path not in
> the working tree.

Isn't that asking to list branches starting with "test" that contain
v2.8.0? There are none to report (since you just made sure to delete
it), so the empty output is correct.

> I.e. this should return an error like "git tag" does:
> 
>     $ ./git tag -d test; ./git tag --contains v2.8.0 test; echo $?;
> git rev-parse test
>     error: tag 'test' not found.
>     fatal: --contains option is only allowed with -l.
>     128
>     test
>     fatal: ambiguous argument 'test': unknown revision or path not in
> the working tree.

The difference between "branch" and "tag" here is that "branch
--contains" implies "--list" (and the argument becomes a pattern).
Whereas "tag --contains" just detects the situation and complains.

If anything, I'd think we would consider teaching "tag" to behave more
like "branch".

-Peff
