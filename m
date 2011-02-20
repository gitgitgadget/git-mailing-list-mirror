From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 4/4] inexact rename detection eye candy
Date: Sun, 20 Feb 2011 04:48:04 -0500
Message-ID: <20110220094803.GA988@sigill.intra.peff.net>
References: <20110219101936.GB20577@sigill.intra.peff.net>
 <20110219102533.GD22508@sigill.intra.peff.net>
 <AANLkTik=pd3vVMERz=H3sp835Ft8OvrOzBE4PUS7vrO7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 20 10:48:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr5tw-0004H7-Ch
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 10:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733Ab1BTJsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 04:48:09 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45177 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652Ab1BTJsH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 04:48:07 -0500
Received: (qmail 16458 invoked by uid 111); 20 Feb 2011 09:48:06 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 20 Feb 2011 09:48:06 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Feb 2011 04:48:04 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTik=pd3vVMERz=H3sp835Ft8OvrOzBE4PUS7vrO7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167407>

On Sat, Feb 19, 2011 at 07:57:57AM -0800, Linus Torvalds wrote:

> > I made it update progress for each of the rename_src * rename_dst
> > similarity estimates. We could just as easily count rename_dst items we
> > look at, but hey, it's eye candy, and obviously bigger numbers are
> > better.
> 
> Uhh. My only big reaction to your patch was literally "why don't you
> just do it on the 'dst' items". I really don't think bigger numbers
> are better, and if you have _so_ many sources that each dst takes so
> long that you'd want updates at that granularity, you're too screwed
> anyway.
> 
> Don't make the "update progress" be part of the O(n^2) problem.

I timed it and it's not. The progress code is smart enough not to
actually print anything more than once per second. So it's just an extra
function call per loop, which is dwarfed by the massive
estimate_similarity(). It's really not that tight a loop.

That being said, the output seems a little smoother to me hoisting it
out, so I've put that in my re-roll. The bigger numbers are worth
keeping, IMHO, as they are a more accurate reflection of how much work
is being done. You do the same amount of work with 2 dests and 1000
sources as you do with 1000 dests and 2 sources. But one will count to
1000, and the other will count to 2. They should probably both count to
2000, the number of estimate_similarity() calls we must make, which is
the expensive part. (Actually that is not quite accurate, as we may skip
some calls for destinations already found, but it's not worth the effort
to figure out how many calls we'll actually make ahead of time).

So here is the re-roll, which I think is probably OK for inclusion. It
replaces 4/4 from my last series.

  [1/3]: add inexact rename detection progress infrastructure
  [2/3]: merge: enable progress reporting for rename detection
  [3/3]: pull: propagate --progress to merge

-Peff
