Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE092EC8748
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 10:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344075AbjIJKFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 06:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjIJKFt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 06:05:49 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C249CCF
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 03:05:41 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 0D15B20391;
        Sun, 10 Sep 2023 06:05:37 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qfHJx-Xv4-00; Sun, 10 Sep 2023 12:05:37 +0200
Date:   Sun, 10 Sep 2023 12:05:37 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     phillip.wood@dunelm.org.uk
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: ignore signals when forking subprocesses
Message-ID: <ZP2U8TBNjKs5ebky@ugly>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <159c16ae-4dbf-4669-bd9d-2f7c52107a68@gmail.com>
 <9ba22d4b-3cbe-4d4a-8dba-bc3781e82222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 08, 2023 at 10:59:06AM +0100, Phillip Wood wrote:
>Ah, I hadn't thought about "gc --auto". I was assuming that the calling 
>code would see the child had been killed and exit but that's not always 
>the case.
>
that's a quite reasonable assumption.
ignoring gc's exit status is ok-ish, but ignoring its termination signal 
is absolutely not.

>On 07/09/2023 22:06, Jeff King wrote:
>> I think this really comes down to: does the user perceive the child
>> process as the current "main" process running in the foreground?
>> 
that is indeed a key point here.
note that the shell doesn't enable job control in scripts, either.

>The child not dying is tricky, if it is in the same process group as 
>git then even if git dies the I think the shell will wait for the child 
>to exit before showing the prompt again so it is not clear to me that 
>the user is disadvantaged by git ignoring SIGINT in that case.
>
there is no such thing as waiting for grandchildren. the grandchild is 
reparented to init when the child exits.

there is a situation were one can be deadlocked by a non-exiting 
grandchild: when doing a blocking read of the child's output past its 
exit, when the grandchild has inherited stdout. but that's a 
implementation bug in the parent. and not relevant here.

On Fri, Sep 08, 2023 at 02:11:51PM +0100, Phillip Wood wrote:
>On 08/09/2023 10:59, Phillip Wood wrote:
>>> I've never done it before, but from my reading we basically want to 
>>> do
>>> (in the forked process before we exec):
>>>
>>>    setsid();
>>>    open("/dev/tty");
>> 
>> Do we want a whole new session? As I understand it to launch a 
>> foreground job shells put the child in its own process group and then 
>> call tcsetpgrp() to change the foreground process group of the 
>> controlling terminal to that of the child.
>
this would indeed be the right way if we wanted to isolate the children 
more, but ...

>It is better for handling SIGINT and SIGQUIT when we don't want git to 
>be killed but in complicates the handling of SIGTSTP and friends. [...]
>
... this shows that we really don't want that; we don't want to 
replicate interactive shell behavior. that is even before the divergence 
on windows.

so i think your patch is approaching things the right way.
though blocking signals doesn't appear right - to ensure git's own clean 
exit while it has no children, it must catch sigint anyway, and 
temporarily ignoring it around spawning children sounds racy.

regards
