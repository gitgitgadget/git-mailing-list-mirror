From: Jeff King <peff@peff.net>
Subject: Re: in_merge_bases() is too expensive for recent "pu" update
Date: Fri, 24 Aug 2012 11:15:11 -0400
Message-ID: <20120824151511.GB15162@sigill.intra.peff.net>
References: <CACsJy8C-VxzwigyUDHnUkXN7vhB+93X96pH9MvgB0ps7v-_NmQ@mail.gmail.com>
 <878vd5k7uu.fsf@thomas.inf.ethz.ch>
 <7vd32h4h1t.fsf@alter.siamese.dyndns.org>
 <7v393d49xs.fsf@alter.siamese.dyndns.org>
 <87393cbp6b.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 24 17:15:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4vba-0006e7-1B
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 17:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758851Ab2HXPPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 11:15:19 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47338 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757228Ab2HXPPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 11:15:16 -0400
Received: (qmail 1153 invoked by uid 107); 24 Aug 2012 15:15:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Aug 2012 11:15:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Aug 2012 11:15:12 -0400
Content-Disposition: inline
In-Reply-To: <87393cbp6b.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204214>

On Fri, Aug 24, 2012 at 11:43:40AM +0200, Thomas Rast wrote:

> > Start from A and B.  Follow from B to find 'x' and paint it in blue,
> > follow from A to find 'y' and paint it in amber.  Follow from 'x' to
> > '1', paint it in blue.  Follow from 'y' to '1', paint it in amber
> > but notice that it already is painted in blue.
> [...]
> >             o-------o
> >            /         \
> >           /       y---A
> >          /       /
> >      ---2---z---1---x---B
> >          \         /
> >           o-------o
> [...]
> > So we need to notice that '1' and '2' have ancestry relation in
> > order to reject '2' as "common but not merge-base".  One way of
> > doing so is not to stop at '1' and keep digging (and eventually we
> > find that '2' is what we could reach from '1' that already is a
> > merge base), but then we will be susceptible to the same kind of
> > clock skew issue as the revision traverser.
> 
> I think that is *the* way to do it.
> 
> And the way to fix the clock skew issue (also in the revision traversal)
> is Peff's generation number cache.  Just keep propagating marks, digging
> in generation order, until the generations prove that nothing new can
> happen.

I thought you were just interested in speeding up is_descendent_of. You
should be able to do that without a generation number. Just start from A
and B as above, do the two-color painting, and do not add the parents of
any two-color commits (because you know they are ancestors of both, and
therefore you cannot find either by looking backwards). If you paint "B"
amber, then it is a descendent of "A" (and vice versa if you paint "A"
blue).

Clock skew may make you take longer (because you may go depth-first down
an uninteresting chain of commits), but it should never give you the
wrong answer. It's not as fast as using a generation-based cutoff
(because you have to keep walking to the actual shared ancestor), but in
practice it's usually fine.

The reason I did not do that for "tag --contains" is that I wanted to
do a simultaneous walk for all tags. That would require N color bits for
N tags, and we have a limited space in each commit object. I didn't time
using a separate hash table to store those bits outside of the commit
objects. That would have a higher constant, but should still yield good
big-O complexity.

>   [Side note, in reply to an earlier comment in the rev-list thread: I
>   agree with Peff's reasoning that a cache is better than a commit
>   header.]

I still think it's a good idea to keep it out of the commit header. But
I think I might lean towards tying it to the pack index (i.e.,
generating it when we generate the index, and depending on the sha1
table in the index). That would be smaller, and gets rid of any
complexity or performance issues with making incremental updates to the
cache. Loose objects wouldn't have a cached version number, but that's
OK; in practice you can quickly walk backwards to a commit that _is_
cached.

-Peff
