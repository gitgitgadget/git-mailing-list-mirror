Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7C5C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 01:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242904AbhLHBtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 20:49:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:46294 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhLHBtp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 20:49:45 -0500
Received: (qmail 8820 invoked by uid 109); 8 Dec 2021 01:46:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Dec 2021 01:46:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26643 invoked by uid 111); 8 Dec 2021 01:46:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Dec 2021 20:46:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Dec 2021 20:46:12 -0500
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Fwd: coverity problems in reftable code
Message-ID: <YbAOZMxGDELhgfut@coredump.intra.peff.net>
References: <YarO3nkrutmWF7nb@coredump.intra.peff.net>
 <CAFQ2z_OK5949p1WfovJ00Katk5hTv_oeLo-ZRCi1XqrtzQqL2g@mail.gmail.com>
 <CAFQ2z_OrN+RkwnMyrJHdh5xN6ueOP8KKBVQ7-U4kEkA3ApcuNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_OrN+RkwnMyrJHdh5xN6ueOP8KKBVQ7-U4kEkA3ApcuNg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 07, 2021 at 12:34:15PM +0100, Han-Wen Nienhuys wrote:

> >   - A lot of your structs have vtables. Initializing them to NULL, as in
> >     reftable_reader_refs_for_indexed(), leaves the risk that we'll try
> >     to call a NULL function pointer, even if it's for something simple
> 
> I have the impression that coverity doesn't understand enough of the
> control flow.  Some of the things it complains of are code paths that
> only get executed if err==0, in which case, the struct members at hand
> should not be null.

I've definitely run into cases where it doesn't understand some
invariant (e.g., "foo" is only nonzero if "bar" is not NULL). But the
ones I looked at here were triggerable. It's a lot easier to see via
their site which details there view of the control flow...

> > The summary of issues is below. You can get more details on their site.
> > I _think_ I've configured it so that anybody can look at:
> >
> >   https://scan.coverity.com/projects/peff-git/view_defects
> 
> Alas, it says I have no access, even after I logged in.

...hrmph. I have it "open to all users", but maybe you have to be
associated with the project. I'll send you an "invite" through the
Coverity site and see if that works (of course don't feel obligated if
you don't want to deal further with Coverity; it _does_ produce a ton of
false positives, but it sometimes says useful things, too).

> > I similarly wondered if these polymorphic types could be using a union
> > within reftable_record, rather than pointing to a separate stack
> > variable. Then you could initialize the whole thing without worrying
> > about intermediate NULLs (and also there's less pointer chasing and it's
> > a little bit more type safe than a void pointer). But again, I don't
> > know the code well enough to know if that would cover all of your cases.
> 
> This is a great idea. I've made a change that does this, which I will
> post shortly.

Oh good. I was worried I was going off on a tangent. I'll give your
patches a look.

-Peff
