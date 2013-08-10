From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Sat, 10 Aug 2013 05:50:00 -0400
Message-ID: <20130810095000.GC2518@sigill.intra.peff.net>
References: <7va9ksbqpl.fsf@alter.siamese.dyndns.org>
 <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
 <7v61vgazp5.fsf@alter.siamese.dyndns.org>
 <CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
 <7vwqnw7z47.fsf@alter.siamese.dyndns.org>
 <CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
 <20130809110000.GD18878@sigill.intra.peff.net>
 <CALkWK0nSC-Aty55QO+DrM5Zf2t=DK8iMfbhv_HD44Z_m8d19Pg@mail.gmail.com>
 <20130809221615.GA7160@sigill.intra.peff.net>
 <CACsJy8BZv0nr92foiYpbscpg86awFZVerpeXcz5CuYWeg3guEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 11:50:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V85oj-0002vM-T1
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 11:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968523Ab3HJJuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 05:50:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:55378 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968520Ab3HJJuD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 05:50:03 -0400
Received: (qmail 3727 invoked by uid 102); 10 Aug 2013 09:50:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Aug 2013 04:50:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Aug 2013 05:50:00 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BZv0nr92foiYpbscpg86awFZVerpeXcz5CuYWeg3guEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232083>

On Sat, Aug 10, 2013 at 08:24:39AM +0700, Nguyen Thai Ngoc Duy wrote:

> > the other end cannot use). You _might_ be able to get by with a kind of
> > "two-level" hack: consider your main pack as "group A" and newly pushed
> > packs as "group B". Allow storing thin deltas on disk from group B
> > against group A, but never the reverse (nor within group B). That makes
> > sure you don't have cycles, and it eliminates even more I/O than any
> > repacking solution (because you never write the extra copy of Y to disk
> > in the first place). But I can think of two problems:
> [...]
> 
> Some refinements on this idea
> 
>  - We could keep packs in group B ordered as the packs come in. The
> new pack can depend on the previous ones.

I think you could dispense with the two-level altogether and simply give
a definite ordering to packs, whereby newer packs can only depend on
older packs. Enforcing that with filesystem mtime feels a bit
error-prone; I think you'd want to explicitly store a counter somewhere.

>  - A group index in addition to separate index for each pack would
> solve linear search object lookup problem.

Yeah. I do not even think it would be that much work. It is a pure
optimization, so you can ignore issues like "what happens if I search
for an object, but the pack it is supposed to be in went away?". The
answer is "you fall back to a linear search through the packs", and
assume it happens infrequently enough not to care.

I'd wait to see how other proposed optimizations work out before doing a
global index, though.  The current wisdom is "don't have a ton of packs,
for both the index issue and other reasons, like wasting space and
on-the-fly deltas for fetches". If the "other reasons" go away, then a
global index would make sense to solve the remaining issue. But if the
solution for the other issues is to make it cheaper to repack so you can
do it more often, then the index issue just goes away.

-Peff
