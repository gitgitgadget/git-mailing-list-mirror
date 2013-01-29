From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] optimizing pack access on "read only" fetch repos
Date: Tue, 29 Jan 2013 16:19:33 -0500
Message-ID: <20130129211932.GA17377@sigill.intra.peff.net>
References: <20130126224011.GA20675@sigill.intra.peff.net>
 <7vlibfxhit.fsf@alter.siamese.dyndns.org>
 <20130129082939.GB6396@sigill.intra.peff.net>
 <7vwquwrng6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 22:20:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Iaz-0002F3-Eg
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 22:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796Ab3A2VTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 16:19:37 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53553 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646Ab3A2VTg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 16:19:36 -0500
Received: (qmail 23704 invoked by uid 107); 29 Jan 2013 21:20:58 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jan 2013 16:20:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2013 16:19:33 -0500
Content-Disposition: inline
In-Reply-To: <7vwquwrng6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214973>

On Tue, Jan 29, 2013 at 07:58:01AM -0800, Junio C Hamano wrote:

> The point is not about space.  Disk is cheap, and it is not making
> it any worse than what happens to your target audience, that is a
> fetch-only repository with only "gc --auto" in it, where nobody
> passes "-f" to "repack" to cause recomputation of delta.
> 
> What I was trying to seek was a way to reduce the runtime penalty we
> pay every time we run git in such a repository.
> 
>  - Object look-up cost will become log2(50*n) from 50*log2(n), which
>    is about 50/log2(50) improvement;

Yes and no. Our heuristic is to look at the last-used pack for an
object. So assuming we have locality of requests, we should quite often
get "lucky" and find the object in the first log2 search. Even if we
don't assume locality, a situation with one large pack and a few small
packs will have the large one as "last used" more often than the others,
and it will also have the looked-for object more often than the others

So I can see how it is something we could potentially optimize, but I
could also see it being surprisingly not a big deal. I'd be very
interested to see real measurements, even of something as simple as a
"master index" which can reference multiple packfiles.

>  - System resource cost we incur by having to keep 50 file
>    descriptors open and maintaining 50 mmap windows will reduce by
>    50 fold.

I wonder how measurable that is (and if it matters on Linux versus less
efficient platforms).

> > I would be interested to see the timing on how quick it is compared to a
> > real repack,...
> 
> Yes, that is what I meant by "wonder if we would be helped by" ;-)

There is only one way to find out... :)

Maybe I am blessed with nice machines, but I have mostly found the
repack process not to be that big a deal these days (especially with
threaded delta compression).

> > But how do these somewhat mediocre concatenated packs get turned into
> > real packs?
> 
> How do they get processed in a fetch-only repositories that
> sometimes run "gc --auto" today?  By runninng "repack -a -d -f"
> occasionally, perhaps?

Do we run "repack -adf" regularly? The usual "git gc" procedure will not
use "-f", and without that, we will not even consider making deltas
between objects that were formerly in different packs (but now are in
the same pack).

So you are avoiding doing medium-effort packs ("repack -ad") in favor of
doing potentially quick packs, but occasionally doing a big-effort pack
("repack -adf"). It may be reasonable advice to "repack -adf"
occasionally, but I suspect most people are not doing it regularly (if
only because "git gc" does not do it by default).

-Peff
