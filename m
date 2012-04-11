From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v4 8/8] gitweb: Refinement highlightning in combined diffs
Date: Wed, 11 Apr 2012 23:18:44 +0200
Message-ID: <1334179124-14258-9-git-send-email-michal.kiedrowicz@gmail.com>
References: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, michal.kiedrowicz@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 11 23:19:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI4wq-0005HZ-Tn
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933386Ab2DKVTT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 17:19:19 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63166 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933381Ab2DKVTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:19:16 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1311420wgb.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 14:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Elovb/DtXwN3dtbJ1041U6uxsYdwtaw27oOYz3dQoYQ=;
        b=sf311YB5pGHor2p0Ui6+YyfKQWl/7L9JCxiXtwU6H38m5kjm7z6vqEMUE0UGIFfRT3
         hlJZZzngGy/A51DkZawx3i/LVvuTGeBmlWSDOq8AXP7rrR3VxPl34wHBx8d7KetYWXab
         6GFWQwLoFNAtpkKmiBC+CySZlu1uH11O5urT3BL8S5ytXr4lP3MOoRP1bQDp2ZZeiLKv
         cQpuuIQxwOFEttjJ74FiM9vV+5brZKZUzzauRqKduahMIWuNZqz13c69FjpqwmqDbIH9
         TVFifuzH6AjZQqQU+vCdxn5FPKg6rM653zHDBZPv+1S+9AlXxuQzaQMHsRPvNd//B6kM
         nVvg==
Received: by 10.180.24.35 with SMTP id r3mr9893900wif.7.1334179155414;
        Wed, 11 Apr 2012 14:19:15 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id ex2sm13733279wib.8.2012.04.11.14.19.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 14:19:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195264>

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
index d5b3f04..f4feacc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5064,7 +5064,7 @@ sub print_inline_diff_lines {
 # Format removed and added line, mark changed part and HTML-format the=
m.
 # Implementation is based on contrib/diff-highlight
 sub format_rem_add_lines_pair {
-	my ($rem, $add) =3D @_;
+	my ($rem, $add, $num_parents) =3D @_;
=20
 	# We need to untabify lines before split()'ing them;
 	# otherwise offsets would be invalid.
@@ -5076,8 +5076,8 @@ sub format_rem_add_lines_pair {
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
@@ -5115,15 +5115,43 @@ sub format_rem_add_lines_pair {
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
@@ -5139,10 +5167,11 @@ sub format_ctx_rem_add_lines {
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
@@ -5153,7 +5182,7 @@ sub print_diff_lines {
 }
=20
 sub print_diff_chunk {
-	my ($diff_style, $is_combined, $from, $to, @chunk) =3D @_;
+	my ($diff_style, $num_parents, $from, $to, @chunk) =3D @_;
 	my (@ctx, @rem, @add);
=20
 	# The class of the previous line.
@@ -5188,7 +5217,7 @@ sub print_diff_chunk {
 		if (!$class || ((@rem || @add) && $class eq 'ctx') ||
 		    (@rem && @add && $class ne $prev_class)) {
 			print_diff_lines(\@ctx, \@rem, \@add,
-		                         $diff_style, $is_combined);
+		                         $diff_style, $num_parents);
 			@ctx =3D @rem =3D @add =3D ();
 		}
=20
@@ -5331,7 +5360,7 @@ sub git_patchset_body {
 			my $class =3D diff_line_class($patch_line, \%from, \%to);
=20
 			if ($class eq 'chunk_header') {
-				print_diff_chunk($diff_style, $is_combined, \%from, \%to, @chunk);
+				print_diff_chunk($diff_style, scalar @hash_parents, \%from, \%to, =
@chunk);
 				@chunk =3D ();
 			}
=20
@@ -5340,7 +5369,7 @@ sub git_patchset_body {
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
