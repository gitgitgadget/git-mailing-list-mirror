Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2FC91F516
	for <e@80x24.org>; Thu, 28 Jun 2018 22:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966548AbeF1WDf (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 18:03:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:58906 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966120AbeF1WDf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 18:03:35 -0400
Received: (qmail 31895 invoked by uid 109); 28 Jun 2018 22:03:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 22:03:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25952 invoked by uid 111); 28 Jun 2018 22:03:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 18:03:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 18:03:33 -0400
Date:   Thu, 28 Jun 2018 18:03:33 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] fsck: check skiplist for object in fsck_blob()
Message-ID: <20180628220332.GA5128@sigill.intra.peff.net>
References: <2fc2d53f-e193-2a2a-9f8f-b3e1d256d940@ramsayjones.plus.com>
 <20180628114912.GA12901@sigill.intra.peff.net>
 <0a18acbd-0124-1c92-0046-05b8b035dd28@ramsayjones.plus.com>
 <20180628174501.GC31766@sigill.intra.peff.net>
 <db7683ab-1025-d7bb-d0ce-fc4ee28681e1@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <db7683ab-1025-d7bb-d0ce-fc4ee28681e1@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 28, 2018 at 07:53:27PM +0100, Ramsay Jones wrote:

> > Yes, though I don't think it's too bad. We already have a "die_on_error"
> > flag in the config code. I think it just needs to become a tristate:
> > die/error/silent (and probably get passed in via config_options, since I
> > think we tie it right now to the file/blob source).
> 
> Yes, but this code is already very crufty - and I'm just
> waiting for someone to want to have per-repo/submodule
> config parsing i... ;-)

It is crufty, but I think we actually handle that part OK; the flag gets
attached to the stack.

> > Hmm, if we end up doing the config thing above, then this patch would
> > become unnecessary.
> 
> I was thinking of timing - the current patch could go
> in quickly to solve the immediate problem (eg. in maint).
> 
> Also, it does not hurt to do this _as well as_ suppress
> the config errors.

Yes, it can go in quickly. But I'd prefer not to keep it in the long
term if it's literally doing nothing.

I have some patches which I think solve your problem. They apply on
v2.18.0, but not on v2.17.1 (because they rely on Dscho's increased
passing of config_options in v2.18). Is that good enough?

> > And I think doing that would help _all_ cases, even ones without a
> > skiplist. They don't need to see random config error messages either,
> > even if we do eventually report an fsck error.
> 
> Oh, yes, I agree. You will have noticed that it was my
> first suggested solution. (I have started writing that
> patch a few times, but it just makes me want to throw
> the current code away and start again)!
> 
> Hmm, BTW, the 'rejected push' problem would include *any*
> '.gitmodules' blob that contained a syntax error, right?
> 
> Maybe it won't be as rare as all that! (Imagine not being
> able to push due to a compiler error/warning in source files.
> How irritating would that be! :-P ).

Yes, it would include any syntax error. I also have a slight worry about
that, but nobody seems to have screamed _yet_. :)

> (if we fix this, you could hide some nefarious settings
> after an obvious syntax error - then get the victim to
> fix the syntax error ...)

You can also usually get the victim to type "make", which is even
simpler. :)

Here are the patches I came up with.

Note that the config_options struct has a bit of a dual-nature. Some
options are respected only via config_from_options(), and some only from
git_config_from_file(). I think this should probably be remedied in the
long run, but I stopped here in the interest of keeping this
maint-worthy.

  [1/4]: config: turn die_on_error into caller-facing enum
  [2/4]: config: add CONFIG_ERROR_SILENT handler
  [3/4]: config: add options parameter to git_config_from_mem
  [4/4]: fsck: silence stderr when parsing .gitmodules

 config.c                   | 32 +++++++++++++++++++++++---------
 config.h                   | 13 +++++++++++--
 fsck.c                     |  4 +++-
 submodule-config.c         |  2 +-
 t/t7415-submodule-names.sh | 15 +++++++++++++++
 5 files changed, 53 insertions(+), 13 deletions(-)

-Peff
