Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0E021F404
	for <e@80x24.org>; Sat, 10 Feb 2018 18:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbeBJSgt (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 13:36:49 -0500
Received: from grym.ekleog.org ([94.23.42.210]:55894 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbeBJSgs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 13:36:48 -0500
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id 77c7d4c4;
        Sat, 10 Feb 2018 18:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        grym-20170528; bh=EAWnBdBB0lMQBtfC4t4czF1th7w=; b=2pGsoOFWkxUybs
        zRXYrZ9AKg+ArFu61z6XrFnj1J+WGTtnoKMUcRExhEgTMhUGXbo8jBMlICYW+Hbz
        ECNyZGXuXS3MB3XIqFWh9ifp/zJV0mlVwI4l/ENIUDzS4mlAb7Uhm8auxNzUWNlZ
        bE02qHEkGBP+Sosvmcuw6oEDZ8T6U=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTPSA id 7da92812 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sat, 10 Feb 2018 18:36:47 +0000 (UTC)
Subject: Re: Fetch-hooks
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
 <20180208153040.GA5180@kitenet.net>
 <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
 <87bmgzmbsk.fsf@evledraar.gmail.com>
 <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
 <87po5dbz1a.fsf@evledraar.gmail.com>
 <20180209223011.GA24578@sigill.intra.peff.net>
 <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
 <20180210001317.GA26856@sigill.intra.peff.net>
 <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io>
 <20180210122131.GB21843@sigill.intra.peff.net>
From:   Leo Gaspard <leo@gaspard.io>
Message-ID: <5abf8565-1aa1-c101-83a7-90781682bc7a@gaspard.io>
Date:   Sat, 10 Feb 2018 19:36:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180210122131.GB21843@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/10/2018 01:21 PM, Jeff King wrote:
> On Sat, Feb 10, 2018 at 01:37:20AM +0100, Leo Gaspard wrote:
> 
>>> Yeah, tag-following may be a little tricky, because it usually wants to
>>> write to refs/tags/. One workaround would be to have your config look
>>> like this:
>>>
>>>   [remote "origin"]
>>>   fetch = +refs/heads/*:refs/quarantine/origin/heads/*
>>>   fetch = +refs/tags/*:refs/quarantine/origin/tags/*
>>>   tagOpt = --no-tags
>>>
>>> That's not exactly the same thing, because it would fetch all tags, not
>>> just those that point to the history on the branches. But in most
>>> repositories and workflows the distinction doesn't matter.
>>
>> Hmm... apart from the implementation complexity (of which I have no
>> idea), is there an argument against the idea of adding a
>> remote.<name>.fetchTagsTo refmap similar to remote.<name>.fetch but used
>> every time a tag is fetched? (well, maybe not exactly similar to
>> remote.<name>.fetch because we know the source is going to be
>> refs/tags/*; so just having the part of .fetch past the ':' would be
>> more like what's needed I guess)
> 
> I don't think it would be too hard to implement, and is at least
> logically consistent with the way we handle tags.
> 
> If we were designing from scratch, I do think this would all be helped
> immensely by having more separation of refs fetched from remotes. There
> was a proposal in the v1.8 era to fetch everything for a remote,
> including tags, into "refs/remotes/origin/heads/",
> "refs/remotes/origin/tags/", etc. And then we'd teach the lookup side to
> look for tags in each of the remote-tag namespaces.
> 
> I still think that would be a good direction to go, but it would be a
> big project (which is why the original stalled).

Hmm... would this also drown the remote.<name>.fetch map? Also, I think
this behavior could be emulated with fetch and fetchTagsTo, and it would
look like:
[remote "my-remote"]
    fetch = +refs/heads/*:refs/remotes/my-remote/heads/*
    fetchTagsTo = refs/remotes/my-remote/tags/*
The remaining issue being to teach the lookup side to look for tags in
all the remote-tag namespaces (and the fact it's a breaking change).

That said, actually I just noticed an issue in the “add a
remote.<name>.fetch option to fetch to refs/quarantine then have the
post-fetch hook do the work”: it means if I run `git pull`, then:
 1. The remote references will be pulled to refs/quarantine/...
 2. The post-fetch hook will copy the accepted ones to refs/remotes/...
 3. The `git merge FETCH_HEAD` called by pull will merge FETCH_HEAD into
local branches... and so merge from refs/quarantine.

A solution would be to also update FETCH_HEAD in the post-fetch hook,
but then we're back to the issue raised by Junio after the “*HOWEVER*”
of [1]: the hook writer has to maintain consistency between the “copied”
references and FETCH_HEAD.

So, when thinking about it, I'm back to thinking the proper hook
interface should be the one of the tweak-fetch hook, but its
implementation should make it not go crazy on remote servers. And so
that the implementation should do all this refs/quarantine wizardry
inside git itself.

So basically what I'm getting at at the moment is that git fetch should:
 1. fetch all the references to refs/real-remotes/<name>/{insert here a
copy of the refs/ tree of <name>}
 2. figure out what the “expected” names for these references will by,
by looking at remote.<name>.fetch (and at whether --tags was passed)
 3. for each “expected” name,
     1. if a tweak-fetch hook is present, call it with the
refs/real-remotes/... refname and the “expected end-name” from
remote.<name>.fetch
     2. based on the hook's result, potentially to move the “expected
end-name” to another commit than the one referenced by refs/real-remotes/...
     3. move the “expected” name to the commit referenced in
refs/real-remotes

Which would make the tweak-fetch hook interface simpler (though more
restrictive, but I don't have any real use case for the other change
possibilities) than it is now:
 1. feed the hook with lines of
“refs/real-remotes/my-remote/heads/my-branch
refs/remotes/my-remote/my-branch” (assuming remote.my-remote.fetch is
“normal”) or “refs/real-remotes/my-remote/tags/my-tag refs/tags/my-tag”
(if my-tag is being fetched from my-remote)
 2. read lines of “<refspec> refs/remotes/my-remote/my-branch”, that
will re-point my-branch to <refspec> instead of
refs/real-remotes/my-remote/heads/my-branch. In order to avoid any
issue, the hook is not allowed to pass as second output a reference that
was not passed as second input.

This way, the behavior of the tweak-fetch hook is reasonably preserved
(at least for my use case), and there is no additional load on the
servers thanks to the up-to-date references being stored in
refs/real-remotes/<name>/<refspec>

Does this reasoning make any sense?


[1] https://marc.info/?l=git&m=132478296309094&w=2
