From: Jeff King <peff@peff.net>
Subject: Re: thin packs ending up fat
Date: Fri, 13 Jan 2012 10:55:36 -0500
Message-ID: <20120113155536.GB9373@sigill.intra.peff.net>
References: <20120112221523.GA3663@sigill.intra.peff.net>
 <CACBZZX567mHKXDtTcb+zFKtr2ZvcssF+O=w-x86PfNh+5tTpRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 13 16:56:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RljUr-0002yS-8K
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 16:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758393Ab2AMP4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jan 2012 10:56:44 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36713
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758383Ab2AMPzi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 10:55:38 -0500
Received: (qmail 10108 invoked by uid 107); 13 Jan 2012 16:02:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jan 2012 11:02:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jan 2012 10:55:36 -0500
Content-Disposition: inline
In-Reply-To: <CACBZZX567mHKXDtTcb+zFKtr2ZvcssF+O=w-x86PfNh+5tTpRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188516>

On Fri, Jan 13, 2012 at 09:28:43AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Thu, Jan 12, 2012 at 23:15, Jeff King <peff@peff.net> wrote:
>=20
> I'd be interested in testing this on some other repos I have. How
> exactly did you get this:
>=20
> > -- >8 --
> > 8b0e15fa95e11965f18c8d2585dc8ffd9bfc9356 ^7f41b6bbe3181dc4d1687db03=
6bf22316997a1bf
> > 34c4461ae3b353e8c931565d5527b98ed12e3735 ^8b0e15fa95e11965f18c8d258=
5dc8ffd9bfc9356
> > 463b0ea22b5b9a882e8140d0308433d8cbd0d1fe ^34c4461ae3b353e8c931565d5=
527b98ed12e3735
> > 288396994f077eec7e7db0017838a5afbfbf81e3 ^463b0ea22b5b9a882e8140d03=
08433d8cbd0d1fe
> > 05f6edcd2a418a88eeb953d51408a6aeef312f5c ^288396994f077eec7e7db0017=
838a5afbfbf81e3
> > 08cfdbb88cd6225b4fc4b8a3cecd0e01758c835d ^05f6edcd2a418a88eeb953d51=
408a6aeef312f5c
>=20
> From this:
>=20
> > In the first, I used the reflog entries from my
> > refs/remotes/origin/master ref.
>=20
> I can't make "git reflog refs/remotes/..." show me anything similar.

I just looked in the reflog file directly:

  perl -alne 'print "$F[1] ^$F[0]"' \
    .git/logs/refs/remotes/origin/master

Note that these are just an approximation of what was fetched each time=
=2E
The real fetches packed objects for other refs, too. But with respect t=
o
this patch, the result should be the same (since the interesting thing
is the graph boundaries that are packed, so the size of the slice of
history is what's important).

The other slight inaccuracy is that my tests repack the whole repo, and
then simulate old fetches from that repo. When I actually fetched
7f415b6..8b0e15fa from upstream, all of those later commits didn't
actually exist yet. And therefore the blobs in those tip commits were
actually more likely to be non-delta, and therefore this optimization i=
s
more likely to help (because we already re-tried deltas if the target
object was delta'd against something else).

At least in theory. In practice, the variance of the improvement it
provides to each pack is so quite high. Some packs don't benefit at all=
,
because the preferred bases simply aren't that useful, or are perhaps
already being used. Some packs can have improvements in the 70-80%
range.

The numbers I reported were averaged over all of the packs in the
dataset. You can see individual packs with the script I provided
earlier:

  # before patch
  ./test-pack <dataset-fetch >output-fetch-before
  # after patch
  ./test-pack <dataset-fetch >output-fetch-after

  # collate results
  paste output-fetch-{before,after} |
  perl -alne 'print "$F[0] $F[2] " .
                int(0.5 + (($F[0] - $F[2]) / $F[0] * 100))'

The output is below. You can also feed the percentages through this poo=
r
man's graph generator to see just how wildly it varies:

  perl -alne 'print "*" x $F[2]'

-Peff

-- >8 --
154471 92495 40
41970 24681 41
102816 71062 31
21089 21089 0
57900 13345 77
75666 61518 19
163516 107785 34
44913 15795 65
85452 77832 9
102034 93336 9
10095 8283 18
86078 65495 24
1854 1854 0
16079 8125 49
13830 7119 49
1283 1283 0
4697 2633 44
4584 3818 17
21535 18953 12
3800 3800 0
13963 10215 27
4453 4073 9
1029 598 42
111233 68267 39
879 879 0
96628 86206 11
3287 3287 0
71212 20832 71
132916 100268 25
170716 40959 76
1830 1262 31
243950 133932 45
64588 31546 51
1108 1108 0
6488 6488 0
101179 64014 37
114760 18969 83
23443 19445 17
28207 28080 0
2317 2317 0
110890 53555 52
5660 5543 2
18683 18683 0
4709 4709 0
