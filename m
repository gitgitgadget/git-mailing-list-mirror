From: Jeff King <peff@peff.net>
Subject: Re: Ambiguous reference weirdness
Date: Wed, 22 Feb 2012 15:38:21 -0500
Message-ID: <20120222203821.GA6781@sigill.intra.peff.net>
References: <CABURp0oAw7cvU7cwCZOtvqZ_oa0hDPsE_0Lm3kR1ctdNuxU3hg@mail.gmail.com>
 <20120222070034.GA17015@sigill.intra.peff.net>
 <CABURp0r+3gOQ3rq_ubv=uEoU=XmtYs=etfT4W2Lb9M0LBrikWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 21:38:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0IxJ-0005vZ-Eq
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 21:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548Ab2BVUiY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 15:38:24 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47336
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065Ab2BVUiX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 15:38:23 -0500
Received: (qmail 31390 invoked by uid 107); 22 Feb 2012 20:38:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Feb 2012 15:38:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2012 15:38:21 -0500
Content-Disposition: inline
In-Reply-To: <CABURp0r+3gOQ3rq_ubv=uEoU=XmtYs=etfT4W2Lb9M0LBrikWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191281>

On Wed, Feb 22, 2012 at 09:48:23AM -0500, Phil Hord wrote:

> > What is 1147? Is it supposed to be a partial sha1, or is it a ref y=
ou
> > have?
>=20
> 1147 was a typo.  It was a Gerritt changeset ID I forgot to expand.
> When I type "git cherry-pick 1147<TAB>", autocompletion expands this
> for me to "git cherry-pick origin/changes/47/1147/1".  Except in this
> case I misfired the TAB and got the weird "BUG:" report.  But I didn'=
t
> see the same problem with other invalid refs, so I went searching for
> the variants and to see what caused it.

Ah. It's a little annoying that Gerrit names refs that look kind of
like partial sha1s. But I guess most of the time it's not that big a
deal (it is only because you were using the partial Gerrit ref with tab
completion). And I don't think we're about to change how Gerrit names
things. :)

> > Have you looked at the object that it resolves to? I suspect it is =
the
> > partial sha1 of a non-commit object. E.g.:
>=20
> All of these examples were run in current git.git, so you can try the=
m
> yourself if needed.  But I did figure out that 1147 resolves to a
> blob, and that's apparently the difference between these three:

Yeah. I figured that after reading more, but didn't go back and revise
the first part of my message. I was able to easily get the same results
as you (actually, in my git.git, 1147 is ambiguous because I happen to
have some extra refs, but it was easy to replicate with a fresh clone).

> $ git cherry-pick 1147
> fatal: BUG: expected exactly one commit from walk
>=20
> $ git cherry-pick 1146
> error: short SHA1 1146 is ambiguous.
> error: short SHA1 1146 is ambiguous.
> fatal: ambiguous argument '1146': unknown revision or path not in the
> working tree.
> Use '--' to separate paths from revisions
>=20
> $ git cherry-pick 114333
> fatal: ambiguous argument '114333': unknown revision or path not in
> the working tree.
> Use '--' to separate paths from revisions
>=20
> I consider the first two responses to be UI bugs.   The second one is
> minor (the twice-reported error message), and the first one is pretty
> rude.   I would expect all three to report the same conclusion,
> "fatal: ambiguous argument 'XXXXX': unknown revision or path not in
> the working tree."  But the first one doesn't.

Right. Because cherry-pick's logic is:

  if the arguments do not resolve to any objects at all
      complain of unknown revision
  if the resolved object is not a single commit
      die of BUG

And I think you just want to collapse those two conditions into a singl=
e
conditional, which seems reasonable (the error message does say "unknow=
n
revision", not "unknown object". It's a little more complicated than
that, because you are crossing a boundary between reusable library code
and cherry-pick specific code.

As for the doubled "ambiguous" warning, I'm not sure what the cause is
for that. I suspect it is because cherry-pick tries to parse one way (a=
s
a revision walk specifier, like "a..b"), and then parses again (as a
single commit) when that fails, due to historical reasons. Obviously
it would be nice to see that improved, but I suspect it will be annoyin=
g
to do so; the error message is emitted by a low-level, and cherry-pick
has no idea that it has happened (it only sees "this didn't result in
parsing anything").

> Thanks.  I'm not familiar with the {tree} syntax -- in fact I'd like
> to find a dictionary for all the reference spelling variants -- but
> this is elucidating.

See "git help rev-parse", section "Specifying Revisions".

> > In the cherry-pick case, the code is checking the right thing, but =
the
> > message is horrible. It is not a bug, but merely unexpected input, =
and
> > it should provide a usage message.
>=20
> Bug is too strong a word in one sense, but from the user perspective =
I
> consider this "horrible message" a bug.

Sorry, I meant git is wrong to use the word "BUG". For us, die("BUG:
=2E..") is the equivalent of an assert. It means something totally
unexpected happened that should never happen, and therefore there is a
bug in git. But this is not a bug in git (well, it is, but not that
kind). It is a totally reasonable and expected malformed input that git
should diagnose and report correctly.

So it is a bug that git says "BUG". It should say "you gave me objects,
but they are not revisions" or something similar.

> > I think checkout has the same "is this a path or a revision" ambigu=
ity
> > to resolve. But rather than be explicit that you might have meant "=
114"
> > as a tree, the error message assumes you meant a path. That might b=
e
> > worth improving, similar to the above example.
> >
> > Again, you can disambiguate with:
> >
> > =C2=A0$ git checkout -- 1147
> > =C2=A0error: pathspec '1147' did not match any file(s) known to git=
=2E
> >
> > =C2=A0$ git checkout 1147 --
> > =C2=A0fatal: reference is not a tree: 1147
> >
> >> $ git checkout 1147
> >> fatal: reference is not a tree: 1147
>=20
> Yes, I understand this.  This was a typo and it was ambiguous.  But
> shouldn't we tell the user the same thing when encountering the same
> failure?

No, because there are really three cases here:

  1. The user told us 1147 is a path.

  2. The user told us 1147 is a tree.

  3. The user did not tell us which, and we must guess.

We guess (1) if the name does not resolve at all, and (2) otherwise. An=
d
the error message only indicates the particular guess we made.

So while I don't think they should all have the same error message,
there are two improvements I can see:

  a. If we are guessing, and 1147 resolves but is _not_ a tree, we
     could guess path instead.

  b. When our guess results in an error, it would be better to be
     explicit about the fact that we guessed (i.e., say "this is neithe=
r
     a tree nor a path that git knows about", similar to git-log).

> > I think the outcomes are all working as intended, but the error mes=
sages
> > could stand to be improved.
>=20
> Yes, I agree.  I only meant to complain about the error messages, not
> the results.  Thanks for the discussion.  I'll try to look for where
> these come from and see if they can be improved within reason.

Great. I look forward to it.

-Peff
