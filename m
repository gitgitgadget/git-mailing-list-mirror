Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CC8C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552766054E
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347983AbhIXSPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:15:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:54590 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347973AbhIXSPL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:15:11 -0400
Received: (qmail 19001 invoked by uid 109); 24 Sep 2021 18:13:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:13:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10774 invoked by uid 111); 24 Sep 2021 18:13:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:13:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:13:36 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/9] refs: make _advance() check struct repo, not flag
Message-ID: <YU4VUF17tyG2AZi3@coredump.intra.peff.net>
References: <cover.1632242495.git.jonathantanmy@google.com>
 <493fff7f4716d889da751b5f8c6740cc1e3aa360.1632242495.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <493fff7f4716d889da751b5f8c6740cc1e3aa360.1632242495.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 09:51:03AM -0700, Jonathan Tan wrote:

> Currently, ref iterators access the object store each time they advance
> if and only if the boolean flag DO_FOR_EACH_INCLUDE_BROKEN is unset.
> (The iterators access the object store because, if
> DO_FOR_EACH_INCLUDE_BROKEN is unset, they need to attempt to resolve
> each ref to determine that it is not broken.)
> 
> Also, the object store accessed is always that of the_repository, making
> it impossible to iterate over a submodule's refs without
> DO_FOR_EACH_INCLUDE_BROKEN (unless add_submodule_odb() is used).
>
> As a first step in resolving both these problems, replace the
> DO_FOR_EACH_INCLUDE_BROKEN flag with a struct repository pointer. This
> commit is a mechanical conversion - whenever DO_FOR_EACH_INCLUDE_BROKEN
> is set, a NULL repository (representing access to no object store) is
> used instead, and whenever DO_FOR_EACH_INCLUDE_BROKEN is unset, a
> non-NULL repository (representing access to that repository's object
> store) is used instead. Right now, the locations in which
> non-the_repository support needs to be added are marked with BUG()
> statements - in a future patch, these will be replaced. (NEEDSWORK: in
> this RFC patch set, this has not been done)

I think your goal here of passing around a repository object is good.
But rolling the meaning of DO_FOR_EACH_INCLUDE_BROKEN into an implicit
"do we have a non-NULL repository" makes things awkward, I think.

As you noticed, we can't get rid of the flags parameter entirely. We
still have DO_FOR_EACH_PER_WORKTREE_ONLY. But I also have a series which
adds another flag which pairs with INCLUDE_BROKEN. Having half of the
logic implicit in the repository pointer and half in a flag would be
weird.

I'll post that series in a moment, but what I'm wondering here is: would
it be that big a deal to just pass the repository object around, and it
is simply not used if INCLUDE_BROKEN is passed?

-Peff
