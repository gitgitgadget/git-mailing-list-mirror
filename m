Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DEBC1F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 20:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDWUJe (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 16:09:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43112 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfDWUJe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 16:09:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1FC7660592; Tue, 23 Apr 2019 20:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556050173;
        bh=v4sbJic/ExZvPLpE3ynH+F2+v+ApkbtLU2zNSVUd9A0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YywT46HlScnjU+IY5RPUO0aaaotl7zpuNjYois1D1Z1HWsDEtFZShfN6BgpLpQ2rF
         qqNdgqA8tv52gKdY7a3ot/yX7SXENJ1KkpZq4SqyDhlMAEvCi6yOKB67i+EDzRuK3G
         W+OG0MFNSm55+8RW3NXZ01SD3YTLpLDJjRAqegUQ=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92F93601D4;
        Tue, 23 Apr 2019 20:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556050172;
        bh=v4sbJic/ExZvPLpE3ynH+F2+v+ApkbtLU2zNSVUd9A0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pIiQj5jC3CuBo0oSEvc1eSdE2stXD+mlvPAeCi14RX4BSQ7nJI9SfFdfrr4sVANX0
         VB1pWOjEJAZL9A7f/b8G/obrDLIB6D+ufVwW1QuJ43SOetpodr+NHrcP4kn29JbR/5
         14spqmnkSRYI6pBmAGfHXKYeodaCoRGQ7BSKreDw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92F93601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: Resolving deltas dominates clone time
Date:   Tue, 23 Apr 2019 14:09:31 -0600
Message-ID: <3329645.KIYB9vJKXd@mfick-lnx>
User-Agent: KMail/5.1.3 (Linux/4.4.0-137-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <CACsJy8B7tjjpUZK+zH4rvOSk=uTLOHCOy6hk4FkkHXqCzNZU9g@mail.gmail.com>
References: <259296914.jpyqiltySj@mfick-lnx> <20190423042109.GA19183@sigill.intra.peff.net> <CACsJy8B7tjjpUZK+zH4rvOSk=uTLOHCOy6hk4FkkHXqCzNZU9g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, April 23, 2019 5:08:40 PM MDT Duy Nguyen wrote:
> On Tue, Apr 23, 2019 at 11:45 AM Jeff King <peff@peff.net> wrote:
> > On Mon, Apr 22, 2019 at 09:55:38PM -0400, Jeff King wrote:
> > > Here are my p5302 numbers on linux.git, by the way.
> > > 
> > >   Test                                           jk/p5302-repeat-fix
> > >   ------------------------------------------------------------------
> > >   5302.2: index-pack 0 threads                   307.04(303.74+3.30)
> > >   5302.3: index-pack 1 thread                    309.74(306.13+3.56)
> > >   5302.4: index-pack 2 threads                   177.89(313.73+3.60)
> > >   5302.5: index-pack 4 threads                   117.14(344.07+4.29)
> > >   5302.6: index-pack 8 threads                   112.40(607.12+5.80)
> > >   5302.7: index-pack default number of threads   135.00(322.03+3.74)
> > > 
> > > which still imply that "4" is a win over "3" ("8" is slightly better
> > > still in wall-clock time, but the total CPU rises dramatically; that's
> > > probably because this is a quad-core with hyperthreading, so by that
> > > point we're just throttling down the CPUs).
> > 
> > And here's a similar test run on a 20-core Xeon w/ hyperthreading (I
> > tweaked the test to keep going after eight threads):
> > 
> > Test                            HEAD
> > ----------------------------------------------------
> > 5302.2: index-pack 1 threads    376.88(364.50+11.52)
> > 5302.3: index-pack 2 threads    228.13(371.21+17.86)
> > 5302.4: index-pack 4 threads    151.41(387.06+21.12)
> > 5302.5: index-pack 8 threads    113.68(413.40+25.80)
> > 5302.6: index-pack 16 threads   100.60(511.85+37.53)
> > 5302.7: index-pack 32 threads   94.43(623.82+45.70)
> > 5302.8: index-pack 40 threads   93.64(702.88+47.61)
> > 
> > I don't think any of this is _particularly_ relevant to your case, but
> > it really seems to me that the default of capping at 3 threads is too
> > low.

Here are my index-pack results (I only ran them once since they take a while) 
using vgit 1.8.3.2:

Threads  real       user        sys
1     108m46.151s 106m14.420s  1m57.192s
2     58m14.274s  106m23.158s  5m32.736s
3     40m33.351s  106m42.281s  5m40.884s
4     31m40.342s  107m20.278s  5m40.675s
5     26m0.454s   106m54.370s  5m35.827s
12    13m25.304s  107m57.271s  6m26.493s
16    10m56.866s  107m46.107s  6m41.330s
18    10m18.112s  109m50.893s  7m1.369s
20    9m54.010s   113m51.028s  7m53.082s
24    9m1.104s    115m8.245s   7m57.156s
28    8m26.058s   116m46.311s  8m34.752s
32    8m42.967s   140m33.280s  9m59.514s
36    8m52.228s   151m28.939s  11m55.590s
40    8m22.719s   153m4.496s   12m36.041s
44    8m12.419s   166m41.594s  14m7.717s
48    8m0.377s    172m3.597s   16m32.041s
56    8m22.320s   188m31.426s  17m48.274s

 
> Looking back at the multithread commit, I think the trend was the same
> and I capped it because the gain was not proportional to the number of
> cores we threw at index-pack anymore. I would not be opposed to
> raising the cap though (or maybe just remove it)

I think that if there were no default limit during a clone it could have 
disastrous effects on people using the repo tool from the android project, or 
any other "submodule like" tool that might clone many projects in parallel. 
With the repo tool, people often use a large -j number such as 24 which means 
they end up cloning around 24 projects at a time, and they may do this for 
around 1000 projects. If git clone suddenly started as many threads as there 
are CPUs for each clone, this would likely paralyze the machine.

I do suspect it would be nice to have a switch though that repo could use to 
adjust this intelligently, is there some way to adjust threads from a clone, I 
don't see one? I tried using 'GIT_FORCE_THREADS=28 git clone ...' and it 
didn't seem to make a difference?

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

