Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55280C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A314613D2
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239897AbhGNSAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:00:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:49738 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231623AbhGNSAO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 14:00:14 -0400
Received: (qmail 29916 invoked by uid 109); 14 Jul 2021 17:57:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jul 2021 17:57:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26760 invoked by uid 111); 14 Jul 2021 17:57:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jul 2021 13:57:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Jul 2021 13:57:21 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 4/4] Bump rename limit defaults (yet again)
Message-ID: <YO8lgYa5/RlL1zGp@coredump.intra.peff.net>
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
 <8f1deb6dd16a0c0d88cf594d2019b3096dbe5383.1626225154.git.gitgitgadget@gmail.com>
 <YO8UPtFr4wRhVTXE@coredump.intra.peff.net>
 <CABPp-BG7T2QP+6uP57NuE1Htr-vBzozL-aDxU4FsyQO+ELQ9Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BG7T2QP+6uP57NuE1Htr-vBzozL-aDxU4FsyQO+ELQ9Uw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 10:32:56AM -0700, Elijah Newren wrote:

> > It's slightly sad that we only got a 30% CPU improvement in the past 10
> > years. Are you just counting clock speed as a short-hand here? I think
> > that doesn't tell the whole story. But all of this is a side-note
> > anyway.  What I care about is your actual timings. :)
> 
> I'm using shorthand when discussing file sizes above (though I used
> actual measurements when picking new values below).  But the 30% came
> from measuring the timings with the exact same sample file as you and
> using a lightly modified version of your original script (tweaked to
> also change file basenames) on an AWS c5xlarge instance.  My timings
> showed they were only about 30% faster than what you got when you last
> bumped the limits.

Interesting. My timings are much faster. With a 20k file, I get (on my
laptop, which is an i9-9880H):

     N     CPU (2008)    CPU (now)
    10          0.43s       0.007s
   100          0.44s       0.071s
   200          1.40s       0.226s
   400          4.87s       0.788s
   800         18.08s       2.887s
  1000         27.82s       4.431s

The 2008 timings are from the old email you linked in your commit
message, and the new one is from running the revised script you showed.
The savings seem like more than 30%. I don't know if that's all CPU or
if something changed in the code.

Using a 3k file (the median for ls-tree), numbers are similar, but a
little smaller (my n=1300 is about 1.4s).  So I think we're both in the
same ballpark (and certainly an AWS machine is a perfectly fine
representative sample of where people might run Git).

-Peff
