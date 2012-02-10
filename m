From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Fri, 10 Feb 2012 10:18:12 +0100
Message-ID: <1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 10:18:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvmcu-0005Y7-07
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 10:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758876Ab2BJJSe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 04:18:34 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57380 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758625Ab2BJJS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 04:18:29 -0500
Received: by mail-ee0-f46.google.com with SMTP id c14so882738eek.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 01:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eUt4bG5/1MME2Kz2o5cIWhfkc+Qp+zT3VcXuF8vtCck=;
        b=N5fanrklHGlnwgwbvwCfV+NysvYyxffa+9Ba90QLgNgHQBmn0eFIiHajXBccfe8zoe
         Qu8vsX1IyQZHgiGqAui1s21arUAe6GmzZfaCq0/vKmbIU+SQnTBSqLqWSMBJztXZwMEC
         Ze1GrFWXpXvkIa9WBH+mtO7CB6ajd6bvq+nds=
Received: by 10.14.48.66 with SMTP id u42mr1767635eeb.59.1328865509211;
        Fri, 10 Feb 2012 01:18:29 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id n17sm20003697eei.3.2012.02.10.01.18.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 01:18:28 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190389>

Reading diff output is sometimes very hard, even if it's colored,
especially if lines differ only in few characters.  This is often true
when a commit fixes a typo or renames some variables or functions.

This commit teaches gitweb to highlight characters that are different
between old and new line.  This should work in the similar manner as in
Trac or GitHub.

The code that comares lines is based on
contrib/diff-highlight/diff-highlight, except that it works with
multiline changes too.  It also won't highlight lines that are
completely different because that would only make the output unreadable=
=2E
Combined diffs are not supported but a following commit will change it.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 gitweb/gitweb.perl |   82 ++++++++++++++++++++++++++++++++++++++++++++=
++++---
 1 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index db61553..1a5b454 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2322,7 +2322,7 @@ sub format_cc_diff_chunk_header {
 # wrap patch (diff) line into a <div> (not to be used for diff headers=
),
 # the line must be esc_html()'ed
 sub format_diff_line {
-	my ($line, $diff_class, $from, $to) =3D @_;
+	my ($line, $diff_class) =3D @_;
=20
 	my $diff_classes =3D "diff";
 	$diff_classes .=3D " $diff_class" if ($diff_class);
@@ -4923,14 +4923,85 @@ sub print_inline_diff_lines {
 	print foreach (@$add);
 }
=20
+# Highlight characters from $prefix to $suffix and escape HTML.
+# $str is a reference to the array of characters.
+sub esc_html_mark_range {
+	my ($str, $prefix, $suffix) =3D @_;
+
+	# Don't generate empty <span> element.
+	if ($prefix =3D=3D $suffix + 1) {
+		return esc_html(join('', @$str), -nbsp=3D>1);
+	}
+
+	my $before =3D join('', @{$str}[0..($prefix - 1)]);
+	my $marked =3D join('', @{$str}[$prefix..$suffix]);
+	my $after =3D join('', @{$str}[($suffix + 1)..$#{$str}]);
+
+	return esc_html($before, -nbsp=3D>1) .
+		$cgi->span({-class=3D>'marked'}, esc_html($marked, -nbsp=3D>1)) .
+		esc_html($after,-nbsp=3D>1);
+}
+
+# Format removed and added line, mark changed part and HTML-format the=
m.
+sub format_rem_add_line {
+	my ($rem, $add) =3D @_;
+	my @r =3D split(//, $rem);
+	my @a =3D split(//, $add);
+	my ($esc_rem, $esc_add);
+	my ($prefix, $suffix_rem, $suffix_add) =3D (1, $#r, $#a);
+	my ($prefix_is_space, $suffix_is_space) =3D (1, 1);
+
+	while ($prefix < @r && $prefix < @a) {
+		last if ($r[$prefix] ne $a[$prefix]);
+
+		$prefix_is_space =3D 0 if ($r[$prefix] !~ /\s/);
+		$prefix++;
+	}
+
+	while ($suffix_rem >=3D $prefix && $suffix_add >=3D $prefix) {
+		last if ($r[$suffix_rem] ne $a[$suffix_add]);
+
+		$suffix_is_space =3D 0 if ($r[$suffix_rem] !~ /\s/);
+		$suffix_rem--;
+		$suffix_add--;
+	}
+
+	# Mark lines that are different from each other, but have some common
+	# part that isn't whitespace.  If lines are completely different, don=
't
+	# mark them because that would make output unreadable, especially if
+	# diff consists of multiple lines.
+	if (($prefix =3D=3D 1 && $suffix_rem =3D=3D $#r && $suffix_add =3D=3D=
 $#a)
+		|| ($prefix_is_space && $suffix_is_space)) {
+		$esc_rem =3D esc_html($rem);
+		$esc_add =3D esc_html($add);
+	} else {
+		$esc_rem =3D esc_html_mark_range(\@r, $prefix, $suffix_rem);
+		$esc_add =3D esc_html_mark_range(\@a, $prefix, $suffix_add);
+	}
+
+	return format_diff_line($esc_rem, 'rem'),
+		format_diff_line($esc_add, 'add');
+}
+
 # HTML-format diff context, removed and added lines.
 sub format_ctx_rem_add_lines {
-	my ($ctx, $rem, $add) =3D @_;
+	my ($ctx, $rem, $add, $is_combined) =3D @_;
 	my (@new_ctx, @new_rem, @new_add);
+	my $num_add_lines =3D @$add;
+
+	if (!$is_combined && $num_add_lines > 0 && $num_add_lines =3D=3D @$re=
m) {
+		for (my $i =3D 0; $i < $num_add_lines; $i++) {
+			my ($line_rem, $line_add) =3D format_rem_add_line(
+				$rem->[$i], $add->[$i]);
+			push @new_rem, $line_rem;
+			push @new_add, $line_add;
+		}
+	} else {
+		@new_rem =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'rem')=
 } @$rem;
+		@new_add =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'add')=
 } @$add;
+	}
=20
 	@new_ctx =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'ctx') =
} @$ctx;
-	@new_rem =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'rem') =
} @$rem;
-	@new_add =3D map { format_diff_line(esc_html($_, -nbsp=3D>1), 'add') =
} @$add;
=20
 	return (\@new_ctx, \@new_rem, \@new_add);
 }
@@ -4939,7 +5010,8 @@ sub format_ctx_rem_add_lines {
 sub print_diff_lines {
 	my ($ctx, $rem, $add, $diff_style, $is_combined) =3D @_;
=20
-	($ctx, $rem, $add) =3D format_ctx_rem_add_lines($ctx, $rem, $add);
+	($ctx, $rem, $add) =3D format_ctx_rem_add_lines($ctx, $rem, $add,
+		$is_combined);
=20
 	if ($diff_style eq 'sidebyside' && !$is_combined) {
 		print_sidebyside_diff_lines($ctx, $rem, $add);
--=20
1.7.3.4
