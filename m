From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v3 8/8] gitweb: Refinement highlightning in combined diffs
Date: Wed,  4 Apr 2012 21:57:13 +0200
Message-ID: <1333569433-3245-9-git-send-email-michal.kiedrowicz@gmail.com>
References: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 21:57:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFWL3-0001rM-1X
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 21:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932805Ab2DDT5q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 15:57:46 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:53202 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932770Ab2DDT5o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 15:57:44 -0400
Received: by mail-wi0-f178.google.com with SMTP id hq7so630903wib.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 12:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IxD8fgreXkM3u/tWvtXhT1dKJcn+ugv5Gouji96ngwE=;
        b=kZpAGmPbfMAzShOvRwKTHc/oiVLXklsWagD2VOjDWfQJ9LDQmoiajgJpg0+SKCgQ5m
         drxHMgkvcSviEPDkzwqVBfVJ4oGFu1KawFIbp/UcqACaWdPZVGSj7AsVmHv4jrFOFsTA
         xl29n+FH8R+3WRDaQ8HA73GYOXnQXYc9TAdJXAv+t0/DBTyj5BZnO+jY91SxB8923bGR
         jHndfWXnOLMRMRFnV+5rw9kiHBfP9fkQrhvZ8w4WKXHWHmhZm7CtiPta/47hGZDIio+X
         wZxzloLMI94kP9ajXPQg7fo1YZW7RYAon+Xil4X2EBDk+HfCORc6GVlmM3oF10dNH+yZ
         FZSQ==
Received: by 10.216.131.154 with SMTP id m26mr2109518wei.91.1333569463575;
        Wed, 04 Apr 2012 12:57:43 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id k6sm7360397wiy.7.2012.04.04.12.57.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 12:57:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194732>

The highlightning of combined diffs is currently disabled.  This is
because output from a combined diff is much harder to highlight because
it is not obvious which removed and added lines should be compared.

Current code requires that the number of added lines is equal to the
number of removed lines and only skips first +/- character, treating
second +/- as a line content, Thus, it is not possible to simply use
existing algorithm unchanged for combined diffs.

Let's start with a simple case: only highlight changes that come from
one parent, i.e. when every removed line has a corresponding added line
for the same parent.  This way the highlightning cannot get wrong. For
example, following diffs would be highlighted:

	- removed line for first parent
	+ added line for first parent
	  context line
	 -removed line for second parent
	 +added line for second parent

or

	- removed line for first parent
	 -removed line for second parent
	+ added line for first parent
	 +added line for second parent

but following output will not:

	- removed line for first parent
	 -removed line for second parent
	 +added line for second parent
	++added line for both parents

In other words, we require that pattern of '-'-es in pre-image matches
pattern of '+'-es in post-image.

