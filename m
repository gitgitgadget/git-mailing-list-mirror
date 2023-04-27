Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F96C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 05:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242847AbjD0Fnr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 01:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjD0Fnp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 01:43:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB31D2D79
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 22:43:44 -0700 (PDT)
Received: (qmail 19588 invoked by uid 109); 27 Apr 2023 05:43:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Apr 2023 05:43:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16368 invoked by uid 111); 27 Apr 2023 05:43:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Apr 2023 01:43:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Apr 2023 01:43:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH 2/2] Honor GIT_DEFAULT_HASH for empty clones without
 remote algo
Message-ID: <20230427054343.GE982277@coredump.intra.peff.net>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230426205324.326501-1-sandals@crustytoothpaste.net>
 <20230426205324.326501-3-sandals@crustytoothpaste.net>
 <xmqqbkjaqqfp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbkjaqqfp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2023 at 02:33:30PM -0700, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> >  `GIT_DEFAULT_HASH`::
> >  	If this variable is set, the default hash algorithm for new
> >  	repositories will be set to this value. This value is currently
> > +	ignored when cloning if the remote value can be definitively
> > +	determined; the setting of the remote repository is used
> > +	instead. The value is honored if the remote repository's
> > +	algorithm cannot be determined, such as some cases when
> > +	the remote repository is empty. The default is "sha1".
> > +	THIS VARIABLE IS EXPERIMENTAL! See `--object-format`
> > +	in linkgit:git-init[1].
> 
> We'd need to evantually cover all the transports (and non-transport
> like the "--local" optimization) so that the object-format and other
> choices are communicated from the origin to a new clone anyway, so
> this extra complexity "until X is fixed, it behaves this way, but
> otherwise the variable is read in the meantime" may be a disservice
> to the end users, even though it may make it easier in the shorter
> term for maintainers of programs that rely on the buggy "git clone"
> that partially honored this environment variable.
> 
> In short, I am still not convinced that the above is a good design
> choice in the longer term.

I also think it is working against the backwards-compatible design of
the hash function transition. If we do not see an object-format line
from the remote, then either:

  1. They sent us capabilities, but it did not include object-format. So
     if we are in GIT_DEFAULT_HASH=sha256 mode locally, but the other
     side is an older version of Git (or even a current version of other
     implementations, like Dulwich) that do not send object-format at
     all, then we will not correctly fall back to assuming they are
     sha1. In a non-empty repo, this means we'll fail to parse their ref
     advertisement (we'll expect sha256 hashes but get sha1), and
     cloning will be broken.

  2. They did not send us capabilities, because the repo is empty (and
     the server does not have brian's patch 1). The hash transition doc
     says we're supposed to assume they're sha1. It's _sort of_
     academic, in that they also are not telling us about any refs on
     their side. But we may end up mis-matched with the server (again,
     this is the 50/50 thing; we don't know what their format is).
     Presumably that bites us later when we try to push up new objects
     (but would eventually work when we support interop).

I think handling (2) is iffy as a goal, but the collateral damage of (1)
is a complete show-stopper for this patch. If we wanted to do (2) by
itself, we'd have to distinguish "did they even send us a capabilities
line" as a separate case (but I tend to agree with you that it is not
worth doing for now).

-Peff
