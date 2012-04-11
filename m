From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v4 6/8] gitweb: Push formatting diff lines to print_diff_chunk()
Date: Wed, 11 Apr 2012 23:18:42 +0200
Message-ID: <1334179124-14258-7-git-send-email-michal.kiedrowicz@gmail.com>
References: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, michal.kiedrowicz@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 11 23:19:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI4wi-0005Cb-IW
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933380Ab2DKVTL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 17:19:11 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43287 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933377Ab2DKVTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:19:09 -0400
Received: by mail-wi0-f172.google.com with SMTP id hj6so4824587wib.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MgBfP2uw7hs0D6wQqKcH2WEn/hDI9i9fm/UOWyBGn7o=;
        b=v6suxmbo7aTJ/fnTb14IWr9sMpTayCDcSOYPdJ28ciCSDBfq0ti9vm00JRElUxddX1
         eGEeLo4EmU8EiJn1yBkWFLVz+5s5E1jF5XBjO0RqEaH4UuCIl6pKvYAxr9IorxQpowqh
         MbL/Zd/p+2OxOuuyzySwP1mbnIWjhUdZtaImWMtqNKUlQUkqVMWbHHYTqtILgd27+UDk
         WoiJWyXSgBWFuJrENp3OvkPEj9lZVJNs0cOT4hbZ6J2tUSEsVlLEN+eV/D1+nsboFE83
         etFkD3/onkLsew8l6Ec9vx/TTHScW9j0WnIsoP9g5kzZ2mJzwhnP5yNCkb+MkKrTw2p2
         W1FQ==
Received: by 10.216.131.212 with SMTP id m62mr9656813wei.20.1334179148249;
        Wed, 11 Apr 2012 14:19:08 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id 6sm47595471wiz.1.2012.04.11.14.19.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 14:19:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195263>

Now lines are formatted closer to place where we actually use HTML
formatted output.

This means that we put raw lines in the @chunk accumulator, rather than
formatted lines.  Because we still need to know class (type) of line
when accumulating data to post-process and print, process_diff_line()
subroutine was retired and replaced by diff_line_class() used in
git_patchset_body() and new restructured format_diff_line() used in
print_diff_chunk().

As a side effect, we have to pass \%from and \%to down to callstack.

This is a preparation patch for diff refinement highlightning. It's not
meant to change gitweb output.

[jn: wrote commit message]

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   37 ++++++++++++++++++-------------------
 1 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 90836e6..390774e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2430,26 +2430,26 @@ sub format_cc_diff_chunk_header {
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
+	return $line;
 }
=20
 # Generates undef or something like "_snapshot_" or "snapshot (_tbz2_ =
_zip_)",
@@ -5068,7 +5068,7 @@ sub print_diff_lines {
 }
=20
 sub print_diff_chunk {
-	my ($diff_style, $is_combined, @chunk) =3D @_;
+	my ($diff_style, $is_combined, $from, $to, @chunk) =3D @_;
 	my (@ctx, @rem, @add);
=20
 	# The class of the previous line.
@@ -5090,6 +5090,8 @@ sub print_diff_chunk {
 	foreach my $line_info (@chunk) {
 		my ($class, $line) =3D @$line_info;
=20
+		$line =3D format_diff_line($line, $class, $from, $to);
+
 		# print chunk headers
 		if ($class && $class eq 'chunk_header') {
 			print $line;
@@ -5243,22 +5245,19 @@ sub git_patchset_body {
=20
 			next PATCH if ($patch_line =3D~ m/^diff /);
=20
-			my ($class, $line) =3D process_diff_line($patch_line, \%from, \%to)=
;
-			my $diff_classes =3D "diff";
-			$diff_classes .=3D " $class" if ($class);
-			$line =3D "<div class=3D\"$diff_classes\">$line</div>\n";
+			my $class =3D diff_line_class($patch_line, \%from, \%to);
=20
 			if ($class eq 'chunk_header') {
-				print_diff_chunk($diff_style, $is_combined, @chunk);
+				print_diff_chunk($diff_style, $is_combined, \%from, \%to, @chunk);
 				@chunk =3D ();
 			}
=20
-			push @chunk, [ $class, $line ];
+			push @chunk, [ $class, $patch_line ];
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
