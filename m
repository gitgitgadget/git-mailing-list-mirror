Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2832C6FD19
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 09:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjCJJky (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 04:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjCJJkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 04:40:09 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFCB4DE14
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 01:39:09 -0800 (PST)
Received: (qmail 19373 invoked by uid 109); 10 Mar 2023 09:39:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Mar 2023 09:39:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10548 invoked by uid 111); 10 Mar 2023 09:39:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Mar 2023 04:39:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Mar 2023 04:39:08 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Better suggestions when git-am(1) fails
Message-ID: <ZAr6vIOe3WbTIohE@coredump.intra.peff.net>
References: <897c200c-afb3-ceb4-bf44-9af651f5feb4@gmail.com>
 <ZAlPtxZ/0Z28r5tF@coredump.intra.peff.net>
 <xmqqedpxq4if.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedpxq4if.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2023 at 08:22:00AM -0800, Junio C Hamano wrote:

> > The reason is probably that they have set diff.noprefix in their config,
> > and git-format-patch respects that. Which is arguably a bug.
> 
> FWIW, I've always considered it a feature to help projects that
> prefer their patches in -p0 form.  Of course, Git optimized itself
> for the usecase we consider the optimum, i.e. using a/ and b/ prefix
> on the diff generation side, while stripping them with -p1 on the
> applying side.
> 
> I wonder apply.plevel or am.plevel would be a good way to help them
> further?

I doubt they would help, because they imply a constant project workflow.
We have seen several reports of "sometimes I get a patch without a
prefix, and it doesn't apply. What's going on?". But I don't think
anybody asked for "my project doesn't use prefixes, and I am tired of
typing -p0".

The more interesting case to me is that the receiver _isn't_ using Git.
They are using "patch" or similar, and they expect senders to send them
patches without prefixes. And there, diff.noprefix is doing what they
want. But I have to wonder if these hypothetical maintainers exist:

  1. I feel like "-p1" was pretty standard even before Git. You'd
     extract two copies of the tarball, one into "foo-1.2.3" and one
     into "foo-1.2.3.orig", and then "diff -Nru" between them to send a
     patch.

  2. It feels weird that a maintainer who isn't using Git would expect a
     lot of contributions from folks who are. And even weirder, that
     they would insist that all of the folks sending patches set
     diff.noprefix.

So I won't say it's not possible (especially in some closed community).
But I'm skeptical.

All that said, if "apply" and "am" could automatically figure out and
handle "-p0" patches, that would be a useful way to help people. I'm
just hesitant because it probably involves some heuristics. E.g., we get
"foo/bar", realize that "bar" doesn't exist, but "foo/bar" does. Except
that fails if a project does have "bar". And so on.

> I am not sure making format-patch _ignore_ diff.src/dst_prefix is a
> good approach.  If we were wiser, we may not have introduced the
> diff.noprefix option, made sure diff.src/dstprefix to be always a
> single level, and kept -p<n> on the application side as an escape
> hatch only to deal with non-Git generated patches.  The opportunity
> to simplify the world that way however we missed 15 years ago X-<.

Yeah, I am as always a little concerned that one person's fix is another
one's regression. But it really just seems to that on balance people set
diff.noprefix with no thought at all to how it would affect format-patch
(in fact, I'd guess 99% of Git users do not use format-patch at all).
And then they are surprised (or worse, the receiver is surprised) when
it doesn't work.

-Peff
