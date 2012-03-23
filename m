From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v2 4/8] gitweb: Use print_diff_chunk() for both side-by-side and inline diffs
Date: Fri, 23 Mar 2012 23:56:53 +0100
Message-ID: <1332543417-19664-5-git-send-email-michal.kiedrowicz@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 23:57:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBDQL-0006K1-NA
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 23:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757291Ab2CWW5M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Mar 2012 18:57:12 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:44960 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539Ab2CWW5K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 18:57:10 -0400
Received: by wgbds11 with SMTP id ds11so1313135wgb.1
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 15:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TocRqX7CopiLc9/jo84jjGaiGPYLy1a5kfR63XAB/9A=;
        b=e8j4zioMs4kzgl3lV0BiapQtfJOVRB/2CmquIE64lvGClmirmiLve+YBSSjSSPydIp
         BKJex8poNV7Ek8ygvGYsHtgcvXuVINzQTXFMZac4lOAeHkOdOoz5d6t8ATGWvJ1K+TKF
         HVCoTdqlKqjAxAxtVvzbqq98PyfGoi7kZ7UWoagilSd+GMEMoGn4ciU59/zYAEm7AwA3
         oXtnksLDem8PTNYdIrhNDoXw+cSt5KC1FkfXywOpe2PaYJKbjuOfLlDKuOuPTLaEPh8y
         v5sON6UhMOPVMeR3RxKWKGGHUG4X2w2NeuBZO9PY9pTkiHXM5euwc5lWLIMYGyZxPoi6
         ERkg==
Received: by 10.216.133.151 with SMTP id q23mr8090106wei.14.1332543428663;
        Fri, 23 Mar 2012 15:57:08 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id bx13sm17626206wib.10.2012.03.23.15.57.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Mar 2012 15:57:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193807>

This renames print_sidebyside_diff_chunk() to print_diff_chunk() and
makes use of it for both side-by-side and inline diffs.  Now diff lines
are always accumulated before they are printed.  This opens the
possibility to preprocess diff output before it's printed, which is
needed for diff refinement highlightning (implemented in incoming
patches).

If left as is, the new function print_inline_diff_lines() could reorder
diff lines.  It first prints all context lines, then all removed lines
and finally all added lines.  If the diff output consisted of mixed add=
ed
and removed lines, gitweb would reorder these lines.  This is true for
combined diff output, for example:

	 - removed line for first parent
	 + added line for first parent
	  -removed line for second parent
	 ++added line for both parents

would be rendered as:

	- removed line for first parent
	 -removed line for second parent
	+ added line for first parent
	++added line for both parents

To prevent gitweb from reordering lines, print_diff_chunk() calls
print_diff_lines() as soon as it detects that both added and removed
lines are present and there was a class change.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 gitweb/gitweb.perl |   55 +++++++++++++++++++++++++++++++++++++-------=
-------
 1 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 86d5a02..1a2f258 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5045,10 +5045,34 @@ sub print_sidebyside_diff_lines {
 	}
 }
=20
-sub print_sidebyside_diff_chunk {
-	my @chunk =3D @_;
+# Print context lines and then rem/add lines in inline manner.
+sub print_inline_diff_lines {
+	my ($ctx, $rem, $add) =3D @_;
+
+	print foreach (@$ctx);
+	print foreach (@$rem);
+	print foreach (@$add);
+}
+
+# Print context lines and then rem/add lines.
+sub print_diff_lines {
+	my ($ctx, $rem, $add, $diff_style, $is_combined) =3D @_;
+
+	if ($diff_style eq 'sidebyside' && !$is_combined) {
+		print_sidebyside_diff_lines($ctx, $rem, $add);
+	} else {
+		# default 'inline' style and unknown styles
+		print_inline_diff_lines($ctx, $rem, $add);
+	}
+}
+
+sub print_diff_chunk {
+	my ($diff_style, $is_combined, @chunk) =3D @_;
 	my (@ctx, @rem, @add);
=20
+	# The class of the previous line.=20
+	my $prev_class =3D '';
+
 	return unless @chunk;
=20
 	# incomplete last line might be among removed or added lines,
@@ -5072,9 +5096,13 @@ sub print_sidebyside_diff_chunk {
 		}
=20
 		## print from accumulator when have some add/rem lines or end
-		# of chunk (flush context lines)
-		if (((@rem || @add) && $class eq 'ctx') || !$class) {
-			print_sidebyside_diff_lines(\@ctx, \@rem, \@add);
+		# of chunk (flush context lines), or when have add and rem
+		# lines and new block is reached (otherwise add/rem lines could
+		# be reordered)
+		if (((@rem || @add) && $class eq 'ctx') || !$class ||
+		    (@rem && @add && $class ne $prev_class)) {
+			print_diff_lines(\@ctx, \@rem, \@add, $diff_style,
+					$is_combined);
 			@ctx =3D @rem =3D @add =3D ();
 		}
=20
@@ -5091,6 +5119,8 @@ sub print_sidebyside_diff_chunk {
 		if ($class eq 'ctx') {
 			push @ctx, $line;
 		}
+
+		$prev_class =3D $class;
 	}
 }
=20
@@ -5217,22 +5247,17 @@ sub git_patchset_body {
 			$diff_classes .=3D " $class" if ($class);
 			$line =3D "<div class=3D\"$diff_classes\">$line</div>\n";
=20
-			if ($diff_style eq 'sidebyside' && !$is_combined) {
-				if ($class eq 'chunk_header') {
-					print_sidebyside_diff_chunk(@chunk);
-					@chunk =3D ( [ $class, $line ] );
-				} else {
-					push @chunk, [ $class, $line ];
-				}
+			if ($class eq 'chunk_header') {
+				print_diff_chunk($diff_style, $is_combined, @chunk);
+				@chunk =3D ( [ $class, $line ] );
 			} else {
-				# default 'inline' style and unknown styles
-				print $line;
+				push @chunk, [ $class, $line ];
 			}
 		}
=20
 	} continue {
 		if (@chunk) {
-			print_sidebyside_diff_chunk(@chunk);
+			print_diff_chunk($diff_style, $is_combined, @chunk);
 			@chunk =3D ();
 		}
 		print "</div>\n"; # class=3D"patch"
--=20
1.7.8.4
