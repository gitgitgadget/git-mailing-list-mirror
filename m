Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878EAC2D0A3
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 03:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E18022249
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 03:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895221AbgJVDAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 23:00:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:39024 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442495AbgJVDAx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 23:00:53 -0400
Received: (qmail 13921 invoked by uid 109); 22 Oct 2020 03:00:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Oct 2020 03:00:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23584 invoked by uid 111); 22 Oct 2020 03:00:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Oct 2020 23:00:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Oct 2020 23:00:51 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Nikos Chantziaras <realnc@gmail.com>
Subject: Re: [PATCH] svn: use correct variable name for short OID
Message-ID: <20201022030051.GB1480820@coredump.intra.peff.net>
References: <rmpve5$q2s$1@ciao.gmane.io>
 <20201022011811.853465-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022011811.853465-1-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 22, 2020 at 01:18:11AM +0000, brian m. carlson wrote:

> The commit 9ab33150a0 ("perl: create and switch variables for hash
> constants", 2020-06-22) converted each instance of the variable
> $sha1_short into $oid_short in the Subversion code, since git-svn now
> understands SHA-256.  However, one conversion was missed.
> 
> As a result, Perl complains about the use of this variable:
> 
>   Use of uninitialized value $sha1_short in regexp compilation at
>   /usr/lib64/perl5/vendor_perl/5.30.3/Git/SVN/Log.pm line 301, <$fh>
>   line 6.
> 
> Because we're parsing raw diff output here, the likelihood is very low
> that we'll actually misparse the data, since the only lines we're going
> to get starting with colons are the ones we're expecting.  Even if we
> had a newline in a path, we'd end up with a quoted path.  Our regex is
> just less strict than we'd like it to be.

I agree this is unlikely to matter much in the happy path, but I
wondered how confused things could get. I'd never looked at this code
before, but it looks like we take git-log @args from the user. So:

  git svn log --format=":123456 123456 foo"

gets mis-parsed. But not only is that exceedingly unlikely in the first
place, AFAICT the command was never meant to allow arbitrary formats
anyway. It's expecting its own "--pretty=raw" to be respected, so the
command above is broken even with your fix.

None of that changes the fix, which is obviously correct, but I wondered
if we ought to have better test coverage here. And I've convinced myself
the answer is "no"; there's no reasonable-to-test functional impact of
this bug or its fix (aside from generating the warning, but it would be
silly to write a test for this one warning; if we do anything it should
be to complain about any warnings during the test run).

-Peff
