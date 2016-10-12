Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 436EF215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 23:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933214AbcJLXYw (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 19:24:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:56731 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933112AbcJLXYv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 19:24:51 -0400
Received: (qmail 3190 invoked by uid 109); 12 Oct 2016 23:18:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Oct 2016 23:18:10 +0000
Received: (qmail 24735 invoked by uid 111); 12 Oct 2016 23:18:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Oct 2016 19:18:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2016 19:18:07 -0400
Date:   Wed, 12 Oct 2016 19:18:07 -0400
From:   Jeff King <peff@peff.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Huge performance bottleneck reading packs
Message-ID: <20161012231807.syockv2emrsjf55r@sigill.intra.peff.net>
References: <ea8db41f-2ea4-b37b-e6f8-1f1d428aea5d@oracle.com>
 <20161012230143.5kxcmtityaasra5j@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161012230143.5kxcmtityaasra5j@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 07:01:43PM -0400, Jeff King wrote:

> On Thu, Oct 13, 2016 at 12:30:52AM +0200, Vegard Nossum wrote:
> 
> > However, the commit found by 'git blame' above appears just fine to me,
> > I haven't been able to spot a bug in it.
> > 
> > A closer inspection reveals the problem to really be that this is an
> > extremely hot path with more than -- holy cow -- 4,106,756,451
> > iterations on the 'packed_git' list for a single 'git fetch' on my
> > repository. I'm guessing the patch above just made the inner loop
> > ever so slightly slower.
> > 
> > My .git/objects/pack/ has ~2088 files (1042 idx files, 1042 pack files,
> > and 4 tmp_pack_* files).
> 
> Yeah. I agree that the commit you found makes the check a little more
> expensive, but I think the root of the problem is calling
> prepare_packed_git_one many times. This _should_ happen once for each
> pack at program startup, and possibly again if we need to re-scan the
> pack directory to account for racing with a simultaneous repack.
> 
> The latter is generally triggered when we fail to look up an object we
> expect to exist. So I'd suspect 45e8a74 (has_sha1_file: re-check pack
> directory before giving up, 2013-08-30) is playing a part. We dealt with
> that to some degree in 0eeb077 (index-pack: avoid excessive re-reading
> of pack directory, 2015-06-09), but it would not surprise me if there is
> another spot that needs similar treatment.
> 
> Does the patch below help?

Also, is it possible to make the repository in question available? I
might be able to reproduce based on your description, but it would save
time if I could directly run gdb on your example.

Specifically, I'm interested in the call graph that leads to calling
reprepare_packed_git().

-Peff
