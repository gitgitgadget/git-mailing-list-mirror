Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D83C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B5361206
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbhGLR5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:57:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:46634 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232912AbhGLR5I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:57:08 -0400
Received: (qmail 19419 invoked by uid 109); 12 Jul 2021 17:54:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jul 2021 17:54:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8115 invoked by uid 111); 12 Jul 2021 17:54:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Jul 2021 13:54:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Jul 2021 13:54:18 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] revision: allow pseudo options after --end-of-options
Message-ID: <YOyByjmGu1oDXK4X@coredump.intra.peff.net>
References: <20210708150316.10855-1-worldhello.net@gmail.com>
 <YOcvaFL7+6qcIOUa@camp.crustytoothpaste.net>
 <CANYiYbGYzbMoU_2wb4duppASoYUjGLsJsr692Xe3GaVBOXUsBA@mail.gmail.com>
 <YOoXCJV2ssef/KsN@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YOoXCJV2ssef/KsN@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 10, 2021 at 09:54:16PM +0000, brian m. carlson wrote:

> > But for the original implementation, because pseudo revision options
> > (--branches, --tags, --not, ..., etc) can not be used after the
> > "--end-of-options" option, we have to put "--end-of-options" at the
> > end of revisions, such as:
> > 
> >     git log --pretty="%m %s" rev1 --not rev2 rev3 rev4 \
> >             --end-of-options -- path/file
> 
> Or you could just use the other syntax and not have the problem.  Or you
> could write this:
> 
>   git log --pretty="%m %s" refs/heads/rev1 --not --end-of-options rev2 rev3 rev4 \
>           -- path/file
> 
> Unless there's a functional problem we're trying to solve, I'd much
> rather we didn't make --end-of-options means
> --end-of-some-options-but-not-others.  That makes it hard to reason
> about, and if someone does have a need for disabling all options, then
> we have to add another option.  It's also incompatible with the previous
> behavior, so whereas "--not" used to be a revision, now it's an option.

I agree that if we can avoid making exceptions, it makes the whole thing
conceptually much cleaner (both for users to understand, but also for us
to avoid accidentally introducing a security problem).

I don't think fully-qualifying refs is a complete solution, though. The
common use case for --end-of-options is that you're passing along names
from somewhere else, and you don't know how to qualify them. E.g., in:

  git rev-list --end-of-options "$rev" --

you need to behave differently if you got "1234abcd" versus "foo" versus
"refs/heads/foo".

For --not, I do think using "^" is a complete solution. It's a little
more work for the caller to prepend to each argument, but there's no
policy logic they have to implement.

Looking over the other pseudo-opts, I could see some where treating them
as a rev is reasonable (e.g., "--all"), but many where it is not at all
(e.g., "--no-walk"; why is this even in handle_revision_pseudo_opt?).
Even if you're just passing along untrusted revision specifiers, they
act in roughly the same way as a single specifier. The big thing we'd
lose is that you could never refer to a branch named "--not" or "--all".

So my gut feeling is _not_ to support them, but I can see arguments in
both directions and I don't feel that strongly about it.

> > Yes, "--end-of-options" must be used if there is a revision which
> > starts with dash, such as branch "--output=yikes" in t6000. That's
> > even stranger, for we have to write  command in the middle of
> > revisions like this:
> > 
> >     git log --pretty="%m %s" rev1 --not rev2 rev3 \
> >             --end-of-options --output=yikes -- path/file
> > 
> > I know "rev1..rev2" and "rev2 ^rev1", but I prefer to use "rev1 --not
> > rev2 rev3" instead of "rev1 ^rev2 ^rev3".
> 
> I don't think a personal preference is a good reason to change this.

I do think it rises slightly above personal preference. It's potentially
making things much easier for the caller if they can ferry along:

  tip=$1; shift
  git rev-list --end-of-options "$1" --not "$@"

instead of:

  tip=$1; shift
  # whoops, whitespace splitting is wrong here! Real programming
  # languages make this easier, of course.
  git rev-list --end-of-options "$1" $(for i in "$@"; do echo "^$i"; done)

Though in my experience it is usually a static "--not --all" or "--not
--branches --tags" or similar in such a function. I don't think I've
ever seen a case quite like the code above in practice.

-Peff
