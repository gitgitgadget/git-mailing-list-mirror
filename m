From: Jeff King <peff@peff.net>
Subject: Re: gsoc - Better git log --follow support
Date: Wed, 23 Mar 2011 12:20:23 -0400
Message-ID: <20110323162023.GC30337@sigill.intra.peff.net>
References: <AANLkTi=n7e70UqYU+6wpG4cu95fsg39tVM6=7fpfdZFz@mail.gmail.com>
 <20110321122407.GH16334@sigill.intra.peff.net>
 <AANLkTi=woLeveur6gKnSXTRzmS8nB0o4M9HegJ+GNUCa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82_=C5=81owicki?= <mlowicki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 17:20:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2QnR-0004iY-Qd
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 17:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325Ab1CWQU1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 12:20:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40300
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170Ab1CWQUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 12:20:25 -0400
Received: (qmail 6124 invoked by uid 107); 23 Mar 2011 16:21:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Mar 2011 12:21:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Mar 2011 12:20:23 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=woLeveur6gKnSXTRzmS8nB0o4M9HegJ+GNUCa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169850>

On Wed, Mar 23, 2011 at 12:23:45AM +0100, Micha=C5=82 =C5=81owicki wrot=
e:

> > =C2=A0# But now look at it in gitk. Commit 4 is included as a bound=
ary
> > =C2=A0# commit, but we fail to notice that it connects to three. An=
d we
> > =C2=A0# don't see commit 3 connecting to anything, and commit 1 is =
missing
> > =C2=A0# entirely.
> > =C2=A0gitk --follow newfile
>=20
> Why commit 4 is displayed here (changes only file2) ?

It's part of how gitk shows the graph. It shows all of the commits you
asked for with blue nodes, and then it shows the "boundary" commits wit=
h
a special white node. This lets you distinguish between actual root
commits (i.e., ones with no parents) and ones whose parents are simply
uninteresting to the current query.

> # git log with graph works here OK. It displays six -- five .. --
> three .. - one .In this case results shouldn't be similar to gitk ?
> git log --graph --follow newfile

Sort of. Notice the "..." in the output (it is easier to see with "git
log --graph --oneline --follow newfile). It is not showing the
simplified history, but instead indicates that there were some commits
omitted in between the two points. It doesn't make the output terrible
in such a simple linear case. But consider a case with branching:

  # Our A-B-C repo
  git init repo && cd repo
  echo content >file1 && git add file1 && git commit -m one
  echo content >file2 && git add file2 && git commit -m two
  echo content >>file1 && git add file1 && git commit -m three

  # Now make a side branch that also touches file1
  git checkout -b side HEAD^
  echo content >>file1 && git commit -a -m four

  # And merge them back to together
  git merge master

  # And then do our other commits with rename on top
  echo content >>file2 && git commit -a -m five
  git mv file1 newfile && git commit -m six
  echo content >>newfile && git commit -a -m seven

Showing "git log --graph --oneline --follow newfile" becomes a bit more
confusing. A simplified history would show "six" as the merge between
the two branches, but here it happens at some indeterminate point in th=
e
history that is not shown.

And again, this is a simple example. For something more complex, try
this in git.git:

  # We know builtin-add.c got renamed to builtin/add.c, so
  # let's cheat and tell git which paths we're interested in.
  # The resulting graph is pretty readable, and is more or less what we
  # would want from --follow.
  git log --oneline --graph -- builtin-add.c builtin/add.c

  # Now try it with --follow. Not so pretty.
  git log --oneline --graph --follow builtin/add.c

-Peff
