From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v4 7/8] gitweb: Highlight interesting parts of diff
Date: Wed, 11 Apr 2012 23:18:43 +0200
Message-ID: <1334179124-14258-8-git-send-email-michal.kiedrowicz@gmail.com>
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
	id 1SI4wj-0005Cb-46
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933384Ab2DKVTQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 17:19:16 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63166 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933377Ab2DKVTN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:19:13 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1311420wgb.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 14:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9dqFLoJRgFxSJzodYu/tG4ObR2gCu2BDXByCtP0fThE=;
        b=sgmUp4sDJQAcR9/8ZggmagDElM6ZmQTdp71HhDG4Zs/tMpzeSHHz0lsBmyRdcqmUEr
         KakHVk+vpcvCvZiJYHqLd2fOhzyjTddsav31qkf8MyOY/zTb3kTRuzz857HsIjlAU8IM
         +1RA+6XLiopK+QBkN9gz02Tv0kil66FGJ91RVhhNVtPF/YUpAhQ76TBCzCtDKFogEkRR
         gB38KZALTFZ7WzCidcpHNUjugJ5Wvv+XcyxwN9Ke/CxYwTNgzPkIiAbrx6QhXdMaShiy
         0Tct8zU0Q1/mgmxh6X1eluPc3M2N9PG/+xg1JPtcZQE2+C5aCNBGZQ0rS1eeY5N3IeaX
         Ygvw==
Received: by 10.216.139.29 with SMTP id b29mr9732584wej.55.1334179151407;
        Wed, 11 Apr 2012 14:19:11 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id fl2sm13751248wib.2.2012.04.11.14.19.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 14:19:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195262>

Reading diff output is sometimes very hard, even if it's colored,
especially if lines differ only in few characters.  This is often true
when a commit fixes a typo or renames some variables or functions.

This commit teaches gitweb to highlight characters that are different
between old and new line with a light green/red background.  This shoul=
d
work in the similar manner as in Trac or GitHub.

The algorithm that compares lines is based on contrib/diff-highlight.
Basically, it works by determining common prefix/suffix of correspondin=
g
lines and highlightning only the middle part of lines.  For more
information, see contrib/diff-highlight/README.

Combined diffs are not supported but a following commit will change it.

Since we need to pass esc_html()'ed or esc_html_hl_regions()'ed lines t=
o
format_diff_lines(), so it was taught to accept preformatted lines
passed as a reference.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
 gitweb/gitweb.perl       |  107 ++++++++++++++++++++++++++++++++++++++=
++-----
 gitweb/static/gitweb.css |    8 +++
 2 files changed, 103 insertions(+), 12 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 390774e..d5b3f04 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2430,19 +2430,25 @@ sub format_cc_diff_chunk_header {
 }
=20
 # process patch (diff) line (not to be used for diff headers),
