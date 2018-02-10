Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52161F404
	for <e@80x24.org>; Sat, 10 Feb 2018 00:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753327AbeBJAhW (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 19:37:22 -0500
Received: from grym.ekleog.org ([94.23.42.210]:55246 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753300AbeBJAhV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 19:37:21 -0500
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id 1de1ca48;
        Sat, 10 Feb 2018 00:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        grym-20170528; bh=ziQNEO7Cx5tEj9VcaVEqlORQF78=; b=VUWnAbiPt/vogR
        kvTV3HCnH/JrgmxmYM3Q/J72JfsQ/34MPZwronjnoPDZcBMArQMF4bzCqKEcUKJg
        Y2kYt4kG6BGZFfM7R3YZ1Fbi3Qqw3mhmpVnLAqV9sV8yZYMiZ8Q5+x7JAtgAxbYb
        LDZ3Kiri0N7gul3Ny3r/j1n5bKPjQ=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTPSA id 9d6a0111 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sat, 10 Feb 2018 00:37:20 +0000 (UTC)
Subject: Re: Fetch-hooks
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
 <87inb8mn0w.fsf@evledraar.gmail.com>
 <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
 <20180208153040.GA5180@kitenet.net>
 <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
 <87bmgzmbsk.fsf@evledraar.gmail.com>
 <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
 <87po5dbz1a.fsf@evledraar.gmail.com>
 <20180209223011.GA24578@sigill.intra.peff.net>
 <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
 <20180210001317.GA26856@sigill.intra.peff.net>
From:   Leo Gaspard <leo@gaspard.io>
Message-ID: <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io>
Date:   Sat, 10 Feb 2018 01:37:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180210001317.GA26856@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/10/2018 01:13 AM, Jeff King wrote:
> On Sat, Feb 10, 2018 at 12:49:31AM +0100, Leo Gaspard wrote:
>> So the changes that are required are:
>>  * Adding a notification-only post-fetch hook
>>  * For handling tags, there is a need to have a refmap for tags. Maybe
>> adding a remote.my-remote.fetchTags refmap, that would be used when
>> running with --tags, and having it default to “refs/tags/*:refs/tags/*”
>> to keep the current behavior by default?
> 
> Yeah, tag-following may be a little tricky, because it usually wants to
> write to refs/tags/. One workaround would be to have your config look
> like this:
> 
>   [remote "origin"]
>   fetch = +refs/heads/*:refs/quarantine/origin/heads/*
>   fetch = +refs/tags/*:refs/quarantine/origin/tags/*
>   tagOpt = --no-tags
> 
> That's not exactly the same thing, because it would fetch all tags, not
> just those that point to the history on the branches. But in most
> repositories and workflows the distinction doesn't matter.

Hmm... apart from the implementation complexity (of which I have no
idea), is there an argument against the idea of adding a
remote.<name>.fetchTagsTo refmap similar to remote.<name>.fetch but used
every time a tag is fetched? (well, maybe not exactly similar to
remote.<name>.fetch because we know the source is going to be
refs/tags/*; so just having the part of .fetch past the ':' would be
more like what's needed I guess)

The issue with your solution is that if the user runs 'git fetch
--tags', he will get the (potentially compromised) tags directly in his
refs/tags/.

> (By the way, the I specifically chose the name "refs/quarantine" instead
> of anything in "refs/remotes" because we'd want to make sure that the
> "git checkout" DWIM behavior cannot accidentally pull from quarantine).

(Indeed, I understood after reading it, and would likely not have
thought of it otherwise, thanks!)

>> The only remaining issue I can think of is: How do we avoid the issue
>> of the
>> trigger-only-hook-inciting-bad-behavior-by-hook-authors-who-really-want-modification
>> raised in the side-thread that Junio wrote in [1]? Maybe just writing
>> in the documentation that the hook should use a quarantine-like
>> approach if it wants modification would be enough to not have hook
>> authors try to modify the ref in the post-fetch hook?
> 
> I don't have a silver bullet there. Documenting the "right" way at least
> seems like a good first step.

So long as it's not a merge-blocker it's good with me! (but then I'm
likely not the one who's going to be pointed at when things go wrong in
a hook, so I'm clearly biased on this matter)
