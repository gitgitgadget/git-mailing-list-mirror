From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] translate bad characters in refnames during git-svn
	fetch
Date: Tue, 17 Jul 2007 15:17:19 +0200
Message-ID: <20070717131719.GB19724@piper.oerlikon.madduck.net>
References: <20070715130548.GA6144@piper.oerlikon.madduck.net> <20070716033050.GA29521@muzzle> <20070716111509.GC18293@efreet.light.src> <20070715130548.GA6144@piper.oerlikon.madduck.net> <20070716033050.GA29521@muzzle> <20070716174731.GA4792@lapse.madduck.net> <20070717122852.GA21372@mayonaise>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 17 15:17:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAmvd-00026Y-Kf
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 15:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbXGQNRW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 09:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbXGQNRV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 09:17:21 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:53238 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbXGQNRU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 09:17:20 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 00EDC895D8F
	for <git@vger.kernel.org>; Tue, 17 Jul 2007 15:17:20 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 26444-08 for <git@vger.kernel.org>;
	Tue, 17 Jul 2007 15:17:19 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id AA874895D8E
	for <git@vger.kernel.org>; Tue, 17 Jul 2007 15:17:19 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 36DDD9F166
	for <git@vger.kernel.org>; Tue, 17 Jul 2007 15:17:19 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 0D64343EA; Tue, 17 Jul 2007 15:17:19 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070717122852.GA21372@mayonaise>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52759>


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Eric Wong <normalperson@yhbt.net> [2007.07.17.1428 +0200]:
> I like it, too.  How about something like the two functions below?
> This will break things a bit for people currently using % in
> refnames, however.

Well, wait. git-svn usually works in its own repo, and if that's
tracked by another repo, then it is tracked under the
remote/whatever namespace, so there should not be any conflicts. You
also hardly ever run git-svn to clone stuff *into* an existing repo,
so there can't be conflicts with existing refnames-with-%. Thus the
only breakage is if a person creates a new refname inside a git-svn
repo, which uses % in such a way as to collide with an imported
branch/tag/whatever from git-svn. That's not breakage, since git
will just refuse to do it.

Remember that we're only translating from <char> -> %XX, never the
other way around, really. Okay, we might be during git-svn
rebase/dcommit, but only for those refnames which we store in
=2Egit/svn/ anyway. So a user-specified refname containing % will not
be a problem, will it?

> I think this will work rather nicely once I've figured out how the path
> globbing code works[1] and where to sanitize/desanitize the refnames
> properly.

I am glad you're having the same problem; makes me feel less stupid.
:)

>   Somebody naming directories on the SVN side with the path component
>   ":refs/remotes" in them could screw things up for us.

Those people should be tarred and feathered. git owns the trademark
on these names.

> sub desanitize_ref_name {
> 	my ($refname) =3D @_;
> 	$refname =3D~ s{%(?:([0-9A-F]{2})}{chr hex($1)}g;
>=20
> 	$refname;
> }

We could make it escape to %25; instead of %25. That's ugly but it
would make desanitation a little safer.

> > On the other hand, we could make the translation regexps
> > configurable...
>=20
> Hopefully not needed.  I fear it would just add to confusion.

I was thinking about something like.

  git-svn clone ...
  ...
  error: remote branch/tagn name includes ~, which git does not
  allow. please specify a replacement character in .git/config

and then have config.svn-remote.svn.translations simply be a list of
pairs in vim pairlist syntax:

  ~:!,^:#,.:\,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"it is easier to be a lover than a husband for the simple reason
 that it is more difficult to be witty every day
 than to say pretty things from time to time."
                                                   -- honor=E9 de balzac

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGnMFfIgvIgzMMSnURAoa4AKC5zQwwB4h4jLtMYb8zpSD3EyhsrQCfZchz
VJoanG4GE07PQDCAn5RyNe4=
=yhv/
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
