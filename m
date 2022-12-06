Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F69C4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiLFCDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiLFCDp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:03:45 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4177810FDD
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:03:44 -0800 (PST)
Received: (qmail 11360 invoked by uid 109); 6 Dec 2022 02:03:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Dec 2022 02:03:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16249 invoked by uid 111); 6 Dec 2022 02:03:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Dec 2022 21:03:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Dec 2022 21:03:42 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 0/4] Don't lazy-fetch commits when parsing them
Message-ID: <Y46i/npXcnsT1pqF@coredump.intra.peff.net>
References: <Y4lFbemK4HHiCsyJ@coredump.intra.peff.net>
 <20221206004935.1794596-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221206004935.1794596-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2022 at 04:49:34PM -0800, Jonathan Tan wrote:

> > So it really seems like we're quite likely to get an errno from opening
> > or mapping packs. Which implies the original suffers from the same
> > issue, but we simply never triggered it meaningfully in a test.
> 
> Thanks for checking. I'm still not sure how the current code passes CI, but my
> patches don't. 

Hmm. Actually, I am now, too.

My assumption was that only certain tests would notice the problem,
because both outcomes are an error, and they only differ in what stderr
says ("this does not exist" versus "we got this weird errno"). And so I
assumed that the old spot in read_object_file() did not happen to
trigger any tests which check stderr, but your new caller in
repo_parse_commit_internal() was unlucky enough to do so. But since that
new caller was calling repo_read_object_file() before, I'd think it
would have triggered the same thing.

> > That might make things more verbose for other code paths, but that kind
> > of seems like a good thing. If you have an object file that we can't
> > open, we probably _should_ be complaining loudly about it.
> > 
> > We may need to be a little more careful about preserving errno in
> > map_loose_object_1(), though (gee, another place where the existing
> > check could run into trouble).
> 
> Besides needing to be careful in map_loose_object_1(), I'm not sure if this
> fully solves the problem. This is non-fatal, so the EMFILE commit's work would
> still remain undone. If this were made fatal, I think this would change the
> behavior of too much code, especially those that can tolerate loose objects
> being missing.

True, in the sense that we'd still say "X is corrupt". But I think the
real sin prior to 3ba7a0655 is that we _only_ said "hey, this looks
corrupt". If the output is:

  error: unable to mmap .git/objects/12/3456abcd...
  fatal: object 123456abcd is corrupt or missing

then that is at least not actively misleading (and is broadly similar to
other cases in Git, where higher-level code only knows "I expected us to
have this object and for some reason we don't", but without knowing
whether it was missing, or a system error, or corrupt).

That said I think all of these die() statements that you moved into
die_if_corrupt() are already doing the wrong thing. We should probably
mention errors (besides "missing object") to the user at the lowest
level where we can give the most detail, and then return errors up the
stack. That makes Git more verbose, but remember we're talking about
corrupted or broken repositories here. You shouldn't see these under
normal circumstances.

> What do you think of not putting any die_if_corrupt() calls in the commit
> parsing code at all? The error message printed would then be different (just a
> generic message about being unable to parse a commit, versus the specific one
> here) but it does pass CI [1]. Also, I don't think that we should be doing errno
> diagnostics separate from what causes the errno anyway.

So I think that's a lesser version of what I'm proposing above. ;) In
the sense that yes, I would say that repo_parse_commit_internal() does
not need to do anything more specific than its existing "could not read"
message. But I would go further and say:

  - it would be nice the low-level code where errno _is_ valid said more
    about what happened

  - we should take read_object_file_extended() in the same direction

-Peff
