Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDE8E1F576
	for <e@80x24.org>; Wed, 24 Jan 2018 10:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932891AbeAXKcs (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 05:32:48 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:59698 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932859AbeAXKcr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 05:32:47 -0500
Received: from [192.168.2.240] ([92.22.6.159])
        by smtp.talktalk.net with SMTP
        id eIMGemEZhCbAZeIMGechyV; Wed, 24 Jan 2018 10:32:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1516789965;
        bh=EZ8xaUGV2h/Yr9T4s/4n4KzOB36ZB5F497ZSOXEZKlM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=N9TPOjcdzgBPLKjIgDm/baNrRArtIZK/jYVR1wwWBDR5dExzQ3Htx8xB0zHpL6+Wy
         cp0jzqpU9lqXbzcxT20kQbpBuLY8lpGQtkDofjLCQLD4FRFGt5pS+kouJLIt4LjRUr
         fm/5/o2m50SufARxqsMgWbi4jII4PL5MEfTRac6Y=
X-Originating-IP: [92.22.6.159]
X-Spam: 0
X-OAuthority: v=2.2 cv=JvuBlIwC c=1 sm=1 tr=0 a=zHCrIP3pJrCm+L4FAUKT3Q==:117
 a=zHCrIP3pJrCm+L4FAUKT3Q==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=p6Q6hMC2-a0vtcDAqCEA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/8] sequencer: fast-forward merge commits, if possible
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <9878bd57cc82daf08309943305460c1e8a050518.1516225925.git.johannes.schindelin@gmx.de>
 <7e6906c9-d642-ee8d-82fd-29ee6c60e308@talktalk.net>
 <xmqqr2qggzie.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <f1c5e283-d9c9-700d-0484-ec9c6bf76068@talktalk.net>
Date:   Wed, 24 Jan 2018 10:32:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqr2qggzie.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNVB+ClzzkoX/Y/8YCYXA3swZb3IuqyUvQG2PYlVimJ8ObeRT0SZVjKvCJDa188F/JOdcgYzLM7t2h+vgz7KlW31K38YCaVXyL4N7DGdDoYQAQz7NwgU
 vWXyJB98G1apMIvNcv1QgA4XiPPx7OivIl1c2hPbmS7VnX6t0tvw32jNwMI29cD89c9h9GJqx+G8EJ7VeTiLbh9A4jhto4UIY8o4P51xzfFVRJbLmpihhO91
 Dzdk7hDLH8m63ZEBtC7qtYTWmA7HFTM3x9taYE2/rsM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/01/18 19:12, Junio C Hamano wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
>> On 18/01/18 15:35, Johannes Schindelin wrote:
>>>
>>> Just like with regular `pick` commands, if we are trying to recreate a
>>> merge commit, we now test whether the parents of said commit match HEAD
>>> and the commits to be merged, and fast-forward if possible.
>>>
>>> This is not only faster, but also avoids unnecessary proliferation of
>>> new objects.
>>
>> I might have missed something but shouldn't this be checking opts->allow_ff?
> 
> Because the whole point of this mechanism is to recreate the
> topology faithfully to the original, even if the original was a
> redundant merge (which has a side parent that is an ancestor or a
> descendant of the first parent), we should just point at the
> original merge when the condition allows it, regardless of
> opts->allow_ff.

I agree that the merge should be recreated, but I was thinking of 
something slightly different. Currently the sequencer uses 
opts->allow_ff to control whether a new commit with the same contents 
should be created even if the existing one could be reused. So I was 
querying whether we should recreate the commit when the user run 'git 
rebase --recreate-merges --no-ff' rather than just reusing it. As merges 
also have another meaning for fast-forward the terminology gets confusing.

> I think it is a different matter if an insn to create a new merge
> (i.e. "merge - <parent> <message>", not "merge <commit> <parent>")
> should honor opts->allow_ff; because it is not about recreating an
> existing history but is a way to create what did not exist before,
> I think it is sensible if allow_ff option is honored.

This is the merge sense of 'fast-forward' not the existing sequencer 
sense, without thinking about it more I'm not sure if one command line 
option for rebase is sufficient to cover both uses.

Best Wishes

Phillip

