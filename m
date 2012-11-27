From: Jeff King <peff@peff.net>
Subject: Re: Possible vulnerability to SHA-1 collisions
Date: Tue, 27 Nov 2012 18:07:53 -0500
Message-ID: <20121127230753.GA22730@sigill.intra.peff.net>
References: <50B0AB9C.2040802@caltech.edu>
 <CAJo=hJsZdduMdSbN+3Ei-7vx3_Q7tO88LywWj5Vw3Ngs0QgsZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Hirshleifer <111mth@caltech.edu>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 00:08:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUGK-0008Qo-UW
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641Ab2K0XH5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2012 18:07:57 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58707 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217Ab2K0XHz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 18:07:55 -0500
Received: (qmail 29543 invoked by uid 107); 27 Nov 2012 23:08:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Nov 2012 18:08:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2012 18:07:53 -0500
Content-Disposition: inline
In-Reply-To: <CAJo=hJsZdduMdSbN+3Ei-7vx3_Q7tO88LywWj5Vw3Ngs0QgsZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210622>

On Sat, Nov 24, 2012 at 10:09:31AM -0800, Shawn O. Pearce wrote:

> On Sat, Nov 24, 2012 at 3:12 AM, Michael Hirshleifer <111mth@caltech.=
edu> wrote:
> > Evil Guy creates 2 files, 1 evil and 1 innocuous, with the same SHA=
-1
> > checksum (including Git header). Mr. Evil creates a local branch wi=
th an
> > innocuous name like =E2=80=9Ctest-bugfix=E2=80=9D, and adds a commi=
t containing a reference
> > to the evil file. Separately, using a sockpuppet, Evil Guy creates =
an
> > innocuous bugfix (very likely to be accepted) containing the innocu=
ous file,
> > and submits it to Good Guy. Before Good Guy can commit the bugfix, =
Evil Guy
> > pushes the evil branch to Github, and then immediately deletes it; =
or
> > equivalently --force pushes any innocuous commit on top of it. (Thi=
s is
> > unlikely to arouse suspicion, and he can always say he deleted it b=
ecause it
> > didn=E2=80=99t work.)
>=20
> Here you assume Evil Guy has write access to the same repository as
> Good Guy. Lets assume this is possible, e.g. Evil Guy is actually
> impersonating White Hat because he managed to steal White Hat's
> credentials through a compromised host. Typically Evil Guy doesn't
> have write access to Good Guy's repository, and thus can't introduce
> objects into it without Good Guy being the one that creates the
> objects.
>=20
> But lets just keep he assumption that Evil Guy can write to the same
> repository as Good Guy, and that he managed to create the bad branch
> and delete it, leaving the bad object in an unreachable state for 2
> weeks.

Actually, it is somewhat easier on GitHub, because we share objects
between forks of a repository via the alternates mechanism. So if you
can publicly fork the project and push a branch to your fork, you can
write to the shared object database. This applies not just to GitHub,
but to any hosting service which shares object databases between
projects (I do not know offhand if other hosting providers like Google
Code do this).

But as you noted later in your email, the byte-for-byte comparison on
object collision will let us detect this case when the good guy tries t=
o
push and abort.

-Peff

PS I also think the OP's "sockpuppet creates innocuous bugfix" above is
   easier said than done. We do not have SHA-1 collisions yet, but if
   the md5 attacks are any indication, the innocuous file will not be
   completely clean; it will need to have some embedded binary goo that
   is mutated randomly during the collision process (which is why the
   md5 attacks were demonstrated with postscript files which _rendered_
   to look good, but contained a chunk of random bytes in a spot ignore=
d
   by the postscript interpreter).
