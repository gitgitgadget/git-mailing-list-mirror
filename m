Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D1CC35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 06:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE8E2082F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 06:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgBNGxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:53:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:43220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725845AbgBNGxx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 01:53:53 -0500
Received: (qmail 19464 invoked by uid 109); 14 Feb 2020 06:53:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 06:53:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19391 invoked by uid 111); 14 Feb 2020 07:02:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 02:02:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 01:53:52 -0500
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Roland Hieber <rhi@pengutronix.de>, git <git@vger.kernel.org>
Subject: Re: git-describe --tags warning: 'X' is really 'Y' here
Message-ID: <20200214065352.GG605125@coredump.intra.peff.net>
References: <20200205141332.lov2f2fvinehcd3a@pengutronix.de>
 <CAHd-oW6p-zs-SZnQsJNWPGE8-Ls3vXvf_HOeO+W=1PsQ_oihZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd-oW6p-zs-SZnQsJNWPGE8-Ls3vXvf_HOeO+W=1PsQ_oihZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 05, 2020 at 02:15:07PM -0300, Matheus Tavares Bernardino wrote:

> > I'm working with the GCC Git repo [0] (which was apparently recently
> > converted from SVN [1]), and I'm trying to find out the most recent tag.
> > So on the master branch I do:
> >
> >     gcc (master) $ git describe --tags --abbrev=0
> >     warning: tag 'gcc_9_2_0_release' is really 'releases/gcc-9.2.0' here
> >     gcc_9_2_0_release
> >
> > It took me a while to find out what the warning means, because
> > 'gcc_9_2_0_release' is not in $(git tag -l), and it cannot be used as a
> > ref either:
> [...]
> It seems that the commit which added the output message you got is
> 212945d ("Teach git-describe to verify annotated tag names before
> output", 2008-02-28) [1]. As the commit message states, the warning is
> emitted when a tag is locally stored under a different name from the
> one it was originally created (being the former the one you will want
> to use at `git show`).

Yeah, I think that is what's going on with that warning, but there's a
weird thing about the actual stdout output. We see a tag object whose
name doesn't match the ref. What's the "real" name of that tag? Is it
the name in the object, and the ref is wrong? Or is the ref correct, and
the object is wrong?

You could get pretty philosophical there, I think, but it seems slightly
annoying that we print the name from the object to stdout, when one
cannot then use that name to access the tag in any way.

I.e., I think it might be reasonable to issue that warning but then
print "releases/gcc-9.2.0" instead.

-Peff
