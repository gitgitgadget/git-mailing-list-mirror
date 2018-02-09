Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7B621F404
	for <e@80x24.org>; Fri,  9 Feb 2018 23:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbeBIXti (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 18:49:38 -0500
Received: from grym.ekleog.org ([94.23.42.210]:55196 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752521AbeBIXtg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 18:49:36 -0500
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id d37e69f2;
        Fri, 9 Feb 2018 23:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        grym-20170528; bh=3cVUNlBZ+h6TUoztN2TOpQuNK4Q=; b=HbyVA/7YOa7k5M
        k3/ZPPo/0BZU/62nDzYfMWlREZUXSANdeOo7vL2XM2wZzm9vWCjxsni7rivXFpJg
        d+ywWigwhPKXh/fj2rOPY4eYwaUXctRCCr8XUVYtnbBcchrn6HQGR0mPZp+X8SPh
        /2NOQAq7LGbKHzsX/PTPUDz/2i4FE=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTPSA id 336111cd (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 9 Feb 2018 23:49:35 +0000 (UTC)
Subject: Re: Fetch-hooks
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     Joey Hess <id@joeyh.name>, git@vger.kernel.org,
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
From:   Leo Gaspard <leo@gaspard.io>
Message-ID: <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
Date:   Sat, 10 Feb 2018 00:49:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209223011.GA24578@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/2018 11:30 PM, Jeff King wrote:
> On Fri, Feb 09, 2018 at 11:04:17PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> One thing that's not discussed yet, and I know just enough about for it
>> to tingle my spidey sense, but not enough to say for sure (CC'd Jeff &
>> Brandon who know more) is that this feature once shipped might cause
>> higher load on git hosting providers.
>>
>> This is because people will inevitably use it in popular projects for
>> some custom filtering, and because you're continually re-fetching and
>> inspecting stuff what used to be a really cheap no-op "pull" most of the
>> time is a more expensive negotiation every time before the client
>> rejects the refs again, and worse for hosting providers because you have
>> bespoke ref fetching strategies you have less odds of being able to
>> cache both the negotiation and the pack you serve.
> 
> Most of the discussion so far seems to be about "accept this ref or
> don't accept this ref", which seems OK. But if you are going to do
> custom tweaking like rewriting objects, or making it common to refuse
> some refs, then I think things get pretty inefficient for _everybody_.
> 
> The negotiation for future fetches uses the existing refs as the
> starting point. And if we don't know that we have the objects because
> there are no refs pointing at them, they're going to get transferred
> again. That's extra load no the server, and extra time for the user
> waiting on the network.

Oh. I thought the protocol git used was something like
client: I want to fetch refs A and B
server: so you'll need objects 12345678 and 90ABCDEF, A and B both point
to 12345678
client: please give me object 12345678
server: here it is
[...]

I was clearly wrong, thanks! (and thanks Ævar for your explanation in
the side-thread, too!)

> I tend to agree with the direction of thinking you outlined: you're
> generally better off completing the fetch to a local namespace that
> tracks the other side completely, and then manipulating the local refs
> as you see fit (e.g., fetching into refs/quarantine, and then migrating
> "good" refs over to refs/remotes/origin).

Hmm... so do I understand it correctly when I say the process you're
thinking about works like this?
 * User installs hook for my-remote by running [something]
 * User runs git fetch
 * git fetch fetches remote refs/heads/* to local refs/quarantine/* (so
I guess [something] changes the remote.my-remote.fetch refmap)
 * When this is done `git fetch` runs a notification-only post-fetch
hook (that would need to be added)
 * The post-fetch hook then performs whatever it wants and updates the
references in refs/remotes/my-remote/*

So the changes that are required are:
 * Adding a notification-only post-fetch hook
 * For handling tags, there is a need to have a refmap for tags. Maybe
adding a remote.my-remote.fetchTags refmap, that would be used when
running with --tags, and having it default to “refs/tags/*:refs/tags/*”
to keep the current behavior by default?

The only remaining issue I can think of is: How do we avoid the issue of
the
trigger-only-hook-inciting-bad-behavior-by-hook-authors-who-really-want-modification
raised in the side-thread that Junio wrote in [1]? Maybe just writing in
the documentation that the hook should use a quarantine-like approach if
it wants modification would be enough to not have hook authors try to
modify the ref in the post-fetch hook?

Thanks for all your thoughts, and hope we're getting somewhere!
Leo


PS: I'll read over the reviews once I'm all clear as to what exactly is
wanted for this patch, as most likely they'll just be dumped, given the
current state of affairs.

[1] https://marc.info/?l=git&m=132480559712592&w=2
