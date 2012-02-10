From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH 2/8] gitweb: Use print_diff_chunk() for both side-by-side and inline diffs
Date: Fri, 10 Feb 2012 10:18:08 +0100
Message-ID: <1328865494-24415-3-git-send-email-michal.kiedrowicz@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 10:18:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvmd9-0005f5-18
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 10:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758678Ab2BJJSZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 04:18:25 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61683 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758625Ab2BJJSX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 04:18:23 -0500
Received: by eaah12 with SMTP id h12so852938eaa.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 01:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vFPWV1tCazpUME0pyZH09TURuK5ovazkYD1DWl8NiQk=;
        b=mIlM/uS+uo88rptAgDVeFYbHO1GwGcKah4JdEfjS4KNid6PEOG6RbKxixGS+w4yYu8
         YmhFf+Xuylzr6XaCrWepymGebbvBhyHk1VcOxFvl0bkXvAQfSmxPh0cFpA+AzDiyhbu3
         K+glW4Hc69cTBu6q13tkq5espEJybLO9Ld6hI=
Received: by 10.14.149.20 with SMTP id w20mr1735882eej.64.1328865502062;
        Fri, 10 Feb 2012 01:18:22 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id n58sm19925975een.10.2012.02.10.01.18.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 01:18:21 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190391>

This renames print_sidebyside_diff_chunk() to print_diff_chunk() and
makes use of it for both side-by-side and inline diffs. Now diff lines
are always accumulated before they are printed. This opens the
possibility to preprocess diff output before it's printed.

The new function print_inline_diff_lines() could reorder diff lines.  I=
t
first prints all context lines, then all removed lines and finally all
added lines. If the diff output consisted of mixed added and removed
lines, gitweb would reorder these lines. This is especially true for
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
 gitweb/gitweb.perl |   53 +++++++++++++++++++++++++++++++++++++-------=
-------
 1 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1247607..ed63261 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4908,9 +4908,31 @@ sub print_sidebyside_diff_lines {
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
+	my $prev_class =3D '';
=20
 	return unless @chunk;
=20
@@ -4935,9 +4957,13 @@ sub print_sidebyside_diff_chunk {
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
+				(@rem && @add && $class ne $prev_class)) {
+			print_diff_lines(\@ctx, \@rem, \@add, $diff_style,
+					$is_combined);
 			@ctx =3D @rem =3D @add =3D ();
 		}
=20
@@ -4954,6 +4980,8 @@ sub print_sidebyside_diff_chunk {
 		if ($class eq 'ctx') {
 			push @ctx, $line;
 		}
+
+		$prev_class =3D $class;
 	}
 }
=20
@@ -5080,22 +5108,17 @@ sub git_patchset_body {
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
1.7.3.4
