Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4431F404
	for <e@80x24.org>; Fri,  9 Feb 2018 21:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbeBIV2J (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 16:28:09 -0500
Received: from grym.ekleog.org ([94.23.42.210]:55018 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752807AbeBIV2I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 16:28:08 -0500
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id 7fe68339;
        Fri, 9 Feb 2018 21:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=
        subject:cc:references:from:to:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        grym-20170528; bh=jmnBN6+CFDgsRz/cu9sfcNQT5sU=; b=djzHBDSZle+44B
        K77X5KC+BNHnkc19esuj/vbyf+nZgIDnenASmZsEW0Z9hYMXeuIkSWD0Am6D3Hd1
        vGQ5pOWxgghv8GCpMmqqDi0/7nb3A0e4Xc7/zwHbSrpaD8Oyw8DK1s/ldj4ALO6s
        Xzufn75Bx31jv2BU6Do8KzjJkk8x8=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTPSA id 2d5759e0 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 9 Feb 2018 21:28:06 +0000 (UTC)
Subject: [PATCH 0/2] fetch: add tweak-fetch hook
Cc:     Joey Hess <id@joeyh.name>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
 <87inb8mn0w.fsf@evledraar.gmail.com>
 <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
 <20180208153040.GA5180@kitenet.net>
 <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
 <3a5a2827-0f69-3a11-2664-51a60eefebf1@gaspard.io>
 <20180209202044.GA6783@kitenet.net>
From:   Leo Gaspard <leo@gaspard.io>
To:     git@vger.kernel.org
Message-ID: <30753d19-d77d-1a1a-ba42-afcd6fbb4223@gaspard.io>
Date:   Fri, 9 Feb 2018 22:28:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209202044.GA6783@kitenet.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/2018 09:20 PM, Joey Hess wrote:> Yes; my patches are under the
same GPL-2 as the rest of git.

Thanks! So here comes my patch series, heavily based on yours.

There are some things to bear in mind while reviewing it:

 * This is my first real attempt at contributing to git, which means I
could be very very far off-track

 * Most of it is based on trying to make the 6-year-old patch series
work and pass all the tests, so if a new feature has been added since
then I likely didn't notice it or don't know how to handle it correctly

There are still three TODO's in the code:

 * In the documentation, one stating that I don't really get what this
“ignore” parameter exactly does, and whether it should be handled
specially (a prime example of a new feature I'm not really sure how to
handle, somewhere in the code it's written all the “ignore” references
are at the end of the list, but I'm already not self-confident enough
about the difference between “merge” and “not-for-merge” to even
consider making a good choice about how to handle “ignore”)

 * In `builtins/fetch.c`, function `do_fetch`, there is a conflict of
interest between placing the `prune` before the `fetch` (as done by
commit 10a6cc889 ("fetch --prune: Run prune before fetching",
2014-01-02)), and placing the `fetch` before the `prune` (which would
allow hooks that rename the local-ref to not be prune'd and then
re-fetched when doing a `git fetch --prune` -- without that a hook that
would want to both read the old commit information and rename the
local-ref would not be able to). Or maybe this question means actually
there should be a third solution? but I don't really know what. Maybe
also hooking into the prune operation?

 * In `templates/hooks--tweak-fetch.sample`, the “check this actually
works” todo, as I'd rather first check this patch series is not too far
off-topic before doing non-essential work -- anyway another version of
the patch series will be required for the other two TODO's, so I can fix
it at this point.

That being said, what do you think about these patches?

Thanks for your time!
Leo Gaspard
