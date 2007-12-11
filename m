From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 20:34:07 +0100
Message-ID: <20071211193407.GC20644@artemis.madism.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="eHhjakXzOLJAF9wJ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Daniel Berlin <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:34:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2AsE-0007qX-0x
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbXLKTeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753578AbXLKTeM
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:34:12 -0500
Received: from pan.madism.org ([88.191.52.104]:58518 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753550AbXLKTeL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 14:34:11 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3616E2F6A4;
	Tue, 11 Dec 2007 20:34:07 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 5364E2F3; Tue, 11 Dec 2007 20:34:07 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Daniel Berlin <dberlin@dberlin.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67919>


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2007 at 07:09:03PM +0000, Daniel Berlin wrote:
> On 12/11/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> >
> > On Tue, 11 Dec 2007, Daniel Berlin wrote:
> > >
> > > This seems to be a common problem with git. It seems to use a lot of
> > > memory to perform common operations on the gcc repository (even though
> > > it is faster in some cases than hg).
> >
> > The thing is, git has a very different notion of "common operations" th=
an
> > you do.
> >
> > To git, "git annotate" is just about the *last* thing you ever want to =
do.
> > It's not a common operation, it's a "last resort" operation. In git, the
> > whole workflow is designed for "git log -p <pathnamepattern>" rather th=
an
> > annotate/blame.
> >
> I understand this, and completely agree with you.
> However, I cannot force GCC people to adopt completely new workflow in
> this regard.
> The changelog's are not useful enough (and we've had huge fights over
> this) to do git log -p and figure out the info we want.

> Looking through thousands of diffs to find the one that happened to
> your line is also pretty annoying.

  If the question you want to answer is "what happened to that line"
then using git annotate is using a big hammer for no good reason.

git log -S'<put the content of the line here>' -- path/to/file.c

will give you the very same answer, pointing you to the changes that
added or removed that line directly. It's not a fast command either, but
it should be less resource hungry than annotate that has to do roughly
the same for all lines whereas you're interested in one only.

The direct plus here, is that git log output is incremental, so you have
answers about the first diffs quite quick, which let you examine the
first answers while the rest is still being computed.

Unlike git annotate, this also allow you to restrict the revisions
where it searches to a range where you know this happened, which makes
it almost instantaneous in most cases.

Of course, if the line is '    free(p);\n' then you will probably have
quite a few false positives, but with the path restriction, I assume
this will still be quite accurate.

What is important here is to know what is the real question the GCC
programmers want to answer to. It seems to me that `blame` is an
overkill for the underlying issue.


Note that it does not justifies the current memory consumption that just
looks bad and wrong to me, but this aims at finding a way to answer your
question doing just what you need to answer it and not gazillions of
other things :)
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHXuYvvGr7W6HudhwRAjLKAKCmas1lx/KnHi/jdl8DX6VclAnN3ACffPmS
xX6Nbjj5k7dSnvSqGdiV4j4=
=ugiq
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
