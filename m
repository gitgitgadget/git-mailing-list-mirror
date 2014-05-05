From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with
 decomposed filenames
Date: Mon, 5 May 2014 17:46:58 -0400
Message-ID: <20140505214658.GA16971@sigill.intra.peff.net>
References: <20140428161630.GA9435@sigill.intra.peff.net>
 <5365DA7B.6050000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 06 18:44:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiAX-0007Xo-ES
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756853AbaEEVrC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 May 2014 17:47:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:45553 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756764AbaEEVrA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 17:47:00 -0400
Received: (qmail 8004 invoked by uid 102); 5 May 2014 21:47:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 May 2014 16:47:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 May 2014 17:46:58 -0400
Content-Disposition: inline
In-Reply-To: <5365DA7B.6050000@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248151>

On Sun, May 04, 2014 at 08:13:15AM +0200, Torsten B=C3=B6gershausen wro=
te:

> >   1. Tell everyone that NFD in the git repo is wrong, and
> >      they should make a new commit to normalize all their
> >      in-repo files to be precomposed.
> >      This is probably not the right thing to do, because it
> >      still doesn't fix checkouts of old history. And it
> >      spreads the problem to people on byte-preserving
> >      filesystems (like ext4), because now they have to start
> >      precomposing their filenames as they are adde to git.
>      (typo:                                                          =
        ^added)
> I'm not sure if I follow. People running ext4 (or Linux in general,
> or Windows, or Unix) do not suffer from file system
> "feature" of Mac OS, which accepts precomposed/decomposed Unicode
> but returns decompomsed.

What I mean by "spreads the problem" is that git on Linux does not need
to care about utf8 at all. It treats filenames as a byte sequence. But
if we were to start enforcing "filenames should be precomposed utf8",
then people adding files on Linux would want to enforce that, too.

People on Linux could ignore the issue as they do now, but they would
then create problems for OS X users if they add decomposed filenames.
IOW, if the OS X code assumes "all repo filenames are precomposed", the=
n
other systems become a possible vector for violating that assumption.

> >   3. Convert index filenames to their precomposed form when
> >      we read the index from disk. This would be efficient,
> >      but we would have to be careful not to write the
> >      precomposed forms back out to disk.
> Question:
> How could we be careful?
> Mac OS writes always decomposed Unicode to disk.
> (And all other OS tend to use precomposed forms, mainly because the "=
keyboard
> driver" generates it.)

Sorry, I should have been more clear here. I meant "do not write index
entries using the precomposed forms out to the on-disk index". Because
that would mean that git silently converts your filenames, and it would
look like you have changes to commit whenever you read in a tree with a
decomposed name.

Looking over the patch you sent earlier, I suspect that is part of its
problem (it stores the converted name in the index entry's name field).

> This is my understanding:
> Some possible fixes are:
>=20
>   1. Accept that NFD in a Git repo which is shared between Mac OS
>      and Linux or Windows is problematic.
>      Whenever core.precomposeunicode =3D true, do the following:
>      Let Git under Mac OS change all file names in the index
>      into the precomposed form when a new commit is done.
>      This is probably not a wrong thing to do.
>=20
>      When the index file is read into memory, precompose the file nam=
es and compare
>      them with the precomposed form coming from precompose_utf8_readd=
ir().
>      This avoids decomposed file names to be reported as untracked by=
 "git status.

This is the case I was specifically thinking of above (and I think what
your patch is doing).

>   2. Do all index filename comparisons under Mac OS X using a UTF-8 a=
ware
>      comparison function regardless if core.precomposeunicode is set.
>      This would probably have bad performance, and somewhat
>      defeats the point of converting the filenames at the
>      readdir level in the first place.

Right, I'm concerned about performance here, but I wonder if we can
reuse the name-hash solutions from ignorecase.

-Peff
