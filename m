Return-Path: <SRS0=2KbR=CB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBF3C433DF
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 02:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C592072D
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 02:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgHWCwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 22:52:37 -0400
Received: from mimir.eigenstate.org ([206.124.132.107]:47252 "EHLO
        mimir.eigenstate.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgHWCwh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Aug 2020 22:52:37 -0400
Received: from abbatoir.fios-router.home (pool-74-101-2-6.nycmny.fios.verizon.net [74.101.2.6])
        by mimir.eigenstate.org (OpenSMTPD) with ESMTPSA id ed9c112b (TLSv1.2:ECDHE-RSA-AES256-SHA:256:NO);
        Sat, 22 Aug 2020 19:52:37 -0700 (PDT)
Message-ID: <5374D56FBAB7F3BCD976B433934DEFCA@eigenstate.org>
To:     ori@eigenstate.org, git@vger.kernel.org
Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles
Date:   Sat, 22 Aug 2020 19:52:35 -0700
From:   ori@eigenstate.org
In-Reply-To: <20200823005236.10386-1-ori@eigenstate.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In packfile.c:1680, there's an infinite loop that tries to get
> to the base of a packfile. With offset deltas, the offset needs
> to be greater than 0, so it's always walking backwards, and the
> search is guaranteed to terminate.
> 
> With reference deltas, there's no check for a cycle in the
> references, so a cyclic reference will cause git to loop
> infinitely, growing the delta_stack infinitely, which will
> cause it to consume all available memory as as a full CPU
> core.
> 
> This change puts an arbitrary limit of 10,000 on the number
> of iterations we make when chasing down a base commit, to
> prevent looping forever, using all available memory growing
> the delta stack.

For context, I discovered this accidentally when I
introduced a bug in pack deltification in git9 (my
implementation of git for plan 9). An example of a
packfile and index that will reproduce this issue
is available here:

https://eigenstate.org/tmp/95a0f4f3f3f21d723d501552eaf22ff4055e13a4.pack
https://eigenstate.org/tmp/95a0f4f3f3f21d723d501552eaf22ff4055e13a4.idx

The suggestion to just cap the depth instead of
doing full cycle detection came from Jeff King
(peff@peff.net)

