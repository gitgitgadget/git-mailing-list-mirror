Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8E6C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 20:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B266F6104F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 20:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhHKUY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 16:24:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:44628 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhHKUYz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 16:24:55 -0400
Received: (qmail 22829 invoked by uid 109); 11 Aug 2021 20:24:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Aug 2021 20:24:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14365 invoked by uid 111); 11 Aug 2021 20:24:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Aug 2021 16:24:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Aug 2021 16:24:30 -0400
From:   Jeff King <peff@peff.net>
To:     Joel Klinghed via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Joel Klinghed <the_jk@spawned.biz>
Subject: Re: [PATCH] commit: restore --edit when combined with --fixup
Message-ID: <YRQx/jXdydxMGBmS@coredump.intra.peff.net>
References: <pull.1014.git.1628689758413.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1014.git.1628689758413.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 11, 2021 at 01:49:18PM +0000, Joel Klinghed via GitGitGadget wrote:

> From: Joel Klinghed <the_jk@spawned.biz>
> 
> Recent changes to --fixup, adding amend suboption, caused the
> --edit flag to be ignored as use_editor was always set to zero.
> 
> Restore edit_flag having higher priority than fixup_message when
> deciding the value of use_editor by only changing the default
> if edit_flag is not set.

This is definitely a change in behavior due to 494d314a05 (commit: add
amend suboption to --fixup to create amend! commit, 2021-03-15). That
was in v2.32.0, so it's not a regression in the upcoming v2.33 which
needs to be handled in the next few days.

My inclination is to call it a regression and restore the original
behavior. But when I was going to suggest that you add a test, it made
me wonder: what would we be testing for?

If the user says "git commit --fixup HEAD --edit", it seems reasonable
for them to expect that the editor is run, and that is easy to check.
But what are they planning to edit? If they modify the subject line of
the commit, it will wreck the "fixup!" mechanism. If they modify the
body (which starts blank), it's going to be discarded by the fixup
operation.

Is the goal that they might leave notes for themselves, which they can
view in the meantime before they run "rebase --autosquash"?

-Peff
