From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/6] reuse deltas found by bitmaps
Date: Wed, 26 Mar 2014 14:13:00 -0400
Message-ID: <20140326181300.GA7087@sigill.intra.peff.net>
References: <20140326072215.GA31739@sigill.intra.peff.net>
 <xmqq7g7gkgp6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ben Maurer <bmaurer@fb.com>,
	Siddharth Agarwal <sid0@fb.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 19:13:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSsK4-0000GS-9A
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 19:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbaCZSND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 14:13:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:47699 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751330AbaCZSNC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 14:13:02 -0400
Received: (qmail 14100 invoked by uid 102); 26 Mar 2014 18:13:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Mar 2014 13:13:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2014 14:13:00 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7g7gkgp6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245201>

On Wed, Mar 26, 2014 at 10:33:41AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   2. When considering whether a delta can be reused, check the bitmaps
> >      to see if the client has the base. If so, allow reuse.
> > ...
> > The implementation I'm including here is the one I've shown before,
> > which does (2). Part of the reason that I'm reposting it before looking
> > further into these options is that I've written a t/perf script that can
> > help with the analysis.
> 
> Conceptually, that feels like a natural extension for the "thin
> pack" transfer.  I wouldn't foresee a correctness issue, as long as
> the fetcher runs "index-pack --fix-thin" at their end.

Right, this is only enabled when --thin is negotiated during the
protocol transfer. I don't think there's any correctness problem here.
But I want to make sure we are doing the fastest thing.

Here's another set of results comparing three runs: v1.9.0 (with no
bitmaps), origin/master (bitmaps), and this series. Apologies for the
long lines.

  Test                         v1.9.0            origin                     HEAD                   
  -------------------------------------------------------------------------------------------------
  5311.3: server   (1 days)    0.20(0.17+0.02)   0.29(0.34+0.04) +45.0%     0.14(0.12+0.02) -30.0% 
  5311.4: size     (1 days)              56.2K              1.0M +1694.4%             59.5K +5.9%  
  5311.5: client   (1 days)    0.08(0.07+0.00)   0.03(0.04+0.00) -62.5%     0.08(0.07+0.00) +0.0%  
  5311.7: server   (2 days)    0.06(0.06+0.00)   0.28(0.33+0.04) +366.7%    0.14(0.11+0.02) +133.3%
  5311.8: size     (2 days)              56.2K              1.0M +1694.4%             59.5K +5.9%  
  5311.9: client   (2 days)    0.09(0.08+0.00)   0.03(0.04+0.00) -66.7%     0.09(0.08+0.00) +0.0%  
  5311.11: server   (4 days)   0.21(0.18+0.02)   0.29(0.33+0.03) +38.1%     0.14(0.11+0.02) -33.3% 
  5311.12: size     (4 days)             64.2K              1.1M +1536.6%             67.9K +5.8%  
  5311.13: client   (4 days)   0.08(0.08+0.00)   0.04(0.03+0.01) -50.0%     0.09(0.07+0.01) +12.5% 
  5311.15: server   (8 days)   0.22(0.21+0.02)   0.36(0.47+0.03) +63.6%     0.14(0.11+0.02) -36.4% 
  5311.16: size     (8 days)            125.7K              1.5M +1100.8%            130.1K +3.5%  
  5311.17: client   (8 days)   0.11(0.10+0.00)   0.05(0.05+0.00) -54.5%     0.13(0.11+0.01) +18.2% 
  5311.19: server  (16 days)   0.26(0.26+0.03)   0.76(1.20+0.04) +192.3%    0.25(0.21+0.04) -3.8%  
  5311.20: size    (16 days)            358.6K              3.7M +931.7%             359.8K +0.3%  
  5311.21: client  (16 days)   0.28(0.27+0.01)   0.13(0.15+0.00) -53.6%     0.30(0.28+0.02) +7.1%  
  5311.23: server  (32 days)   0.44(0.54+0.07)   1.39(2.54+0.04) +215.9%    0.28(0.23+0.04) -36.4% 
  5311.24: size    (32 days)              1.1M              8.6M +652.4%               2.1M +83.9% 
  5311.25: client  (32 days)   0.66(0.64+0.02)   0.32(0.38+0.01) -51.5%     0.69(0.67+0.04) +4.5%  
  5311.27: server  (64 days)   2.78(4.02+0.17)   7.02(15.59+0.16) +152.5%   0.43(0.37+0.07) -84.5% 
  5311.28: size    (64 days)             18.7M             68.3M +265.5%              24.5M +31.3% 
  5311.29: client  (64 days)   6.25(6.29+0.16)   3.21(4.76+0.14) -48.6%     6.27(6.46+0.18) +0.3%  
  5311.31: server (128 days)   4.48(7.32+0.21)   7.56(16.60+0.16) +68.8%    0.51(0.45+0.10) -88.6% 
  5311.32: size   (128 days)             25.8M             83.1M +222.3%              35.9M +39.2% 
  5311.33: client (128 days)   7.32(7.58+0.17)   3.94(5.87+0.18) -46.2%     7.15(7.80+0.20) -2.3%  

My previous results showed that this series was an improvement over
straight bitmaps. But what it didn't show is that bitmaps actually
provide a regression for some fetches (I think because we do not find
the boundary commits at all, and do not have any preferred bases).

Just looking at the 128-day case again, using bitmaps increased our
server CPU time _and_ made a much bigger pack. This series not only
fixes the CPU time regression, but it also drops the server CPU time to
almost nothing. That's a nice improvement, and it makes perfect sense:
we are reusing on-disk deltas instead of on-the-fly computing deltas
against the preferred bases.

And it does help with the size regression, though the end result is
still a bit worse than v1.9.0. I'm not exactly sure what's going on
here. My guess is that we have objects to send that are not deltas on
disk (probably because they are at the tip of history and other things
are deltas against them). We would still want to do delta compression of
them against preferred bases, but we don't have any preferred bases in
our list.

So I think we still want to add back in some list of preferred base
objects when bitmaps are in use. The question is, which objects?
With bitmaps, it's easy to add in all of the objects the client has, but
that is probably going to be counterproductive (I still need to measure
it, though).

I think we could still add the objects from the tip of the client's HAVE
list. This patch would still be a CPU win on top of that, because it
would reduce the number of objects which need a delta search in the
first place.

But it also creates worse packs on the client side after --fix-thin is
run. Any preferred base we use it something the client may have to add
back in. So once a thin base is used, we would want to use it again to
reduce the work the client has to do to fix it. And in that sense, it
would be helpful to add in bases that we reuse via this patch as
preferred bases for further delta searches.

But solely relying on that would give us a rather incomplete set of
bases. If we are sending a blob for "foo.c" that has an on-disk delta
against an older version that the client has, we'd reuse that delta. And
then further versions of foo.c might be able to use that same base,
which is good. But if we are sending one version of "bar.c" that has no
on-disk delta, then it has no useful preferred bases.

So I think the next steps are probably:

  1. Measure the "all objects are preferred bases" approach and confirm
     that it is bad.

  2. Measure the "reused deltas become preferred bases" approach. I
     expect the resulting size to be slightly better than what I have
     now, but not as good as v1.9.0's size (but taking less CPU time).

  3. Measure the "figure out boundaries and add them as preferred bases,
     like we do without bitmaps" approach. I expect this to behave
     similarly to v1.9.0.

  4. Combine (2) and (3) and measure them. I'm _hoping_ this will give
     us the best of both worlds, but I still want to do the individual
     measurements so we can see where any improvement is coming from.

-Peff
