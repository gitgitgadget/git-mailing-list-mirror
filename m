From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v3 5/8] gitweb: Use print_diff_chunk() for both side-by-side and inline diffs
Date: Wed,  4 Apr 2012 21:57:10 +0200
Message-ID: <1333569433-3245-6-git-send-email-michal.kiedrowicz@gmail.com>
References: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 21:57:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFWL1-0001rM-C6
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 21:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773Ab2DDT5i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 15:57:38 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:40072 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932624Ab2DDT5f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 15:57:35 -0400
Received: by wgbds11 with SMTP id ds11so800182wgb.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 12:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fIz8VNVGDXazZrSrv7d4pGxfyig1tx5XvFdYQmTxgWA=;
        b=uL5JkkphBvtVsNcyLHTiPLidKOaDqrb21hPAsRiM+jwu50+YKAIChXN5UmivWWPxlH
         alj5ZQCzwT+ohQ84fIt519WuHhDD6yfYj1efyc10nRXYl9mYg+qTZGXbHiSTR+ldSA7F
         dg7XPaTLtUO7izZoXI1Rs4q9bFS/bXRVmXYZUN6F8gV7Ltss2kdeYD8kshKh7m4dKhiu
         cz0/cQzDMey5PPEBYGRCDGXYAzfNt7E4Um+UOwyOZTxIJUBBRe8H+1JTw/8cP+RBONTG
         0dKFoA1jb1GmJ91V7qE5R77G0qmzFAClWK24tQShlljom1JtcVLxEbzIM9yZiX+9Q72d
         zgng==
Received: by 10.216.136.100 with SMTP id v78mr2202301wei.88.1333569453655;
        Wed, 04 Apr 2012 12:57:33 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id bx13sm7351244wib.10.2012.04.04.12.57.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 12:57:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194731>

This renames print_sidebyside_diff_chunk() to print_diff_chunk() and
makes use of it for both side-by-side and inline diffs.  Now diff lines
are always accumulated before they are printed.  This opens the
possibility to preprocess diff output before it's printed, which is
needed for diff refinement highlightning (implemented in incoming
patches).

If print_diff_chunk() was left as is, the new function
print_inline_diff_lines() could reorder diff lines.  It first prints al=
l
context lines, then all removed lines and finally all added lines.  If
the diff output consisted of mixed added and removed lines, gitweb woul=
d
reorder these lines.  This is true for combined diff output, for
example:

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
 gitweb/gitweb.perl |   55 ++++++++++++++++++++++++++++++++++++--------=
-------
 1 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 56721a3..4f6b043 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5047,10 +5047,32 @@ sub print_sidebyside_diff_lines {
 	}
 }
=20
-sub print_sidebyside_diff_chunk {
-	my @chunk =3D @_;
+# Print context lines and then rem/add lines in inline manner.
+sub print_inline_diff_lines {
+	my ($ctx, $rem, $add) =3D @_;
+
+	print @$ctx, @$rem, @$add;
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
@@ -5074,9 +5096,13 @@ sub print_sidebyside_diff_chunk {
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
+			print_diff_lines(\@ctx, \@rem, \@add,
+		                         $diff_style, $is_combined);
 			@ctx =3D @rem =3D @add =3D ();
 		}
=20
@@ -5093,6 +5119,8 @@ sub print_sidebyside_diff_chunk {
 		if ($class eq 'ctx') {
 			push @ctx, $line;
 		}
+
+		$prev_class =3D $class;
 	}
 }
=20
@@ -5219,22 +5247,17 @@ sub git_patchset_body {
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
-			} else {
-				# default 'inline' style and unknown styles
-				print $line;
+			if ($class eq 'chunk_header') {
+				print_diff_chunk($diff_style, $is_combined, @chunk);
+				@chunk =3D ();
 			}
+
+			push @chunk, [ $class, $line ];
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
