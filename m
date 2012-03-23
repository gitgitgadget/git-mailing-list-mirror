From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v2 8/8] gitweb: Refinement highlightning in combined diffs
Date: Fri, 23 Mar 2012 23:56:57 +0100
Message-ID: <1332543417-19664-9-git-send-email-michal.kiedrowicz@gmail.com>
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
	id 1SBDQN-0006K1-V0
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 23:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347Ab2CWW5Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Mar 2012 18:57:24 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41012 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757328Ab2CWW5R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 18:57:17 -0400
Received: by mail-wi0-f178.google.com with SMTP id hq7so2508665wib.1
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2jY+wP0FJCnzC7j4+QhS2bMA9QWYnM/C1UGESEEx5Ik=;
        b=YORA63HT72vzCm7BHhSZyCsoeBWsrIEzf5psWMRFcCCxqykyAKLXje6V31HHqGmLqQ
         onA91T8TBC3xGDFScO3pQxQpP+NGi5rens9xLyu5K6k/JNzWApZFO9nCgdCyXi2azphH
         fwf5c6x1pU+Rq0vDZzpp0x6kQmvYG50YD91kjxd8LcgQQUEUrElj9wRibocDaz8IzOcM
         pxLPrGKYpjSWSfXgqiN3Ba9uX3GMe9yqv//QlqMO1/rUwza+0wAmItKblF4/h1wHcFje
         oNnXnJWsGHfttcTTdJDHkT5CDJThxUp4JOoLhAIatYzk/BRN+4bHofV/90xAPfnfPG6z
         V/xQ==
Received: by 10.216.137.226 with SMTP id y76mr7340975wei.96.1332543436129;
        Fri, 23 Mar 2012 15:57:16 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id k7sm28941636wia.5.2012.03.23.15.57.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Mar 2012 15:57:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193810>

The highlightning of combined diffs is currently disabled.  This is
because output from a combined diff is much harder to highlight because
it's not obvious which removed and added lines should be compared.

Moreover, code that compares added and removed lines doesn't care about
combined diffs. It only skips first +/- character, treating second +/-
as a line content.

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

=46urther changes may introduce more intelligent approach that better
handles combined diffs.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 gitweb/gitweb.perl |   57 +++++++++++++++++++++++++++++++++++++++-----=
-------
 1 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 872ba12..c056e83 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5057,12 +5057,12 @@ sub print_inline_diff_lines {
 # Format removed and added line, mark changed part and HTML-format the=
m.
 # Impementation is based on contrib/diff-highlight
 sub format_rem_add_line {
-	my ($rem, $add) =3D @_;
+	my ($rem, $add, $num_parents) =3D @_;
 	my @rem =3D split(//, $rem);
 	my @add =3D split(//, $add);
 	my ($esc_rem, $esc_add);
-	# Ignore +/- character, thus $prefix_len is set to 1.
-	my ($prefix_len, $suffix_len) =3D (1, 0);
+	# Ignore leading +/- characters for each parent.
+	my ($prefix_len, $suffix_len) =3D ($num_parents, 0);
 	my ($prefix_is_space, $suffix_is_space) =3D (1, 1);
=20
 	while ($prefix_len < @rem && $prefix_len < @add) {
@@ -5084,7 +5084,7 @@ sub format_rem_add_line {
 	# part that isn't whitespace.  If lines are completely different, don=
't
 	# mark them because that would make output unreadable, especially if
 	# diff consists of multiple lines.
-	if (($prefix_len =3D=3D 1 && $suffix_len =3D=3D 0) ||
+	if (($prefix_len =3D=3D $num_parents && $suffix_len =3D=3D 0) ||
 	    ($prefix_is_space && $suffix_is_space)) {
 		$esc_rem =3D esc_html($rem, -nbsp=3D>1);
 		$esc_add =3D esc_html($add, -nbsp=3D>1);
@@ -5099,15 +5099,43 @@ sub format_rem_add_line {
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
-	# Combined diffs are not supported ATM.
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
 			my ($line_rem, $line_add) =3D format_rem_add_line(
-			        $rem->[$i], $add->[$i]);
+			        $rem->[$i], $add->[$i], $num_parents);
 			push @new_rem, $line_rem;
 			push @new_add, $line_add;
 		}
@@ -5123,10 +5151,11 @@ sub format_ctx_rem_add_lines {
=20
 # Print context lines and then rem/add lines.
 sub print_diff_lines {
-	my ($ctx, $rem, $add, $diff_style, $is_combined) =3D @_;
+	my ($ctx, $rem, $add, $diff_style, $num_parents) =3D @_;
+	my $is_combined =3D $num_parents > 1;
=20
 	($ctx, $rem, $add) =3D format_ctx_rem_add_lines($ctx, $rem, $add,
-		$is_combined);
+		$num_parents);
=20
 	if ($diff_style eq 'sidebyside' && !$is_combined) {
 		print_sidebyside_diff_lines($ctx, $rem, $add);
@@ -5137,7 +5166,7 @@ sub print_diff_lines {
 }
=20
 sub print_diff_chunk {
-	my ($diff_style, $is_combined, $from, $to, @chunk) =3D @_;
+	my ($diff_style, $num_parents, $from, $to, @chunk) =3D @_;
 	my (@ctx, @rem, @add);
=20
 	# The class of the previous line.=20
@@ -5174,7 +5203,7 @@ sub print_diff_chunk {
 		if (((@rem || @add) && $class eq 'ctx') || !$class ||
 		    (@rem && @add && $class ne $prev_class)) {
 			print_diff_lines(\@ctx, \@rem, \@add, $diff_style,
-					$is_combined);
+					$num_parents);
 			@ctx =3D @rem =3D @add =3D ();
 		}
=20
@@ -5317,7 +5346,7 @@ sub git_patchset_body {
 			my $class =3D diff_line_class($patch_line, \%from, \%to);
=20
 			if ($class eq 'chunk_header') {
-				print_diff_chunk($diff_style, $is_combined, \%from, \%to, @chunk);
+				print_diff_chunk($diff_style, scalar @hash_parents, \%from, \%to, =
@chunk);
 				@chunk =3D ( [ $class, $patch_line ] );
 			} else {
 				push @chunk, [ $class, $patch_line ];
@@ -5326,7 +5355,7 @@ sub git_patchset_body {
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
