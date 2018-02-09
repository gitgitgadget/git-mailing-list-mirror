Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D701F1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 22:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753112AbeBIWYw (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 17:24:52 -0500
Received: from grym.ekleog.org ([94.23.42.210]:55118 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752522AbeBIWYv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 17:24:51 -0500
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id 181a85e4;
        Fri, 9 Feb 2018 22:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        grym-20170528; bh=EHTaKtZCKlh4fQmvE5tVuOeZrGU=; b=GZKnW7AWIQeCXA
        zZw5dLILx9ARJJLOO1CL6HgRtDaWPKb+InPOZ2P75zu9libwkqxBV2CfipsRsUmo
        j3hzUTvttZzBjnamezfLbxDQQKR1ouVFlk5AmC7RqXcZriykcEMye7Q+83FQl1co
        +rtcEj2cEL76HR4eQlVzLTSzcqoKc=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTPSA id 34c1252f (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 9 Feb 2018 22:24:48 +0000 (UTC)
Subject: Re: Fetch-hooks
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
 <87inb8mn0w.fsf@evledraar.gmail.com>
 <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
 <20180208153040.GA5180@kitenet.net>
 <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
 <87bmgzmbsk.fsf@evledraar.gmail.com>
 <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
 <87po5dbz1a.fsf@evledraar.gmail.com>
From:   Leo Gaspard <leo@gaspard.io>
Message-ID: <25bd770c-6a48-5b5d-04cc-6d02784ea3e7@gaspard.io>
Date:   Fri, 9 Feb 2018 23:24:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87po5dbz1a.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/2018 11:04 PM, Ævar Arnfjörð Bjarmason wrote:>>> You could also
have some intermediate step between these two, where
>>> e.g. your refspec for "origin" is
>>> "+refs/heads/*:refs/remotes/origin-untrusted/*" instead of the default
>>> "+refs/heads/*:refs/remotes/origin/*", you fetch all refs to that
>>> location, then you move them (with some alias/hook) to
>>> "refs/remotes/origin/*" once they're seen to be "OK".
>>
>> That is indeed another possibility, but then the idea is to make things
>> as transparent as possible for the end-user, not to completely change
>> their git workflow. As such, considering only signed commits to be part
>> of the upstream seems to make sense to me?
> 
> I mean this would be something that would be part of a post-fetch hook,
> so it would be as transparent as what you're doing to the user, with the
> difference that it doesn't need to involve changes to what you slurp
> down from the server.
> 
> I.e. we'd just fetch into refs/remotes/origin-untrusted/, then we run
> your post-fetch hook and you go over the new refs, and copy what you
> like (usually everything) to refs/remotes/origin/*.

Hmm... but that would then require a post-fetch hook, wouldn't it? And
about a post-fetch hook, if I understood correctly, Junio in [1] had a
quite nice argument against it:

    Although I do not deeply care between such a "trigger to only
    notify, no touching" hook and a full-blown "allow hook writers to
    easily lie about what happened in the fetch" hook, I was hoping that
    we would get this right and useful if we were spending our brain
    bandwidth on it. I am not very fond of an easier "trigger to only
    notify" hook because people are bound to misuse the interface and
    try updating the refs anyway, making it easy to introduce
    inconsistencies between refs and FETCH_HEAD that will confuse the
    later "merge" step.

Otherwise, if it doesn't require a post-fetch hook, then it would
require the end-user to first fetch, then run the
`copy-trusted-refs-over` script, which would add stuff to the user's
workflow.

Did I miss another possibility?

> [...]
> 
> One thing that's not discussed yet, and I know just enough about for it
> to tingle my spidey sense, but not enough to say for sure (CC'd Jeff &
> Brandon who know more) is that this feature once shipped might cause
> higher load on git hosting providers.
> 
> This is because people will inevitably use it in popular projects for
> some custom filtering, and because you're continually re-fetching and
> inspecting stuff what used to be a really cheap no-op "pull" most of the
> time is a more expensive negotiation every time before the client
> rejects the refs again, and worse for hosting providers because you have
> bespoke ref fetching strategies you have less odds of being able to
> cache both the negotiation and the pack you serve.
> 
> I.e. you want this for some security feature where 99.99% of the time
> you accept all refs, but most people will probably use this to implement
> dynamic Turing-complete refspecs.
> 
> Maybe that's worrying about nothing, but worth thinking about.

Well... First, I must say I didn't really understand your last paragraph
about Turing-complete refspecs.

But my understanding of how the fetch-hook patchset I sent this evening
works is that it first receives all the objects from the hosting
provider, then locally moves the refs, but never actually discards the
downloaded objects (well, until a `git gc` I guess).

So I don't think the network traffic with the provider would be any
different wrt. what it is now, even if a tweak-fetch hook rejects some
commits? Then again I don't know git's internals enough to be have even
a bit of certainty about what I'm saying right now, so...


[1] https://marc.info/?l=git&m=132480559712592&w=2
