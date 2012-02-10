From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH 3/8] gitweb: Move HTML-formatting diff line back to process_diff_line()
Date: Fri, 10 Feb 2012 10:18:09 +0100
Message-ID: <1328865494-24415-4-git-send-email-michal.kiedrowicz@gmail.com>
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
	id 1Rvmcj-0005Sy-GT
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 10:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758737Ab2BJJS0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 04:18:26 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42215 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302Ab2BJJSY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 04:18:24 -0500
Received: by mail-ee0-f46.google.com with SMTP id c14so882729eek.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 01:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9kBgv9qHF91/TBcD2xUtCbqSnXl7sJw7SlT/xeOmhnM=;
        b=f5P+vnOdj3OEbdOCRQSPjjzUt6oe4Fm2/L6nlXIEHPfN0RvY72gT+8gUDzzBbVp3/3
         Xy6Q2Tc0REi4OQBOvCR+plqWnEZY61O9BEm3c3rnNcSc22inwnAk8Bx6liira3hVD4M0
         edq8qzw2wD8+8r99cluK5RaN2YFZtuKaUHkXk=
Received: by 10.14.39.207 with SMTP id d55mr1787895eeb.36.1328865503896;
        Fri, 10 Feb 2012 01:18:23 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id o49sm19959969eeb.7.2012.02.10.01.18.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 01:18:23 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190387>

Commit 6ba1eb51b (gitweb: Add a feature to show side-by-side diff,
2011-10-31) for no special reason moved wrapping diff line in <div> out
of format_diff_line(). Bring back old behavior.

This simplifies code in git_patchset_body() and keeps formatting of a
diff line in one place.

The more long-term purpose of this patch is to move formatting diff
lines down to print_diff_chunk(), to allow processing lines without
HTML-formatting.

This is just a refactoring patch. It's not meant to change gitweb
output.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 gitweb/gitweb.perl |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ed63261..d2f75c4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2332,14 +2332,18 @@ sub process_diff_line {
=20
 	if ($from && $to && $line =3D~ m/^\@{2} /) {
 		$line =3D format_unidiff_chunk_header($line, $from, $to);
-		return $diff_class, $line;
=20
 	} elsif ($from && $to && $line =3D~ m/^\@{3}/) {
 		$line =3D format_cc_diff_chunk_header($line, $from, $to);
-		return $diff_class, $line;
-
+	} else {
+		$line =3D esc_html($line, -nbsp=3D>1);
 	}
-	return $diff_class, esc_html($line, -nbsp=3D>1);
+
+	my $diff_classes =3D "diff";
+	$diff_classes .=3D " $diff_class" if ($diff_class);
+	$line =3D "<div class=3D\"$diff_classes\">$line</div>\n";
+
+	return $diff_class, $line;
 }
=20
 # Generates undef or something like "_snapshot_" or "snapshot (_tbz2_ =
_zip_)",
@@ -5104,9 +5108,6 @@ sub git_patchset_body {
 			next PATCH if ($patch_line =3D~ m/^diff /);
=20
 			my ($class, $line) =3D process_diff_line($patch_line, \%from, \%to)=
;
-			my $diff_classes =3D "diff";
-			$diff_classes .=3D " $class" if ($class);
-			$line =3D "<div class=3D\"$diff_classes\">$line</div>\n";
=20
 			if ($class eq 'chunk_header') {
 				print_diff_chunk($diff_style, $is_combined, @chunk);
--=20
1.7.3.4
