From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 3 Oct 2007 02:54:15 -0400
Message-ID: <20071003065414.GA13737@coredump.intra.peff.net>
References: <7vfy11yyxk.fsf@gitster.siamese.dyndns.org> <20070927023633.GA28902@coredump.intra.peff.net> <20071002041652.GA32133@coredump.intra.peff.net> <7vsl4up0tf.fsf@gitster.siamese.dyndns.org> <20071002050820.GA4261@coredump.intra.peff.net> <20071002051332.GA4462@coredump.intra.peff.net> <86ejge6o8b.fsf@lola.quinscape.zz> <20071002161114.GC6828@coredump.intra.peff.net> <86ve9p32cp.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0710021916080.3579@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 08:54:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icy7m-0007Fd-Je
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 08:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbXJCGyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 02:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbXJCGyS
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 02:54:18 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3698 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbXJCGyR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 02:54:17 -0400
Received: (qmail 12547 invoked by uid 111); 3 Oct 2007 06:54:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Oct 2007 02:54:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2007 02:54:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710021916080.3579@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59797>

On Tue, Oct 02, 2007 at 07:28:19PM -0700, Linus Torvalds wrote:

> Sadly, that's not the case. It *does* seem to beat the current 
> implementation, but it's not "beat the pants off". It looks like an 
> improvement of about 15%, which is nothing to sneeze at, but it's not an 
> order-of-magnitude improvement either.
> 
> Here's a test-patch. I don't guarantee anything, except that when I did 
> the timings I also did a "wc" on the result, and they matched..

I get slightly better speedups with my pathological case (around 30%):

Before:
  $ /usr/bin/time git-diff --raw -M -l0 06d288^ 06d288 >/dev/null
  105.38user 3.65system 2:14.90elapsed 80%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (15432major+542627minor)pagefaults 0swaps

After:
  $ /usr/bin/time git-diff --raw -M -l0 06d288^ 06d288 >/dev/null
  71.70user 3.47system 1:40.43elapsed 74%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (15065major+551778minor)pagefaults 0swaps

But yes, it's not the order of magnitude we were looking for.

> 	[torvalds@woody linux]$ time git diff -l0 --stat -C v2.6.22.. | wc

I found less noise in the timing by using --raw, since the patch
computation takes an appreciable amount of time.

> but the diff is fairly simple, so if somebody will go over it and say 
> whether it's likely to be *correct* too, that 15% may well be worth it.

Patch looks correct, and it produces correct results on my (admittedly
limited) test data.

I think it's worth applying (though I agree that a comment on the
assumption of a zero "cnt" at the end is worth adding) unless some
drastically different solution comes along (e.g., David's idea to try
avoiding the outer O(n^2) loop). But I don't think there is much more to
be gained from a different approach to comparing the two hash tables.

-Peff
