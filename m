From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] combine-diff: handle binary files as binary
Date: Mon, 30 May 2011 12:19:27 -0400
Message-ID: <20110530161927.GC24431@sigill.intra.peff.net>
References: <20110523201529.GA6281@sigill.intra.peff.net>
 <20110523202734.GC6298@sigill.intra.peff.net>
 <7vpqn0ofy5.fsf@alter.siamese.dyndns.org>
 <20110530143627.GC31490@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 30 18:19:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR5Bm-0007hx-W3
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 18:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756662Ab1E3QTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 12:19:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60717
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432Ab1E3QT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 12:19:29 -0400
Received: (qmail 17096 invoked by uid 107); 30 May 2011 16:19:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 May 2011 12:19:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 May 2011 12:19:27 -0400
Content-Disposition: inline
In-Reply-To: <20110530143627.GC31490@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174761>

On Mon, May 30, 2011 at 10:36:27AM -0400, Jeff King wrote:

>   1. Grab each blob, check binary-ness, and free. This double-loads in
>      the common, non-binary case.
> [...]
>
> I'll try to take a look at it this week and get some measurements on (1)
> versus (2) for both speed and peak memory usage. And then see if I can
> do better with (3), and implement the "peek" solution both here and in
> regular diff.

I was curious about this, so I stole a few minutes to do some
preliminary benchmarks this morning.

The first thing to look at is the performance of the original code, that
does not check binary-ness at all. It's going to represent the best we
can do with any strategy. So I tried:

  git log -p --cc --merges origin/master

on git.git using both v1.7.5.3 and the jk/combine-diff-binary-etc
branch. And it turns out that the extra loads really don't make a
difference in practice. My best-of-5 for the two cases were:

  $ time git.v1.7.5.3 log -p --cc --merges origin/master >/dev/null
  real    0m59.518s
  user    0m58.672s
  sys     0m0.688s

  $ time git.jk.binary-combined-diff log -p --cc \
      --merges origin/master >/dev/null
  real    0m58.949s
  user    0m58.220s
  sys     0m0.572s

The new code actually came out slightly faster.  One reason may be that
there are 3 combined diffs of git-gui/lib/git-gui.ico that we avoid
doing (and just say "Binary files differ"). That's not a lot, but it
gives us a very tiny edge (though that edge is very close to the amount
of noise between runs). Still, I think it implies that the extra loads
in the common non-binary case are not actually measurable.

The peak memory use between the two should be the same (since we free
each blob immediately), but I didn't measure it.

So I think in practice it's not a big deal. I'll still take a look at
the "peek" optimization later this week, since that can make a
difference in some corner cases. And as part of that, it will probably
make sense to keep the buffers around for small-ish files, so we'll get
the optimization I mentioned more or less for free. I'll also do the
check for duplicated sha1s that you mentioned.

-Peff
