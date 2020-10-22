Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DE5C55178
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 02:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6176A22249
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 02:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895233AbgJVC4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 22:56:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:39008 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895224AbgJVC4p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 22:56:45 -0400
Received: (qmail 13885 invoked by uid 109); 22 Oct 2020 02:56:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Oct 2020 02:56:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23559 invoked by uid 111); 22 Oct 2020 02:56:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Oct 2020 22:56:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Oct 2020 22:56:44 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nikos Chantziaras <realnc@gmail.com>, git@vger.kernel.org
Subject: Re: git svn log: Use of uninitialized value $sha1_short
Message-ID: <20201022025644.GA1480820@coredump.intra.peff.net>
References: <rmpve5$q2s$1@ciao.gmane.io>
 <20201021202642.GA60606@coredump.intra.peff.net>
 <xmqqwnzj5mq5.fsf@gitster.c.googlers.com>
 <20201021212917.GA62005@coredump.intra.peff.net>
 <20201021222901.GK490427@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021222901.GK490427@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 21, 2020 at 10:29:01PM +0000, brian m. carlson wrote:

> >   - I wonder if it's suitable for production use (i.e., would it become
> >     annoying when a newer version of perl issues a harmless warning;
> >     right now that's a minor inconvenience, but aborting the whole
> >     program might be a show-stopper).
> 
> No, that's not suitable for production use.  Perl does add new warnings
> from time to time and breaking things when Perl gets upgraded will
> definitely not make us the friends of Linux distros.  Doing this is like
> using -Werror: fine for your personal development needs, but not
> suitable for shipping to others.

OK, that matches my general sense.

> We could run "perl -w" on each file and look for a single-line output
> with "OK"; that's what we did at a previous job.  However, any change we
> make here needs to be conditional on DEVELOPER, because otherwise anyone
> who needs to build an Git with a new version of Perl will potentially
> have a broken testsuite.

Yeah, I've done something similar as well. I agree it would be
potentially annoying for distros building. But unlike the -Wall/-Werror
distinction, where the builder may be annoyed by extra messages but the
end result is presumably OK, this _does_ affect end users. I.e., if it
triggers, it also means the users of your package are going to see
annoying warnings. The change I'm proposing is just whether that's fatal
or not.

So it might actually be of interest to distro builders to know that the
version of Git they're building is going to produce annoying warnings.
And the escape hatch there is likely not to turn warnings from fatal to
non-fatal, but to suppress the particular warning entirely with a patch
to the code.

I dunno. I admit I don't really care enough about our perl code in
general (which I consider mostly legacy; I doubt we'd introduce new perl
scripts lightly). So it may not even be worth putting a lot of effort
into it. But it is unfortunate that this bug _could_ have been caught
automatically but wasn't.

-Peff
