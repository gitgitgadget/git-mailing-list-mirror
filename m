Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF35C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57DC6100A
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhDJBej (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 21:34:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:47412 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234333AbhDJBei (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 21:34:38 -0400
Received: (qmail 4774 invoked by uid 109); 10 Apr 2021 01:34:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 10 Apr 2021 01:34:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18773 invoked by uid 111); 10 Apr 2021 01:34:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 21:34:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 21:34:23 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH 0/2] here-doc test bodies
Message-ID: <YHEAn7u4SXlmZsfZ@coredump.intra.peff.net>
References: <YHDUg6ZR5vu93kGm@coredump.intra.peff.net>
 <42b187cb-6417-0353-cf63-c6379be53208@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42b187cb-6417-0353-cf63-c6379be53208@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 09:03:24PM -0400, Derrick Stolee wrote:

> On 4/9/2021 6:26 PM, Jeff King wrote:
> > I've been wanting to do this for years, but after getting bitten by a
> > misplaced quote the other day, I finally did. This series allows you to
> > do:
> > 
> >   test_expect_success <<\EOT
> >           something 'with single quotes'
> >   EOT
> > 
> > Thoughts?
> 
> Odd. I _just_ hit this for the first time today. I didn't know
> about the $SQ trick, so I just modified my 'sed' call to drop
> the single quotes from the string I was trying to match [1].
> 
> [1] https://lore.kernel.org/git/36aa6837-722c-9ef0-84cc-77e982db9f6e@gmail.com/

Yep, that case would definitely benefit. We have a variety of little
workarounds now, but it would be nice to not even need them.

> I think this is a good pattern for this kind of thing. I
> imagine that if the test itself needed heredocs, then they
> would be interpreted correctly when evaluating stdin (as
> long as a different identifier is used).

Yeah, some of the tests I converted in t1404 have their own here-docs.
It works for the same reason that the single-quoted snippets work: the
outer doc slurps the whole thing to the "EOT" marker. So we do not even
consider the inner here-docs until we are eval-ing the snippet.

> I also like the "EOT" pattern as an example.

I think it would make sense to have a convention here for readability.
Also, I added this to the sharness vim highlighter from [1]:

diff --git a/sharness.vim b/sharness.vim
index 6ffc64f..7dbcd18 100644
--- a/sharness.vim
+++ b/sharness.vim
@@ -21,6 +21,9 @@ syn region shsTestBody contained transparent excludenl matchgroup=shQuote start=
 syn region shsTestBody contained oneline transparent excludenl keepend matchgroup=shQuote start=+ '+hs=s+1 end=+'$+ contains=@shSubShList
 syn region shsTestBody contained oneline transparent excludenl keepend matchgroup=shQuote start=+ "+hs=s+1 end=+"$+ contains=@shSubShList
 
+" here-doc body
+syn region shsTestBody contained transparent excludenl matchgroup=shQuote start=+ <<\\EOT+ end=+EOT$+ contains=@shSubShList
+
 syn match shsPrereq contained "\<[A-Z_,]\+\>" nextgroup=shsTestTitle
 syn match shsPrereqLazy contained "\<[A-Z_,]\+\>" nextgroup=shsTestBody
 

which makes the innards look nice. :) I think it could be written to
allow any marker, but there would probably need to be some magic with
matching the opening and closing markers.

-Peff

[1] https://lore.kernel.org/git/CAMP44s1D-Zp3KDS+Hi74a=Lkc7Nc_0qiEzQEF0Pmj=bD8i+=JQ@mail.gmail.com/
