Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E14C2D0C0
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 06:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80751208E4
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 06:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfL2GMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 01:12:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:54852 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725800AbfL2GMr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 01:12:47 -0500
Received: (qmail 20766 invoked by uid 109); 29 Dec 2019 06:12:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 29 Dec 2019 06:12:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5004 invoked by uid 111); 29 Dec 2019 06:17:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Dec 2019 01:17:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 29 Dec 2019 01:12:46 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] commit-graph: examine changed-path objects in pack
 order
Message-ID: <20191229061246.GB220034@coredump.intra.peff.net>
References: <20191222093036.GA3449072@coredump.intra.peff.net>
 <20191222093206.GA3460818@coredump.intra.peff.net>
 <8b331ef6-f431-56ef-37a9-1d6e263ea0fe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b331ef6-f431-56ef-37a9-1d6e263ea0fe@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 27, 2019 at 09:51:02AM -0500, Derrick Stolee wrote:

> On 12/22/2019 4:32 AM, Jeff King wrote:
> > Looking at the diff of commit objects in pack order is much faster than
> > in sha1 order, as it gives locality to the access of tree deltas
> > (whereas sha1 order is effectively random). Unfortunately the
> > commit-graph code sorts the commits (several times, sometimes as an oid
> > and sometimes a pointer-to-commit), and we ultimately traverse in sha1
> > order.
> > 
> > Instead, let's remember the position at which we see each commit, and
> > traverse in that order when looking at bloom filters. This drops my time
> > for "git commit-graph write --changed-paths" in linux.git from ~4
> > minutes to ~1.5 minutes.
> 
> I'm doing my own perf tests on these patches, and my copy of linux.git
> has four packs of varying sizes (corresponding with my rare fetches and
> lack of repacks). My time goes from 3m50s to 3m00s. I was confused at
> first, but then realized that I used the "--reachable" flag. In that
> case, we never run set_commit_pos(), so all positions are equal and the
> sort is not helpful.
> 
> I thought that inserting some set_commit_pos() calls into close_reachable()
> and add_missing_parents() would give some amount of time-order to the
> commits as we compute the filters. However, the time did not change at
> all.
> 
> I've included the patch below for reference, anyway.

Yeah, I expected that would cover it, too. But instrumenting it to dump
the position of each commit (see patch below), and then decorating "git
log" output with the positions (see script below) shows that we're all
over the map:

  *   3
  |\  
  | * 2791
  | * 5476
  | * 8520
  | * 12040
  | * 16036
  * |   2790
  |\ \  
  | * | 5475
  | * | 8519
  | * | 12039
  | * | 16035
  | * | 20517
  | * | 25527
  | |/  
  * |   5474
  |\ \  
  | * | 8518
  | * | 12038
  * | |   8517
  [...]

I think the root issue is that we never do any date-sorting on the
commits. So:

  - we hit each ref tip in lexical order; with tags, this is quite often
    the opposite of reverse-chronological

  - we traverse breadth-first, but we don't order queue at all. So if we
    see a merge X, then we'll next process X^1 and X^2, and then X^1^,
    and then X^2^, and so forth. So we keep digging equally down
    simultaneous branches, even if one branch is way shorter than the
    other. Whereas a regular Git traversal will order the queue by
    commit timestamp, so it tends to be roughly chronological (of course
    a topo-sort would work too, but that's probably overkill).

I wonder if this would be simpler if "commit-graph --reachable" just
used the regular revision machinery instead of doing its own custom
traversal.

-Peff
