Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E50C25B06
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 21:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiHJVPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 17:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiHJVPp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 17:15:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4214A5FAFE
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 14:15:45 -0700 (PDT)
Received: (qmail 6885 invoked by uid 109); 10 Aug 2022 21:15:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Aug 2022 21:15:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15664 invoked by uid 111); 10 Aug 2022 21:15:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Aug 2022 17:15:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Aug 2022 17:15:43 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] [RFC] list-objects-filter: introduce new filter
 sparse:buffer=<spec>
Message-ID: <YvQf/xW7oohAsJct@coredump.intra.peff.net>
References: <pull.1316.git.1659958159193.gitgitgadget@gmail.com>
 <xmqqczdau2yd.fsf@gitster.g>
 <46ca40a9-2d9a-3c7c-3272-938003f4967a@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46ca40a9-2d9a-3c7c-3272-938003f4967a@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 09, 2022 at 09:37:09AM -0400, Derrick Stolee wrote:

> > Was the reason why we have "we limit to an object we already have"
> > restriction because we didn't want to blindly use a piece of
> > uncontrolled arbigrary end-user data here?  Just wondering.
> 
> One of the ideas here was to limit the opportunity of sending an
> arbitrary set of data over the Git protocol and avoid exactly the
> scenario you mention.

One other implication here is that the filter spec is sent inside of a
pkt-line.  So the implementation here is limiting us to 64kb. That may
sound like a lot for simple specs, but I imagine in big repos they can
possibly get pretty complex.

That would be fixable with a protocol extension to take the data over
multiple pkt-lines.

That said...

> At this moment, I think path-scoped filters have a lot of problems
> that need solving before they can be used effectively in the wild.
> I would prefer that we solve those problems before making the
> feature more complicated. That's a tall ask, since these problems
> do not have simple solutions.

...I agree with this. It is nice to put more power in the hands of the
clients, but we have to balance that with other issues like server
resource use. The approach so far has been to implement the simplest and
most efficient operations at the client-server level, and then have the
client build local features on top of that. So in this case, probably
requesting that _no_ trees are sent in the initial clone, and then
faulting them in as the client explores the tree using its own local
sparse definition. And I think that mostly works now.

Though I admit I do not keep a close watch on the status of
partial-checkout features. I mostly always cared about it from the
server provider angle. ;)

-Peff
