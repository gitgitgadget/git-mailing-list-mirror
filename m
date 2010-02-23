From: Jeff King <peff@peff.net>
Subject: Re: Bugs with detection of renames that are also overwrites
Date: Tue, 23 Feb 2010 07:22:57 -0500
Message-ID: <20100223122257.GA1735@coredump.intra.peff.net>
References: <alpine.DEB.2.00.1002131820150.14055@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Feb 23 13:23:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njtn9-0006fY-Sf
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 13:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604Ab0BWMXA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 07:23:00 -0500
Received: from peff.net ([208.65.91.99]:58320 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751998Ab0BWMW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 07:22:59 -0500
Received: (qmail 17764 invoked by uid 107); 23 Feb 2010 12:23:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 23 Feb 2010 07:23:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Feb 2010 07:22:57 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1002131820150.14055@dr-wily.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140790>

On Sat, Feb 13, 2010 at 06:46:55PM -0500, Anders Kaseorg wrote:

> One can create a rename that also overwrites an existing file, for ex=
ample=20
> with =E2=80=98git mv -f=E2=80=99:
>=20
> $ git init
> $ seq 100 200 > a; seq 300 400 > b; git add a b
> $ git commit -m foo; git tag foo
> $ git mv -f a b
> $ git commit -m bar; git tag bar
>=20
> Git does not ordinarily detect this as a rename, even with -M.

Right. Git looks at only a subset of the files when looking for renames=
=2E
=46or straight renames, the set of possible sources is the list of dele=
ted
files, and the possible destinations are the new files.

=46inding copies ("-C") is similar, except that we also consider files
that were modified but not deleted. And --find-copies-harder will look
at _all_ files as sources, not just modified ones.

But what you are asking for is to expand the possible destination list
to include files that were modified but are not new. I don't think ther=
e
is currently a way to do that explicitly.

As you discovered, though, if either the source or destination file has
changed significantly, we should break them apart using "-B":

> But it can (sometimes*) be forced to detect the rename with -M -B. =20
>=20
> $ git diff --stat -M -B foo bar
>  a =3D> b |    0
>  1 files changed, 0 insertions(+), 0 deletions(-)

In which case the rename engine sees the deletion and addition
separately (they just happen to have the same path name), and therefore
the path gets added to the source and destination lists.

> However, the resulting patch incorrectly omits the deletion of the=20
> overwritten file!
>=20
> $ git diff -M -B foo bar
> diff --git a/a b/b
> similarity index 100%
> rename from a
> rename to b
>
> Therefore, the patch can=E2=80=99t be applied to its own source tree.
>=20
> $ git checkout foo
> $ git diff -M -B foo bar | git apply
> error: b: already exists in working directory

Hmm. I think this is a conflict between what the user wants to see and
what apply wants to see. From the user's perspective, thinking about th=
e
diff representing a change, "b" was not really deleted. It was simply
overwritten. But from apply's perspective, the diff is a set of
instructions, and those instructions do not mention that "b" previously
existed and was overwritten. So it is right to be cautious and declare =
a
conflict.

I'm not sure just throwing a "delete" line in there would be the best
thing, though. The instructions for apply really need to be "if 'b' has
this sha1, then it is safe to delete and rename a into place. Otherwise
it is a conflict". And I'm not sure how we would represent that (I gues=
s
with a full diff and an "index" line).

> Also, a question: is it possible to get =E2=80=98git merge=E2=80=99 t=
o recognize this=20
> rename?

No, I don't think there is a way currently. You would need to patch git
to set opts.break_opt in merge-recursive.c:get_renames, I think.

> (* I say =E2=80=9Csometimes=E2=80=9D because -B only detects the rewr=
ite if it deems the=20
> renamed file to be sufficiently different than the overwritten file. =
 If=20
> you use 190 and 390 instead of 200 and 400 above, the rewrite and ren=
ame=20
> will not be detected, even though the rename would be detected if it =
was=20
> not an overwrite.  This also feels like a bug.)

I think you are getting into a philosophical discussion of what is a
rename, here. If "a" and "b" are very similar, "a" is removed, and "b"
has the same (or similar) content as "a", was it a rename from "a", or
was it simply that "b" was changed, possibly to incorporate the
duplicated items in "a"?

So I don't think it is a bug. But that isn't to say you can't come up
with a case where it would be nice, during a diff or a merge, to show
things that way. I mentioned at the beginning of the message that what
you wanted was to expand the list of destination possibilities. You
could have a "--find-overwrites" which puts all of the modified files
into the destination list. You would not want it on by default, though,
I think, as it would add a lot of computation time to find a somewhat
rare case.

-Peff
