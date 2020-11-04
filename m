Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF39DC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 21:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C4F2080D
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 21:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbgKDVD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 16:03:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:48102 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgKDVD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 16:03:28 -0500
Received: (qmail 11591 invoked by uid 109); 4 Nov 2020 21:03:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 21:03:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16094 invoked by uid 111); 4 Nov 2020 21:03:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 16:03:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 16:03:27 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Sathyajith Bhat <sathya@sathyasays.com>, git@vger.kernel.org
Subject: Re: [PATCH] log: diagnose -L used with pathspec as an error
Message-ID: <20201104210327.GG3629238@coredump.intra.peff.net>
References: <20201102144321.GA3962443@coredump.intra.peff.net>
 <20201103101553.GH24813@szeder.dev>
 <20201103182102.GA459792@coredump.intra.peff.net>
 <xmqq361qs31a.fsf@gitster.c.googlers.com>
 <20201103185711.GA461461@coredump.intra.peff.net>
 <xmqqimamqjhl.fsf@gitster.c.googlers.com>
 <xmqq7dr1nh3a.fsf_-_@gitster.c.googlers.com>
 <20201104194155.GA3060815@coredump.intra.peff.net>
 <xmqq361onahn.fsf@gitster.c.googlers.com>
 <xmqqy2jglv29.fsf_-_@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2jglv29.fsf_-_@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 04, 2020 at 12:35:10PM -0800, Junio C Hamano wrote:

> The new tests say they may fail with "-L and --follow being
> incompatible" instead of "-L and pathspec being imcompatible".
> Currently the expected failure can come only from the latter, but
> this is to futureproof them, in case we decide to add code to
> explicititly die on -L and --follow used together.

This explanation makes sense (though s/imcompat/incompat/).

> +test_expect_success 'basic command line parsing' '
> +	# This may fail due to "no such path a.c in commit", or
> +	# "-L is incompatible with pathspec", depending on the
> +	# order the error is checked.  Either is acceptable.
> +	test_must_fail git log -L1,1:a.c -- a.c &&
> +
> +	# This must fail due to "-L is incompatible with pathspec".
> +	test_must_fail git log -L1,1:b.c -- b.c 2>error &&
> +	test_i18ngrep "cannot be used with pathspec" error &&

The renaming makes sense...

> +
> +	# Note that incompatibility between -L/--follow is not
> +	# explicitly checked to avoid redundant code and the comments
> +	# on the following tests are merely for future-proofing.

...as does this comment to explain the rest of the tests.

> +	# These must fail due to "follow requires one pathspec", or
> +	# "-L is incompatible with --follow", depending on the
> +	# order the error is checked.  Either is acceptable.
> +	test_must_fail git log -L1,1:b.c --follow &&
> +	test_must_fail git log --follow -L1,1:b.c &&
> +
> +	# This may fail due to "-L is incompatible with pathspec", or
> +	# "-L is incompatible with --follow", depending on the
> +	# order the error is checked.  Either is acceptable.
> +	test_must_fail git log --follow -L1,1:b.c -- b.c
> +'

Though "depending on the order" is a bit of a fiction, because those
checks do not exist at all. I'm OK with it because the earlier comment
explains what is going. I guess:

  # This may fail due to "-L is incompatible with pathspec", or
  # "-L is incompatible with --follow". We don't have the latter as of
  # the writing of this test, but either would be acceptable if we added
  # it.

would be an alternative. I doubt it's worth spending too much time
polishing.

-Peff
