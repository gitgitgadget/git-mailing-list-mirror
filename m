Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C28DE1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 17:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeJPBA0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 21:00:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:41212 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726585AbeJPBAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 21:00:25 -0400
Received: (qmail 17555 invoked by uid 109); 15 Oct 2018 17:14:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 15 Oct 2018 17:14:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1335 invoked by uid 111); 15 Oct 2018 17:13:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 15 Oct 2018 13:13:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Oct 2018 13:14:17 -0400
Date:   Mon, 15 Oct 2018 13:14:17 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     taoqy@ls-a.me, Git Mailing List <git@vger.kernel.org>
Subject: Re: [Question] builtin/branch.c
Message-ID: <20181015171417.GA1301@sigill.intra.peff.net>
References: <20181013081101.6602-1-taoqy@ls-a.me>
 <CACBZZX7i-Uob9EJ8GeDKYVTyKtdRiy=qPbxSOe=FGh2cbHG9Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7i-Uob9EJ8GeDKYVTyKtdRiy=qPbxSOe=FGh2cbHG9Zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 14, 2018 at 12:19:35PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Sat, Oct 13, 2018 at 10:12 AM Tao Qingyun <taoqy@ls-a.me> wrote:
> > Hi, I am learning `builtin/branch.c`. I find that it will call `branch_get`
> > before create and [un]set upstream, and die with "no such branch" if failed.
> > but `branch_get` seems never fail, it is a get_or_create. Also, it was
> > confused that getting a branch before it has created.
> >
> > builtin/branch.c #811
> >
> >     } else if (argc > 0 && argc <= 2) {
> >         struct branch *branch = branch_get(argv[0]);
> >
> >         if (!branch)
> >             die(_("no such branch '%s'"), argv[0]);
> 
> From my reading of the source you're correct. That !branch case is
> pointless. The only way that function can fail is in the x*() family
> of functions, which'll make the function die instead of returning
> NULL.

It sometimes returns current_branch, which can be NULL (e.g., if you're
on a detached HEAD). Try:

  $ git branch HEAD
  fatal: no such branch 'HEAD'

  $ git branch ''
  fatal: no such branch ''

However, it seems weird that we'd check those cases here (and provide
such lousy messages). And indeed, dropping that and letting us
eventually hit create_branch() gives a much better message:

  $ git branch HEAD
  fatal: 'HEAD' is not a valid branch name.

  $ git branch ''
  fatal: '' is not a valid branch name.

I think we'd want to see that reasoning in the commit message.

-Peff
