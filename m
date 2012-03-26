From: "W. Trevor King" <wking@drexel.edu>
Subject: Re: [PATCH v5 3/3] gitweb: add If-Modified-Since handling to
 git_snapshot().
Date: Mon, 26 Mar 2012 15:14:19 -0400
Message-ID: <20120326191418.GB9041@odin.tremily.us>
References: <7vsjgvnr4x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=DKU6Jbt7q3WqK7+M
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 21:14:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCFNS-0001cN-St
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 21:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606Ab2CZTOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 15:14:46 -0400
Received: from vms173015pub.verizon.net ([206.46.173.15]:41692 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab2CZTOp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 15:14:45 -0400
Received: from odin.tremily.us ([unknown] [72.68.85.198])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1I00EVEAS1NM70@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 26 Mar 2012 14:14:36 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 090E042E94F; Mon,
 26 Mar 2012 15:14:19 -0400 (EDT)
Content-disposition: inline
In-reply-to: <7vsjgvnr4x.fsf@alter.siamese.dyndns.org>
 <20120326111300.GD2951@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193959>


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Because snapshots can be large, you can save some bandwidth by
supporting caching via If-Modified-Since.  This patch adds support for
the i-m-s request to git_snapshot() if the requested hash is a commit.
Requests for snapshots of tree-ishes, which lack well defined
timestamps, are still handled as they were before.

Signed-off-by: W Trevor King <wking@drexel.edu>
---
 gitweb/gitweb.perl                       |   21 +++++++++++++++---
 t/t9501-gitweb-standalone-http-status.sh |   33 ++++++++++++++++++++++++++=
++++
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 229f3da..be9ad5d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7051,6 +7051,10 @@ sub git_snapshot {
=20
 	my ($name, $prefix) =3D snapshot_name($project, $hash);
 	my $filename =3D "$name$known_snapshot_formats{$format}{'suffix'}";
+
+	my %co =3D parse_commit($hash);
+	exit_if_unmodified_since($co{'committer_epoch'}) if %co;
+
 	my $cmd =3D quote_command(
 		git_cmd(), 'archive',
 		"--format=3D$known_snapshot_formats{$format}{'format'}",
@@ -7060,10 +7064,19 @@ sub git_snapshot {
 	}
=20
 	$filename =3D~ s/(["\\])/\\$1/g;
-	print $cgi->header(
-		-type =3D> $known_snapshot_formats{$format}{'type'},
-		-content_disposition =3D> 'inline; filename=3D"' . $filename . '"',
-		-status =3D> '200 OK');
+	if (%co) {
+		my %latest_date =3D parse_date($co{'committer_epoch'}, $co{'committer_tz=
'});
+		print $cgi->header(
+			-type =3D> $known_snapshot_formats{$format}{'type'},
+			-content_disposition =3D> 'inline; filename=3D"' . $filename . '"',
+			-last_modified =3D> $latest_date{'rfc2822'},
+			-status =3D> '200 OK');
+	} else {
+		print $cgi->header(
+			-type =3D> $known_snapshot_formats{$format}{'type'},
+			-content_disposition =3D> 'inline; filename=3D"' . $filename . '"',
+			-status =3D> '200 OK');
+	}
=20
 	open my $fd, "-|", $cmd
 		or die_error(500, "Execute git-archive failed");
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-stan=
dalone-http-status.sh
index 0e49f29..38e90bd 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -138,6 +138,39 @@ test_expect_success 'modification: feed if-modified-si=
nce (unmodified)' '
 '
 test_debug 'cat gitweb.headers'
=20
+test_expect_success 'modification: snapshot last-modified' '
+	gitweb_run "p=3D.git;a=3Dsnapshot;h=3Dmaster;sf=3Dtgz" &&
+	grep "Status: 200 OK" gitweb.output &&
+	grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.output
+'
+test_debug 'cat gitweb.headers'
+
+test_expect_success 'modification: snapshot if-modified-since (modified)' '
+	export HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
+	gitweb_run "p=3D.git;a=3Dsnapshot;h=3Dmaster;sf=3Dtgz" &&
+	unset HTTP_IF_MODIFIED_SINCE &&
+	grep "Status: 200 OK" gitweb.output
+'
+test_debug 'cat gitweb.headers'
+
+test_expect_success 'modification: snapshot if-modified-since (unmodified)=
' '
+	export HTTP_IF_MODIFIED_SINCE=3D"Thu, 7 Apr 2005 22:14:13 +0000" &&
+	gitweb_run "p=3D.git;a=3Dsnapshot;h=3Dmaster;sf=3Dtgz" &&
+	unset HTTP_IF_MODIFIED_SINCE &&
+	grep "Status: 304 Not Modified" gitweb.output
+'
+test_debug 'cat gitweb.headers'
+
+test_expect_success 'modification: tree-ish snapshot' '
+	ID=3D`git rev-parse --verify HEAD^{tree}` &&
+	export HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
+	gitweb_run "p=3D.git;a=3Dsnapshot;h=3Dmaster;sf=3Dtgz" &&
+	unset HTTP_IF_MODIFIED_SINCE &&
+	grep "Status: 200 OK" gitweb.output &&
+	! grep "Last-Modified" gitweb.output
+'
+test_debug 'cat gitweb.headers'
+
 # ----------------------------------------------------------------------
 # load checking
=20
--=20
1.7.3.4

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPcMAJAAoJEPe7CdOcrcTZ5nYIAIeCU1DQOykZbCoPqulikN+e
ADjVO+CHCHGn9sMVSekqtrfpym/G1hM6BX+rDpffIabhAGvNBZlKpd7BPmHLOdo3
gDH12pa0YXJQIHn/dbqCW7HNAaA4Yw5sm5dt5pmzCJ/+xnfI/M+kFVRaO3s7LRN/
sFBFdFPlrEinmuYsbtS5Ic2wfMjpRAjlk57ORsGGHqnEMJBX79OTVN8A2Dge4dWB
zCc92N07L3gFsbuUWQCgqkIjxK97AhkUPwhb3nvfGDMP0kQdXeGgH9qAXw5s1Gpa
Z4RtHWK2bWyvNn6GRDi2n92m1DZai6p1qThVRQvLzdKKbtfpqSz3xzDLR3SmpNw=
=42I7
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
