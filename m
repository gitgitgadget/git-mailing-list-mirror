Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A52951FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 06:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750825AbdDAGID (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 02:08:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:55253 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750799AbdDAGIC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 02:08:02 -0400
Received: (qmail 21954 invoked by uid 109); 1 Apr 2017 06:08:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 06:08:03 +0000
Received: (qmail 15887 invoked by uid 111); 1 Apr 2017 06:08:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 02:08:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Apr 2017 02:08:00 -0400
Date:   Sat, 1 Apr 2017 02:08:00 -0400
From:   Jeff King <peff@peff.net>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG?] iconv used as textconv, and spurious ^M on added lines on
 Windows
Message-ID: <20170401060800.hrpqqgdx6t262c7f@sigill.intra.peff.net>
References: <feaeade7-aeb5-fa67-ab29-9106aeadb2a6@gmail.com>
 <20170330200021.c2l5jak3xb5aoxyc@sigill.intra.peff.net>
 <e1a6d44c-b01b-993c-6a22-e6ac0abca03c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1a6d44c-b01b-993c-6a22-e6ac0abca03c@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 03:24:48PM +0200, Jakub Narębski wrote:

> > I suspect in the normal case that git is doing line-ending conversion,
> > but it's suppressed when textconv is in use.
> 
> I would not consider this a bug if not for the fact that there is no ^M
> without using iconv as textconv.

I don't think it's a bug, though. You have told Git that you will
convert the contents (whatever their format) into the canonical format,
but your program to do so includes a CR.

We _could_ further process with other canonicalizations, but I'm not
sure that is a good idea (line-endings sound reasonably harmless, but
almost certainly we should not be doing clean/smudge filtering). And I'm
not sure if there would be any compatibility fallouts.

So I think the behavior is perhaps not what you want, but it's not an
unreasonable one. And the solution is to define your textconv such that
it produces clean LF-only output. Perhaps:

  [diff.whatever]
  textconv = "iconv ... | tr -d '\r'"

?

-Peff
