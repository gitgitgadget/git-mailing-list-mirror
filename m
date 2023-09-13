Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088AEEE01E2
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 16:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjIMQoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 12:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjIMQno (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 12:43:44 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221784697
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 09:40:51 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id C77F920084;
        Wed, 13 Sep 2023 12:40:49 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qgSv2-SXQ-00; Wed, 13 Sep 2023 18:40:48 +0200
Date:   Wed, 13 Sep 2023 18:40:48 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     phillip.wood@dunelm.org.uk
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: ignore signals when forking subprocesses
Message-ID: <ZQHmEKQ1q1lciUqE@ugly>
References: <ZP2U8TBNjKs5ebky@ugly>
 <80eb7631-e5c0-497e-b2a9-b1f8c8a4a306@gmail.com>
 <a37a0f11-0723-4964-a187-54d960615d79@gmail.com>
 <ZP7st70/G3kLujHG@ugly>
 <51ad269b-d8df-4424-8127-293b2971d65d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <51ad269b-d8df-4424-8127-293b2971d65d@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2023 at 04:33:06PM +0100, Phillip Wood wrote:
>On 11/09/2023 11:32, Oswald Buddenhagen wrote:
>> On Mon, Sep 11, 2023 at 11:14:31AM +0100, Phillip Wood wrote:
>>> On 11/09/2023 11:00, Phillip Wood wrote:
>>>> There is an inevitable race between wait() returning and calling 
>>>> signal() to restore the handlers for SIGINT and SIGQUIT,
>>>
>>> In principle if we installed a signal handler to set a flag if a 
>>> signal is received while calling wait() and then once wait() returns 
>>> successfully see if the child was killed we can tell if the signal was 
>>> received while the child was alive.
>>>
>> yes, this is what i was already writing:
>
>I'm afraid that was not clear to me from your message.
>
i meant, this is what i already wrote before i read your reply-to-self.
i just pasted it into the new reply i sent instead without adjusting for 
the new context. the sentence was meant to explain the slight "impedance 
mismatch".

>> install the handlers when the sequencer is entered and leave them 
>> there. the handlers need to set (volatile) flag variables, which are 
>> checked by the sequencer on a regular basis.
>
>I did consider doing that before I submitted this patch

>but it is a much more invasive and substantial change.
>
yes

>The patch here makes it safe for the user to interrupt a subprocess 
>started by the sequencer.
>
for the exec case, i don't see how this actually improves anything.  
whether git gets killed along with the child, or catches the child's 
abnormal exit and immediately exits, makes no difference. arguably, it's 
even counter-productive, because from the outside it's random whether 
git will just exit on sigint or report that its child exited on sigint 
and exit with some other status.

actual value would come from doing something before exiting, but the 
commit message is pretty much saying that this is not the case.

the commit/edit case is more complicated, but arguably the problem is 
the (hypothetical?) editor that just ignores sigint rather than 
reprogramming the terminal appropriately for full-screen use.  
git-commit ignoring sigint seems like a somewhat misguided workaround, 
and piling on top of that won't really improve things.

>If I understand correctly your suggestion implies that the user could 
>interrupt the sequencer at any point and we'd need to exit and ensure 
>that they could safely continue the rebase afterwards.
>
yes

>That is not the case at the moment

>and I'm concerned making that promise could turn into a maintenance 
>burden in the future.
>
of course it would. the question is whether it would be worth it. with 
delayed state commits, some extra trasactionality might well be 
required.

regards
