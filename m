Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 830421F461
	for <e@80x24.org>; Fri, 28 Jun 2019 23:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfF1XxH convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 28 Jun 2019 19:53:07 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:38115 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF1XxH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 19:53:07 -0400
X-Originating-IP: 24.188.109.83
Received: from vas-air.home (ool-18bc6d53.dyn.optonline.net [24.188.109.83])
        (Authenticated sender: vas@commonkarma.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id CC733240002;
        Fri, 28 Jun 2019 23:53:01 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/1] Let rebase.reschedulefailedexec only affect
 interactive rebases
From:   Vas Sudanagunta <vas@commonkarma.org>
In-Reply-To: <xmqq4l498irq.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 28 Jun 2019 19:52:59 -0400
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5862CF8D-2D4E-40B4-81A1-4BA9B59AC52E@commonkarma.org>
References: <pull.253.git.gitgitgadget@gmail.com>
 <fab124da41858b849ae74dfb1fe403bb834870f1.1561623167.git.gitgitgadget@gmail.com>
 <xmqqzhm2ang5.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1906281342280.44@tvgsbejvaqbjf.bet>
 <e332eb5f-0818-763c-9de0-889644446a35@gmail.com>
 <xmqq4l498irq.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, original reporter of the issue here. Some thoughts from a user perspective, from outside the black box of “the machinery":


It seems unintuitive that including a command to execute between each rebase merge implies an interactive rebase. It’s no more interactive than a sequence of rebase merges without intervening commands. A command failure interrupts a rebase just as a merge conflict does. If the fact that a rebase can be interrupts mid-sequence, then all rebases are interactive. 

The intuitive behavior for “rebase.reschedulefailedexec” is that it has no impact if nothing is scheduled.  It has nothing to do with interactivity. 

vas



On Jun 28, 2019, at 6:08 PM, Junio C Hamano <gitster@pobox.com> wrote:

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> I wonder if users understand that '-x' is "an interctive rebase".
>>> The documentation can read both ways, and one of these may want to
>>> be clarified.
>>> 
>>> 	-x <cmd>, --exec <cmd>
>>> 	...
>>> 	This uses the --interactive machinery internally, but it can
>>> 	be run without an explicit --interactive.
>>> 
>>> Is it saying that use of interactive machinery is an impelementation
>>> detail the users should not concern themselves (in which case, the
>>> message given to "die()" above is misleading---not a new problem
>>> with this patch, though)?  Is it saying "-x" makes it plenty clear
>>> that the user wants interactive behaviour, so the users do not need
>>> to spell out --interactive in order to ask for it (in which case,
>>> "die()" message is fine, but "... internally, but ..." is
>>> misleading)?
>> 
>> Hmm. What would you think about:
>> 
>>   		die(_("--reschedule-failed-exec requires --exec or --interactive"));

I was leaning towards admitting that the use of the interactive
machinery in "-x" is not merely an implementation detail and fixing
the documentation, leaving the die() message in the patch as-is.

But ...

> I was wondering about requiring --exec with --reschedule-failed-exec
> rather than checking is_interactive() as that would be easier to
> understand.

... I find this a reasonable way to think about the issue.  The
option only matters when we are doing "--exec".  And the usual
convenience measure we'd use, i.e. with --reschedule-failed-exec we
consider that we are implicitly in --exec mode, would not work
because there is no default "command" to be executed.

> One potential problem is if someone has an alias that
> always sets --reschedule-failed-exec but does not always add --exec to
> the command line.

Such a use case would be hitting this die() already without this
topic, wouldn't it?  In which case we can say there is no "someone"
with such an alias.

