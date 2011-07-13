From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCHv2 6/6] limit "contains" traversals based on commit
 generation
Date: Wed, 13 Jul 2011 03:23:50 -0400
Message-ID: <20110713072350.GA18614@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713070644.GF18566@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 09:24:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgtnb-0003oG-Pv
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 09:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758692Ab1GMHXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 03:23:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59258
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544Ab1GMHXy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 03:23:54 -0400
Received: (qmail 21481 invoked by uid 107); 13 Jul 2011 07:24:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 03:24:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 03:23:50 -0400
Content-Disposition: inline
In-Reply-To: <20110713070644.GF18566@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177007>

On Wed, Jul 13, 2011 at 03:06:44AM -0400, Jeff King wrote:

> This optimization can provide massive speedups. For example,
> doing "git tag --contains HEAD~1000" in the linux-2.6
> repository goes from:
> 
>   real    0m3.139s
>   user    0m3.044s
>   sys     0m0.092s
> 
> to:
> 
>   real    0m0.035s
>   user    0m0.028s
>   sys     0m0.004s

I pulled this commit message from the original "cutoff at timestamp"
patch, though I did update the timings for the new code. What it doesn't
mention is that the first run will take something like 3.7 seconds, and
then subsequent ones will be way faster. I had mentioned that number
elsewhere in the thread, but it should probably go here. I'll put it in
the next version.

One number I haven't mentioned elsewhere, though, is how expensive it is
to add new commits to the cache. So here's an interesting timing:

  $ cd linux-2.6

  : slow, cache-generating time
  $ rm .git/cache/generations
  $ time git tag --contains HEAD
  real    0m3.795s
  user    0m3.420s
  sys     0m0.372s

  : fast, cached time
  $ time git tag --contains HEAD
  real    0m0.022s
  user    0m0.008s
  sys     0m0.012s

  : now what if we add one more commit?
  $ echo foo >>Makefile && git commit -a -m foo
  $ time git tag --contains HEAD
  real    0m0.271s
  user    0m0.020s
  sys     0m0.252s

It takes barely any time to get the generation of the new commit, but we
spend .25 seconds writing the whole new cache file out. This could be
improved with a more clever disk format that contained a journal of
unsorted newly written entries. You'd still write the full cache out
once in a while, but the cost would be amortized.

I'm not sure the complexity is worth it, though. Yes, the write-out time
is way slower than the super-fast everything-is-cached case. But it
doesn't happen that often (only when you have new commits, _and_ your
traversal actually looks at them). And it's still an order of magnitude
faster than it is without the cache at all. I doubt I would even notice
a quarter-second delay, or would just chalk it up to a few objects
needing to be pulled from disk.

So I'm inclined to leave it as-is, at least for now. If somebody wants
to revisit the topic later and speed up cache writing, they can. But I
don't want a complex solution to hold up this series, which is already a
big improvement.

-Peff
