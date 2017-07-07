Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8219202AE
	for <e@80x24.org>; Fri,  7 Jul 2017 05:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750905AbdGGFT5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 01:19:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:33224 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750855AbdGGFT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 01:19:56 -0400
Received: (qmail 31849 invoked by uid 109); 7 Jul 2017 05:19:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 05:19:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19662 invoked by uid 111); 7 Jul 2017 05:20:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 01:20:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jul 2017 01:19:54 -0400
Date:   Fri, 7 Jul 2017 01:19:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
Subject: Re: [PATCH 2/6] t1414: document some reflog-walk oddities
Message-ID: <20170707051954.rpej3taew6onv3oo@sigill.intra.peff.net>
References: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
 <20170705080036.qxzy7havcy72mvff@sigill.intra.peff.net>
 <xmqqh8yqix7p.fsf@gitster.mtv.corp.google.com>
 <20170705212757.3ygxiasbi2e7v27p@sigill.intra.peff.net>
 <xmqqa84ih5ao.fsf@gitster.mtv.corp.google.com>
 <20170706071606.doxirwm6cqx3duzg@sigill.intra.peff.net>
 <xmqq1spth8qy.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1spth8qy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 06, 2017 at 08:42:45AM -0700, Junio C Hamano wrote:

> >> I somehow feel that the "showing all entries from HEAD and then
> >> showing all from side" is simply a buggy behaviour.  I do not think
> >> our users would terribly mind if we changed it later.  But I may be
> >> missing the reason why (sometimes?) the sequential behaviour may be
> >> useful.
> >
> > If we think it's buggy, we can fix it now. But I'm not convinced that
> > sequential iteration is that bad. It's at least _simple_ and easy to
> > explain.
> 
> Yes, I agree that sequential is easy to explain, but only when I
> consider use of "log" family without "-n 30" or "--since 3.days".
> It still is easy to explain---we show from one and then from the
> other, but because we stop after showing 30 of them, and the first
> one has more than that, you do not see any from the latter.

Ah, right, I didn't think of limiting like that. I agree that makes a
strong argument in favor of the date-ordered queue.

I suspect that "--since 3.days" is still quite buggy (even with a single
reflog) because it checks commit timestamps and stops traversing when we
go too bar back. But in a reflog, the commits may be totally out of
order. I'm not sure what it should do. Either:

  1. During a reflog walk, --since and --until should respect reflog
     timestamps instead of commit timestamps. You can already do
     "--until" there by simply starting the traversal later, but there's
     no way to cut it off with --since.

  2. Limit commits shown by --since/--until as usual, but skip the "stop
     traversing" optimization when we see too many "old" commits. I.e.,
     omit a 4.days.ago commit, but keep walking to find other recent
     commits.

-Peff
