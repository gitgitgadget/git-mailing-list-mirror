Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370E3C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 01:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1570960FE6
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 01:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243878AbhH0BGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 21:06:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:60294 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231434AbhH0BGr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 21:06:47 -0400
Received: (qmail 5117 invoked by uid 109); 27 Aug 2021 01:05:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Aug 2021 01:05:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10483 invoked by uid 111); 27 Aug 2021 01:05:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Aug 2021 21:05:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Aug 2021 21:05:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, Yuri <yuri@rawbw.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: 'git pull' complains that a locally resurrected directory would
 be overwritten by merge when no pulled changes are affecting that directory
Message-ID: <YSg6dshmB5JA7KZO@coredump.intra.peff.net>
References: <01514401-78f6-3fdc-aa74-c519fb6ab427@rawbw.com>
 <YSWXSWiDWNU93lhC@coredump.intra.peff.net>
 <CABPp-BEMXW3EOdT4jt1g63uPyZ5YuKUPfBE9BL=E66QcT5uXXA@mail.gmail.com>
 <xmqqzgt5gr3g.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgt5gr3g.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 02:19:15PM -0700, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
> 
> > ... allow if the incoming changes don't touch the same files), but
> > local *staged* changes.  As per the merge manpage:
> >
> > """
> > To avoid recording unrelated changes in the merge commit, git pull and
> > git merge will also abort if there are any changes registered in the
> > index relative to the HEAD commit.
> > """
> >
> > While this particular example could theoretically be handled by the
> > merge machinery without requiring the index match HEAD,...
> 
> While I do not mind seeing a patch that loosens the condition ONLY
> when the merge will cleanly auto-resolve without end-user
> interaction, when any paths conflict and require editing by the
> end-user, it is pretty much essential to require that the index
> matches HEAD to keep "git merge" usable. 
> 
> This is because the final step to conclude such an "automated
> procedure cannot cleanly resolve, so the end user helps resolving
> with the editor and mark the resolved paths with 'git add' or 'git
> rm'" session will become very error prone if we did not have the
> requirement.  Not just the user MUST remember not to use "commit -a"
> or "git add" a path that was already dirty in the working tree
> before the merge started (which is the consequence of the current
> requirement, which allows local changes to the unrelated working
> tree files), they must MUST remember to somehow EXCLUDE the changes
> already registered for unrelted paths from the concluded merge.

Good point.

In theory we could reject the merge only after finding that there were
conflicts. That lets the happy path continue even with unrelated changes
(just like a fast-forward does). I suspect we'd need to change the
interface to the merge-backends, though (to say "do the merge, and bail
on conflicts, but _don't_ write out conflict markers or touch any other
state in that case").

(I am just thinking out loud, though. My personal opinion is that if you
have a bunch of staged changes and want to do any non-trivial merging,
you should considering committing or stashing those changes).

-Peff
