From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH] git-svn: Remove unnecessary Git::SVN::Util package
Date: Thu, 22 Nov 2007 11:18:00 -0800
Message-ID: <1195759080-20132-1-git-send-email-ddkilzer@kilzer.net>
References: <2CB65B86-3BEF-46C2-86F8-EFAB2AE6D353@develooper.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "David D. Kilzer" <ddkilzer@kilzer.net>
To: ask@develooper.com, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:18:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvHZB-0002wj-1R
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 20:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbXKVTSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 14:18:06 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbXKVTSF
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 14:18:05 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:51344 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbXKVTSE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 14:18:04 -0500
Received: from relay12.apple.com (relay12.apple.com [17.128.113.53])
	by mail-out4.apple.com (Postfix) with ESMTP id C85DC19E80AA;
	Thu, 22 Nov 2007 11:18:02 -0800 (PST)
Received: from relay12.apple.com (unknown [127.0.0.1])
	by relay12.apple.com (Symantec Mail Security) with ESMTP id AF1352804E;
	Thu, 22 Nov 2007 11:18:02 -0800 (PST)
X-AuditID: 11807135-a9102bb00000088f-90-4745d5ea073f
Received: from localhost.localdomain (unknown [17.151.110.200])
	by relay12.apple.com (Apple SCV relay) with ESMTP id 636072804C;
	Thu, 22 Nov 2007 11:18:02 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <2CB65B86-3BEF-46C2-86F8-EFAB2AE6D353@develooper.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65836>

Digest::MD5 is loaded regardless of the package in which it's
declared, so move its 'use' statement and the md5sum() function
into the main package.

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---

Ask Bj=C3=B8rn Hansen <ask@develooper.com> wrote:
> On Nov 21, 2007, at 11:57, David D. Kilzer wrote:
> > Created new Git::SVN::Util package with an md5sum() function.  A
> > new package was created so that Digest::MD5 did not have to be
> > loaded in the main package.
> Huh?  It's all in the same file anyway, so what difference does it
> make?

None!

 git-svn.perl |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 62801c8..17d3020 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -35,6 +35,7 @@ push @Git::SVN::Ra::ISA, 'SVN::Ra';
 push @SVN::Git::Editor::ISA, 'SVN::Delta::Editor';
 push @SVN::Git::Fetcher::ISA, 'SVN::Delta::Editor';
 use Carp qw/croak/;
+use Digest::MD5;
 use IO::File qw//;
 use File::Basename qw/dirname basename/;
 use File::Path qw/mkpath/;
@@ -48,8 +49,7 @@ BEGIN {
 	foreach (qw/command command_oneline command_noisy command_output_pipe
 	            command_input_pipe command_close_pipe/) {
 		for my $package ( qw(SVN::Git::Editor SVN::Git::Fetcher
-			Git::SVN::Migration Git::SVN::Log Git::SVN
-			Git::SVN::Util),
+			Git::SVN::Migration Git::SVN::Log Git::SVN),
 			__PACKAGE__) {
 			*{"${package}::$_"} =3D \&{"Git::$_"};
 		}
@@ -835,19 +835,19 @@ sub cmd_info {
 			    command_output_pipe(qw(cat-file blob), "HEAD:$path");
 			if ($file_type eq "link") {
 				my $file_name =3D <$fh>;
-				$checksum =3D Git::SVN::Util::md5sum("link $file_name");
+				$checksum =3D md5sum("link $file_name");
 			} else {
-				$checksum =3D Git::SVN::Util::md5sum($fh);
+				$checksum =3D md5sum($fh);
 			}
 			command_close_pipe($fh, $ctx);
 		} elsif ($file_type eq "link") {
 			my $file_name =3D
 			    command(qw(cat-file blob), "HEAD:$path");
 			$checksum =3D
-			    Git::SVN::Util::md5sum("link " . $file_name);
+			    md5sum("link " . $file_name);
 		} else {
 			open FILE, "<", $path or die $!;
-			$checksum =3D Git::SVN::Util::md5sum(\*FILE);
+			$checksum =3D md5sum(\*FILE);
 			close FILE or die $!;
 		}
 		$result .=3D "Checksum: " . $checksum . "\n";
@@ -1187,11 +1187,6 @@ sub find_file_type_and_diff_status {
 	return ("file", $diff_status);
 }
=20
-package Git::SVN::Util;
-use strict;
-use warnings;
-use Digest::MD5;
-
 sub md5sum {
 	my $arg =3D shift;
 	my $ref =3D ref $arg;
@@ -2926,7 +2921,7 @@ sub apply_textdelta {
=20
 		if (defined $exp) {
 			seek $base, 0, 0 or croak $!;
-			my $got =3D Git::SVN::Util::md5sum($base);
+			my $got =3D ::md5sum($base);
 			die "Checksum mismatch: $fb->{path} $fb->{blob}\n",
 			    "expected: $exp\n",
 			    "     got: $got\n" if ($got ne $exp);
@@ -2945,7 +2940,7 @@ sub close_file {
 	if (my $fh =3D $fb->{fh}) {
 		if (defined $exp) {
 			seek($fh, 0, 0) or croak $!;
-			my $got =3D Git::SVN::Util::md5sum($fh);
+			my $got =3D ::md5sum($fh);
 			if ($got ne $exp) {
 				die "Checksum mismatch: $path\n",
 				    "expected: $exp\n    got: $got\n";
@@ -3300,7 +3295,7 @@ sub chg_file {
 	$fh->flush =3D=3D 0 or croak $!;
 	seek $fh, 0, 0 or croak $!;
=20
-	my $exp =3D Git::SVN::Util::md5sum($fh);
+	my $exp =3D ::md5sum($fh);
 	seek $fh, 0, 0 or croak $!;
=20
 	my $pool =3D SVN::Pool->new;
--=20
1.5.3.4
