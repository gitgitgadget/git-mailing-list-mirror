Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1790C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 10:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF5020717
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 10:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgC1K6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 06:58:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:54340 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726164AbgC1K6F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 06:58:05 -0400
Received: (qmail 23335 invoked by uid 109); 28 Mar 2020 10:58:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 28 Mar 2020 10:58:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 505 invoked by uid 111); 28 Mar 2020 11:08:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Mar 2020 07:08:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 28 Mar 2020 06:58:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] tests: turn GPG, GPGSM and RFC1991 into lazy
 prereqs
Message-ID: <20200328105804.GB639140@coredump.intra.peff.net>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
 <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
 <85457a7b61874e8e9f3af9c231451df0aba7a7b5.1585114881.git.gitgitgadget@gmail.com>
 <20200326083519.GD2200716@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2003261450590.46@tvgsbejvaqbjf.bet>
 <20200327091004.GA610157@coredump.intra.peff.net>
 <xmqqr1xdhev8.fsf@gitster.c.googlers.com>
 <CAPig+cT6CQsYyMR=-nAo7GD8mXAWyUWPrbTnCZ0nBs54Ah0PbQ@mail.gmail.com>
 <xmqq1rpdfpj5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rpdfpj5.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 27, 2020 at 02:37:02PM -0700, Junio C Hamano wrote:

> >>  And here are the "don'ts:"
> >>
> >>   - Don't exit() within a <script> part.
> >
> > We use 'exit 1' to terminate subshells[1] inside tests.
> >
> > [1]: https://lore.kernel.org/git/20150325052952.GE31924@peff.net/
> 
> Yeah, I gave two alternatives, but the third one could be
> 
>        test_expect_success 'git frotz on various versions' '
>            (
>              for revision in one two three
>              do
>                      echo "frotz $revision" >expect &&
>                      git frotz "$revision" >actual &&
>                      test_cmp expect actual || exit 1
>              done 
>            ) &&
>            test something else
>        '

We definitely shouldn't suggest _introducing_ a subshell for this
purpose. It's longer to write and less efficient.

> Anyway, that existing rule is not what I added in the rough draft
> under discussion.  To clarify it, we'd end up needing "unless A, B
> or C" that may be too complex.  I dunno.

I think the existing rule is OK. If you know enough to create the
situation where "exit 1" is useful, then you probably know enough to
know when to break that rule. That said, I'm not opposed to something
like:

  - Don't call "exit" within a <script> part, unless you're in a
    subshell. It will cause the whole to test script to exit (and fail).

or something.

-Peff
