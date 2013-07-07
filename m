From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] cat-file: add --batch-disk-sizes option
Date: Sun, 7 Jul 2013 14:19:25 -0400
Message-ID: <20130707181925.GA20085@sigill.intra.peff.net>
References: <20130707100133.GA18717@sigill.intra.peff.net>
 <20130707100949.GC19143@sigill.intra.peff.net>
 <7vtxk645vp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 20:19:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvtYb-0000FR-LO
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 20:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956Ab3GGSTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 14:19:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:50042 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849Ab3GGST3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 14:19:29 -0400
Received: (qmail 2607 invoked by uid 102); 7 Jul 2013 18:20:43 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Jul 2013 13:20:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Jul 2013 14:19:25 -0400
Content-Disposition: inline
In-Reply-To: <7vtxk645vp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229794>

On Sun, Jul 07, 2013 at 10:49:46AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Perhaps we need
> >
> >   git cat-file --batch-format="%(disk-size) %(object)"
> >
> > or similar.
> 
> I agree with your reasoning.  It may be simpler to give an interface
> to ask for which pieces of info, e.g. --batch-cols=size,disksize,
> without giving the readers a flexible "format".

Yeah, that is probably a lot more sane. That would be sufficient for my
use, I doubt anyone really wants the full format, and it would be easy
to add it later if we are wrong. It would also be easy to add other
items from the sha1_object_info_extended list, too (e.g.,
loose/cached/packed).

I'll do that in my re-roll.

> > +NOTE: The on-disk size reported is accurate, but care should be taken in
> > +drawing conclusions about which refs or objects are responsible for disk
> > +usage. [...]
> 
> This is a good note to leave to the readers. I was wondering how
> valid to accuse that B is taking a lot of space compared to C when
> you have three objects A, B and C (in decreasing order of on-disk
> footprint) when A is huge and C is a small delta against A and B is
> independent.  The role of A and C in their delta chain could easily
> be swapped during the next full repack and then C will appear a lot
> larger than B.

Yeah. I exercise a lot of human analysis when I use this tool myself.
What I am usually looking for is that somebody has forked a 100M repo,
and then dumped 2G of extra data on top. Those cases are not all that
hard to spot, and would not usually change too much in a repack.

> It might be interesting to measure the total disk footprint of an
> entire delta "family" (the objects that delta against the same
> base).  You may find out that hello.c with a manageable size have
> very many revisions and overall have a larger on-disk footprint than
> a single copy of unchanging help.mov clip used in the documentation
> does, which may be an interesting observation to make.

Yeah, that is an interesting stat, though I have not had a need for it
myself. Certainly you could do:

  git rev-list --objects --all |
  grep ' hello.c$' |
  cut -d' ' -f1 |
  git cat-file --batch-disk-sizes

to see hello.c's size. But I cannot think offhand of a way to get the
list of objects that are in a delta chain together (potentially crossing
path boundaries), short of parsing verfiy-pack output myself. I think it
is orthogonal to this patch, though. This exposes more information about
objects themselves; it would be up to another patch to help discover and
narrow the list of interesting objects.

-Peff
