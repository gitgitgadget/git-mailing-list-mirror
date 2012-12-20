From: Sergio Talens-Oliag <sto@iti.es>
Subject: Gitweb running as FCGI does not print its output in UTF-8
Date: Thu, 20 Dec 2012 14:53:57 +0100
Message-ID: <20121220135357.GA27920@iti.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 15:12:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlgqu-0004LV-JQ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 15:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300Ab2LTOLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 09:11:43 -0500
Received: from smtpsal1.cc.upv.es ([158.42.249.61]:34250 "EHLO
	marfik.cc.upv.es" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751709Ab2LTOLl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 09:11:41 -0500
X-Greylist: delayed 1060 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Dec 2012 09:11:41 EST
Received: from smtpx.upv.es (smtpxv.cc.upv.es [158.42.249.46])
	by marfik.cc.upv.es (8.13.6/8.13.6) with ESMTP id qBKDrxW4004479
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 20 Dec 2012 14:53:59 +0100
Received: from smtp.upv.es (celaeno.cc.upv.es [158.42.249.55])
	by smtpx.upv.es (8.14.3/8.14.3) with ESMTP id qBKDrxOh007547
	for <git@vger.kernel.org>; Thu, 20 Dec 2012 14:53:59 +0100
Received: from tormenta.iti.upv.es (grumete.iti.upv.es [158.42.165.251])
	by smtp.upv.es (8.13.6/8.13.6) with ESMTP id qBKDrwWo030666
	for <git@vger.kernel.org>; Thu, 20 Dec 2012 14:53:58 +0100
Received: from maxc64.iti.upv.es (maxc64.iti.upv.es [192.168.1.125])
	by tormenta.iti.upv.es (Postfix) with ESMTP id 655AE30C8014
	for <git@vger.kernel.org>; Thu, 20 Dec 2012 14:53:57 +0100 (CET)
Received: by maxc64.iti.upv.es (Postfix, from userid 1000)
	id 3C25F1A000AD; Thu, 20 Dec 2012 14:53:57 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211888>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello, I'm sending this message to explain a problem I've found with
gitweb.cgi when running it using a call like the following:

    export FCGI_SOCKET_PATH=3D"/run/gitweb.socket"
    gitweb.cgi --fcgi --nproc 2

I've fixed the problem for my installation usign a wrapper script, as
explained below.

I'm not sending a patch because I'm no expert in Perl and I'm unsure that
the solution I've found is the right one, but in the hope that my descripti=
on
of the problem and the provided solution will be useful for others.

Problem description:

   When using gitweb.cgi in FCGI mode the answers from the script are retur=
ned
   using the wrong encoding (UTF-8 characters are printed as LATIN-1).
  =20
   It seems that the problem appears because the FCGI streams are implement=
ed
   using the older stream API, TIEHANDLE and applying PerlIO layers using
   binmode() has no effect to them.

Applied solution:

   A solution similar to the use of binmode for the output stream is to
   redefine the FCGI::Stream::PRINT function to use UTF-8 as output encodin=
g.

   To do it with minimal chages I've created a gitweb.cgi wrapper that
   redefines the function and runs the original script; I'm doing it like t=
his
   to be able to use the packaged script until upstream includes a fix for =
the
   problem.

Wrapper code (uses /usr/share/gitweb/gitweb.cgi as the PATH for gitweb.cgi):

  #!/usr/bin/perl
  # gitweb.cgi wrapper that fixes the UTF-8 problem with fastcgi

  # Local redefinition of FCGI::Stream::PRINT
  use Encode;
  use FCGI;

  our $enc =3D Encode::find_encoding('UTF-8');
  our $org =3D \&FCGI::Stream::PRINT;
  no warnings 'redefine';

  local *FCGI::Stream::PRINT =3D sub {
    my @OUTPUT =3D @_;
    for (my $i =3D 1; $i < @_; $i++) {
      $OUTPUT[$i] =3D $enc->encode($_[$i], Encode::FB_CROAK|Encode::LEAVE_S=
RC);
    }
    @_ =3D @OUTPUT;
    goto $org;
  };

  # Execute original script
  do "/usr/share/gitweb/gitweb.cgi";

References:

   The applied solution has been found on the following StackOverflow
   question:

     http://stackoverflow.com/questions/5005104

Environment:

  The system I'm using is Debian Wheezy and I'm serving gitweb using nginx's
  fastcgi interface.

  The versions of the related debian packages are:
 =20
	Package: git
	Version: 1:1.7.10.4-1+wheezy1
	Package: libcgi-fast-perl
	Version: 5.14.2-16
	Package: libfcgi-procmanager-perl
	Version: 0.24-1
	Package: perl
	Version: 5.14.2-16

  To launch gitweb as fastcgi I'm using an init.d script that runs the wrap=
per
  script in the background as the `www-user` using a call similar to the
  following:

    export FCGI_SOCKET_PATH=3D"/run/gitweb/socket"
    gitweb.cgi-wrapper --fcgi --nproc 2

Greetings,

  Sergio.

--=20
Sergio Talens-Oliag <sto@iti.es>               <http://www.iti.es/>
Key fingerprint =3D FF77 A16B 9D09 FC7B 6656 CFAD 261D E19A 578A 36F2

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlDTGHUACgkQJh3hmleKNvJAtgCg418Bxi9OtQPqN+2oHAaHbf8R
/w8AnA26ZV92aV57VqEl0Rq/5qlu9Mzd
=X1Pn
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
