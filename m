From: Jeff King <peff@github.com>
Subject: Re: [RFH] eol=lf on existing mixed line-ending files
Date: Sat, 9 Apr 2011 15:32:39 -0400
Message-ID: <20110409192941.GB31579@sigill.intra.peff.net>
References: <20110407231556.GA10868@sigill.intra.peff.net>
 <BANLkTimBewshVRYBibXJ7nDNoX0S0iDaUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Mislav Marohnic <mislav@github.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 21:32:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8dtp-0002vx-Tm
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 21:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041Ab1DITco convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2011 15:32:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56233
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753895Ab1DITco (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 15:32:44 -0400
Received: (qmail 15970 invoked by uid 107); 9 Apr 2011 19:33:31 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.197.88.253)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 09 Apr 2011 15:33:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Apr 2011 15:32:39 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimBewshVRYBibXJ7nDNoX0S0iDaUQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171204>

On Sat, Apr 09, 2011 at 10:58:59PM +0400, Dmitry Potapov wrote:

> > Now we come to the first confusing behavior. Generally one would ex=
pect
> > the working directory to be clean after a "git reset --hard". But n=
ot
> > here:
> >
> > =C2=A0git reset --hard &&
> > =C2=A0git status
> >
> > will still show "mixed" as modified.
>=20
> It is because you discard all changes except to .gitattributes.  If
> .gitattributes were tracked, "reset" would discard them too, and you
> would get clean original state.

Yeah, in this case. But gitattributes could easily be in the repository
already, and reset still wouldn't change it (as it is in the jquery
example).

> > So that kind of makes sense. But it isn't all that helpful, if I ju=
st
> > want to reset my working tree to something sane without making a ne=
w
> > commit (more on this later).
>=20
> If we do not discard changes to .gitattributes then the question is
> what a sane state is? It is really difficult to define what is sane
> when conversion to the work tree and back gives a different result.

Agreed. The problem is the disconnect between what is in the repository=
,
and what _would_ be in the repository if we committed the file. So
obviously what the user is giving to git in this case is slightly
insane.

I just wonder if git can do better. But the only options I could think
of are:

  1. Set the working tree file to have just LF's. But that doesn't help=
,
     since it is the conversion _to_ linefeeds that make it look like
     the file is changed. So we'd still see unstaged changes.

  2. Set the index file to have just LF's. That would make the working
     tree look clean, but it would look like changes are staged, which
     is even worse.

> > But here's an extra helping of confusion on top. Every once in a wh=
ile,
> > doing the reset _won't_ keep "mixed" as modified. I can trigger it
> > reliably by inserting an extra sleep into git:
>=20
> you can have the same effect by doing:
>=20
> git reset --hard HEAD && sleep 1 && git touch .git/index

Yeah, that has the same effect. I wanted to show the sleep inside git t=
o
demonstrate that it really is an inside-git race condition.

> Ironically, that the race that you observed is result of fixing anoth=
er
> race in git when files are changed too fast, so they may have the sam=
e
> timestamp. To prevent this race, git checks timestamp of .git/index
> and a trcking file. If .git/index timestamp is older or same as that =
file,
> this file is considered dirty. So, it is re-read from the disk to che=
ck
> if there are any changes. This works well but only if conversion to t=
he
> work tree and back produces the same result.

Yeah, that's my analysis, too.

> > So we get two different outcomes, depending on the index raciness. =
Which
> > one is right, or is it right for it to be non-deterministic?
>=20
> I like everything being deterministic, but in this case I do not see
> how it is possible without making the normal case much slower.

I think if you took my (1) suggestion above, it would be deterministic.
I don't know how much that would help. It would at least force people t=
o
always see the change and hopefully spur them to commit the fixed
line-endings.

> > And one final question. Let's say I don't immediately convert this =
mixed
> > file to the correct line-endings.
>=20
> IMHO, adding .gitattributes that specifies line endings while not
> fixing actual line endings of existing files is really a bad idea.

I absolutely agree, and my first advice upon seeing this jquery repo wa=
s
to fix those line endings. But they went for over a year with the broke=
n
setup, so clearly it wasn't bothering them. I wonder what git could do
better to provoke them to fix it sooner.

> As with any other filter, the rule is that conversion from git to
> the working tree and back should give the same result for any file
> in the repository, otherwise you will have a lot of troubles later.

I think that's a good rule in general, but doesn't crlf=3Dinput (and no=
w
eol=3Dlf, and by extension, the text attribute) encourage exactly that =
if
you have mixed line-ending files?

I think the moral of the story may simply be that mixed line-ending tex=
t
files are an abomination which should be rooted out and destroyed.

> > =C2=A0git clone git://github.com/jquery/jquery.git &&
> > =C2=A0cd jquery &&
> > =C2=A0git checkout 1.4.2 &&
> > =C2=A0git checkout master
> >
> > which will fail (but may succeed racily on a slow enough machine).
> > Obviously they need to fix the mixed line-ending files in their rep=
o.
> > But that fix would be on HEAD, and "git checkout 1.4.2" will be for=
ever
> > broken. Is there a way to fix that?
>=20
> You cannot change the past history. Well, you can overwrite that
> setting using .git/info/attributes. It does not make sense to do
> that in general, but it may be useful if you do git bisect.

The problem with that is that for recent commits you want one set of
attributes (where the files have been fixed), and for going back to
older commits, you want a different set of attributes (where you say
"don't care about line endings in these files").

One solution would be to have a git-notes ref with per-commit
attributes, so you could selectively override attributes as you explore
history.

> BTW, nowadays, we have much better alternative than using
>=20
> * crlf=3Dinput
>=20
> Instead of it, you probably want to use:
>=20
> * text=3Dauto

Agreed, and I already recommended that to jquery people (actually, one
of the problem files you will see in the example above is a binary file=
,
though later on they ended up fixing its attributes by specifically
marking its extension as binary).

-Peff
