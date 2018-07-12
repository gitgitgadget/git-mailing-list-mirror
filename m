Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14F9C1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 18:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeGLSaj (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 14:30:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:57178 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726444AbeGLSaj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 14:30:39 -0400
Received: (qmail 6562 invoked by uid 109); 12 Jul 2018 18:19:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Jul 2018 18:19:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24968 invoked by uid 111); 12 Jul 2018 18:19:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 12 Jul 2018 14:19:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jul 2018 14:19:55 -0400
Date:   Thu, 12 Jul 2018 14:19:55 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 21/25] t5000-t5999: fix broken &&-chains
Message-ID: <20180712181955.GA13268@sigill.intra.peff.net>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
 <20180702002405.3042-22-sunshine@sunshineco.com>
 <20180712123729.17861-1-szeder.dev@gmail.com>
 <CAPig+cRYNo_KL02LN1LOa79Zm2oYZqbnBHJ=KDA3oaF4pVfjcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRYNo_KL02LN1LOa79Zm2oYZqbnBHJ=KDA3oaF4pVfjcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 01:44:49PM -0400, Eric Sunshine wrote:

> On Thu, Jul 12, 2018 at 8:37 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > The change below should be squashed into this patch to fix a
> > previously unnoticed broken &&-chain.  I think you missed it, because
> > this test script is rather expensive and you didn't run it with
> > GIT_TEST_CLONE_2GB=YesPlease.
> >
> > diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
> > @@ -23,7 +23,7 @@ test_expect_success CLONE_2GB 'setup' '
> > -               echo "M 100644 :$i $i" >> commit
> > +               echo "M 100644 :$i $i" >> commit &&
> 
> Thanks for finding this. I tried to get as much coverage as possible
> by installing packages I don't normally have installed (Apache, cvs,
> cvsps, Subversion, Perforce, etc.) and even temporarily modified a
> script or two to force it run when I simply couldn't meet some
> prerequisite, thus reducing the "skipped" messages to a minimum, but I
> wasn't even aware of this prerequisite since I never saw a "skipped"
> message for it.

I think in theory we should be able to lint _every_ test, even if we're
not running it. After all, the point is that a proper linting runs zero
commands.

That said, it may not be worth the implementation effort. The linting
happens at a pretty low-level, and we've already decided to skip tests
long before then (even for single prereqs, let alone skip_all cases
where we exit the script early).

> Looking at it more closely, I think the reason it didn't come to my
> attention is that this script doesn't use the standard skip_all="..."
> mechanism for skipping the tests but instead "rolls its own", and
> apparently 'prove' simply swallowed (or was unable to produce) an
> overall "skipped" message for this script.

Yeah, that is a bit funny. For a whole-test skip like this, I think
skip_all is easier to read, as it is immediately apparent to the reader
that nothing that _doesn't_ meet that prereq should be in the file. So
I'd be happy to see it switched (though it's not _that_ big a deal, so
leaving it is fine, too).

By the way, "prove --directives" can help with finding individual
skipped tests.

-Peff
