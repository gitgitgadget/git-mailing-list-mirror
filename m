From: Jeff King <peff@peff.net>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Wed, 6 Mar 2013 20:02:54 -0500
Message-ID: <20130307010254.GA850@sigill.intra.peff.net>
References: <20130306150548.GC15375@pengutronix.de>
 <CALWbr2xDYuCN4nd-UNxkAY8-EguYjHBYgfu1fLtOGhYZyRQg_A@mail.gmail.com>
 <20130306200347.GA20312@sigill.intra.peff.net>
 <7vvc94p8hb.fsf@alter.siamese.dyndns.org>
 <20130306205400.GA29604@sigill.intra.peff.net>
 <7vr4jsp756.fsf@alter.siamese.dyndns.org>
 <20130306212140.GA30202@sigill.intra.peff.net>
 <7vip54p58p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git <git@vger.kernel.org>,
	kernel@pengutronix.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 02:03:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDPEx-0004Xo-IZ
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 02:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755076Ab3CGBC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 20:02:57 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38684 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753509Ab3CGBC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 20:02:57 -0500
Received: (qmail 32440 invoked by uid 107); 7 Mar 2013 01:04:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Mar 2013 20:04:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2013 20:02:54 -0500
Content-Disposition: inline
In-Reply-To: <7vip54p58p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217566>

On Wed, Mar 06, 2013 at 01:50:46PM -0800, Junio C Hamano wrote:

> I think it is more like "I added bread and my wife added bread to
> our common shopping list" and our two-way "RCS merge" default is to
> collapse that case to "one loaf of bread on the shopping list".  My
> impression has always been that people who use "diff3" mode care
> about this case and want to know that the original did not have
> "bread" on the list in order to decide if one or two loaves of bread
> should remain in the result.

I think that is only the case sometimes. It depends on what is in the
conflict, and what your data is. I think you are conflating two things,
though: zealousness of merge, and having the original content handy when
resolving. To me, diff3 is about the latter. It can also be a hint that
the user cares about the former, but not necessarily.

> > In Uwe's example,
> > it is just noise that detracts from the interesting part of the change
> > (or does it? I think the answer is in the eye of the reader).
> 
> In other words, you would use the "RCS merge" style because most of
> the time you would resolve to "one loaf of bread" and the fact that
> it was missing in the original is not needed to decide that.  So, it
> feels strange to use "diff3" and still want to discard that
> information---if it is not relevant, why are you using diff3 mode in
> the first place?  That is the question that is still not answered.

Because for the lines that _are_ changed, you may want to see what the
original looked like. Here's a more realistic example:

	git init repo
	cd repo

	# Some baseline C code.
	cat >foo.c <<\EOF
	int foo(int bar)
	{
	  return bar + 5;
	}
	EOF
	git add foo.c
	git commit -m base
	git tag base

	# Simulate a modification to the function.
	sed -i '2a\
	  if (bar < 3)\
	    bar *= 2;
	' foo.c
	git commit -am multiply
	git tag multiply

	# And another modification.
	sed -i 's/bar + 5/bar + 7/' foo.c
	git commit -am plus7

	# Now on a side branch...
	git checkout -b side base

	# let's cherry pick the first change. Obviously
	# we could just fast-forward in this toy example,
	# but let's try to simulate a real history.
	#
	# We insert a sleep so that the cherry-pick does not
	# accidentally end up with the exact same commit-id (again,
	# because this is a toy example).
	sleep 1
	git cherry-pick multiply

	# and now let's make a change that conflicts with later
	# changes on master
	sed -i 's/bar + 5/bar + 8/' foo.c
	git commit -am plus8

	# and now merge, getting a conflict
	git merge master

	# show the result with various marker styles
	for i in merge diff3 zdiff3; do
	  echo
	  echo "==> $i"
	  git.compile checkout --conflict=$i foo.c
	  cat foo.c
	done

which produces:

	==> merge
	int foo(int bar)
	{
	  if (bar < 3)
	    bar *= 2;
	<<<<<<< ours
	  return bar + 8;
	=======
	  return bar + 7;
	>>>>>>> theirs
	}

The ZEALOUS level has helpfully cut out the shared cherry-picked bits,
and let us focus on the real change.

	==> diff3
	int foo(int bar)
	{
	<<<<<<< ours
	  if (bar < 3)
	    bar *= 2;
	  return bar + 8;
	||||||| base
	  return bar + 5;
	=======
	  if (bar < 3)
	    bar *= 2;
	  return bar + 7;
	>>>>>>> theirs
	}

Here we get to see all of the change, but the interesting difference is
overwhelmed by the shared cherry-picked bits. It's only 2 lines here,
but of course it could be much larger in a real example, and the reader
is forced to manually verify that the early parts are byte-for-byte
identical.

	==> zdiff3
	int foo(int bar)
	{
	  if (bar < 3)
	    bar *= 2;
	<<<<<<< ours
	  return bar + 8;
	||||||| base
	  return bar + 5;
	=======
	  return bar + 7;
	>>>>>>> theirs
	}

Here we see the hunk cut-down again, removing the cherry-picked parts.
But the presence of the base is still interesting, because we see
something that was not in the "merge" marker: that we were originally
at "5", and moved to "7" on one side and "8" on the other.

I see conflicts like this when I rebase my topics forward; you may pick
up part of my series, or even make a tweak to a patch in the middle. I
prefer diff3 markers because they carry more information (and use them
automatically via merge.conflictstyle). But in some cases, the lack of
zealous reduction means that I end having to figure out whether and if
anything changed in the seemingly identical bits.  Sometimes it is
nothing, and sometimes you tweaked whitespace or fixed a typo, and it
takes a lot of manual looking to figure it out. I hadn't realized it was
related to the use of diff3 until the discussion today.

-Peff
