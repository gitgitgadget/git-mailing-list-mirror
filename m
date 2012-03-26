From: "W. Trevor King" <wking@drexel.edu>
Subject: [PATCH v4 2/3] gitweb: refactor If-Modified-Since handling
Date: Mon, 26 Mar 2012 07:12:03 -0400
Message-ID: <20120326111203.GC2951@odin.tremily.us>
References: <7v62dy4zhf.fsf@alter.siamese.dyndns.org>
 <m3sjh2ay6j.fsf@localhost.localdomain>
 <7v1uol3m5m.fsf@alter.siamese.dyndns.org>
 <201203221346.35295.jnareb@gmail.com> <20120326110943.GA2951@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 13:12:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SC7qc-0003qh-S3
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 13:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757412Ab2CZLMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 07:12:21 -0400
Received: from vms173015pub.verizon.net ([206.46.173.15]:38133 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757408Ab2CZLMU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 07:12:20 -0400
Received: from odin.tremily.us ([unknown] [72.68.85.198])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1H003UNOG4AB90@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 26 Mar 2012 06:12:05 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 0BEB642DC34; Mon,
 26 Mar 2012 07:12:03 -0400 (EDT)
Content-disposition: inline
In-reply-to: <20120326110943.GA2951@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193904>


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The current gitweb only generates Last-Modified and handles
If-Modified-Since headers for the git_feed action.  This patch breaks
the Last-Modified and If-Modified-Since handling code out from
git_feed into a new function die_if_unmodified.  This makes the code
easy to reuse for other actions.

Only gitweb actions which can easily calculate a modification time
should use die_if_unmodified, as the goal is to balance local
processing time vs. upload bandwidth.

Signed-off-by: W Trevor King <wking@drexel.edu>
---
 gitweb/gitweb.perl                       |   40 +++++++++++++++++---------=
---
 t/t9501-gitweb-standalone-http-status.sh |   27 +++++++++++++++++++-
 2 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 041da17..229f3da 100755
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
@@ -7820,24 +7842,8 @@ sub git_feed {
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
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-stan=
dalone-http-status.sh
index 31076ed..0e49f29 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -92,7 +92,7 @@ test_debug 'cat gitweb.output'
 test_expect_success 'snapshots: bad tree-ish id (tagged object)' '
 	echo object > tag-object &&
 	git add tag-object &&
-	git commit -m "Object to be tagged" &&
+	test_tick && git commit -m "Object to be tagged" &&
 	git tag tagged-object `git hash-object tag-object` &&
 	gitweb_run "p=3D.git;a=3Dsnapshot;h=3Dtagged-object;sf=3Dtgz" &&
 	grep "400 - Object is not a tree-ish" gitweb.output
@@ -112,6 +112,31 @@ test_expect_success 'snapshots: bad object id' '
 '
 test_debug 'cat gitweb.output'
=20
+# ----------------------------------------------------------------------
+# modification times (Last-Modified and If-Modified-Since)
+
+test_expect_success 'modification: feed last-modified' '
+	gitweb_run "p=3D.git;a=3Datom;h=3Dmaster" &&
+	grep "Status: 200 OK" gitweb.output
+	grep "Last-modified: Thu, 7 Apr 2005 22:14:13 +0000" gitweb.output
+'
+test_debug 'cat gitweb.headers'
+
+test_expect_success 'modification: feed if-modified-since (modified)' '
+	export HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
+	gitweb_run "p=3D.git;a=3Datom;h=3Dmaster" &&
+	unset HTTP_IF_MODIFIED_SINCE &&
+	grep "Status: 200 OK" gitweb.output
+'
+test_debug 'cat gitweb.headers'
+
+test_expect_success 'modification: feed if-modified-since (unmodified)' '
+	export HTTP_IF_MODIFIED_SINCE=3D"Thu, 7 Apr 2005 22:14:13 +0000" &&
+	gitweb_run "p=3D.git;a=3Datom;h=3Dmaster" &&
+	unset HTTP_IF_MODIFIED_SINCE &&
+	grep "Status: 304 Not Modified" gitweb.output
+'
+test_debug 'cat gitweb.headers'
=20
 # ----------------------------------------------------------------------
 # load checking
--=20
1.7.3.4

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPcE8CAAoJEPe7CdOcrcTZ9pYH/1L+d/UaiQlY/wFoIeSfp82q
XWCs2TYYHhyWOrhyOKfEg6rQ8jg8tMflo3V4cfzXviyqc12fhbRgw8Hx441TBJuO
ux9A+yRQNErGd8aoflHUduKbM7FbNQoVqpGEAOWSwdc1KAIn78hFn7Nkr2zHJi9c
DzeR4oO/dLebNNn0a7VhFBFJPias9DETaH+sN/GzrhshOrNK+CWYnlb83j4VEJxS
vjdDe6VsLYfWj5FYpXwP5O2Q/zX9TBqWHAq9yrOmFP8l1fmgkx4nYuaqtaTZmVDB
lgQM11D8nGLQUrtPFZcHr24xuu3ewXfjY/XYH9N0sbUfaX1Lxcr2fDWtwkSHlyA=
=6yw6
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
