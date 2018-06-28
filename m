Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B9721F516
	for <e@80x24.org>; Thu, 28 Jun 2018 14:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966852AbeF1OfR (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 10:35:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:58248 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966775AbeF1OfP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 10:35:15 -0400
Received: (qmail 14388 invoked by uid 109); 28 Jun 2018 14:35:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 14:35:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20325 invoked by uid 111); 28 Jun 2018 14:35:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 10:35:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 10:35:13 -0400
Date:   Thu, 28 Jun 2018 10:35:13 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 29/29] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
Message-ID: <20180628143513.GB16657@sigill.intra.peff.net>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-30-sunshine@sunshineco.com>
 <xmqqwouljr5e.fsf@gitster-ct.c.googlers.com>
 <CAPig+cSLyie8mr+u8Thv9cJ0J12nCA+RU6Mg3S5F8U68q1+nzQ@mail.gmail.com>
 <20180626201708.GA2341@sigill.intra.peff.net>
 <CAPig+cRvgsu-6f+mzjGVDWTVhFrhLY5MsNxEQBJYckKDpeaMAg@mail.gmail.com>
 <20180626210100.GA3682@sigill.intra.peff.net>
 <CAPig+cRzZ-Nd2b-M8v0NUsLX_gkKwLqyakgcRhwGf3CzsWwxBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRzZ-Nd2b-M8v0NUsLX_gkKwLqyakgcRhwGf3CzsWwxBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 05:13:05PM -0400, Eric Sunshine wrote:

> On Tue, Jun 26, 2018 at 5:01 PM Jeff King <peff@peff.net> wrote:
> > On Tue, Jun 26, 2018 at 04:46:18PM -0400, Eric Sunshine wrote:
> > > Some of these dangers can be de-thoothed during the linting phase by
> > > defining do-nothing shell functions:
> > >
> > >     cp () { :; }
> > >     mv () { :; }
> > >     ln () { :; }
> > >
> > > That, at least, makes the scariest case ("rm") much less so.
> >
> > Now that's an interesting idea. We can't catch every dangerous action
> > (notably ">" would be hard to override), but it should be pretty cheap
> > to cover some obvious ones.
> 
> Taking the idea a bit further, the 'sed' script could also throw away
> strings of "../" inside subshells, which would help defang the more
> difficult cases, like "echo x >../git.c". There are pathological
> cases, of course, which it wouldn't catch:
> 
>     P=../git.c
>     test_expect_success 'foo' '
>         (
>             cd dir &&
>             echo x >$P
>         )
>     '
> 
> but it does help mitigate the issue for the most typical cases.

It seems like the dangerous thing there is ">", not necessarily "..".
Could we just s/>/x/g ?

That "breaks" the commands in a sense, but the whole point is that these
commands shouldn't ever be run in the first place.

-Peff
