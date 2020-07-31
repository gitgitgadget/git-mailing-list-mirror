Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B474FC433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 02:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F088207F5
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 02:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbgGaCWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 22:22:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:43282 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730797AbgGaCWS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 22:22:18 -0400
Received: (qmail 18146 invoked by uid 109); 31 Jul 2020 02:22:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 02:22:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23351 invoked by uid 111); 31 Jul 2020 02:22:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jul 2020 22:22:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jul 2020 22:22:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] fmt-merge-msg: selectively suppress "into
 <branch>"
Message-ID: <20200731022217.GA825094@coredump.intra.peff.net>
References: <xmqq5za596uo.fsf@gitster.c.googlers.com>
 <20200730180237.1392480-1-gitster@pobox.com>
 <20200731004202.GA240563@coredump.intra.peff.net>
 <xmqqy2n04ezk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2n04ezk.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 30, 2020 at 07:04:15PM -0700, Junio C Hamano wrote:

> You'd rather want to "lie" about the destination branch while
> redoing these merges, perhaps with
> 
> 	$ git merge --pretend-dest=jch topic-name
> 
> with your HEAD detached, and tell fmt-merge-msg to pretend that the
> merge is being made into jch branch.  And that is outside the scope
> of this patch, though it might be a good #leftoverbits candidate.

Since nobody really asked for it, it may make sense to wait for such a
feature. After all, this is the just the starting text we put into the
merge message. You are always free to add the pretend branch yourself in
the editor.

> >   - should "master" be in the list even if you configure a value? That
> >     would do the wrong thing if you have a non-integration master, but
> >     that seems unlikely. And it would do the right thing if somebody
> >     later puts "main" in merge.suppressDest, but still occasionally
> >     works with "master" repos (where "right" is defined as "what they
> >     probably wanted", but it is perhaps a bit magical).
> 
> If you configure, you can configure it fully without manually
> clearing first.  If you do not configure, you get a backward
> compatible default.  I think that is the only sensible semantics.
> 
> Besides, I thought we were aiming to make 'master' less special.
> When a user already has a concrete list of things to use shorter
> merge title for, why should 'master' be magically added to the list
> and force the user to explicitly clear it?  I do not think that
> makes much sense.

It's magic-ness would be purely for backwards compatibility. IMHO
maintaining exact behavior with respect to this particular case was not
a big deal, but clearly Linus disagrees. But the "do the right thing
above" I mentioned above is "do the right thing even if the user _did_
switch their config to a new name, but forgot that they sometimes are
working with old repos". So it is perhaps an even weaker reason.

To be clear, I'm OK with the behavior in your patch. I just wanted to
make sure we thought through all of the implications.

> >   - what's the plan if we do switch init.defaultBranch to "main"? Would
> >     we add default_branch() to the list of defaults alongside "master",
> >     or just add "main", or just leave it and let people configure
> >     independently? It doesn't need to be decided now, but maybe worth
> >     thinking about.
> [...quite reasonable analysis that I agree with...]
> 
> In any case, I do not think I want to see more reliance of the
> notion that there always is one and only one single special branch
> in the repository, so if we can get away without it, that would be
> more preferrable.

Yeah, if the plan is to stop here then I'm OK with that. That makes
"master" special for historical reasons, but "main" or whatever never
got this special treatment by default. People have the ability to
configure if they choose, or they may not care either way.

We might get a feature request later that says "gee, I wish we did this
for 'main' by default without me having to configure it", but we can
cross that bridge when we come to it.

-Peff
