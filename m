Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23131C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C992823108
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbhASXAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:00:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:60398 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbhASXAY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:00:24 -0500
Received: (qmail 15437 invoked by uid 109); 19 Jan 2021 22:59:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Jan 2021 22:59:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13559 invoked by uid 111); 19 Jan 2021 22:59:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Jan 2021 17:59:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 Jan 2021 17:59:34 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jacob Vosmaer <jacob@gitlab.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] ls-refs.c: minimize number of refs visited
Message-ID: <YAdkVkXOnpDy28h2@coredump.intra.peff.net>
References: <20210119144251.27924-1-jacob@gitlab.com>
 <20210119144251.27924-2-jacob@gitlab.com>
 <YAcE/dTuOB9PbGQU@nand.local>
 <CADMWQoPREhirr+RJPkJJV2U+8VG=DFotvTBCDSXFhn-3pn2X-A@mail.gmail.com>
 <YAcuUDqfvKzfHFMb@nand.local>
 <YAdWNgF75QEYFLA7@coredump.intra.peff.net>
 <YAdaAsP6vCQla/Ar@coredump.intra.peff.net>
 <YAdb6GmVXWLEGkP1@nand.local>
 <YAdik+z5yj2XU0ti@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAdik+z5yj2XU0ti@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 05:52:04PM -0500, Jeff King wrote:

> On Tue, Jan 19, 2021 at 05:23:36PM -0500, Taylor Blau wrote:
> 
> > > Having now looked carefully at the ls-refs code, it's a pure
> > > prefix-match, too. So I think we _could_ rely on for_each_fullref_in()
> > > returning us the correct full results, and not checking it further in
> > > send_ref(). But I kind of like keeping it there as an extra check (and
> > > one which could in theory grow more logic later).
> > 
> > Hmm. What if the caller asks for:
> > 
> >   ref-prefix refs/tags/a
> >   ref-prefix refs/tags/b
> > 
> > ?
> > 
> > The LCP between those two is refs/tags, so send_ref() will presumably
> > get lots of reuslts that it doesn't care about (assuming there are tags
> > besides a and b).
> 
> Oh, you're right, of course. Ignore me. :)

Actually, I am not sure that we would look for "refs/tags/" in that case
(I did a quick test and we do not seem to). Which makes sense, as it is
cheaper to find the "a" and "b" hierarchies separately if there is a
very big "refs/tags/c" hierarchy.

But I agree that this is a good reason that callers should consider it
as an optimization which could return more results than expected.

-Peff
