Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA69FC433DF
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 06:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9A421744
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 06:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgGQGdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:33:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:59870 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgGQGdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 02:33:25 -0400
Received: (qmail 28891 invoked by uid 109); 17 Jul 2020 06:33:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Jul 2020 06:33:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 731 invoked by uid 111); 17 Jul 2020 06:33:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jul 2020 02:33:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Jul 2020 02:33:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?5a2Z5LiW6b6Z?= sunshilong <sunshilong369@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: How can I search git log with ceratin keyword but without the
 other keyword?
Message-ID: <20200717063324.GB1179001@coredump.intra.peff.net>
References: <CAAvDm6Z2HcQkyinCD4hKTnqGR3gcXodhoo0YKSnbB-vDJcn3MQ@mail.gmail.com>
 <CAPUEspg=4HJL8iiNrNp9Wr9sVj5Gw_PciSezHV5iJ1w-ymdzdw@mail.gmail.com>
 <CAAvDm6avvkXrU-Q8zu7C5WFqfCbf0DN=6cPMU-rOxgmdAh1Ebw@mail.gmail.com>
 <20200716153159.GA1061124@coredump.intra.peff.net>
 <CAAvDm6Z6SA8rYYHaFT=APBSx0tM+5rHseP+fRLufgDxvEthsww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAvDm6Z6SA8rYYHaFT=APBSx0tM+5rHseP+fRLufgDxvEthsww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 17, 2020 at 09:45:26AM +0800, 孙世龙 sunshilong wrote:

> I wonder why this command doesn't work well.
> I intend to find the comment with the keyword "12" but without "comments"
> whereas the output is something like this:
> 
> git log --perl-regexp --all-match --grep=12 --grep '\b(?!comments\b)\w+'
> commit f5b6c3e33bd2559d6976b1d589071a5928992601
> Author: sunshilong <sunshilong369@gmail.com>
> Date:   2020-04-12 23:00:29 +0800
> 
>     comments 2020.04.12 ng

I think this is the thing I was mentioning earlier. That negative
lookahead means the second one wouldn't match "comments", but it would
still match "2020.04.12" or "ng". So it won't do what you want.

I can't think of a way to do what you want just a regex, but maybe
somebody more clever than me can.

The natural thing to me would be the equivalent of:

  git grep -e 12 --and --not -e comments

The underlying grep machinery in Git understands how to compose multiple
patterns like this, and the command above really does work (though of
course it is searching for lines in a file and not commit messages).

But none of that is exposed via the command-line of "git log". I think
it would be possible to do so, but I'm not sure how tricky it would be
(certainly one complication is that "--not" already means something else
there, but presumably we could have "--grep-and", "--grep-not", etc).

-Peff
