Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248C6CA0EC7
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 23:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349295AbjIKVdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbjIKKcb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 06:32:31 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B15E5F
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 03:32:26 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id F2FB023EB7;
        Mon, 11 Sep 2023 06:32:23 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qfeDP-mon-00; Mon, 11 Sep 2023 12:32:23 +0200
Date:   Mon, 11 Sep 2023 12:32:23 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     phillip.wood@dunelm.org.uk
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: ignore signals when forking subprocesses
Message-ID: <ZP7st70/G3kLujHG@ugly>
References: <ZP2U8TBNjKs5ebky@ugly>
 <80eb7631-e5c0-497e-b2a9-b1f8c8a4a306@gmail.com>
 <a37a0f11-0723-4964-a187-54d960615d79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a37a0f11-0723-4964-a187-54d960615d79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 11, 2023 at 11:14:31AM +0100, Phillip Wood wrote:
>On 11/09/2023 11:00, Phillip Wood wrote:
>> There is an inevitable race between wait() returning and calling 
>> signal() to restore the handlers for SIGINT and SIGQUIT,
>
>In principle if we installed a signal handler to set a flag if a signal 
>is received while calling wait() and then once wait() returns 
>successfully see if the child was killed we can tell if the signal was 
>received while the child was alive.
>
yes, this is what i was already writing:

my point is that you shouldn't be doing that in the first place.
install the handlers when the sequencer is entered and leave them there.
the handlers need to set (volatile) flag variables, which are checked by
the sequencer on a regular basis.

a few notes on that:
- install without SA_RESTART, so syscalls can actually return with EINTR
   and give us the opportunity to check the flag.
- an alternative to setting flags is setjmp()/longjmp(), but you really
   don't want to go there.
- install with SA_RESETHAND, so the second ctrl-c will kill git
   regardless, providing an escape hatch.

>In practice if the child is catching SIGINT or SIGQUIT we cannot rely 
>on it re-raising the signal so that wont work.
>
yes, but that's a minor issue, i think.
by far most hooks and other things that might be invoked within 
sequencer context don't mess with signals in the first place.
the things that do should be presumed to do the right thing, which means 
at least a non-zero exit status in case of a premature termination, 
which will yield pretty much the same effect on our side anyway.
so the only actually problematic situation would be us completely 
ignoring the exit code (like the git-gc call, but that's clearly a bug 
in git, and we control both sides, so it's easily fixable).

regards
