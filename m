Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964A8C433E0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B678619CE
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhC3PU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:20:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:37416 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232342AbhC3PUE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:20:04 -0400
Received: (qmail 20884 invoked by uid 109); 30 Mar 2021 15:20:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Mar 2021 15:20:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26825 invoked by uid 111); 30 Mar 2021 15:20:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Mar 2021 11:20:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Mar 2021 11:20:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Andreas =?utf-8?Q?F=C3=A4rber?= <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/6] Makefile: refactor out "ln || ln -s || cp" pattern
Message-ID: <YGNBoljqknW+Kpif@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
 <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
 <patch-3.7-bde9de756b4-20210329T162327Z-avarab@gmail.com>
 <xmqqsg4dha3i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsg4dha3i.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 03:24:33PM -0700, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > Refactor out the hard-to-read and maintain "ln || ln -s || cp"
> > pattern.
> >
> > This was initially added in 3e073dc5611 (Makefile: always provide a
> > fallback when hardlinks fail, 2008-08-25), but since then it's become
> > a lot more complex as we've added:
> >
> >  * 3426e34fedd (Add NO_CROSS_DIRECTORY_HARDLINKS support to the
> >    Makefile, 2009-05-11)
> >
> >  * NO_INSTALL_HARDLINKS in 70de5e65e8c (Makefile:
> >    NO_INSTALL_HARDLINKS, 2012-05-02)
> >
> >  * INSTALL_SYMLINKS in ad874608d8c (Makefile: optionally symlink
> >    libexec/git-core binaries to bin/git, 2018-03-13)
> >
> >  * SKIP_DASHED_BUILT_INS 179227d6e21 (Optionally skip linking/copying
> >    the built-ins, 2020-09-21)
> >
> > Each of those commits had to add a new special-case to this code,
> > resulting in quite an unmaintainable mess for adding any sort of new
> > option.
> >
> > Let's use the newly introduced ln-or-cp.sh script instead, note that
> > we only sometimes pass the --no-cross-directory-hardlinks option, per
> > the previous behavior. The target of the "ln -s" is also another
> > special snowflake, but we're careful to carry that forward.
> 
> Nice.  These explicit command-line options to the helper may be
> harder to initially write and maintain than just exporting the
> relevant $(MAKE) macros and using it from the helper, but once
> it works correctly, it is much easier to see what is going on.

Another option is to make "ln-or-cp" itself a target that "make" knows
how to build, and bake the values into its "built" version. Besides
making the invocations a bit shorter, it also means that the dependency
graph is more correct. If a rule invokes ln-or-cp, its behavior will
change if $NO_INSTALL_HARDLINKS changes, for example. Telling that to
make requires depending on a sentinel file in each such caller (like
GIT-BUILD-OPTIONS). Whereas we could do that once for the "ln-or-cp"
target, and then everyone who uses it just depends on it.

I had a series a long time ago that moved the whole Makefile in that
direction, but I got nervous that it was too disruptive and too
non-idiomatic to be worth pursuing. So I offer the alternative here
mostly as food for thought. It may not be a good direction (and we
already have good-enough solutions, like depending on
GIT-BUILD-OPTIONS).

-Peff
