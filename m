From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: [PATCH 3/3] gitweb: remove test when closing file descriptor
Date: Thu, 16 Dec 2010 23:37:00 +0100
Message-ID: <1292539020.2511.6.camel@kheops>
References: <1292535801-7421-1-git-send-email-sylvain@abstraction.fr>
	 <1292535801-7421-4-git-send-email-sylvain@abstraction.fr>
	 <m3pqu4lx6n.fsf@localhost.localdomain>
Reply-To: sylvain@abstraction.fr
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-uV3PVPRGEpbuGn0T/fJ4"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 23:37:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTMRh-0005n5-6Q
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 23:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690Ab0LPWhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 17:37:04 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41541 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab0LPWhD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 17:37:03 -0500
Received: by wyb28 with SMTP id 28so54089wyb.19
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 14:37:02 -0800 (PST)
Received: by 10.216.162.138 with SMTP id y10mr172116wek.62.1292539022382;
        Thu, 16 Dec 2010 14:37:02 -0800 (PST)
Received: from [192.168.0.7] (85-168-197-251.rev.numericable.fr [85.168.197.251])
        by mx.google.com with ESMTPS id r6sm325259weq.20.2010.12.16.14.37.01
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 14:37:01 -0800 (PST)
In-Reply-To: <m3pqu4lx6n.fsf@localhost.localdomain>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163827>


--=-uV3PVPRGEpbuGn0T/fJ4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-12-16 at 14:30 -0800, Jakub Narebski wrote:
> Sylvain Rabot <sylvain@abstraction.fr> writes:
>=20
> > it happens that closing file descriptor fails whereas
> > the blob is perfectly readable.
> >=20
> > Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
> > ---
> >  gitweb/gitweb.perl |    3 +--
> >  1 files changed, 1 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 9398475..9a885b1 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -3450,8 +3450,7 @@ sub run_highlighter {
> >  	my ($fd, $highlight, $syntax) =3D @_;
> >  	return $fd unless ($highlight && defined $syntax);
> > =20
> > -	close $fd
> > -		or die_error(404, "Reading blob failed");
> > +	close $fd;
>=20
> Actually what I think happens is the following.  "close $fh" cannot
> usually fail, unless (`perldoc -f close`):
>=20
>    If the file handle came from a piped open, "close" will additionally
>    return false if one of the other system calls involved fails, or if th=
e
>    program exits with non-zero status.  (If the only problem was that the
>    program exited non-zero, $! will be set to 0.)  Closing a pipe also wa=
its
>    for the process executing on the pipe to complete, in case you want to
>    look at the output of the pipe afterwards, and implicitly puts the exi=
t
>    status value of that command into $?.
>=20
>    Prematurely closing the read end of a pipe (i.e. before the process wr=
it-
>    ing to it at the other end has closed it) will result in a SIGPIPE bei=
ng
>    delivered to the writer.  If the other end can't handle that, be sure =
to
>    read all the data before closing the pipe.
>=20
> In this place we close read end of pipe after at most reading a few
> bytes (what -T test does), so what might happen is that writer got
> SIGPIPE and "failed".  But we are not interested in this, so we can
> safely ignore return from 'close'.
>=20
> I think that some from above explanation should make it to commit
> message.

Thanks for explaining it, I did not have any idea why it was failing.
Can I use your explanation as commit message ?

>=20
> >  	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
> >  	          quote_command($highlight_bin).
> >  	          " --xhtml --fragment --syntax $syntax |"
>=20
> P.S. A better solution would be to redirect opened $fd to highlighter,
> instead of closing and reopening a pipe... but I'm not sure how it
> could be implemented.

I don't know either.

>=20


--=20
Sylvain Rabot <sylvain@abstraction.fr>

--=-uV3PVPRGEpbuGn0T/fJ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAABAgAGBQJNCpSMAAoJECLlHVUnhaoWdJ4H/R4E3Ej9yQYJCY0WOd0AzuWy
IyzEWC0hsdgfCr/5CQ/30uEZf6fy+6DvhgcY8JDWxrZukfwJ3qjeaGWtIUfh8Flo
8h26cdLr3b8z9koE1mhV1Q3rd+dQQFdFtqDY9XljGw426Yt4W92Qt3A5Xh1U9NKU
/l7bunjeYd6p7xVKW+Je7vbmkp1LKpk1AUh64P274umBvmaajmKC7eXu6lSYSvK2
QRVBJW+2XNQVMB34WDXQyDw7Za/wE+duH/RSk12/BZrwVB4kBDL+/A0uAK5bOaSG
KLjLtW8JSdE2lmGS/Yzz8UChsdwnX8859EjVckyeGQKBe82DVWh19COAVry8iqA=
=p3pD
-----END PGP SIGNATURE-----

--=-uV3PVPRGEpbuGn0T/fJ4--
