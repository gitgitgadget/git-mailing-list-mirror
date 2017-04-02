Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EF311FAFB
	for <e@80x24.org>; Sun,  2 Apr 2017 07:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750953AbdDBHpZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 03:45:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:55621 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750860AbdDBHpY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 03:45:24 -0400
Received: (qmail 32603 invoked by uid 109); 2 Apr 2017 07:45:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 02 Apr 2017 07:45:23 +0000
Received: (qmail 23118 invoked by uid 111); 2 Apr 2017 07:45:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 02 Apr 2017 03:45:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Apr 2017 03:45:22 -0400
Date:   Sun, 2 Apr 2017 03:45:22 -0400
From:   Jeff King <peff@peff.net>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG?] iconv used as textconv, and spurious ^M on added lines on
 Windows
Message-ID: <20170402074522.4qhannjus4ynwx4i@sigill.intra.peff.net>
References: <feaeade7-aeb5-fa67-ab29-9106aeadb2a6@gmail.com>
 <20170330200021.c2l5jak3xb5aoxyc@sigill.intra.peff.net>
 <e1a6d44c-b01b-993c-6a22-e6ac0abca03c@gmail.com>
 <20170401060800.hrpqqgdx6t262c7f@sigill.intra.peff.net>
 <63eb5546-0dce-2f69-c2f8-1e777b97c532@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63eb5546-0dce-2f69-c2f8-1e777b97c532@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 01, 2017 at 08:31:27PM +0200, Jakub Narębski wrote:

> W dniu 01.04.2017 o 08:08, Jeff King pisze:
> > On Fri, Mar 31, 2017 at 03:24:48PM +0200, Jakub Narębski wrote:
> > 
> >>> I suspect in the normal case that git is doing line-ending conversion,
> >>> but it's suppressed when textconv is in use.
> >>
> >> I would not consider this a bug if not for the fact that there is no ^M
> >> without using iconv as textconv.
> > 
> > I don't think it's a bug, though. You have told Git that you will
> > convert the contents (whatever their format) into the canonical format,
> > but your program to do so includes a CR.
> 
> Well, I have not declared file binary with "binary = true" in diff driver
> definition, isn't it?

I don't think binary has anything to do with it. A textconv filter takes
input (binary or not) and delivers a normalized representation to feed
to the diff algorithm. There's no further post-processing, and it's the
responsibility of the filter to deliver the bytes it wants diffed.

Like I said, I could see an argument for treating the filter output as
text to be pre-processed, but that's not how it works (and I don't think
it is a good idea to change it now, unless by adding an option to the
diff filter).

> P.S. What do you think about Git supporting 'encoding' attribute (or
> 'core.encoding' config) plus 'core.outputEncoding' in-core?

Supporting an "encoding" attribute to normalize file encodings in diffs
seems reasonable to me. But it would have to be enabled only for
human-readable diffs, as the result could not be applied (so the same as
textconv).

I don't think core.outputEncoding is necessarily a good idea. We are not
really equipped anything that isn't an ascii superset, as we intermingle
the bytes with ascii diff headers (though I think that is true of the
commitEncoding stuff; I assume everything breaks horribly if you tried
to set that to UTF-16, but I've never tried it).

-Peff
