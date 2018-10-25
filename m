Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9A801F453
	for <e@80x24.org>; Thu, 25 Oct 2018 05:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeJYOLJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 10:11:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:53802 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726804AbeJYOLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 10:11:09 -0400
Received: (qmail 23378 invoked by uid 109); 25 Oct 2018 05:40:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Oct 2018 05:40:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13689 invoked by uid 111); 25 Oct 2018 05:39:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 25 Oct 2018 01:39:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2018 01:39:59 -0400
Date:   Thu, 25 Oct 2018 01:39:59 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: New semantic patches vs. in-flight topics [was: Re: [PATCH
 00/19] Bring more repository handles into our code base]
Message-ID: <20181025053959.GB11460@sigill.intra.peff.net>
References: <20181016233550.251311-1-sbeller@google.com>
 <20181022173935.GG30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181022173935.GG30222@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 07:39:35PM +0200, SZEDER Gábor wrote:

> I don't really like how this or the previous RFC patch series deal
> with semantic patches (or how some past patch series dealt with them,
> for that matter), for various reasons:
> [..]

I am a little late to this thread, but it really seems to me that the
crux of the issue here:

>   - 'make coccicheck' won't run clean (and the static analysis build
>     job on Travis CI will fail) for all commits following adding the
>     new semantic patches but before applying the resulting
>     transformations.
> 
>   - These semantic patches interact badly with 'pu' and 'next',
>     because those integration branches can contain topic branches
>     adding new code that should be transformed by these semanic
>     patches.  Consequently, 'make coccicheck' won't run clean and the
>     static analysis build job will fail until all those topics reach
>     'master', and the remaining transformations are applied on top.

Is that we are considering it a failure for "pu" to have pending
coccinelle patches. Are there any coccicheck transformations that aren't
just "we prefer to do it like X instead of Y"?

Changes that actually break things should be caught by the compiler
(either by their nature, or because we take care to rename or change
interfaces when making a semantic change to a function).

I think that's getting at what you're saying here:

>   - Is it really necessary to carry these semantic patches in-tree?
>     Let me ellaborate.  There are basically two main use cases for
>     semantic patches:
> 
>       - To avoid undesirable code patterns, e.g. we should not use
> [...]
>       - To perform one-off code transformations, e.g. to modify a

I am mostly thinking of your first type here. And I think it makes sense
for people to avoid submitting code that does not pass "make coccicheck"
_as it was at the state of their branch_. But for cocci changes that are
in flight at the same time as their branch, I do not see any need to
strictly adhere to them. The code is "undesirable", not "wrong".

For the second type, I agree that we do not necessarily need to carry
them in-tree. Eventually the transformation happens, and nobody would
use the "old" way because it doesn't work anymore. Problem solved.

I do not mind carrying them for a while as a convenience to people who
will need to fix up their topics in flight (or more likely to the
maintainer, who will need to fixup the merge). But we should make sure
not to forget to remove them when their usefulness has passed.

Likewise, we should not forget to occasionally run "make coccicheck" on
master to make sure people have a clean base to build on. If Junio is
able to do that, then great. But other people can also do so and submit
patches (to go on their respective topics, or to be a new mass-cleanup
topic).

I guess there is some lag there if Junio pushes out a master branch that
fails coccicheck, because contributors may build on it before somebody
gets around to fixing it.

>         Having said that, it's certainly easier to double-check the
>         resulting transformations when one can apply the semantic
>         patches locally, and doing so is easier when the semantic
>         patches are in tree than when they must be copy-pasted from a
>         commit message.

I've wondered if we could have a script that pulls a coccinelle snippet
from a commit message and runs it. It may be a hassle to find the right
commit, though (you'd start the procedure from "oops, my compile now
seems broken; what was the change that I need to apply to adapt?").

>   - A new semantic patch should be added as "pending", e.g. to the
>     file 'the_repository.pending.cocci', together with the resulting
>     transformations in the same commit.
> 
>     This way neither 'make coccicheck' nor the static analysis build
>     job would complain in the topic branch or in the two integration
>     branches.  And if they do complain, then we would know right away
>     that they complain because of a well-established semantic patch.
>     Yet, anyone interested could run 'make coccicheck-pending' to see
>     where are we heading.

OK, makes sense.

>   - The author of the "pending" semanting patch should then keep an
>     eye on already cooking topics: whether any of them contain new
>     code that should be transformed, and how they progress to
>     'master', and sending followup patch(es) with the remaining
>     transformations when applicable.
>     
>     Futhermore, the author should also pay attention to any new topics
>     that branch off after the "pending" semantic patch, and whether
>     any of them introduce code to be transformed, warning their
>     authors as necessary.

This part seems tricky, though. There's a race condition between
promoting the patch from pending to not-pending and other topics
branching off. And remember that we do not always see other people's
branches, which they may work on in private for a long time (though I
suppose "when Junio applies it" is one effective cutoff).

>   - Finally, after all the dust settled, the dev should follow up with
>     a patch to:
>     
>       - promote the "penging" patch to '<name>.cocci', if its purpose
>         is to avoid undesirable code patterns in the future, or
>     
>       - remove the semantic patch, if it was used in a one-off
>         transformation.

I'm not wild about leaving these loose ends that need to be tied up
manually. It adds a lot of friction and effort.

-Peff
