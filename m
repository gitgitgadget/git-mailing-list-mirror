From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: [PATCH] gitweb: use decode_utf8 directly
Date: Tue, 24 Apr 2007 17:05:15 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200704241705.19661.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1510669.FJOZfySF7x";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 16:04:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgLcr-0004y8-Mr
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 16:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161478AbXDXOEK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 10:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161464AbXDXOEK
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 10:04:10 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:52091 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161478AbXDXOEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 10:04:08 -0400
Received: from southpark.local (unknown [85.101.42.39])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 416FD5F5C303
	for <git@vger.kernel.org>; Tue, 24 Apr 2007 17:04:01 +0300 (EEST)
User-Agent: KMail/1.9.6
X-Face: 9Va_@~iRiB"*X1O@K#(=?utf-8?q?thBxy=236XXkD87I=3DG=7E=23=26tFA=26=24mM+4oHIQZGdgCx9=23IZ=7ByL-?=
 =?utf-8?q?rk8CY=0A=09u=3B=7DX=7D?=,+R%vB]|/kKH:-<%Mym?njPCL%'gcIX.J$I}9+{Q|vvl0&c+>WFNbuN,>)
 =?utf-8?q?Of=3AUJq0=0A=09=7DL9+?="}tE:hB<t]y=^%m/R6z.OA8}$@VZ6N?m?h4^,GBNW&xS]9'I?;1OEohho"yF>
 =?utf-8?q?s36=7EN=0A=09=5CE0=60?=@O~`!C>JQkL|pqY{]A7Ow0PD$;BJ9^%!$[hV?(lrTA\rJk\rxnz>oW&W,
 =?utf-8?q?=3DE3obyZfC=0A=09=5EC=7BbqWCY?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45451>

--nextPart1510669.FJOZfySF7x
Content-Type: multipart/mixed;
  boundary="Boundary-01=_b6gLG52LyGnqd/K"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_b6gLG52LyGnqd/K
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

gitweb currently uses Encode::decode function with a wrapper like this :

# very thin wrapper for decode("utf8", $str, Encode::FB_DEFAULT);
sub to_utf8 {
       my $str =3D shift;
       return decode("utf8", $str, Encode::FB_DEFAULT);
}

But for me this gives the following error when I try to view RSS feed for=20
Linux kernel GIT repo (local checkout) :

Cannot decode string with wide characters=20
at /usr/lib/perl5/vendor_perl/5.8.8/i686-linux/Encode.pm line 162.

I Google'd a bit but the relevant information seems to be missing about thi=
s=20
error. Anyhow there is no need for a wrapper at all as Encode class has a=20
decode_utf8 function which fixes the problem I am experiencing too and chop=
s=20
off the unneeded wrapper.

Patch against git 1.5.1.2 is attached. Comments welcome.

P.S: I am using Encode 2.20 from CPAN which is the latest stable version=20
available.

Regards,
ismail

=2D-=20
Life is a game, and if you aren't in it to win,
what the heck are you still doing here?

=2D- Linus Torvalds (talking about open source development)

--Boundary-01=_b6gLG52LyGnqd/K
Content-Type: text/x-diff;
  charset="utf-8";
  name="decode-utf8.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="decode-utf8.patch"

=2D-- gitweb/gitweb.perl	2007-04-24 16:53:00.000000000 +0300
+++ gitweb/gitweb.perl	2007-04-24 16:54:22.000000000 +0300
@@ -566,12 +566,6 @@
 	return $input;
 }
=20
=2D# very thin wrapper for decode("utf8", $str, Encode::FB_DEFAULT);
=2Dsub to_utf8 {
=2D	my $str =3D shift;
=2D	return decode("utf8", $str, Encode::FB_DEFAULT);
=2D}
=2D
 # quote unsafe chars, but keep the slash, even when it's not
 # correct, but quoted slashes look too horrible in bookmarks
 sub esc_param {
@@ -596,7 +590,7 @@
 	my $str =3D shift;
 	my %opts =3D @_;
=20
=2D	$str =3D to_utf8($str);
+	$str =3D decode_utf8($str);
 	$str =3D $cgi->escapeHTML($str);
 	if ($opts{'-nbsp'}) {
 		$str =3D~ s/ /&nbsp;/g;
@@ -610,7 +604,7 @@
 	my $str =3D shift;
 	my %opts =3D @_;
=20
=2D	$str =3D to_utf8($str);
+	$str =3D decode_utf8($str);
 	$str =3D $cgi->escapeHTML($str);
 	if ($opts{'-nbsp'}) {
 		$str =3D~ s/ /&nbsp;/g;
@@ -893,7 +887,7 @@
=20
 	if (length($short) < length($long)) {
 		return $cgi->a({-href =3D> $href, -class =3D> "list subject",
=2D		                -title =3D> to_utf8($long)},
+		                -title =3D> decode_utf8($long)},
 		       esc_html($short) . $extra);
 	} else {
 		return $cgi->a({-href =3D> $href, -class =3D> "list subject"},
@@ -1110,7 +1104,7 @@
 			if (check_export_ok("$projectroot/$path")) {
 				my $pr =3D {
 					path =3D> $path,
=2D					owner =3D> to_utf8($owner),
+					owner =3D> decode_utf8($owner),
 				};
 				push @list, $pr
 			}
@@ -1139,7 +1133,7 @@
 			$pr =3D unescape($pr);
 			$ow =3D unescape($ow);
 			if ($pr eq $project) {
=2D				$owner =3D to_utf8($ow);
+				$owner =3D decode_utf8($ow);
 				last;
 			}
 		}
@@ -1613,7 +1607,7 @@
 	}
 	my $owner =3D $gcos;
 	$owner =3D~ s/[,;].*$//;
=2D	return to_utf8($owner);
+	return decode_utf8($owner);
 }
=20
 ## ......................................................................
@@ -1696,7 +1690,7 @@
=20
 	my $title =3D "$site_name";
 	if (defined $project) {
=2D		$title .=3D " - " . to_utf8($project);
+		$title .=3D " - " . decode_utf8($project);
 		if (defined $action) {
 			$title .=3D "/$action";
 			if (defined $file_name) {
@@ -1969,7 +1963,7 @@
=20
 	print "<div class=3D\"page_path\">";
 	print $cgi->a({-href =3D> href(action=3D>"tree", hash_base=3D>$hb),
=2D	              -title =3D> 'tree root'}, to_utf8("[$project]"));
+	              -title =3D> 'tree root'}, decode_utf8("[$project]"));
 	print " / ";
 	if (defined $name) {
 		my @dirname =3D split '/', $name;
@@ -2584,7 +2578,7 @@
 		($pr->{'age'}, $pr->{'age_string'}) =3D @aa;
 		if (!defined $pr->{'descr'}) {
 			my $descr =3D git_get_project_description($pr->{'path'}) || "";
=2D			$pr->{'descr_long'} =3D to_utf8($descr);
+			$pr->{'descr_long'} =3D decode_utf8($descr);
 			$pr->{'descr'} =3D chop_str($descr, 25, 5);
 		}
 		if (!defined $pr->{'owner'}) {
@@ -3616,7 +3610,7 @@
 		$hash =3D git_get_head_hash($project);
 	}
=20
=2D	my $filename =3D to_utf8(basename($project)) . "-$hash.tar.$suffix";
+	my $filename =3D decode_utf8(basename($project)) . "-$hash.tar.$suffix";
=20
 	print $cgi->header(
 		-type =3D> "application/$ctype",

--Boundary-01=_b6gLG52LyGnqd/K--

--nextPart1510669.FJOZfySF7x
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)

iD8DBQBGLg6fGp0leluI9UwRAqVJAJ9AixrtEn/lyehOAv3HbZzACtw4jwCdGzrN
ZiyEAkttWWf/kEwUIbnlFbs=
=e8+J
-----END PGP SIGNATURE-----

--nextPart1510669.FJOZfySF7x--
