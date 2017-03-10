Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A60271FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 19:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933432AbdCJTij (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 14:38:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:42210 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755276AbdCJTii (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 14:38:38 -0500
Received: (qmail 29038 invoked by uid 109); 10 Mar 2017 19:38:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 19:38:37 +0000
Received: (qmail 15797 invoked by uid 111); 10 Mar 2017 19:38:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 14:38:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Mar 2017 14:38:35 -0500
Date:   Fri, 10 Mar 2017 14:38:35 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Shawn Pearce <spearce@spearce.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20170310193835.t7syswueuu7nmkjz@sigill.intra.peff.net>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com>
 <20170309202408.GA17847@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170309202408.GA17847@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2017 at 12:24:08PM -0800, Jonathan Nieder wrote:

> > SHA-1 to SHA-3: lookup SHA-1 in .msha1, reverse .idx, find offset to
> > read the SHA-3.
> > SHA-3 to SHA-1: lookup SHA-3 in .idx, and reverse the .msha1 file to
> > translate offset to SHA-1.
> 
> Thanks for this suggestion.  I was initially vaguely nervous about
> lookup times in an idx-style file, but as you say, object reads from a
> packfile already have to deal with this kind of lookup and work fine.

Not exactly. The "reverse .idx" step has to build the reverse mapping on
the fly, and it's non-trivial. For instance, try:

  sha1=$(git rev-parse HEAD)
  time echo $sha1 | git cat-file --batch-check='%(objectsize)'
  time echo $sha1 | git cat-file --batch-check='%(objectsize:disk)'

on a large repo (where HEAD is in a big pack). The on-disk size is
conceptually simpler, as we only need to look at the offset of the
object versus the offset of the object after it. But in practice it
takes much longer, because it has to build the revindex on the fly (I
get 7ms versus 179ms on linux.git).

The effort is linear in the number of objects (we create the revindex
with a radix sort).

The reachability bitmaps suffer from this, too, as they need the
revindex to know which object is at which bit position. At GitHub we
added an extension to the .bitmap files that stores this "bit cache".
Here are timings before and after on linux.git:

  $ time git rev-list --use-bitmap-index --count master
  659371

  real	0m0.182s
  user	0m0.136s
  sys	0m0.044s

  $ time git.gh rev-list --use-bitmap-index --count master
  659371

  real	0m0.016s
  user	0m0.008s
  sys	0m0.004s

It's not a full revindex, but it's enough for bitmap use. You can also
use it to generate the revindex slightly more quickly, because you can
skip the sorting step (you just insert the entries in the correct order
by walking the bit cache and dereferencing the offsets from the .idx
portion). So it's still linear, but with a smaller constant factor.

I think for the purposes here, though, we don't actually care about the
offsets. For the cost of one uint32_t per object, you can keep a list
mapping positions in the sha1 index into the sha3 index. So then you do
the log-n binary search to find the sha1, a constant-time lookup in the
mapping array, and that gives you the position in the sha3 index, from
which you can then access the sha3 (or the actual pack offset, for that
matter).

So I think it's solvable, but I suspect we would want an extension to
the .idx format to store the mapping array, in order to keep it log-n.

-Peff
