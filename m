From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in
 prepare_revision_walk()
Date: Tue, 3 Apr 2012 04:40:36 -0400
Message-ID: <20120403084035.GA14483@sigill.intra.peff.net>
References: <201203291818.49933.mfick@codeaurora.org>
 <7v7gy2q1kq.fsf@alter.siamese.dyndns.org>
 <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com>
 <20120330093207.GA12298@sigill.intra.peff.net>
 <20120330094052.GB12298@sigill.intra.peff.net>
 <4F7780F5.3060306@lsrfire.ath.cx>
 <20120402201432.GA26503@sigill.intra.peff.net>
 <4F7A2E0D.9030402@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Apr 03 10:40:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEzIF-00027G-Du
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 10:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324Ab2DCIkn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Apr 2012 04:40:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44072
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743Ab2DCIkl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 04:40:41 -0400
Received: (qmail 27053 invoked by uid 107); 3 Apr 2012 08:40:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Apr 2012 04:40:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2012 04:40:36 -0400
Content-Disposition: inline
In-Reply-To: <4F7A2E0D.9030402@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194604>

On Tue, Apr 03, 2012 at 12:54:05AM +0200, Ren=C3=A9 Scharfe wrote:

> >   1. Is it worth the complexity of the linked-list mergesort? I was
> >      planning to just build an array, qsort it, and then put the re=
sults
> >      into a linked list. The patch for that is below for reference.
>
> Using a temporary array here is just sad, because linked lists are
> already sortable, albeit not with qsort().  Your measurements seem to
> answer my question regarding the overhead of the callback functions
> of mergesort(), in any case. :)

I agree it is a little gross. The main impetus was shortened code, sinc=
e
we get qsort for free. However, after reading Simon's page that you
referenced and reading your code carefully, I'm beginning to think that
the linked-list mergesort is pretty damn cool (I hadn't seen it before)=
=2E
After all, mergesort without the auxiliary space should be better than
qsort.

So let's go with your patches.

> [...]
> It looks nice and to the point, but breaks several tests for me
> (t3508, t4013, t4041, t4202, t6003, t6009, t6016, t6018 and t7401).
> Not sure why.

I probably screwed up the reversal or something. My patch was a quick "=
I
was thinking of this direction" and I didn't actually test it well.

> >      So I wonder if in the long term we would benefit from a better=
 data
> >      structure, which would make these problems just go away. That =
being
> >      said, there is a lot of code to be updated with such a change,=
 so
> >      even if we do want to do that eventually, a quick fix like thi=
s is
> >      probably still a good thing.
>=20
> Using a more appropriate data structure sounds good in general. How
> about using a skip list?  (Or perhaps I need to lay the hammer of
> linked lists to rest for a while to stop seeing all data structures
> as the proverbial nails, or something. ;-)

Actually, I think a skip list would make a lot of sense, as it mostly
retains the linked-list properties. When I tried converting it to a
heap-based priority queue, I seem to recall that there were some spots
that wanted to splice the commit list (among other things). Although I'=
m
not sure how splicing works in a skip list; I guess you'd have to do a
list merge.

-Peff
