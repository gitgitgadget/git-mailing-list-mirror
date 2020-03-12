Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158DBC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 20:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D952067C
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 20:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgCLUhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:37:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:38260 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725268AbgCLUhU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 16:37:20 -0400
Received: (qmail 14092 invoked by uid 109); 12 Mar 2020 20:37:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Mar 2020 20:37:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1718 invoked by uid 111); 12 Mar 2020 20:46:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Mar 2020 16:46:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Mar 2020 16:37:18 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 20/20] rebase: rename the two primary rebase backends
Message-ID: <20200312203718.GA870787@coredump.intra.peff.net>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
 <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
 <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
 <20200312151318.GM212281@google.com>
 <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
 <xmqqftedfkvy.fsf@gitster.c.googlers.com>
 <CABPp-BGvqUEDoj6_mUAsSVeS8+h5ruCFcMTENtf5LY2XWKVj-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGvqUEDoj6_mUAsSVeS8+h5ruCFcMTENtf5LY2XWKVj-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 12:29:45PM -0700, Elijah Newren wrote:

> First, note that this particular breakage would have occurred
> regardless of the default setting, because the problem was that they
> setting rebase.backend to an unrecognized value, not that we used a
> different backend than they were used to.

If I understand correctly, it was also a setting that never worked in
any released version of Git. It was magic that was only ever in 'next'.

As annoying as it is to experience breakage, I'm not _too_ sympathetic
to this case, because that is part of the cost of running the bleeding
edge of 'next' or even 'master'. I.e., I think we have to make a cutoff
_somewhere_ to say "this is something that made it to the general
public, and therefore we can't break backwards compatibility" to keep
our sanity during development. And it seems like tagged releases are a
pretty good cutoff to me.

Though in this particular case, I don't mind too much just leaving "am"
as an alias for "apply" (it was actually the first thing I tried when
writing my earlier emails, but I'm probably not a representative user
there). Putting that in a release, though, may mean supporting it
forever. :)

>    - We had multiple complaints this cycle about rebase.backend=apply
> merging things incorrectly with the only workaround being to use the
> merge backend[3,4]
>    - The rebase-backend topic wasn't merged down to master until less
> than a week before -rc0.  (For a variety of reasons.)  A big change
> like this probably would have been better to merge down earlier in
> some cycle.

It did feel a bit quick to me, hitting near the end of the cycle. We've
had the apply backend as the default for a decade, so even if there are
problems with it, they're known issues. So I don't think there's a
particular hurry. I'm not entirely convinced that cooking it longer
during the next cycle will turn up a lot of new data (I did find a few
issues, but the real test is the long-tail of weird use cases that we
won't see until an actual release). But it probably doesn't hurt much to
take it slow; it just delays a few bug-fixes (which people can still get
by setting a config option).

I guess like your email I'm going back and forth between the two
options. I think that means it probably doesn't matter _too_ much either
way.

-Peff
