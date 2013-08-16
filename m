From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] lookup_object: split up displacement penalty for hash
 collisions
Date: Fri, 16 Aug 2013 05:57:22 -0400
Message-ID: <20130816095722.GA11201@sigill.intra.peff.net>
References: <1376595306-6335-1-git-send-email-stefanbeller@googlemail.com>
 <87haeqdop3.fsf@linux-k42r.v.cablecom.net>
 <8761v6dm0r.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 16 11:57:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAGmj-0003wv-0w
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 11:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593Ab3HPJ52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 05:57:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:55176 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752084Ab3HPJ51 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 05:57:27 -0400
Received: (qmail 18670 invoked by uid 102); 16 Aug 2013 09:57:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Aug 2013 04:57:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Aug 2013 05:57:22 -0400
Content-Disposition: inline
In-Reply-To: <8761v6dm0r.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232414>

On Fri, Aug 16, 2013 at 11:26:28AM +0200, Thomas Rast wrote:

> > I trust the laptop numbers less because it has far more thermal (and
> > thus throttling) issues, but the runs do show a significant difference,
> > though less than you claimed.
> 
> Well, as I feared... another run on the same laptop:
> 
> Test                               HEAD                next                                            
> ------------------------------------------------------------------------------
> 0001.1: rev-list --all             6.41(6.14+0.24)     6.36(6.10+0.23) -0.9%* 
> 0001.2: rev-list --all --objects   54.60(53.84+0.55)   54.23(53.50+0.53) -0.7%
> ------------------------------------------------------------------------------
> Significance hints:  '.' 0.1  '*' 0.05  '**' 0.01  '***' 0.001

Yeah, I get similar results on my i7-840QM. The new code is sometimes
faster and sometimes slower, never wins by more than 1%, and is well
within the run-to-run noise (which seems to vary by up to 5%).

I think the reason is that having a "2-deep" LRU cache helps less than
one might hope. There are a lot of objects in the hash table, but only a
small fraction are "hot" at any time; specifically, those objects that
are in the currently-examined tree. When we hit the "X" object from
Stefan's diagrams, we know that it is hot. But the "B" object may or may
not be hot. If it is, Stefan's optimization helps; if not, it does
nothing.

But statistically it probably isn't hot. There are ~3 million objects in
the kernel repo, but only ~40,000 tree entries. So we would naively
expect it to have an effect in only ~1% of cases (I am not sure if that
is accurate, though, as "hot" items within the same collision sequence
would tend to float to the front of the chain).  I suspect any savings
in those 1% are eaten up by the extra swapping, as well as the fact that
the "hot" B actually moves to the middle.

Another way to think about it is that if B is hot, it will then get
looked up again and get shifted to the front of the chain, pushing X
back. So this is really only a win when two hot entries, X and B,
collide and trade the front position back and forth.

In that case, it seems like we would want to move B to the second
position. This lets the 2-hot case just keep swapping the hot items back
and forth as quickly as possible. To the detriment of C, D, etc, which
never get promoted. But the likelihood of having _3_ hot items in a
collision chain is even less than 2.

That's all vague and hand-wavy intuition of course, and might be
completely wrong. But it's at least a working theory that explains the
experimental results.

-Peff
