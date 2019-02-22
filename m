Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 022D020248
	for <e@80x24.org>; Fri, 22 Feb 2019 15:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfBVPIy (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 10:08:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:54394 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726310AbfBVPIy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 10:08:54 -0500
Received: (qmail 1521 invoked by uid 109); 22 Feb 2019 15:08:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Feb 2019 15:08:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28621 invoked by uid 111); 22 Feb 2019 15:09:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Feb 2019 10:09:07 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2019 10:08:52 -0500
Date:   Fri, 22 Feb 2019 10:08:52 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        John Keeping <john@keeping.me.uk>,
        Pratik Karki <predatoramigo@gmail.com>
Subject: Re: [PATCH 2/2] rebase: don't rebase linear topology with
 --fork-point
Message-ID: <20190222150852.GB5090@sigill.intra.peff.net>
References: <20190221151009.GA24309@sigill.intra.peff.net>
 <20190221214059.9195-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190221214059.9195-3-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 10:40:59PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Fix a regression introduced in 4f21454b55 ("merge-base: handle
> --fork-point without reflog", 2016-10-12).
> [...]

OK, your explanation mostly makes sense to me, except for one thing.

> Then in 4f21454b55 ("merge-base: handle --fork-point without reflog",
> 2016-10-12) which introduced the regression being fixed here, a bug
> fix for "git merge-base --fork-point" being run stand-alone by proxy
> broke this use-case git-rebase.sh was relying on, since it was still
> assuming that if we didn't have divergent history we'd have no output.

I still don't quite see how 4f21454b55 is involved here, except by
returning a fork-point value when there is no reflog, and thus
triggering the bug in more cases.

In particular, imagine this case:

  git init
  for i in $(seq 1 3); do echo $i >$i; git add $i; git commit -m $i; done
  git checkout -t -b other
  for i in $(seq 4 6); do echo $i >$i; git add $i; git commit -m $i; done
  git rebase

With the current code, that will rewind and replay 4-6, and I understand
that to be a bug from your description. And it happens at 4f21454b55,
too. But it _also_ happens at 4f21454b55^.

I.e., I still think that the only thing that commit changed is that we
found a fork-point in more cases. But the bug was still demonstrably
there when you actually have a reflog entry.

With the fix you have here, that case now produces "Current branch other
is up to date".

This is splitting hairs a little (and of course I'm trying to exonerate
the commit I'm responsible for ;) ), but I just want to make sure we
understand fully what's going on. Your fix looks plausibly correct to
me, but I admit I don't quite grok all the details of that conditional.

-Peff
