Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA28C432C3
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 06:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44CC2053B
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 06:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKVG7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:59:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:57748 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726912AbfKVG7U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 01:59:20 -0500
Received: (qmail 18547 invoked by uid 109); 22 Nov 2019 06:59:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Nov 2019 06:59:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20219 invoked by uid 111); 22 Nov 2019 07:03:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Nov 2019 02:03:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Nov 2019 01:59:18 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     M Lewis <picevio@gmail.com>, git@vger.kernel.org
Subject: Re: GitAttributes feature export-ignore works, but -export-ignore
 (with dash) should also work
Message-ID: <20191122065918.GB23225@sigill.intra.peff.net>
References: <01e0a4ab-d809-d968-5671-b731438c2bc4@gmail.com>
 <20191121075837.GA30966@sigill.intra.peff.net>
 <xmqq5zjd8ij2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zjd8ij2.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 21, 2019 at 10:29:21PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Now obviously there is recursion happening inside git-archive, as it
> > walks the tree. And the current behavior is that it sees the ignored
> > subtree and doesn't walk into it at all. So it _could_ make your
> > original example work by actually searching within the tree for any
> > paths marked -export-ignore, and including the directory if and only if
> > it has unignored entries.
> >
> > I can't offhand think of anything that would break if we started doing
> > that,...
> 
> If there is some effect we want to attach to a directory itself
> without affecting the paths inside it, the current and original
> design lets you express it naturally.  If we make a pattern that
> match a directory to recurse, it is still possible to express it,
> but it is a bit cumbersome, e.g.
> 
> 	/directory	want-to-affect-this
> 	/directory/**	-want-to-affect-this
> 
> I would think.

I didn't mean teaching the attribute code anything about recursion. You
convinced me in the thread I linked that the current rules are just fine
for expressing what we want (and especially with "**" now it's easy).
It's git-archive which does the recursion here, so it could have more
convenient semantics for an attribute attached to a directory.

(Though again, I'm happy enough with the solutions I've suggested in
this thread).

> Git generally does *not* track directories, so in a sense it is
> arguable if it even makes sense to think about attaching an
> attribute to a directory itself (as opposed to a non-directory
> inside the directory) in the first place, though.

I mostly agree, though in this case if we are exporting to a tarball,
which _does_ care about directories. So the difference between "don't
export foo/" and "don't export foo/*" can be observed in the output. I
doubt anybody really cares that much in practice, though (i.e., does
anybody really want to be able to output empty directories in their
tarballs?).

-Peff
