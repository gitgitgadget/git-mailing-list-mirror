From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH 5/8] gitweb: Format diff lines just before printing
Date: Fri, 10 Feb 2012 10:18:11 +0100
Message-ID: <1328865494-24415-6-git-send-email-michal.kiedrowicz@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 10:18:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvmcu-0005Y7-O6
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 10:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758878Ab2BJJSf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 04:18:35 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61683 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302Ab2BJJS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 04:18:28 -0500
Received: by mail-ey0-f174.google.com with SMTP id h12so852938eaa.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 01:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8LUBQHFRRaqRYNqCnfpn/xsYt+/JarI0JXA+faknkak=;
        b=dwN+sVv1bKM1Syx78cRAp5IKAr0CC/X4ViCT2GT3omW4UulCY29mflzgFiN0A2/Mz1
         8pF3H/UjoYaz8m8zmFe7Zk+26XOUu7Iuh2zsl/m3feexzCGP1B+F3zID8b4Ff1lOWWFc
         DEUJZPhk+5AI1hHua5VoxT/A5N1nCLaR6O+kk=
Received: by 10.213.15.145 with SMTP id k17mr230172eba.16.1328865507429;
        Fri, 10 Feb 2012 01:18:27 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id v51sm20013781eef.2.2012.02.10.01.18.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 01:18:27 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190390>

Now we're ready to insert highlightning to diff output.

The call to untabify() remains in the main loop in print_diff_chunk().
The motivation is that it must be called before any call to esc_html()
(because that converts spaces to &nbsp;) and to call it only once.

This is a refactoring patch.  It's not meant to change gitweb output.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 gitweb/gitweb.perl |   42 +++++++++++++++++++++++++++++++-----------
 1 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cae9dfa..db61553 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2319,13 +2319,22 @@ sub format_cc_diff_chunk_header {
 	return $line;
 }
=20
-# process patch (diff) line (not to be used for diff headers),
-# returning HTML-formatted (but not wrapped) line
+# wrap patch (diff) line into a <div> (not to be used for diff headers=
),
+# the line must be esc_html()'ed
 sub format_diff_line {
 	my ($line, $diff_class, $from, $to) =3D @_;
=20
-	chomp $line;
-	$line =3D untabify($line);
+	my $diff_classes =3D "diff";
+	$diff_classes .=3D " $diff_class" if ($diff_class);
+	$line =3D "<div class=3D\"$diff_classes\">$line</div>\n";
+
+	return $line;
+}
+
+# format diff chunk header line (not to be used for diff headers),
+# returning HTML-formatted line
+sub format_diff_chunk_header {
+	my ($line, $diff_class, $from, $to) =3D @_;
=20
 	if ($from && $to && $line =3D~ m/^\@{2} /) {
 		$line =3D format_unidiff_chunk_header($line, $from, $to);
@@ -2336,11 +2345,7 @@ sub format_diff_line {
 		$line =3D esc_html($line, -nbsp=3D>1);
 	}
=20
-	my $diff_classes =3D "diff";
-	$diff_classes .=3D " $diff_class" if ($diff_class);
-	$line =3D "<div class=3D\"$diff_classes\">$line</div>\n";
-
-	return $line;
+	return format_diff_line($line, $diff_class);
 }
=20
 # Generates undef or something like "_snapshot_" or "snapshot (_tbz2_ =
_zip_)",
@@ -4918,10 +4923,24 @@ sub print_inline_diff_lines {
 	print foreach (@$add);
 }
=20
+# HTML-format diff context, removed and added lines.
+sub format_ctx_rem_add_lines {
+	my ($ctx, $rem, $add) =3D @_;
+	my (@new_ctx, @new_rem, @new_add);
+
+	@new_ctx =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'ctx') =
} @$ctx;
+	@new_rem =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'rem') =
} @$rem;
+	@new_add =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'add') =
} @$add;
+
+	return (\@new_ctx, \@new_rem, \@new_add);
+}
+
 # Print context lines and then rem/add lines.
 sub print_diff_lines {
 	my ($ctx, $rem, $add, $diff_style, $is_combined) =3D @_;
=20
+	($ctx, $rem, $add) =3D format_ctx_rem_add_lines($ctx, $rem, $add);
+
 	if ($diff_style eq 'sidebyside' && !$is_combined) {
 		print_sidebyside_diff_lines($ctx, $rem, $add);
 	} else {
@@ -4951,11 +4970,12 @@ sub print_diff_chunk {
 	foreach my $line_info (@chunk) {
 		my ($class, $line) =3D @$line_info;
=20
-		$line =3D format_diff_line($line, $class, $from, $to);
+		$line =3D untabify($line);
=20
 		# print chunk headers
 		if ($class && $class eq 'chunk_header') {
-			print $line;
+			print format_diff_chunk_header($line, $class, $from,
+				$to);
 			next;
 		}
=20
--=20
1.7.3.4