=46urther changes may introduce more intelligent approach that better
handles combined diffs.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   55 +++++++++++++++++++++++++++++++++++++++-----=
-------
 1 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 579592a..e66aa84 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5063,7 +5063,7 @@ sub print_inline_diff_lines {
 # Format removed and added line, mark changed part and HTML-format the=
m.
 # Implementation is based on contrib/diff-highlight
 sub format_rem_add_lines_pair {
-	my ($rem, $add) =3D @_;
+	my ($rem, $add, $num_parents) =3D @_;
=20
 	# We need to untabify lines before split()'ing them;
 	# otherwise offsets would be invalid.
@@ -5074,8 +5074,8 @@ sub format_rem_add_lines_pair {
 	my @rem =3D split(//, $rem);
 	my @add =3D split(//, $add);
 	my ($esc_rem, $esc_add);
-	# Ignore +/- character, thus $prefix_len is set to 1.
-	my ($prefix_len, $suffix_len) =3D (1, 0);
+	# Ignore leading +/- characters for each parent.
+	my ($prefix_len, $suffix_len) =3D ($num_parents, 0);
 	my ($prefix_has_nonspace, $suffix_has_nonspace);
=20
 	my $shorter =3D (@rem < @add) ? @rem : @add;
@@ -5113,15 +5113,43 @@ sub format_rem_add_lines_pair {
=20
 # HTML-format diff context, removed and added lines.
 sub format_ctx_rem_add_lines {
-	my ($ctx, $rem, $add, $is_combined) =3D @_;
+	my ($ctx, $rem, $add, $num_parents) =3D @_;
 	my (@new_ctx, @new_rem, @new_add);
+	my $can_highlight =3D 0;
+	my $is_combined =3D ($num_parents > 1);
=20
 	# Highlight if every removed line has a corresponding added line.
-	# Combined diffs are not supported at this moment.
-	if (!$is_combined && @$add > 0 && @$add =3D=3D @$rem) {
+	if (@$add > 0 && @$add =3D=3D @$rem) {
+		$can_highlight =3D 1;
+
+		# Highlight lines in combined diff only if the chunk contains
+		# diff between the same version, e.g.
+		#
+		#    - a
+		#   -  b
+		#    + c
+		#   +  d
+		#
+		# Otherwise the highlightling would be confusing.
+		if ($is_combined) {
+			for (my $i =3D 0; $i < @$add; $i++) {
+				my $prefix_rem =3D substr($rem->[$i], 0, $num_parents);
+				my $prefix_add =3D substr($add->[$i], 0, $num_parents);
+
+				$prefix_rem =3D~ s/-/+/g;
+
+				if ($prefix_rem ne $prefix_add) {
+					$can_highlight =3D 0;
+					last;
+				}
+			}
+		}
+	}
+
+	if ($can_highlight) {
 		for (my $i =3D 0; $i < @$add; $i++) {
 			my ($line_rem, $line_add) =3D format_rem_add_lines_pair(
-			        $rem->[$i], $add->[$i]);
+			        $rem->[$i], $add->[$i], $num_parents);
 			push @new_rem, $line_rem;
 			push @new_add, $line_add;
 		}
@@ -5137,10 +5165,11 @@ sub format_ctx_rem_add_lines {
=20
 # Print context lines and then rem/add lines.
 sub print_diff_lines {
-	my ($ctx, $rem, $add, $diff_style, $is_combined) =3D @_;
+	my ($ctx, $rem, $add, $diff_style, $num_parents) =3D @_;
+	my $is_combined =3D $num_parents > 1;
=20
 	($ctx, $rem, $add) =3D format_ctx_rem_add_lines($ctx, $rem, $add,
-	        $is_combined);
+	        $num_parents);
=20
 	if ($diff_style eq 'sidebyside' && !$is_combined) {
 		print_sidebyside_diff_lines($ctx, $rem, $add);
@@ -5151,7 +5180,7 @@ sub print_diff_lines {
 }
=20
 sub print_diff_chunk {
-	my ($diff_style, $is_combined, $from, $to, @chunk) =3D @_;
+	my ($diff_style, $num_parents, $from, $to, @chunk) =3D @_;
 	my (@ctx, @rem, @add);
=20
 	# The class of the previous line.=20
@@ -5186,7 +5215,7 @@ sub print_diff_chunk {
 		if (((@rem || @add) && $class eq 'ctx') || !$class ||
 		    (@rem && @add && $class ne $prev_class)) {
 			print_diff_lines(\@ctx, \@rem, \@add,
-		                         $diff_style, $is_combined);
+		                         $diff_style, $num_parents);
 			@ctx =3D @rem =3D @add =3D ();
 		}
=20
@@ -5329,7 +5358,7 @@ sub git_patchset_body {
 			my $class =3D diff_line_class($patch_line, \%from, \%to);
=20
 			if ($class eq 'chunk_header') {
-				print_diff_chunk($diff_style, $is_combined, \%from, \%to, @chunk);
+				print_diff_chunk($diff_style, scalar @hash_parents, \%from, \%to, =
@chunk);
 				@chunk =3D ();
 			}
=20
@@ -5338,7 +5367,7 @@ sub git_patchset_body {
=20
 	} continue {
 		if (@chunk) {
-			print_diff_chunk($diff_style, $is_combined, \%from, \%to, @chunk);
+			print_diff_chunk($diff_style, scalar @hash_parents, \%from, \%to, @=
chunk);
 			@chunk =3D ();
 		}
 		print "</div>\n"; # class=3D"patch"
--=20
1.7.8.4
