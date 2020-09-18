Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC23C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0878821741
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIRSFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 14:05:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:33598 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgIRSFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 14:05:09 -0400
Received: (qmail 11559 invoked by uid 109); 18 Sep 2020 18:05:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Sep 2020 18:05:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23609 invoked by uid 111); 18 Sep 2020 18:05:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Sep 2020 14:05:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Sep 2020 14:05:08 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Thomas Guyot-Sionnest <tguyot@gmail.com>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
Subject: Re: [PATCH 2/2] Allow passing pipes for input pipes to diff
 --no-index
Message-ID: <20200918180508.GB186717@coredump.intra.peff.net>
References: <20200918113256.8699-1-tguyot@gmail.com>
 <20200918113256.8699-3-tguyot@gmail.com>
 <20200918143647.GB1606445@nand.local>
 <CALqVohfFjsh-2jZLNNwON_V95Dfh-aEh1aMb53t4NQrM0qz1tQ@mail.gmail.com>
 <20200918175836.GA149847@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200918175836.GA149847@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 01:58:36PM -0400, Taylor Blau wrote:

> > *untested*:
> >
> >     if (!lstat(name, &st)) {
> >         if (!S_ISLNK(st.st_mode))
> >             return(0);
> >         if (!stat(name, &st)) {
> >             if (!S_ISFIFO(st.st_mode))
> >                 return(0);
> 
> I still don't think I quite understand why FIFOs aren't allowed...

It's the other way around. Non-fifos return "0" from this "is it a pipe"
function.

I think it is to prevent a false positive with:

  rm bar
  ln -s foo bar
  git diff --no-index foo something-else

We'd still want to treat "foo" as a symlink there. I.e., the heuristic
for guessing it's a process substitution pipe is:

  - it's a symlink that doesn't point anywhere
  - it's also a fifo

-Peff
