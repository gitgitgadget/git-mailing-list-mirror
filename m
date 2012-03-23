From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v2 5/8] gitweb: Move HTML-formatting diff line back to process_diff_line()
Date: Fri, 23 Mar 2012 23:56:54 +0100
Message-ID: <1332543417-19664-6-git-send-email-michal.kiedrowicz@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 23:57:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBDQM-0006K1-8x
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 23:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757313Ab2CWW5N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Mar 2012 18:57:13 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41012 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757267Ab2CWW5L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 18:57:11 -0400
Received: by mail-wi0-f178.google.com with SMTP id hq7so2508665wib.1
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 15:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RPqT8Y8F+DldP+VGOeqmZ99MEvTKmkxt9HUKxc5xeSI=;
        b=NyOb1YvV3llSKC01Wo0us4s5TXgXdjGR1JoldzivGQEv6+c68zDuSZsWJRwtmdcvAX
         s63dEgUO9cKA2mUcil8I/7dlD4R/COkL9r/tKDsG3Fina24cQcXHtLqIajbCISNlRAGv
         F7enXIIf5ZpqlzxZEwX2udybIlvaXFDX0x8zc3j6zpjACBvlQftgPq+zqmh6yvyRO1Sx
         Eg/yl1Qtasj0ry3lRrhkNyu17ZA+zcyavvQ+TjtEdBiUNOKdZ9sj1wEsZA364FQDVJ2L
         q4MlsJZTX9eIQp5bF1vytySGzVUaRELHuWrzKxh/LJ8AO50QRjXswgtQejnxZ4c8mmWu
         T5XA==
Received: by 10.180.95.197 with SMTP id dm5mr680692wib.20.1332543430537;
        Fri, 23 Mar 2012 15:57:10 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id e6sm17634557wix.8.2012.03.23.15.57.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Mar 2012 15:57:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193808>

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
Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1a2f258..aacf518 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2438,14 +2438,17 @@ sub process_diff_line {
=20
 	if ($from && $to && $line =3D~ m/^\@{2} /) {
 		$line =3D format_unidiff_chunk_header($line, $from, $to);
-		return $diff_class, $line;
-
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
@@ -5243,9 +5246,6 @@ sub git_patchset_body {
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
1.7.8.4
