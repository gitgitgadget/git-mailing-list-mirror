From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH 4/8] gitweb: Push formatting diff lines to print_diff_chunk()
Date: Fri, 10 Feb 2012 10:18:10 +0100
Message-ID: <1328865494-24415-5-git-send-email-michal.kiedrowicz@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 10:18:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvmck-0005Sy-2T
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 10:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758856Ab2BJJS2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 04:18:28 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61683 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758625Ab2BJJS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 04:18:26 -0500
Received: by mail-ey0-f174.google.com with SMTP id h12so852938eaa.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 01:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RQqxCgsuDbX/TjCY2IBWALR1S4e6rxJx8gOP78qY61Q=;
        b=tURZ89hGpHqkOK1iXlEl1hKXM24LdE0FmUBSqOZIHDT1gn0E6KY0E/dbtZ6tW4QDFP
         aMDmnMUIdV8LaO+HwewhU6eQP28GOsNvuHin4YOdLjC+PSc4W3wG2fWo8vQWC6aAk4lB
         Y46B+MxNuAR0WZQF8Ey4up4Tu2E1hDn+hNUlg=
Received: by 10.213.13.11 with SMTP id z11mr230244ebz.70.1328865505655;
        Fri, 10 Feb 2012 01:18:25 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id w60sm1729210eeb.4.2012.02.10.01.18.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 01:18:25 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190388>

Now git_patchset_body() only calls diff_line_class() (removed from
process_diff_line()). The latter function is renamed to
format_diff_line() and is called from print_diff_chunk().

This is a pure code movement, needed for processing raw diff lines in
the accumulator in print_diff_chunk(). No behavior change is intended b=
y
this change.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 gitweb/gitweb.perl |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d2f75c4..cae9dfa 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2320,12 +2320,9 @@ sub format_cc_diff_chunk_header {
 }
=20
 # process patch (diff) line (not to be used for diff headers),
-# returning class and HTML-formatted (but not wrapped) line
-sub process_diff_line {
-	my $line =3D shift;
-	my ($from, $to) =3D @_;
-
-	my $diff_class =3D diff_line_class($line, $from, $to);
+# returning HTML-formatted (but not wrapped) line
+sub format_diff_line {
+	my ($line, $diff_class, $from, $to) =3D @_;
=20
 	chomp $line;
 	$line =3D untabify($line);
@@ -2343,7 +2340,7 @@ sub process_diff_line {
 	$diff_classes .=3D " $diff_class" if ($diff_class);
 	$line =3D "<div class=3D\"$diff_classes\">$line</div>\n";
=20
-	return $diff_class, $line;
+	return $line;
 }
=20
 # Generates undef or something like "_snapshot_" or "snapshot (_tbz2_ =
_zip_)",
@@ -4934,7 +4931,7 @@ sub print_diff_lines {
 }
=20
 sub print_diff_chunk {
-	my ($diff_style, $is_combined, @chunk) =3D @_;
+	my ($diff_style, $is_combined, $from, $to, @chunk) =3D @_;
 	my (@ctx, @rem, @add);
 	my $prev_class =3D '';
=20
@@ -4954,6 +4951,8 @@ sub print_diff_chunk {
 	foreach my $line_info (@chunk) {
 		my ($class, $line) =3D @$line_info;
=20
+		$line =3D format_diff_line($line, $class, $from, $to);
+
 		# print chunk headers
 		if ($class && $class eq 'chunk_header') {
 			print $line;
@@ -5107,19 +5106,19 @@ sub git_patchset_body {
=20
 			next PATCH if ($patch_line =3D~ m/^diff /);
=20
-			my ($class, $line) =3D process_diff_line($patch_line, \%from, \%to)=
;
+			my $class =3D diff_line_class($patch_line, \%from, \%to);
=20
 			if ($class eq 'chunk_header') {
-				print_diff_chunk($diff_style, $is_combined, @chunk);
-				@chunk =3D ( [ $class, $line ] );
+				print_diff_chunk($diff_style, $is_combined, \%from, \%to, @chunk);
+				@chunk =3D ( [ $class, $patch_line ] );
 			} else {
-				push @chunk, [ $class, $line ];
+				push @chunk, [ $class, $patch_line ];
 			}
 		}
=20
 	} continue {
 		if (@chunk) {
-			print_diff_chunk($diff_style, $is_combined, @chunk);
+			print_diff_chunk($diff_style, $is_combined, \%from, \%to, @chunk);
 			@chunk =3D ();
 		}
 		print "</div>\n"; # class=3D"patch"
--=20
1.7.3.4
