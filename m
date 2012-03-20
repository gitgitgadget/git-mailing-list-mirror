From: "W. Trevor King" <wking@drexel.edu>
Subject: [PATCH v2] Pull gitweb If-Modified-Since handling out into its own
 function and use for snapshots.
Date: Tue, 20 Mar 2012 12:40:56 -0400
Message-ID: <20120320164056.GA23093@odin.tremily.us>
References: <20120315075407.GA18246@odin.tremily.us>
 <m37gyf4hc3.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=6c2NcOVqGQ03X4Wi
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 17:41:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA27V-0008Hd-4L
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 17:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030791Ab2CTQlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 12:41:06 -0400
Received: from vms173017pub.verizon.net ([206.46.173.17]:45160 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab2CTQlE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 12:41:04 -0400
Received: from odin.tremily.us ([unknown] [72.68.85.198])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1600G4OZO87Q10@vms173017.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 20 Mar 2012 11:40:58 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 923D8426BB7; Tue,
 20 Mar 2012 12:40:56 -0400 (EDT)
Content-disposition: inline
In-reply-to: <m37gyf4hc3.fsf@localhost.localdomain>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193518>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The current gitweb only generates Last-Modified and handles                =
    =20
If-Modified-Since headers for the git_feed action.  This patch breaks      =
    =20
the Last-Modified and If-Modified-Since handling code out from             =
    =20
git_feed into a new function modified_since.  This makes the code easy     =
    =20
to reuse for other actions where it is appropriate and adds the code       =
    =20
to do that to git_snapshot.                                                =
    =20

Signed-off-by: W Trevor King <wking@drexel.edu>                            =
    =20
---
Thanks for the feedback, Jakub.  I believe I've addressed your points
in this revised patch.

Changed since v1:
- Fixed impersonal/personal commit message
- Simplified modified_since() -> die_if_unmodified().  Now it only
  takes a $latest_epoch argument and we set fewer headers.  It also
  jump straight to DONE_GITWEB if the page is unmodified.
- Ran tests (which passed this time).  Somehow I missed t/README
  earlier.

I'd add tests for my patch, but I'd have to have commit timestamps
=66rom the test repository, and I don't understand the test framework
well enough to know how to do that cleanly.

Things that haven't changed:

> > @@ -7038,9 +7071,11 @@ sub git_snapshot {
> >  	}
> > =20
> >  	$filename =3D~ s/(["\\])/\\$1/g;
> > +	my %latest_date =3D parse_date($co{'committer_epoch'}, $co{'committer=
_tz'});
> ...
> This simply has no way of working, as %co variable you use here is
> not defined anywhere in git_snapshot() subroutine.

I defined it earlier:

> > @@ -7029,6 +7054,14 @@ sub git_snapshot {
> >
> >   my ($name, $prefix) =3D snapshot_name($project, $hash);
> >   my $filename =3D "$name$known_snapshot_formats{$format}{'suffix'}";
> > +
> > + my %co =3D parse_commit($hash) or die_error(404, "Unknown commit obje=
ct");
> > + if (! modified_since($known_snapshot_formats{$format}{'type'},
> > +                      $co{'committer_epoch'},

While modified_since() (now die_if_unmodified()) handles the 304 case,
we also want to set Last-Modified for 200s.  That's what the latter
code is trying to do.

> What if there is no commit, for example if we are rewuesting snapshot
> of a tree by its SHA-1?  We need to be able to deal with sich
> situation, if only by not handling Last-Modified / If-Modified-Since.

The parse_commit() call should handle these cases.

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

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPaLMVAAoJEPe7CdOcrcTZARUIAI30q9Mi4GK4bbvJTBmnYRtV
jplZcDhlVhxP91eelvpLQ9AMVJFqT+kjPicno+qnzMgH/PNL3DXuX0K2fuSkK4pU
5FBDj2mSShxdR0OCjfJezNlY/E/ArHTbqE0jc6XZtiNwJHRGotMeAPFkmE0THPVD
ljsIfHMMK8n/mFCcREPegB9qzrPyR5no+ngmYrTo8Ra0qYNL6m461jXT36fEmMwv
osg+RX3mlEzX6QmAy/2vHs6CGLZttI4CkohqD+gWijVntQp/tjrtOmIA9i8sE1c5
toQn2PyaZrzDVNh5+ShL8GYSerUfE2yuPybPGWDXVZZoWYQtzn5m2DIs+IBgFpU=
=Bsr0
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
