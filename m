From: Jeff King <peff@peff.net>
Subject: Re: Is there something like a git format-patch --squash?
Date: Thu, 18 Feb 2010 15:34:40 -0500
Message-ID: <20100218203440.GA8110@coredump.intra.peff.net>
References: <32541b131002181145w44d69e9eo150d08f34273cefb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 21:34:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiD5D-0002l2-Jy
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 21:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab0BRUem convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 15:34:42 -0500
Received: from peff.net ([208.65.91.99]:47334 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255Ab0BRUel (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 15:34:41 -0500
Received: (qmail 5304 invoked by uid 107); 18 Feb 2010 20:34:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 18 Feb 2010 15:34:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Feb 2010 15:34:40 -0500
Content-Disposition: inline
In-Reply-To: <32541b131002181145w44d69e9eo150d08f34273cefb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140375>

On Thu, Feb 18, 2010 at 02:45:54PM -0500, Avery Pennarun wrote:

> > Something like this (replace MY_START_BRANCH with your starting
> > branch, and do this in a clone of your repository so you don't dest=
roy
> > anything by accident):
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0parent=3D""
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0git rev-list --first-parent --reverse =C2=
=A0| while read commit; do
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ -z "$pa=
rent" ]; then
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0git checkout -f $commit
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0git clean -fdx
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0git diff $parent $commit | git apply --index
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0git commit -C $commit
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parent=3D$co=
mmit
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0done
>=20
> In the above, in the 'else' clause, what I really wanted was somethin=
g like:
>=20
>    git format-patch --stdout --squash $parent..$commit
>=20
> with one big "| git am" at the end of the loop.

I don't think there is a way to do it automagically. Obviously you can
use diff (as you did) to produce the diff, but how should the many
commit messages be combined?

Worst case, you could probably do it yourself by echoing the mail
headers yourself, throwing all of the commit messages in the body, and
then doing the diff:

  me=3D`git var GIT_AUTHOR_IDENT | sed -e 's/>.*/>/'`
  (echo "From: $me"
   echo "Subject: Mega-squash of $commit"
   echo
   git log --format=3D"%s%n%n%b" $parent..$commit
   echo ---
   git diff $parent $commit
  ) | git am

But that's totally untested (also, do you really need $parent? In
--first-parent --reverse, isn't it always going to be $commit^1?).

But I think you can do it without diff application by just re-using the
tree-state of each merge:

  git rev-list --first-parent --reverse $from..$to |
  last=3D$from
  while read commit; do
    last=3D`git cat-file commit $commit |
          sed '1,/^$/d' |
          git commit-tree $commit^{tree} -p $from`
  done
  git update-ref refs/heads/new $last

But that isn't tested either. :) You might need to replace
"$commit^{tree}" with an equivalent rev-parse.

-Peff