-# returning HTML-formatted (but not wrapped) line
+# returning HTML-formatted (but not wrapped) line.
+# If the line is passed as a reference, it is treated as HTML and not
+# esc_html()'ed.
 sub format_diff_line {
 	my ($line, $diff_class, $from, $to) =3D @_;
=20
-	chomp $line;
-	$line =3D untabify($line);
-
-	if ($from && $to && $line =3D~ m/^\@{2} /) {
-		$line =3D format_unidiff_chunk_header($line, $from, $to);
-	} elsif ($from && $to && $line =3D~ m/^\@{3}/) {
-		$line =3D format_cc_diff_chunk_header($line, $from, $to);
+	if (ref($line)) {
+		$line =3D $$line;
 	} else {
-		$line =3D esc_html($line, -nbsp=3D>1);
+		chomp $line;
+		$line =3D untabify($line);
+
+		if ($from && $to && $line =3D~ m/^\@{2} /) {
+			$line =3D format_unidiff_chunk_header($line, $from, $to);
+		} elsif ($from && $to && $line =3D~ m/^\@{3}/) {
+			$line =3D format_cc_diff_chunk_header($line, $from, $to);
+		} else {
+			$line =3D esc_html($line, -nbsp=3D>1);
+		}
 	}
=20
 	my $diff_classes =3D "diff";
@@ -5055,10 +5061,89 @@ sub print_inline_diff_lines {
 	print @$ctx, @$rem, @$add;
 }
=20
+# Format removed and added line, mark changed part and HTML-format the=
m.
+# Implementation is based on contrib/diff-highlight
+sub format_rem_add_lines_pair {
+	my ($rem, $add) =3D @_;
+
+	# We need to untabify lines before split()'ing them;
+	# otherwise offsets would be invalid.
+	chomp $rem;
+	chomp $add;
+	$rem =3D untabify($rem);
+	$add =3D untabify($add);
+
+	my @rem =3D split(//, $rem);
+	my @add =3D split(//, $add);
+	my ($esc_rem, $esc_add);
+	# Ignore +/- character, thus $prefix_len is set to 1.
+	my ($prefix_len, $suffix_len) =3D (1, 0);
+	my ($prefix_has_nonspace, $suffix_has_nonspace);
+
+	my $shorter =3D (@rem < @add) ? @rem : @add;
+	while ($prefix_len < $shorter) {
+		last if ($rem[$prefix_len] ne $add[$prefix_len]);
+
+		$prefix_has_nonspace =3D 1 if ($rem[$prefix_len] !~ /\s/);
+		$prefix_len++;
+	}
+
+	while ($prefix_len + $suffix_len < $shorter) {
+		last if ($rem[-1 - $suffix_len] ne $add[-1 - $suffix_len]);
+
+		$suffix_has_nonspace =3D 1 if ($rem[-1 - $suffix_len] !~ /\s/);
+		$suffix_len++;
+	}
+
+	# Mark lines that are different from each other, but have some common
+	# part that isn't whitespace.  If lines are completely different, don=
't
+	# mark them because that would make output unreadable, especially if
+	# diff consists of multiple lines.
+	if ($prefix_has_nonspace || $suffix_has_nonspace) {
+		$esc_rem =3D esc_html_hl_regions($rem, 'marked',
+		        [$prefix_len, @rem - $suffix_len], -nbsp=3D>1);
+		$esc_add =3D esc_html_hl_regions($add, 'marked',
+		        [$prefix_len, @add - $suffix_len], -nbsp=3D>1);
+	} else {
+		$esc_rem =3D esc_html($rem, -nbsp=3D>1);
+		$esc_add =3D esc_html($add, -nbsp=3D>1);
+	}
+
+	return format_diff_line(\$esc_rem, 'rem'),
+	       format_diff_line(\$esc_add, 'add');
+}
+
+# HTML-format diff context, removed and added lines.
+sub format_ctx_rem_add_lines {
+	my ($ctx, $rem, $add, $is_combined) =3D @_;
+	my (@new_ctx, @new_rem, @new_add);
+
+	# Highlight if every removed line has a corresponding added line.
+	# Combined diffs are not supported at this moment.
+	if (!$is_combined && @$add > 0 && @$add =3D=3D @$rem) {
+		for (my $i =3D 0; $i < @$add; $i++) {
+			my ($line_rem, $line_add) =3D format_rem_add_lines_pair(
+			        $rem->[$i], $add->[$i]);
+			push @new_rem, $line_rem;
+			push @new_add, $line_add;
+		}
+	} else {
+		@new_rem =3D map { format_diff_line($_, 'rem') } @$rem;
+		@new_add =3D map { format_diff_line($_, 'add') } @$add;
+	}
+
+	@new_ctx =3D map { format_diff_line($_, 'ctx') } @$ctx;
+
+	return (\@new_ctx, \@new_rem, \@new_add);
+}
+
 # Print context lines and then rem/add lines.
 sub print_diff_lines {
 	my ($ctx, $rem, $add, $diff_style, $is_combined) =3D @_;
=20
+	($ctx, $rem, $add) =3D format_ctx_rem_add_lines($ctx, $rem, $add,
+	        $is_combined);
+
 	if ($diff_style eq 'sidebyside' && !$is_combined) {
 		print_sidebyside_diff_lines($ctx, $rem, $add);
 	} else {
@@ -5090,11 +5175,9 @@ sub print_diff_chunk {
 	foreach my $line_info (@chunk) {
 		my ($class, $line) =3D @$line_info;
=20
-		$line =3D format_diff_line($line, $class, $from, $to);
-
 		# print chunk headers
 		if ($class && $class eq 'chunk_header') {
-			print $line;
+			print format_diff_line($line, $class, $from, $to);
 			next;
 		}
=20
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index c530355..cb86d2d 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -438,6 +438,10 @@ div.diff.add {
 	color: #008800;
 }
=20
+div.diff.add span.marked {
+	background-color: #aaffaa;
+}
+
 div.diff.from_file a.path,
 div.diff.from_file {
 	color: #aa0000;
@@ -447,6 +451,10 @@ div.diff.rem {
 	color: #cc0000;
 }
=20
+div.diff.rem span.marked {
+	background-color: #ffaaaa;
+}
+
 div.diff.chunk_header a,
 div.diff.chunk_header {
 	color: #990099;
--=20
1.7.8.4
