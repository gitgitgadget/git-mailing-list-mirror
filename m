Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DC0F1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 18:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeGPTIZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 15:08:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:48142 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727618AbeGPTIY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 15:08:24 -0400
Received: (qmail 8939 invoked by uid 109); 16 Jul 2018 18:39:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 18:39:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13764 invoked by uid 111); 16 Jul 2018 18:39:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 14:39:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 14:39:43 -0400
Date:   Mon, 16 Jul 2018 14:39:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vitali Lovich <vlovich@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: rev-parse --show-toplevel broken during exec'ed rebase?
Message-ID: <20180716183942.GB22298@sigill.intra.peff.net>
References: <CAF8PYMjub1KK_ZK0hijTNBACSa6SaFyu1dJgrXd5fJU5Hc_dhg@mail.gmail.com>
 <xmqq7em01ns9.fsf@gitster-ct.c.googlers.com>
 <20180713184732.GC968742@genre.crustytoothpaste.net>
 <20180713201949.GA17670@sigill.intra.peff.net>
 <xmqqsh4jt5d0.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsh4jt5d0.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 11:14:51AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > None of which is too surprising. The root of the bug is in the
> > conversion to rebase--helper, I think, when presumably we started
> > setting GIT_DIR at all (but I didn't dig further). Then 09d7b6c6fa fixed
> > _one_ fallout of that, which was relative paths, but didn't help the
> > subdirectory case.
> >
> > Just reading over this thread, I suspect the simplest fix is to pass
> > GIT_DIR and GIT_WORK_TREE together, which is almost always the right
> > thing to do.
> 
> Perhaps.  Not exporting GIT_DIR (unless the end-user already did to
> the environment before starting "git rebase"---it would be a bad
> change to unexport it unconditionally) may probably be a way to make
> rebase--helper conversion more faithful to the original scripted
> Porcelain, but I suspect in practice always giving GIT_DIR and
> GIT_WORK_TREE would work well for many existing hooks.

Yeah, that may be an option. I don't remember if this was discussed in
this thread or elsewhere, but setting GIT_DIR is a regression for hooks,
etc, which do:

  git -C /some/other/repo log

or similar. I'm not sure if that falls under "actual regression" or
"just how it happened to work in the past". I'm not even sure it worked
that way _consistently_ in the past.

The best practice if you're switching directories is to do:

  unset $(git rev-parse --local-env-vars)

though I highly doubt that most people bother.

-Peff
