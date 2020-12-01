Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CDAC64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B0F220770
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390030AbgLAL5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 06:57:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:47130 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387394AbgLAL5u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 06:57:50 -0500
Received: (qmail 26212 invoked by uid 109); 1 Dec 2020 11:57:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Dec 2020 11:57:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25966 invoked by uid 111); 1 Dec 2020 11:57:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 06:57:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 06:57:09 -0500
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/6] fixup! reftable: rest of library
Message-ID: <X8YvlS29KKYje1Az@coredump.intra.peff.net>
References: <pull.801.git.1606545878.gitgitgadget@gmail.com>
 <58f2b0394546e8da2922adcbc38bdb6b53f2b313.1606545878.git.gitgitgadget@gmail.com>
 <X8YaWySkyRU3DA87@coredump.intra.peff.net>
 <CAFQ2z_M3C=mCkiPxOLhBSrXR-PDQdb7GLPRWM2egV4cO4a-c0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_M3C=mCkiPxOLhBSrXR-PDQdb7GLPRWM2egV4cO4a-c0w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 12:10:14PM +0100, Han-Wen Nienhuys wrote:

> > I think passing:
> >
> >   sizes_to_segments(&seglen, NULL, 0);
> >
> > may make the code more obvious. Unlike system functions like memcpy(),
> > we can be assured of whether our functions avoid looking at a
> > zero-length array (and size_to_segments does follow that rule).
> >
> >   This function, of course, is nonsense that real code would not do, and
> 
> This test was added because 'real' code did this. In particular, if
> you initialize a stack of reftables, the stack has zero elements. The
> test was for the following bugfix
> 
> https://github.com/google/reftable/commit/b2e42ecb54e413e494c1fcc13c21e24422645007
> 
> Changing the array size to 1 here also prevents Valgrind to mark a
> regression as a OOB write.

Sorry to be unclear. I meant that real code would not allocate a static
zero-length array (though it might do so on the heap). I agree that
making sure the function behaves in the 0-segment case is quite
reasonable.

Passing NULL actually makes the test more rigorous IMHO (because it is a
strict superset of failure modes, and is something an actual caller
might do if it were dynamically growing an array that started at NULL).

-Peff
