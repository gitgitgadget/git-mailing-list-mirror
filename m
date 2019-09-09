Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA00B1F461
	for <e@80x24.org>; Mon,  9 Sep 2019 12:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfIIM5y (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 08:57:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:44022 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727244AbfIIM5y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 08:57:54 -0400
Received: (qmail 18482 invoked by uid 109); 9 Sep 2019 12:57:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Sep 2019 12:57:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8040 invoked by uid 111); 9 Sep 2019 12:59:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2019 08:59:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Sep 2019 08:57:53 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Freese <ericdfreese@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] for-each-ref: add '--no-symbolic' option
Message-ID: <20190909125753.GA8684@sigill.intra.peff.net>
References: <20190907213646.21231-1-ericdfreese@gmail.com>
 <20190907213646.21231-2-ericdfreese@gmail.com>
 <20190908100543.GB15641@sigill.intra.peff.net>
 <xmqq8sqyn6ek.fsf@gitster-ct.c.googlers.com>
 <xmqq4l1mmn8i.fsf@gitster-ct.c.googlers.com>
 <CAAikoA+MvORDJ6y=VSk_1s6v7110UeOfU2X2G7=9ChV+m+COxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAikoA+MvORDJ6y=VSk_1s6v7110UeOfU2X2G7=9ChV+m+COxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 08, 2019 at 10:01:33PM -0600, Eric Freese wrote:

> On Sun, Sep 9, 2019 at 4:34 PM Junio C Hamano <gitster@pobox.com> wrote:
> 
> > I guess with "%(if)...%(then)...%(else)...%(end)" you might be able
> > to do either one of --include/--exclude without supporting the
> > other, e.g. "--include='%(if)%(symref)%(then)%(else)not a
> > symref%(end)" would be usable as "I do not want to see symrefs" in a
> > system that supports only "--include" without "--exclude".
> 
> This has made me realize that I can get the behavior I need by using `%(if)`.
> 
> Exclude symrefs:
>   "%(if)%(symref)%(then)%(else)%(refname)%(end)"
> 
> Only symrefs:
>   "%(if)%(symref)%(then)%(refname)%(end)"
> 
> However, this still prints an empty line for each ref that does not match the
> condition. This can be cleaned up by piping through `grep .`, but what would
> you think of adding a new optional flag to git-for-each-ref to prevent it from
> printing empty expanded format strings?

Yeah, I think that is a much nicer direction, in that it covers many
more cases. I'm tempted to suggest it should even be the default, since
the blank lines are mostly useless (by definition they carry no
information except the single bit of "there was a ref that didn't have
any output for your format").

My only reservation is that for-each-ref is plumbing, and it's
_possible_ somebody is counting up the blank lines as part of some
workflow (say, counting up tags and non-tags). It seems kind of
unlikely, though. Much more likely is having an output format that has
some non-blank elements and some blank, but the proposal wouldn't change
the behavior there at all.

-Peff
