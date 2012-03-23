From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v2 7/8] gitweb: Highlight interesting parts of diff
Date: Fri, 23 Mar 2012 23:56:56 +0100
Message-ID: <1332543417-19664-8-git-send-email-michal.kiedrowicz@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 23:57:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBDQN-0006K1-D4
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 23:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757342Ab2CWW5S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Mar 2012 18:57:18 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:34174 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757267Ab2CWW5O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 18:57:14 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so2998508wej.19
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 15:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fP0XbNZK3kNbPUp5J6aYuMc2tx3M57+GDobxYyEGpnM=;
        b=NQd5RWjohIoljoe7gvRzhGNA887/qd/Pj0OaFgoQ2hm3U/z3kqg5FTF5757pkyOYZ0
         QQxuNHydjGPENpMsIsnmhr1PN3wytgu5ie1iWz0OMsvFhspvBi3GUqWRDKDLzkYQ3psP
         zlOJLEIlJEDghWBYO6JlM77+0x1r+zXEKtUveofospuLZMRpIXBS8Fg2N0fha4d3Q2zt
         G4OAzoVXzePP9SzIK9ZjQ5Dtbp8aUzdJ37R1ToLH8vHtphDK84NW3t9sQDc+1LDvLl7G
         ysrxzUBF4FlTO0jV7R4+HCNdDx5mOBO1gfB5BABOQk6ugHS9CyKSYLg0mKpdBw2+ltcr
         +WaA==
Received: by 10.216.138.135 with SMTP id a7mr8087167wej.19.1332543434296;
        Fri, 23 Mar 2012 15:57:14 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id bx13sm17626777wib.10.2012.03.23.15.57.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Mar 2012 15:57:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193809>

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

Two changes in format_diff_line() were needed to allow diff refinement
highlightning to work.  Firstly, format_diff_line() was taught to not
esc_html() line that was passed as a reference.  This was needed becaus=
e
refining the highlight must be performed on unescaped lines and it uses
a <span> element to mark interesting parts of the line.  Secondly, the
lines are untabified before comparing because calling untabify()
after inserting <span>'s could improperly convert tabs to spaces.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 gitweb/gitweb.perl       |   84 ++++++++++++++++++++++++++++++++++++++=
++++----
 gitweb/static/gitweb.css |    8 ++++
 2 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index db32588..872ba12 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2426,14 +2426,14 @@ sub format_cc_diff_chunk_header {
 }
=20
 # process patch (diff) line (not to be used for diff headers),
-# returning HTML-formatted (but not wrapped) line
+# returning HTML-formatted (but not wrapped) line.
+# If the line is already esc_html()'ed, pass it as a reference.
 sub format_diff_line {
 	my ($line, $diff_class, $from, $to) =3D @_;
=20
-	chomp $line;
-	$line =3D untabify($line);
-
-	if ($from && $to && $line =3D~ m/^\@{2} /) {
+	if (ref($line)) {
+		$line =3D $$line;
+	} elsif ($from && $to && $line =3D~ m/^\@{2} /) {
 		$line =3D format_unidiff_chunk_header($line, $from, $to);
 	} elsif ($from && $to && $line =3D~ m/^\@{3}/) {
 		$line =3D format_cc_diff_chunk_header($line, $from, $to);
@@ -5054,10 +5054,80 @@ sub print_inline_diff_lines {
 	print foreach (@$add);
 }
=20
+# Format removed and added line, mark changed part and HTML-format the=
m.
+# Impementation is based on contrib/diff-highlight
+sub format_rem_add_line {
+	my ($rem, $add) =3D @_;
+	my @rem =3D split(//, $rem);
+	my @add =3D split(//, $add);
+	my ($esc_rem, $esc_add);
+	# Ignore +/- character, thus $prefix_len is set to 1.
+	my ($prefix_len, $suffix_len) =3D (1, 0);
+	my ($prefix_is_space, $suffix_is_space) =3D (1, 1);
+
+	while ($prefix_len < @rem && $prefix_len < @add) {
+		last if ($rem[$prefix_len] ne $add[$prefix_len]);
+
+		$prefix_is_space =3D 0 if ($rem[$prefix_len] !~ /\s/);
+		$prefix_len++;
+	}
+
+	my $shorter =3D (@rem < @add) ? @rem : @add;
+	while ($prefix_len + $suffix_len < $shorter) {
+		last if ($rem[-1 - $suffix_len] ne $add[-1 - $suffix_len]);
+
+		$suffix_is_space =3D 0 if ($rem[-1 - $suffix_len] !~ /\s/);
+		$suffix_len++;
+	}
+
+	# Mark lines that are different from each other, but have some common
+	# part that isn't whitespace.  If lines are completely different, don=
't
+	# mark them because that would make output unreadable, especially if
+	# diff consists of multiple lines.
+	if (($prefix_len =3D=3D 1 && $suffix_len =3D=3D 0) ||
+	    ($prefix_is_space && $suffix_is_space)) {
+		$esc_rem =3D esc_html($rem, -nbsp=3D>1);
+		$esc_add =3D esc_html($add, -nbsp=3D>1);
+	} else {
+		$esc_rem =3D esc_html_hl_regions($rem, 'marked', [$prefix_len, @rem =
- $suffix_len], -nbsp=3D>1);
+		$esc_add =3D esc_html_hl_regions($add, 'marked', [$prefix_len, @add =
- $suffix_len], -nbsp=3D>1);
+	}
+
+	return format_diff_line(\$esc_rem, 'rem'),
+	        format_diff_line(\$esc_add, 'add');
+}
+
+# HTML-format diff context, removed and added lines.
+sub format_ctx_rem_add_lines {
+	my ($ctx, $rem, $add, $is_combined) =3D @_;
+	my (@new_ctx, @new_rem, @new_add);
+
+	# Highlight if every removed line has a corresponding added line.
+	# Combined diffs are not supported ATM.
+	if (!$is_combined && @$add > 0 && @$add =3D=3D @$rem) {
+		for (my $i =3D 0; $i < @$add; $i++) {
+			my ($line_rem, $line_add) =3D format_rem_add_line(
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
+		$is_combined);
+
 	if ($diff_style eq 'sidebyside' && !$is_combined) {
 		print_sidebyside_diff_lines($ctx, $rem, $add);
 	} else {
@@ -5089,11 +5159,11 @@ sub print_diff_chunk {
 	foreach my $line_info (@chunk) {
 		my ($class, $line) =3D @$line_info;
=20
-		$line =3D format_diff_line($line, $class, $from, $to);
+		$line =3D untabify($line);
=20
 		# print chunk headers
 		if ($class && $class eq 'chunk_header') {
-			print $line;
+			print format_diff_line($line, $class, $from, $to);
 			next;
 		}
=20
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index c530355..3c4a3c9 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -438,6 +438,10 @@ div.diff.add {
 	color: #008800;
 }
=20
+div.diff.add span.marked {
+	background-color: #77ff77;
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
+	background-color: #ff7777;
+}
+
 div.diff.chunk_header a,
 div.diff.chunk_header {
 	color: #990099;
--=20
1.7.8.4
