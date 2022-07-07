Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0363C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 17:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbiGGRXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 13:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiGGRXl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 13:23:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000DB4D16D
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 10:23:36 -0700 (PDT)
Received: (qmail 6291 invoked by uid 109); 7 Jul 2022 17:23:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Jul 2022 17:23:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2826 invoked by uid 111); 7 Jul 2022 17:23:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Jul 2022 13:23:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Jul 2022 13:23:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 3/3] clone: propagate empty remote HEAD even with other
 branches
Message-ID: <YscWl+fsVnbvfuT+@coredump.intra.peff.net>
References: <YsVAfudoUA5YkQWH@coredump.intra.peff.net>
 <YsVB2eOMp5guQfVr@coredump.intra.peff.net>
 <xmqqr12ygl3p.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr12ygl3p.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 06, 2022 at 11:19:22AM -0700, Junio C Hamano wrote:

> >    But for the sake of completeness, here are some thoughts:
> >
> >      - if the remote has a non-HEAD "master", we may still end up with a
> >        local "master" that isn't connected to it. This is because the
> >        "how to set local unborn HEAD" code is independent from the "did
> >        we find a remote HEAD we can checkout" code. This could be fixed,
> >        but I'm not sure it's worth caring too much about, since you'd
> >        have to really try hard to create such a situation.
> 
> Hmph.

Yeah, it's definitely ugly. One thing I perhaps could have said here: we
are not fixing all bugs / tricky cases, but this patch is not making
anything _worse_. It's a strict improvement over the status quo.

Handling this case would be an even bigger change to the current logic,
because it involves re-examining the mapped_refs a second time: after we
get no hint of HEAD from the remote, then we choose an arbitrary name
locally, and then we see if the remote happens to have that same name.

It probably is not too hard to do so, but I was really trying to avoid
re-organizing this code, if only because it seemed subtle and I did not
want to introduce new bugs while doing so. Or possibly I am lazy and
wanted to fix the thing I cared about and make it out alive. ;)

> >      - if the remote has branches but doesn't tell us about its HEAD,
> >        we could pick one of those branches as our HEAD instead of
> >        whatever our local default is. This feels on-balance worse to me.
> 
> Sorry, I do not quite get this.  Is this about an old version of the
> server without symrefs, where we try to find the object name HEAD
> (possibly indirectly) points at in the objects their refs/heads/*
> point at to infer which branch they are on?

No, we'll have already called guess_remote_head() and it will have
failed. So we know that no branch points to the same commits as their
HEAD, and thus their HEAD is unborn (and likewise we know it wasn't
detached, because we didn't see a HEAD advertisement). But because they
do not support the symref capability, we don't know the name of that
unborn branch.

So we pick some local name (e.g., "master") which may or may not be
meaningful to the remote repository (imagine they prefer "main", and it
is just unborn). We could instead pick some branch we know they _do_
have, which might be less bad. But it may also be more bad: we know for
a fact that it is not what their HEAD is pointing at (else it would have
been found by guess_remote_head()), so it is probably just confusing
matters more.

> > +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
> > +	git -c init.defaultBranch=main -c protocol.version=2 \
> > +		clone "file://$(pwd)/file_empty_parent" \
> > +		file_empty_child 2>stderr &&
> > +	grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD &&
> > +	grep "warning: remote HEAD refers to nonexistent ref" stderr
> > +'
> 
> OK.  This is called "empty" but actually has objects with a branch
> that are unrelated to the "current" branch which is unborn.

Yeah, this is all pulled directly from the tests above which check the
same thing for a truly empty repository. It is still empty in the sense
that HEAD is empty (and the title says "empty default branch"). I can
call it "unborn" instead if that's more clear.

The name is not all that important either way, as I followed the pattern
of the earlier tests to create and clean up the sample repos in each
test.  I was tempted to amortize the setup (the same "stuff" setup is in
each test) but thought it better to stick to the existing pattern of the
earlier tests.

-Peff
