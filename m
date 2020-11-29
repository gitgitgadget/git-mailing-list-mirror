Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ABDC3E8C5
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 17:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69386206FA
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 17:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgK2RlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 12:41:16 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:37024 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgK2RlP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 12:41:15 -0500
Received: from client3368.fritz.box (i5C747952.versanet.de [92.116.121.82])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 073A83C0094;
        Sun, 29 Nov 2020 18:40:33 +0100 (CET)
Subject: Re: [PATCH] git-gui: use gray selection background for inactive text
 widgets
From:   Stefan Haller <stefan@haller-berlin.de>
To:     serg.partizan@gmail.com
Cc:     me@yadavpratyush.com, git@vger.kernel.org
References: <DZJ7KQ.UXACXR9SWDQI3@gmail.com>
 <20201123114805.48800-1-stefan@haller-berlin.de>
Message-ID: <1a42781d-0e4c-6478-f26d-5eccbd9c6205@haller-berlin.de>
Date:   Sun, 29 Nov 2020 18:40:33 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201123114805.48800-1-stefan@haller-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23.11.20 12:48, Stefan Haller wrote:
> On 22.11.20 18:16, serg.partizan@gmail.com wrote:
>> I think calculating that gray color from current selection bg is too much work
>> for just one color.
>>
>> We can just set inactiveSelectBackground to some neutral gray color like
>> #707070 or #909090 which will work fine with both dark and light themes.
> 
> OK, fine with me. Here's a patch that does this (it sits on top of yours). It
> almost works, except for one problem: on Mac, the inactive selection background
> is white instead of lightgray, but only for the diff view; for the commit editor
> it's correct. On Windows it's also correct for both views. I can't figure out
> what's the difference on Mac; do you have an idea what could be wrong?

After spending quite a while single-stepping through lots of Tk code, I
found the reason. On Mac, disabled text widgets simply don't draw the
selection background. [1]

I can see three options for solving this:

1) Don't use "state focus" and "state !focus" on the text widgets, but
   instead set the selection color manually using "text conf sel
   -background". Disadvantage: have to calculate the disabled color
   using a heuristic like I did for the file lists in my v2 patch.

2) Don't use "configure -state disabled" to make the diff text widget
   read-only; instead, use one of the other methods from [2].
   Disadvantage: quite a big change, and seems complex to me.

3) Enable the the diff widget when it loses focus, and disable it again
   when it gets focus. I tried this in a quick prototype, and it works
   very well. It just *feels* wrong to enable a read-only text widget
   while it is unfocused; but I couldn't find any situation where it
   would behave wrong, because as soon as you try to interact with it,
   the first thing that happens is that it gets disabled again.

I tend towards option 3, because it's reasonably simple and works. I'll
work on a patch tomorrow unless anybody has objections.

-Stefan

[1] https://github.com/tcltk/tk/blob/main/generic/tkTextDisp.c#L847
[2] https://wiki.tcl-lang.org/page/Read-only+text+widget
