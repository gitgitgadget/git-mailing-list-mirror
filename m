From: "W. Trevor King" <wking@drexel.edu>
Subject: [PATCH v3] Isolate If-Modified-Since handling in gitweb
Date: Wed, 21 Mar 2012 08:11:27 -0400
Message-ID: <20120321121126.GA27660@odin.tremily.us>
References: <7v62dy4zhf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=h31gzZEtNLTqOjlF
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 13:35:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAKlM-000820-Oe
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 13:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757605Ab2CUMfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 08:35:32 -0400
Received: from vms173011pub.verizon.net ([206.46.173.11]:34213 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757587Ab2CUMfa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 08:35:30 -0400
Received: from odin.tremily.us ([unknown] [72.68.85.198])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1800MEPHV3GT10@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 21 Mar 2012 07:11:28 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 928254275C2; Wed,
 21 Mar 2012 08:11:27 -0400 (EDT)
Content-disposition: inline
In-reply-to: <7v62dy4zhf.fsf@alter.siamese.dyndns.org>
 <20120320164056.GA23093@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193573>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The current gitweb only generates Last-Modified and handles
If-Modified-Since headers for the git_feed action.  This patch breaks
the Last-Modified and If-Modified-Since handling code out from
git_feed into a new function die_if_unmodified.  This makes the code
easy to reuse for other actions where it is appropriate and adds the
code to do that to git_snapshot.

Signed-off-by: W Trevor King <wking@drexel.edu>                            =
    =20
---
Changed since v2:
  - Shorter title.
  - Fixed modified_since -> die_if_unmodified in commit message.

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a8b5fad..b944351 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7003,6 +7003,28 @@ sub snapshot_name {
 	return wantarray ? ($name, $name) : $name;
 }
=20
+sub die_if_unmodified {
+	my ($latest_epoch) =3D @_;
+	our $cgi;
+
+	my $if_modified =3D $cgi->http('IF_MODIFIED_SINCE');
+	if (defined $if_modified) {
+		my $since;
+		if (eval { require HTTP::Date; 1; }) {
+			$since =3D HTTP::Date::str2time($if_modified);
+		} elsif (eval { require Time::ParseDate; 1; }) {
+			$since =3D Time::ParseDate::parsedate($if_modified, GMT =3D> 1);
+		}
+		if (defined $since && $latest_epoch <=3D $since) {
+			my %latest_date =3D parse_date($latest_epoch);
+			print $cgi->header(
+				-last_modified =3D> $latest_date{'rfc2822'},
+				-status =3D> '304 Not Modified');
+			goto DONE_GITWEB;
+		}
+	}
+}
+
 sub git_snapshot {
 	my $format =3D $input_params{'snapshot_format'};
 	if (!@snapshot_fmts) {
@@ -7029,6 +7051,10 @@ sub git_snapshot {
=20
 	my ($name, $prefix) =3D snapshot_name($project, $hash);
 	my $filename =3D "$name$known_snapshot_formats{$format}{'suffix'}";
+
+	my %co =3D parse_commit($hash) or die_error(404, "Unknown commit object");
+	die_if_unmodified($co{'committer_epoch'});
+
 	my $cmd =3D quote_command(
 		git_cmd(), 'archive',
 		"--format=3D$known_snapshot_formats{$format}{'format'}",
@@ -7038,9 +7064,11 @@ sub git_snapshot {
 	}
=20
 	$filename =3D~ s/(["\\])/\\$1/g;
+	my %latest_date =3D parse_date($co{'committer_epoch'}, $co{'committer_tz'=
});
 	print $cgi->header(
 		-type =3D> $known_snapshot_formats{$format}{'type'},
 		-content_disposition =3D> 'inline; filename=3D"' . $filename . '"',
+		-last_modified =3D> $latest_date{'rfc2822'},
 		-status =3D> '200 OK');
=20
 	open my $fd, "-|", $cmd
@@ -7820,24 +7848,8 @@ sub git_feed {
 	if (defined($commitlist[0])) {
 		%latest_commit =3D %{$commitlist[0]};
 		my $latest_epoch =3D $latest_commit{'committer_epoch'};
+		die_if_unmodified($latest_epoch);
 		%latest_date   =3D parse_date($latest_epoch, $latest_commit{'comitter_tz=
'});
-		my $if_modified =3D $cgi->http('IF_MODIFIED_SINCE');
-		if (defined $if_modified) {
-			my $since;
-			if (eval { require HTTP::Date; 1; }) {
-				$since =3D HTTP::Date::str2time($if_modified);
-			} elsif (eval { require Time::ParseDate; 1; }) {
-				$since =3D Time::ParseDate::parsedate($if_modified, GMT =3D> 1);
-			}
-			if (defined $since && $latest_epoch <=3D $since) {
-				print $cgi->header(
-					-type =3D> $content_type,
-					-charset =3D> 'utf-8',
-					-last_modified =3D> $latest_date{'rfc2822'},
-					-status =3D> '304 Not Modified');
-				return;
-			}
-		}
 		print $cgi->header(
 			-type =3D> $content_type,
 			-charset =3D> 'utf-8',
--                                                                         =
    =20
1.7.3.4                                                                    =
    =20

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPacVtAAoJEPe7CdOcrcTZm8MIAJFHNLU0ZNjTS7BC4NH9r6wx
Ik94+LCI0dPVirG1oH72y2PnFqhfXXLc6yk2fEpVSup0mEzc7eRUlfdiC0InMUhe
12o+9uGhIEPIV+iss/XLzOzhPrzkGFoRKpNFF/ATZ1hjrc4jn1cntMYBdRK8k22e
RCMQfKYkr1e98nGU2n3IKxpirkEmOBGjOSHYJCTaqD62ujYVFjmLVU+PytJ5ev96
hEtyDe7Dpco9xRgD7pkS1J0LhbkzwHL7+FMDwHRYY4dkRjGoFqN/ZCj4U5P5sBT1
v5w7lKNO6qQJyJtqcUaunPb82urkie+OkXslEvKQPPO8EXTYhATbbSk6G7zga+M=
=Mu3W
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
