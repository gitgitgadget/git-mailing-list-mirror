Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53700C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 21:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25DE920738
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 21:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgHYVSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 17:18:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:40764 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgHYVSh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 17:18:37 -0400
Received: (qmail 2920 invoked by uid 109); 25 Aug 2020 21:18:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Aug 2020 21:18:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3000 invoked by uid 111); 25 Aug 2020 21:18:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Aug 2020 17:18:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Aug 2020 17:18:36 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, steadmon@google.com
Subject: Re: [PATCH 0/7] Better threaded delta resolution in index-pack
 (another try)
Message-ID: <20200825211836.GA1448402@coredump.intra.peff.net>
References: <20200824220829.GA802799@coredump.intra.peff.net>
 <20200825181145.1091378-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825181145.1091378-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 11:11:45AM -0700, Jonathan Tan wrote:

> > There may be other cases that get better, though. A 3% increase here is
> > probably OK if we get something for it. But if our primary goal here is
> > increasing multithread efficiency, then we should be able to show some
> > benchmark that improves. :)
> 
> Ah...good question. Cloning from
> https://fuchsia.googlesource.com/third_party/vulkan-cts (mentioned in
> patch 7), cd-ing to the pack dir, and running:
> 
>   git index-pack --stdin -o foo <*.pack
> 
> I got 8m2.878s with my patches and 12m6.365s without. But I ran this on
> a cloud virtual machine (what I have access to right now) so the numbers
> might look different on a dedicated machine.

Thanks, that's a much more interesting example. Here's what I get on my
8-core machine:

  5302.9: index-pack default number of threads   167.70(546.19+12.00)   83.69(585.61+6.95) -50.1%

So that's a considerable improvement. And hardly surprising given the
repository structure. I used the script below to show the size of the
delta families, and the vk-master ones really dominate in size and
object number (the biggest is 50GB in one delta family).

I also ran my PERF_EXTRA tests on them to see if it behaved differently
as the threads increased. Nope:

  5302.3: index-pack 0 threads                   434.13(425.90+8.16)
  5302.4: index-pack 1 threads                   428.65(421.82+6.77)
  5302.5: index-pack 2 threads                   224.05(424.13+6.21)
  5302.6: index-pack 4 threads                   125.43(457.68+5.77)
  5302.7: index-pack 8 threads                   82.60(579.10+7.78) 
  5302.8: index-pack 16 threads                  82.89(1147.82+9.66)
  5302.9: index-pack default number of threads   83.91(576.92+8.52) 

Still maxes out at the number of physical cores (not unexpected, but
that was the thing I was most curious about ;) ). I may run it on the
40-core machine, too. It's possible that with the new threading we're
able to do better going past 20-threads. I doubt it, because I think
it's mostly a function of Git's locking granularity, but worth checking.

-Peff

-- >8 --
#!/bin/sh
# script to output size, count, and filenames for each delta family

git rev-list --objects --all |
git cat-file --buffer \
  --batch-check='%(objectname) %(deltabase) %(objectsize) %(rest)' |
perl -alne '
  if ($F[1] =~ /[^0]/) {
    push @{$children{$F[1]}}, $F[0];
  } else {
    push @bases, $F[0];
  }
  $size{$F[0]} = $F[2];
  $name{$F[0]} = $F[3];
  END {
    sub add_to_component {
      my ($oid, $data) = @_;
      $data->{names}->{$name{$oid}}++;
      $data->{size} += $size{$oid};
      $data->{nr}++;
      add_to_component($_, $data) for @{$children{$oid}};
    }
    for my $b (@bases) {
      my $data = { size => 0, nr => 0, names => {} };
      add_to_component($b, $data);
      print join(" ",
                 $data->{size}, $data->{nr},
		 sort keys(%{$data->{names}})
            ), "\n";
    }
  }
' |
sort -rn
