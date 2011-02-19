From: Jeff King <peff@peff.net>
Subject: Re: Merging limitations after directory renames -- interesting test
 repo
Date: Sat, 19 Feb 2011 04:08:12 -0500
Message-ID: <20110219090812.GA20577@sigill.intra.peff.net>
References: <AANLkTimsQmOLDENX27YqpicBeFFZrfgEAsLvFiJqoV7w@mail.gmail.com>
 <20110218222151.GB4258@sigill.intra.peff.net>
 <AANLkTimKp+Z==QXJg2Bagot+Df4REeANuxwVi7bpPCXr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 19 10:08:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqinl-00061p-Bd
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 10:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403Ab1BSJIX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 04:08:23 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43172 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028Ab1BSJIP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 04:08:15 -0500
Received: (qmail 8067 invoked by uid 111); 19 Feb 2011 09:08:14 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 19 Feb 2011 09:08:14 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Feb 2011 04:08:12 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimKp+Z==QXJg2Bagot+Df4REeANuxwVi7bpPCXr@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167260>

On Fri, Feb 18, 2011 at 03:27:36PM -0800, Linus Torvalds wrote:

> > =C2=A01. Did you bump up your merge.renamelimit? It's hard to see b=
ecause it
> > =C2=A0 =C2=A0 scrolls off the screen amidst the many conflicts, but=
 the first
> > =C2=A0 =C2=A0 message is:
> >
> > =C2=A0 =C2=A0 =C2=A0 warning: too many files (created: 425 deleted:=
 1093), skipping
> > =C2=A0 =C2=A0 =C2=A0 inexact rename detection
> >
> > =C2=A0 =C2=A0 which you want to use. Try "git config merge.renameli=
mit
> > =C2=A0 =C2=A0 10000". Which runs pretty snappily on my machine; I w=
onder if we
> > =C2=A0 =C2=A0 should up the default limit.
>=20
> Yeah, for the kernel, I have
>=20
> 	[diff]
> 		renamelimit=3D0
>=20
> to disable the limit entirely, because the default limit is very low
> indeed. Git is quite good at the rename detection.
>=20
> However, the reason for the low default is not because it's not snapp=
y
> enough - it's because it can end up using a lot of memory (and if
> you're low on memory, the swapping will mean that it goes from "quite
> snappy" to "slow as molasses" - but it still will not be CPU limited,
> it's just paging like crazy).

I think it can be both. There is an O(n^2) part to the algorithm. I did
some timings a few years ago that showed an n^2 increase in time as you
bumped the limit:

  http://article.gmane.org/gmane.comp.version-control.git/73519

That's staying within a reasonable memory size. I would not be surprise=
d
if you can get much worse behavior by going into swap, but I didn't
measure peak memory use there.

Those tests led to:

  commit 50705915eae89eae490dff30fa370ed02e4d6e72
  Author: Jeff King <peff@peff.net>
  Date:   Wed Apr 30 13:24:43 2008 -0400

    bump rename limit defaults

    The current rename limit default of 100 was arbitrarily
    chosen. Testing[1] has shown that on modern hardware, a
    limit of 200 adds about a second of computation time, and a
    limit of 500 adds about 5 seconds of computation time.

    This patch bumps the default limit to 200 for viewing diffs,
    and to 500 for performing a merge. The limit for generating
    git-status templates is set independently; we bump it up to
    200 here, as well, to match the diff limit.

But perhaps it's time to revisit the test; it's been 2 years, and my
hardware at the time was probably 2 years out of date. :)

Here are the old and new times for various sizes of rename. Details
about the test are in the message referenced above.

   N   Old CPU Seconds   New CPU Seconds
  10              0.43              0.02
 100              0.44              0.20
 200              1.40              0.55
 400              4.87              1.90
 800             18.08              7.01
1000             27.82             10.83

So maybe bump the diff limit to 400 and the merge limit to 1000,
doubling both? That leaves us at around 2 seconds per-commit for a log,
and 10 seconds tacked onto a merge. We could maybe even go higher with
the merge limit. If it's such a big merge, the conflict resolution is
probably going to take forever anyway, so 30 extra seconds if it makes
rename detection work is probably a good thing.

According to top, git only hit around 17M resident on the 1000-sized
one, so I don't think memory is a problem, at least for average repos
(and yes, I know top is an awful way to measure, but it's quick and it
would need to be orders of magnitude off for it to be a problem).

So I'm in favor of bumping the limits, or possibly even removing the
hard number limit and putting in a "try to do renames for this many
seconds" option. If we're going to have something like 30 second delays
on merge, though, we should perhaps write some eye candy to stderr afte=
r
2 seconds or so (like we do with "git checkout").

> So I do think we could try to lift the default a bit, but it might be
> even more important to just make the message much more noticeable and
> avoid scrolling past it. For example, setting a flag, and not printin=
g
> out the message immediately, but instead print it out only if it turn=
s
> into trouble at the end.

Yeah, I also think that would be useful. And if that information filter=
s
up to the merge command, it can even give better advice (like how to
tweak the limit).

-Peff
