From: Ed Schouten <ed@fxq.nl>
Subject: Syntax highlighting for gitweb
Date: Mon, 26 Feb 2007 19:18:58 +0100
Message-ID: <20070226181858.GC11232@hoeg.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 26 19:49:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLkuo-0002Cl-Jm
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 19:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbXBZSt1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 13:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030452AbXBZSt1
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 13:49:27 -0500
Received: from palm.hoeg.nl ([83.98.131.212]:64018 "EHLO palm.hoeg.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030447AbXBZSt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 13:49:26 -0500
X-Greylist: delayed 1827 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Feb 2007 13:49:26 EST
Received: by palm.hoeg.nl (Postfix, from userid 1000)
	id 3D2401CF06; Mon, 26 Feb 2007 19:18:58 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40640>


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I just wrote a really awful patch to add syntax highlighting to gitweb:

%%%
--- gitweb	Mon Feb 26 18:36:42 2007
+++ gitweb	Mon Feb 26 19:12:20 2007
@@ -16,6 +16,7 @@
 use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
+use IPC::Open2;
 binmode STDOUT, ':utf8';
=20
 our $cgi =3D new CGI;
@@ -3186,15 +3187,25 @@
 	git_print_page_path($file_name, "blob", $hash_base);
 	print "<div class=3D\"page_body\">\n";
 	my $nr;
+
+	my $pid;
+	local (*HLR, *HLW);
+	$pid =3D open2(\*HLR, \*HLW, "highlight -f --syntax c");
 	while (my $line =3D <$fd>) {
-		chomp $line;
-		$nr++;
-		$line =3D untabify($line);
-		printf "<div class=3D\"pre\"><a id=3D\"l%i\" href=3D\"#l%i\" class=3D\"l=
inenr\">%4i</a> %s</div>\n",
-		       $nr, $nr, $nr, esc_html($line, -nbsp=3D>1);
+		print HLW $line;
 	}
+	close HLW
+		or print "Failed to start highlight.\n";
 	close $fd
 		or print "Reading blob failed.\n";
+
+	while (my $line =3D <HLR>) {
+		$nr++;
+		printf "<div class=3D\"pre\"><a id=3D\"l%i\" href=3D\"#l%i\" class=3D\"l=
inenr\">%4i</a> %s</div>\n",
+		       $nr, $nr, $nr, $line;
+	}
+	close HLR
+		or print "Failed to highlight blob.\n";
 	print "</div>";
 	git_footer_html();
 }
%%%

I am not a Perl programmer, so I kept it really simple by just
hardcoding '--syntax c'. Would it be possible for some real Perl
programmer to clean this up? I think a feature like this would be really
cool to have.

Yours,
--=20
 Ed Schouten <ed@fxq.nl>
 WWW: http://g-rave.nl/

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (FreeBSD)

iD8DBQFF4ySS52SDGA2eCwURAj3rAJ9LoU1zJ0jc5uwrHpof1f1zGYYTjgCeP7/c
4ZABd/QKeKTAqKlh0aBDYi4=
=l+tc
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
