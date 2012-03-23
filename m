From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v2 6/8] gitweb: Push formatting diff lines to print_diff_chunk()
Date: Fri, 23 Mar 2012 23:56:55 +0100
Message-ID: <1332543417-19664-7-git-send-email-michal.kiedrowicz@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 23:57:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBDQO-0006K1-Gg
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 23:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757369Ab2CWW5a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Mar 2012 18:57:30 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:34174 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286Ab2CWW5M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 18:57:12 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so2998508wej.19
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 15:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PmTzyG/FxCaNSHtdMS5MKt/lC66fNymPg0vZ2iMOf0M=;
        b=ytdiG1mEDBj4sMqUrl1+CFh7Ro043TtgGTOeLtdIY84Q+oyUXXCXIK+PDWLG9pUShE
         c45IDtGf79rARbqQVk0OReaoy04jj6fh1DyaKGKyLF8aicKMFwxndtlSSsg1NXJ2OmPe
         wZzU+uzW8Cizh5ln9ZRPMKMzsRc4MTv6aVi0SoNAUSDzkWeOX05mdNjkd/OIbOt1ssvl
         rArNpnL5AvXJY8Va2HfCYzYq0bT3f23DGs50BVI+KODIFTHi7MF2XXHEJeA4QbWQeLGs
         PAHzv2niyS9Yb1CybXyXP3x/NWQV7esXTBUbZY8u9U6Dv14iPYM7btz+EAxSiCpzfW5D
         smxw==
Received: by 10.180.78.225 with SMTP id e1mr798337wix.0.1332543432316;
        Fri, 23 Mar 2012 15:57:12 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id gd4sm16379269wib.6.2012.03.23.15.57.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Mar 2012 15:57:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193812>

Now git_patchset_body() only calls diff_line_class(), which is removed
from process_diff_line(). The latter function is renamed to
format_diff_line() and its output is changed to return only
HTML-formatted line, which brings it in line with outher format_*
subroutined.

This slightly changes the order of operations performed on diff lines.
Before this commit, each read line was formatted and then put to the
@chunk accumulator. Now, lines are formatted inside print_diff_chunk(),

This is a preparation patch for diff refinement highlightning. It's not
meant to change gitweb output.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index aacf518..db32588 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2426,12 +2426,9 @@ sub format_cc_diff_chunk_header {
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
@@ -2448,7 +2445,7 @@ sub process_diff_line {
 	$diff_classes .=3D " $diff_class" if ($diff_class);
 	$line =3D "<div class=3D\"$diff_classes\">$line</div>\n";
=20
-	return $diff_class, $line;
+	return $line;
 }
=20
 # Generates undef or something like "_snapshot_" or "snapshot (_tbz2_ =
_zip_)",
@@ -5070,7 +5067,7 @@ sub print_diff_lines {
 }
=20
 sub print_diff_chunk {
-	my ($diff_style, $is_combined, @chunk) =3D @_;
+	my ($diff_style, $is_combined, $from, $to, @chunk) =3D @_;
 	my (@ctx, @rem, @add);
=20
 	# The class of the previous line.=20
@@ -5092,6 +5089,8 @@ sub print_diff_chunk {
 	foreach my $line_info (@chunk) {
 		my ($class, $line) =3D @$line_info;
=20
+		$line =3D format_diff_line($line, $class, $from, $to);
+
 		# print chunk headers
 		if ($class && $class eq 'chunk_header') {
 			print $line;
@@ -5245,19 +5244,19 @@ sub git_patchset_body {
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
1.7.8.4
