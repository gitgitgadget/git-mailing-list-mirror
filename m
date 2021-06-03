Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDDBC47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AF4D61361
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 19:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhFCTll (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 15:41:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:45400 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCTll (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 15:41:41 -0400
Received: (qmail 6443 invoked by uid 109); 3 Jun 2021 19:39:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Jun 2021 19:39:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28584 invoked by uid 111); 3 Jun 2021 19:39:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Jun 2021 15:39:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 3 Jun 2021 15:39:53 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] packed_ref_store: handle a packed-refs file that is a
 symlink
Message-ID: <YLkwCTcRT/9s8+5R@coredump.intra.peff.net>
References: <20170720232040.GA159617@aiede.mtv.corp.google.com>
 <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
 <87y2bv0yvl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2bv0yvl.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 31, 2021 at 04:18:46PM +0200, Ævar Arnfjörð Bjarmason wrote:

> 
> On Wed, Jul 26 2017, Michael Haggerty wrote:
> 
> > [...]
> > +test_expect_success 'pack symlinked packed-refs' '
> > +	# First make sure that symlinking works when reading:
> > +	git update-ref refs/heads/loosy refs/heads/master &&
> > +	git for-each-ref >all-refs-before &&
> > +	mv .git/packed-refs .git/my-deviant-packed-refs &&
> > +	ln -s my-deviant-packed-refs .git/packed-refs &&
> > +	git for-each-ref >all-refs-linked &&
> > +	test_cmp all-refs-before all-refs-linked &&
> > +	git pack-refs --all --prune &&
> > +	git for-each-ref >all-refs-packed &&
> > +	test_cmp all-refs-before all-refs-packed &&
> > +	test -h .git/packed-refs &&
> > +	test "$(readlink .git/packed-refs)" = "my-deviant-packed-refs"
> > +'
> 
> FWIW this broke tests on AIX because we can't assume readlink(1) exists
> at all. See d2addc3b96 (t7800: readlink may not be available,
> 2016-05-31) for a workaround.

Hmm. So obviously we can use a fix similar to the one in t7800 (though
it's sufficiently complicated that I'd be tempted to wrap it in a helper
function). There are a few other calls that could be changed, too.

But it's interesting to me that it sounds like the tests have been
broken on AIX for 4 years, and nobody noticed. I assume you ran into
this on the gcc build-farm machines. Our traditional approach for
portability has been: if somebody is using the platform and cares enough
to submit patches, then we'll support it. But testing on the build-farm
means preemptively finding these problems, whether anyone actually cares
about AIX or not. :)

I'm not really arguing either way here, just thinking out loud.

Preemptively finding portability problems may save work in the long
term. And people may even be using Git on AIX and just ignoring test
failures, or they have GNU coreutils installed anyway, etc. But it would
also save work if we can ignore platforms that nobody uses.

-Peff
