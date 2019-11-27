Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4496C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 11:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAF82070A
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 11:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfK0LVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:21:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:33714 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726194AbfK0LVv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 06:21:51 -0500
Received: (qmail 10457 invoked by uid 109); 27 Nov 2019 11:21:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Nov 2019 11:21:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9129 invoked by uid 111); 27 Nov 2019 11:25:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2019 06:25:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Nov 2019 06:21:50 -0500
From:   Jeff King <peff@peff.net>
To:     Ruud van Asseldonk <dev@veniogames.com>
Cc:     git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t5150: skip request-pull test if Perl is disabled
Message-ID: <20191127112150.GA22221@sigill.intra.peff.net>
References: <4f11b5b3-a68e-642a-c5fb-7b5dae698669@veniogames.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f11b5b3-a68e-642a-c5fb-7b5dae698669@veniogames.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 26, 2019 at 01:02:46AM +0100, Ruud van Asseldonk wrote:

> The git-request-pull.sh script invokes Perl, so it requires Perl to be
> available, but the associated test t5150 does not skip itself when Perl
> has been disabled, which then makes subtest 4 through 10 fail. Subtest 3
> still passes, but for the wrong reasons (it expects git-request-pull to
> fail, and it does fail when Perl is not available). The initial two
> subtests that do pass are only doing setup.
> 
> To prevent t5150 from failing the build when NO_PERL=1, add a check that
> sets skip_all when "! test_have_prereq PERL", just like how for example
> t3701-add-interactive skips itself when Perl has been disabled.
> 
> Signed-off-by: Ruud van Asseldonk <dev@veniogames.com>
> ---
> I discovered this issue in the Git package in Nixpkgs. The Nix package
> manager tries to make it hard to accidentally introduce undeclared
> dependencies, and it has a sandbox that hides things in /usr/bin. So
> when it builds with NO_PERL=1, it really makes no Perl available, so you
> cannot accidentally depend on the Perl in /usr/bin/perl. For the tests
> it does set PERL_PATH, but it does not point to a binary in /usr/bin.

Hmm. I don't think that technique gives complete coverage. There are
other scripts (e.g., filter-branch) that call a bare "perl" (not
PERL_PATH), which presumably pass the tests even though they'd break in
a real-world system without perl. In fact, many scripts used to do this
before fcb06a8d54 (use @@PERL@@ in built scripts, 2013-10-28). I don't
think the effects on NO_PERL were really considered there; it was more
about finding the right perl.

I think NO_PERL has historically mostly meant "do not build or install
perl scripts", and not "everything ought to run fine without perl".
We've generally assumed you can run vanilla perl snippets from the
command line the same way you'd run awk or sed (and the tests use this
extensively, which is why you have to set PERL_PATH again to run them).

That said, most of those casual uses of perl in actual built scripts
have gone away because the shell scripts have gone away. It looks like
filter-branch, request-pull, and instaweb are the last holdouts. So
maybe we should be treating NO_PERL as disabling those scripts, too.

But then, should we be doing more to make it clear that those scripts
are broken in a NO_PERL build? Who knows what happens if you run
filter-branch without any perl available?

-Peff
