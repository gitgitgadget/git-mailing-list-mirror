Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8254D1F4B6
	for <e@80x24.org>; Tue, 14 May 2019 11:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfENLYy (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 07:24:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:56754 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726036AbfENLYx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 07:24:53 -0400
Received: (qmail 3937 invoked by uid 109); 14 May 2019 11:24:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 May 2019 11:24:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12019 invoked by uid 111); 14 May 2019 11:25:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 07:25:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 07:24:51 -0400
Date:   Tue, 14 May 2019 07:24:51 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-server-info: avoid needless overwrites
Message-ID: <20190514112451.GB26957@sigill.intra.peff.net>
References: <20190511013455.5886-1-e@80x24.org>
 <87v9ygwoj0.fsf@evledraar.gmail.com>
 <20190512040825.GA25370@sigill.intra.peff.net>
 <87tve0w3ao.fsf@evledraar.gmail.com>
 <20190514094729.GA12256@sigill.intra.peff.net>
 <87imudwck8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87imudwck8.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 12:33:11PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I think it would work because any update-server-info, whether from A or
> > B, will take into account the full current repo state (and we don't look
> > at that state until we take the lock). So you might get an interleaved
> > "A-push, B-push, B-maint, A-maint", but that's OK. A-maint will
> > represent B's state when it runs.
> 
> Maybe we're talking about different things. I mean the following
> sequence:
> 
>  1. Refs "X" and "Y" are at X=A Y=A
>  2. Concurrent push #1 happens, updating X from A..F
>  3. Concurrent push #2 happens, updating Y from A..F
>  4. Concurrent push #1 succeeds
>  5. Concurrent push #1 starts update-server-info. Reads X=F Y=A
>  5. Concurrent push #2 succeeds
>  6. Concurrent push #2 starts update-server-info. Reads X=F Y=F
>  7. Concurrent push #2's update-server-info finishes, X=F Y=F written to "info"
>  8. Concurrent push #1's update-server-info finishes, X=A Y=F written to "info"
> 
> I.e. because we have per-ref locks and no lock at all on
> update-server-info (but that would need to be a global ref lock, not
> just on the "info" files) we can have a push that's already read "X"'s
> value as "A" while updating "Y" win the race against an
> update-server-info that updated "X"'s value to "F".
> 
> It will get fixed on the next push (at least as far as "X"'s value
> goes), but until that time dumb clients will falsely see that "X" hasn't
> been updated.

That's the same situation. But I thought we were talking about having an
update-server-info lock. In which case the #2 update-server-info or the
#1 update-server-info runs in its entirety, and cannot have their read
and write steps interleaved (that's what I meant by "don't look at the
state until we take the lock"). Then that gives us a strict ordering: we
know that _some_ update-server-info (be it #1 or #2's) will run after
any given update.

-Peff
