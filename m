From: "W. Trevor King" <wking@drexel.edu>
Subject: [PATCH] Pull gitweb If-Modified-Since handling out into its own
 function and use for snapshots.
Date: Thu, 15 Mar 2012 03:54:07 -0400
Message-ID: <20120315075407.GA18246@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=gKMricLos+KVdGMg
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 15 08:54:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S85Vw-0005WX-Uh
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 08:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757249Ab2COHyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 03:54:20 -0400
Received: from vms173003pub.verizon.net ([206.46.173.3]:38946 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756940Ab2COHyT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 03:54:19 -0400
Received: from odin.tremily.us ([unknown] [72.68.85.198])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M0X00FHJ1Y8GB10@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 15 Mar 2012 02:54:08 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id CC09A41BCCD; Thu,
 15 Mar 2012 03:54:07 -0400 (EDT)
Content-disposition: inline
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193193>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The current gitweb only generates Last-Modified and handles
If-Modified-Since headers for the git_feed action.  This patch breaks
the Last-Modified and If-Modified-Since handling code out from
git_feed into a new function modified_since.  This makes the code easy
to reuse for other actions where it is appropriate, and I've added the
code to do that in git_snapshot.

Signed-off-by: W Trevor King <wking@drexel.edu>

---
 gitweb/gitweb.perl |   54 ++++++++++++++++++++++++++++++++++++------------=
---
 1 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a8b5fad..96a13e7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7003,6 +7003,31 @@ sub snapshot_name {
 	return wantarray ? ($name, $name) : $name;
 }
=20
+sub modified_since {
+	my ($content_type, $latest_epoch, $timezone) =3D @_;
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
+			my %latest_date =3D parse_date($latest_epoch, $timezone);
+			print $cgi->header(
+				-type =3D> $content_type,
+				-charset =3D> 'utf-8',
+				-last_modified =3D> $latest_date{'rfc2822'},
+				-status =3D> '304 Not Modified');
+			return 0;
+		}
+	}
+	return 1;
+}
+
 sub git_snapshot {
 	my $format =3D $input_params{'snapshot_format'};
 	if (!@snapshot_fmts) {
@@ -7029,6 +7054,14 @@ sub git_snapshot {
=20
 	my ($name, $prefix) =3D snapshot_name($project, $hash);
 	my $filename =3D "$name$known_snapshot_formats{$format}{'suffix'}";
+
+	my %co =3D parse_commit($hash) or die_error(404, "Unknown commit object");
+	if (! modified_since($known_snapshot_formats{$format}{'type'},
+	                     $co{'committer_epoch'},
+	                     $co{'committer_tz'})) {
+		return;
+	}
+
 	my $cmd =3D quote_command(
 		git_cmd(), 'archive',
 		"--format=3D$known_snapshot_formats{$format}{'format'}",
@@ -7038,9 +7071,11 @@ sub git_snapshot {
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
@@ -7821,22 +7856,9 @@ sub git_feed {
 		%latest_commit =3D %{$commitlist[0]};
 		my $latest_epoch =3D $latest_commit{'committer_epoch'};
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
+		if (! modified_since($content_type, $latest_epoch,
+		                     $latest_commit{'comitter_tz'})) {
+			return;
 		}
 		print $cgi->header(
 			-type =3D> $content_type,
--=20
1.7.3.4

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPYaAbAAoJEPe7CdOcrcTZTLQH/jvonAKtFxU+oqkIlrZcSG1X
A7yrW+4PM7zGDvhnCbbEMhwyv4573NpaYy1cXiYh12eWNKbXrw7oXaczLCfYA2cn
bu081zm/Zs1Ihq/K80+QZ5lEzaPI8ePQOdr0epm/+tthJ9uiNguP2SKYTMUDgyNE
eu0AIp3J5sTtfV4PFNrjjpzQkw0ouRPZLgjDaPklxG+V0vBEQh/ajn7kW9Ruv6FV
lxHH0ghe3y4eBTsjLd/tzPFn1YIicq6jB2eUpKeCVism5ZrM0GW5xXjH1wkHISIw
Ue2BlgnFUfCxg4ZTk6HmvJV5jed95Pni27PulJk63t0OqUdFA7zCgBT3aPwX1I8=
=1dbJ
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
