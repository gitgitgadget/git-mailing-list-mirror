Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A16C4363D
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99ED9208B6
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 12:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgJEMHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 08:07:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:49542 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgJEMHj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 08:07:39 -0400
Received: (qmail 32167 invoked by uid 109); 5 Oct 2020 12:07:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 12:07:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18925 invoked by uid 111); 5 Oct 2020 12:07:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 08:07:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 08:07:38 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/7] verify_path(): disallow symlinks in .gitattributes
 and .gitignore
Message-ID: <20201005120738.GA2902357@coredump.intra.peff.net>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005072406.GF2291074@coredump.intra.peff.net>
 <20201005080930.GI1166820@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005080930.GI1166820@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 05, 2020 at 01:09:30AM -0700, Jonathan Nieder wrote:

> > I note that neither these new tests nor the existing .gitmodules ones
> > confirm that we catch the obscured ntfs/hfs forms in the actual code
> > paths (instead, we feed them to a synthetic test-tool helper in t0060).
> > I think that's OK, but if we wanted to be super-paranoid we could beef
> > up these tests with trickier names.
> 
> I think being exhaustive wouldn't be worth it, but perhaps *one*
> example (e.g., ".gitmodules ") would not be a terrible idea.

It wasn't _too_ bad to extract these tests into a function, at which
point it was easy to test one filename of each type. That will be in my
v2.

> > +test_expect_success 'refuse to load symlinked .gitattributes into index' '
> > +	test_must_fail git -C symlink-attr read-tree $tree 2>err &&
> > +	test_i18ngrep "invalid path.*gitattributes" err
> 
> This tests that it fails but doesn't test that it had no effect.
> Would that be straightforward to check as well (e.g. an "ls-files -s"
> before and after)?

Yeah, "ls-files" should be empty afterwards (we've never added anything
to the index during the creation steps). That was easy enough to add.

-Peff
