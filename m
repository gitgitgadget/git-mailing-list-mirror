From: Dennis Schridde <devurandom@gmx.net>
Subject: Re: Odd number of elements in anonymous hash
Date: Thu, 10 Jan 2008 22:13:00 +0100
Message-ID: <200801102213.04082.devurandom@gmx.net>
References: <200801081738.56624.devurandom@gmx.net> <200801101813.45938.devurandom@gmx.net> <7v63y178a3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9868438.HVyydnMVv6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:14:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD4jG-0001al-3J
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 22:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbYAJVNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 16:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753952AbYAJVNx
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 16:13:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:42891 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753276AbYAJVNw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 16:13:52 -0500
Received: (qmail invoked by alias); 10 Jan 2008 21:13:51 -0000
Received: from hnvr-4dbbd1d5.pool.einsundeins.de (EHLO ernie.local) [77.187.209.213]
  by mail.gmx.net (mp038) with SMTP; 10 Jan 2008 22:13:51 +0100
X-Authenticated: #19202771
X-Provags-ID: V01U2FsdGVkX1+4iqdB+iK4LmPbkGeoZo3oXzcgPXhY4XJccwy4en
	CujE5kNHXyfz7w
User-Agent: KMail/1.9.7
In-Reply-To: <7v63y178a3.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70092>

--nextPart9868438.HVyydnMVv6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag, 10. Januar 2008 21:08:52 schrieb Junio C Hamano:
> Dennis Schridde <devurandom@gmx.net> writes:
> >> [svn-remote "svn"]
> >>     reposRoot =3D file:///var/svn/warzone2100
> >>     uuid =3D 4a71c877-e1ca-e34f-864e-861f7616d084
> >>     branches-maxRev =3D 14
> >>     tags-maxRev =3D 14
> >>     svnsync-uuid =3D 4a71c877-e1ca-e34f-864e-861f7616d084\n
> >>     svnsync-url =3D http://svn.gna.org/svn/warzone
> >> [svn-remote "tags/1.10a.12"]
> >>     reposRoot =3D file:///var/svn/warzone2100
> >>     uuid =3D 4a71c877-e1ca-e34f-864e-861f7616d084
> >> ---
> >
> > The rest of the file is rather boring. The "svn" remote is not changed
> > (besides having higher revisions) and the other remotes look exactly li=
ke
> > the "tags/1.10a.12" one.
> >
> > Somehow I think that the \n at the end of the svnsync-uuid shouldn't be
> > there... It could be that this is the same linebreak which prevents
> > people from relocating (svn switch --relocate) from
> > svn://svn.gna.org/svn/warzone to http://svn.gna.org/svn/warzone, so that
> > would be a Gna bug.
> > However git-svn shouldn't throw any warnings (or even (make perl) crash=
?)
> > on such occasions, either...
> >
> > I now got it to run through without a segfault, by compiling an unstrip=
ed
> > perl binary with debug symbols (Gentoo: FEATURES=3Dnostrip CFLAGS=3D"...
> > -g"). Maybe this is a bug in GCC or something...
> >
> > The "Odd number of elements in anonymous hash" still stays, though.
>
> The code in question is:
>
> 	my $svnsync;
> 	# see if we have it in our config, first:
> 	eval {
> 		my $section =3D "svn-remote.$self->{repo_id}";
> 		$svnsync =3D {
> 		  url =3D> tmp_config('--get', "$section.svnsync-url"),
> 		  uuid =3D> tmp_config('--get', "$section.svnsync-uuid"),
> 		}
> 	};
>
> I think the "Odd number" is an indication that one of the
> tmp_config() calls is returning an even number of elements (so
> the hash whose ref will be stored in $svnsync ends up having an
> odd number of elements), and that is why I initially asked you
> about "more than one" svnsync-url.  0 is also an even number,
> and it could be that it is not finding any.
>
> How about doing something ugly like this _just for diagnosis_?
>
> 	my $svnsync;
> 	# see if we have it in our config, first:
> 	eval {
> 		my $section =3D "svn-remote.$self->{repo_id}";
> 		my @u =3D tmp_config('--get', "$section.svnsync-url");
> 		my @v =3D tmp_config('--get', "$section.svnsync-uuid");
> 		if (@u !=3D 1 || @v !=3D 1) {
>                 	print STDERR "Oops: <$section> $#u <@u> $#v <@v>\n";
> 		}
> 		$svnsync =3D {
> 		  url =3D> @u,
> 		  uuid =3D> @v,
> 		}
> 	};
I've created /usr/bin/git-svndbg and changed that part, like you proposed.
I now get this output. (As it continues to run, there are probably more=20
occassions of the Oops.)
=2D--
Oops: <svn-remote.svn> 0 <http://svn.gna.org/svn/warzone> 1=20
<4a71c877-e1ca-e34f-864e-861f7616d084 >
Odd number of elements in anonymous hash at /usr/bin/git-svndbg line 1768.
r13 =3D ee6d5a48dd5cf1a96ed5217d638f372d2c173d89 (tags/1.10a)
=2D--

=2D-Dennis

--nextPart9868438.HVyydnMVv6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iEYEABECAAYFAkeGimAACgkQjqfyF1DtJW6LwACeMQiqs/CuQ/TJWYL4j5KEdkXZ
BToAn19k8mqDcbSkGZxSvTPMrXn3fCfm
=vGaL
-----END PGP SIGNATURE-----

--nextPart9868438.HVyydnMVv6--
