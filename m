Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C6E81F404
	for <e@80x24.org>; Wed, 14 Feb 2018 02:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966443AbeBNCCD (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 21:02:03 -0500
Received: from grym.ekleog.org ([94.23.42.210]:59706 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966401AbeBNCCC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 21:02:02 -0500
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id 3c2638df;
        Wed, 14 Feb 2018 02:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        grym-20170528; bh=IuRvqdDetQJrIG/9vXOnp1DnadY=; b=Ea0OqKR8EPtfmK
        8YrLZDimwKTY0+hzyZA1f9/7Squ1gX2/SBQ+zuZcWw751L53pT1QLUGDZ9Yj78l+
        vWnJ/L+tQ3KOQf5/RDmGDtbYeyV3LIaziVvJQljb8co7fBCPsejtoIepiFBeS/U9
        g4V44IV03N3Y6wy5htsuotuAJRe3w=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTPSA id ce34cf4e (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 14 Feb 2018 02:02:00 +0000 (UTC)
Subject: Re: Fetch-hooks
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
 <87bmgzmbsk.fsf@evledraar.gmail.com>
 <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
 <87po5dbz1a.fsf@evledraar.gmail.com>
 <20180209223011.GA24578@sigill.intra.peff.net>
 <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
 <20180210001317.GA26856@sigill.intra.peff.net>
 <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io>
 <20180210122131.GB21843@sigill.intra.peff.net>
 <5abf8565-1aa1-c101-83a7-90781682bc7a@gaspard.io>
 <20180214013520.GA25188@sigill.intra.peff.net>
From:   Leo Gaspard <leo@gaspard.io>
Message-ID: <96dd7fb3-849b-8de6-7c3a-cd6bde9da432@gaspard.io>
Date:   Wed, 14 Feb 2018 03:02:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180214013520.GA25188@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/14/2018 02:35 AM, Jeff King wrote:
> On Sat, Feb 10, 2018 at 07:36:47PM +0100, Leo Gaspard wrote:
>> [...]
> I think there may have been some more concrete proposals after that, but
> that's what I was able to dig up quickly.

Thanks! Though it looks way above my knowledge of git internals as well
as time available, it looks like a great project, and I hope it someday
succeeds!

>> That said, actually I just noticed an issue in the “add a
>> remote.<name>.fetch option to fetch to refs/quarantine then have the
>> post-fetch hook do the work”: it means if I run `git pull`, then:
>>  1. The remote references will be pulled to refs/quarantine/...
>>  2. The post-fetch hook will copy the accepted ones to refs/remotes/...
>>  3. The `git merge FETCH_HEAD` called by pull will merge FETCH_HEAD into
>> local branches... and so merge from refs/quarantine.
> 
> Good point. You can't munge FETCH_HEAD by playing with refspecs.
> 
> I am starting to come around to the idea that "pre-fetch" might be the
> best way to do what you want. Not to rewrite refs, but perhaps to simply
> reject them. In the same way that we allow pre-receive to reject pushed
> refs (both are, after all, the final check on admitting new history into
> the repository, just in opposite directions).
> 
>> So, when thinking about it, I'm back to thinking the proper hook
>> interface should be the one of the tweak-fetch hook, but its
>> implementation should make it not go crazy on remote servers. And so
>> that the implementation should do all this refs/quarantine wizardry
>> inside git itself.
> 
> So does anybody actually want to be able to adjust the refs as they pass
> through? It really sounds like you just want to be able to reject or not
> reject the fetch. And that rejecting would be the uncommon case, so it's
> OK to just abort the whole operation and expect the user to figure it
> out.

This completely fits my use case (modulo the fact that it's more similar
to the `update` hook than to `pre-receive` I think, as verifying the
signature requires the objects to already have been downloaded), indeed,
though I'm not sure it would have fit Joey's (based on my understanding,
adding a merge was what was originally asked for).

Actually, I'm wondering if the existing semantics of `update` could not
be reused for the `pre-fetch`. Would it make sense to just call `update`
during a fetch in the same way as during a receive-pack? That said it
likely makes this a breaking change, though it's maybe unlikely that a
repository is used both for fetching and for receive-pack'ing, it could
happen.

So the proposal as I understand it would currently be adding a
`fetch-update` hook that does exactly the same thing as `update` but for
`fetch`. This solves my use case in a nice way, though it likely doesn't
solve Joey's original one (which has been taken care of by a wrapper
since then).

What do you all think about it?
