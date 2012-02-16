From: Jeff King <peff@peff.net>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Thu, 16 Feb 2012 14:20:02 -0500
Message-ID: <20120216192001.GB4348@sigill.intra.peff.net>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
 <CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
 <8762f9k5sg.fsf@thomas.inf.ethz.ch>
 <CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
 <20120215190318.GA5992@sigill.intra.peff.net>
 <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 20:20:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry6sH-0007od-1b
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 20:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211Ab2BPTUF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Feb 2012 14:20:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38774
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791Ab2BPTUE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 14:20:04 -0500
Received: (qmail 32308 invoked by uid 107); 16 Feb 2012 19:27:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Feb 2012 14:27:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2012 14:20:02 -0500
Content-Disposition: inline
In-Reply-To: <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190901>

On Thu, Feb 16, 2012 at 02:37:47PM +0100, Piotr Krukowiecki wrote:

> >> $ time git status =C2=A0-- .
> >> real =C2=A0 =C2=A00m2.503s
> >> user =C2=A0 =C2=A00m0.160s
> >> sys =C2=A0 =C2=A0 0m0.096s
> >>
> >> $ time git status
> >> real =C2=A0 =C2=A00m9.663s
> >> user =C2=A0 =C2=A00m0.232s
> >> sys =C2=A0 =C2=A0 0m0.556s
> >
> > Did you drop caches here, too?
>=20
> Yes I did - with cache the status takes something like 0.1-0.3s on wh=
ole repo.

OK, then that makes sense. It's pretty much just I/O on the filesystem
and on the object db.

You can break status down a little more to see which is which. Try "git
update-index --refresh" to see just how expensive the lstat and index
handling is.

And then try "git diff-index HEAD" for an idea of how expensive it is t=
o
just read the objects and compare to the index.

> > Not really. You're showing an I/O problem, and repacking is git's w=
ay of
> > reducing I/O.
>=20
> So if I understand correctly, the reason is because git must compare
> workspace files with packed objects - and the problem is
> reading/seeking/searching in the packs?

Mostly reading (we keep a sorted index and access the packfiles via
mmap, so we only touch the pages we need). But you're also paying to
lstat() the directory tree, too. And you're paying to load (probably)
the whole index into memory, although it's relatively compact compared
to the actual file data.

> Is there a way to make packs better? I think most operations are on
> workdir files - so maybe it'd be possible to tell gc/repack/whatever
> to optimize access to files which I currently have in workdir?

It already does optimize for that case. If you can make it even better,
I'm sure people would be happy to see the numbers.

Mostly I think it is just the case that disk I/O is slow, and the
operation you're asking for has to do a certain amount of it. What kind
of disk/filesystem are you pulling off of?

It's not a fuse filesystem by any chance, is it? I have a repo on an
encfs-mounted filesystem, and the lstat times are absolutely horrific.

-Peff
