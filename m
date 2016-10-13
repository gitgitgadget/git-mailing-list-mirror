Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC97320989
	for <e@80x24.org>; Thu, 13 Oct 2016 20:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756855AbcJMUpQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 16:45:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:57157 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756758AbcJMUpO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 16:45:14 -0400
Received: (qmail 8463 invoked by uid 109); 13 Oct 2016 20:43:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Oct 2016 20:43:54 +0000
Received: (qmail 32281 invoked by uid 111); 13 Oct 2016 20:44:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Oct 2016 16:44:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Oct 2016 16:43:51 -0400
Date:   Thu, 13 Oct 2016 16:43:51 -0400
From:   Jeff King <peff@peff.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Huge performance bottleneck reading packs
Message-ID: <20161013204351.rezqssvw63343l4g@sigill.intra.peff.net>
References: <20161013152632.ynsabbv3yrthgidy@sigill.intra.peff.net>
 <d727ee5d-5f0f-e6df-3f83-35fe74641ace@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d727ee5d-5f0f-e6df-3f83-35fe74641ace@oracle.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2016 at 08:18:11PM +0200, Vegard Nossum wrote:

> > My guess is that the number is relatively high. And that would explain
> > why nobody else has really complained much; such a pattern is probably
> > uncommon.
> 
> I get ~3,700 objects "they are advertising that we don't have".
> 
> They are all indeed tags which I don't have (nor want) locally.

Thanks. That's about what I expected.

> So without your patch I get these numbers:
> 
>   %   cumulative   self              self     total
>  time   seconds   seconds    calls   s/call   s/call  name
>  37.34     29.83    29.83 1948265116     0.00     0.00  strip_suffix_mem
>  27.56     51.85    22.02    11358     0.00     0.01 prepare_packed_git_one
>  14.24     63.23    11.38 1924457702     0.00     0.00  strip_suffix
>   4.88     67.13     3.90 26045319     0.00     0.00  find_pack_entry_one
>   4.17     70.46     3.33 84828149     0.00     0.00  hashcmp
>   3.28     73.08     2.62 79760199     0.00     0.00  hashcmp
>   2.44     75.03     1.95                             const_error
> 
> the call graph data shows all the reprepare_packed_git() calls to come
> from a chain like this:
> 
> do_for_each_ref
> do_for_each_ref_iterator
> ref_iterator_advance
> files_ref_iterator_advance
> ref_resolves_to_object
> has_sha1_file
> has_sha1_file_with_flags
> reprepare_packed_git

Hrm. It seems weird that we'd hit reprepare_packed_git() via
do_for_each_ref(), because that's looking at _your_ refs. So any time
that code path hits reprepare_packed_git(), it should be complaining
about repository corruption to stderr.

And that also wouldn't make sense that my patch would improve it. Are
you sure you've read the perf output correctly (I'll admit that I am
often confused by the way it reports call graphs)?

> With your (first) patch I get this instead:
> 
>   %   cumulative   self              self     total
>  time   seconds   seconds    calls  ms/call  ms/call  name
>  29.41      0.25     0.25  4490399     0.00     0.00  hashcmp
>  16.47      0.39     0.14   843447     0.00     0.00  find_pack_entry_one

These functions appearing at the top are probably a sign that you have
too many packs (these are just object lookup, which has to linearly try
each pack).

So I'd expect things to improve after a git-gc (and especially if you
turn off the packSizeLimit).

> Do you have all the profile data you were interested in before I try a
> 'git gc'?

Yes, I think so. At least I'm satisfied that there's not another
HAS_SHA1_QUICK case that I'm missing.

> I really appreciate the quick response and the work you put into fixing
> this, even when it's my fault for disabling gc, thanks!

No problem. I do think you'll benefit a lot from packing everything into
a single pack, but it's also clear that Git was doing more work than it
needed to be. This was a known issue when we added the racy-check to
has_sha1_file(), and knew that we might have to field reports like this
one.

-Peff
