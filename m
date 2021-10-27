Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A56C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 01:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6442B60FE8
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 01:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbhJ0Baj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 21:30:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:47618 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231458AbhJ0Bai (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 21:30:38 -0400
Received: (qmail 11392 invoked by uid 109); 27 Oct 2021 01:28:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Oct 2021 01:28:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15907 invoked by uid 111); 27 Oct 2021 01:28:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Oct 2021 21:28:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Oct 2021 21:28:12 -0400
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: Unexpected cat-file --batch-check output
Message-ID: <YXirLGXsKj01uNGv@coredump.intra.peff.net>
References: <CAGyf7-HFGgkXsA-MXBOdiogDid+=F8jmqw0zxwQoUzha-jc1Hw@mail.gmail.com>
 <YXcC8jQbFsaqYN2M@coredump.intra.peff.net>
 <CAGyf7-Gaphb9q=4cyT0BQa7oYGKXQQsU-XfqvoxfDyijehJO3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-Gaphb9q=4cyT0BQa7oYGKXQQsU-XfqvoxfDyijehJO3Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 04:58:49PM -0700, Bryan Turner wrote:

> >   - what does "git rev-parse refs/heads/develop:path/to/parent/file"
> >     say? If it comes up with 4c8d566ed80, then the problem is cat-file
> >     specific. If not, then it's a problem in the name resolution
> >     routines.
> 
> $ /usr/bin/git rev-parse refs/heads/develop
> 28a05ce2e3079afcb32e4f1777b42971d7933a91
> $ /usr/bin/git rev-parse refs/heads/develop:path/to/parent/file
> cc10f4b278086325aab2f95df97c807c7c6cd75e
> 
> So it looks like rev-parse and cat-file --batch-check both exhibit the
> same behavior.

OK, that's not too surprising, since they're using the same routines
under the hood. But that does imply that the problem is in the get_oid()
family, which is what's doing that name to oid lookup.

I don't recall us ever having a bug of this nature in the history of
Git, nor do I think this code would have changed recently. But of course
there's a first time for everything.

The parser there isn't exactly left-to-right, so perhaps this particular
name is stimulating some corner case. I imagine the answer is "no", or
you'd have said so already, but are there any unusual characters in the
filename path? Colons, curly braces, etc?

> I also had them expand their cat-file --batch-check to include another
> file in the same "path/to/parent" directory:
> $ echo 'refs/heads/develop
> refs/heads/develop:path/to/parent/sibling
> refs/heads/develop:path/to/parent/file' | /usr/bin/git cat-file --batch-check
> 28a05ce2e3079afcb32e4f1777b42971d7933a91 commit 259
> 2bfe7b4b7c7cdeb9653801d99b65dfefe5780dda blob 897
> cc10f4b278086325aab2f95df97c807c7c6cd75e commit 330
> 
> So the "sibling" file in the same directory comes out as a "blob", as expected.

Interesting. That again points to their being something funny either
with this filename, or perhaps with the tree that contains it.

> >   - likewise, what does "git cat-file -t cc10f4b27808" say? I'd expect
> >     it to really be a commit (a bug in batch-check's formatting routines
> >     could show the wrong object, but I'd expect the oid to at least
> >     match what ls-tree showed).
> 
> $ /usr/bin/git cat-file -t cc10f4b278086325aab2f95df97c807c7c6cd75e
> commit

That's not too surprising. I did wonder if refs/replace or something
could be at work here, but I think in that case we'd still report the
expected oid. At any rate, we can probably rule that out as rev-parse is
returning the same unexpected oid, which means the problem is during the
name resolution (and we shouldn't respect refs/replace there at all; we
would respect it while reading the outer tree, but then so would your
ls-tree, etc).

> I've asked them to double-check whether they can provide me with the
> repository, or with an anonymized copy. At this point, it feels like
> there's not a lot more I can do/check without access to data that
> reproduces the issue so I can attach a debugger.

Another possibility, if they would run a custom Git on their end, is to
provide them with a patch that cranks up the debugging output from
get_oid_with_context_1(). Though I feel like it's hard to know where to
sprinkle printf()s until we know where things go wrong. Is it
misinterpreting the name, and not realizing it's a tree:path name? Or is
get_tree_entry() at fault? That kind of thing is much easier to figure
out interactively in a debugger.

-Peff
