From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH 8/8] gitweb: Highlight combined diffs
Date: Fri, 10 Feb 2012 10:18:14 +0100
Message-ID: <1328865494-24415-9-git-send-email-michal.kiedrowicz@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 10:19:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvmdA-0005f5-6f
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 10:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758868Ab2BJJSr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 04:18:47 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42215 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758866Ab2BJJSd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 04:18:33 -0500
Received: by mail-ee0-f46.google.com with SMTP id c14so882729eek.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 01:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vagidob6LIqYeBIEk51gkO7aeTP3AY4tnd2wAIeWaRM=;
        b=kNDWF8ETMmxbIWwEVO2Qt2UdBKObQMBuNpbAdS2aa4UwHHr8dmCa01sob/ktKxn2B+
         BfLrV8LJ0OIpJUjM8BslBshOE3jyB646SAobd6VKIqxvA8Bwf7kqpGT1XDCp05xPWZrN
         kCKKUFSjlKveLyOARH2tsGH3C6aX9VSiUgSFU=
Received: by 10.213.13.11 with SMTP id z11mr230301ebz.70.1328865512890;
        Fri, 10 Feb 2012 01:18:32 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id w60sm1730269eeb.4.2012.02.10.01.18.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 01:18:32 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190393>

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
 gitweb/gitweb.perl |   40 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1a5b454..2b6cb9e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4944,13 +4944,16 @@ sub esc_html_mark_range {
=20
 # Format removed and added line, mark changed part and HTML-format the=
m.
 sub format_rem_add_line {
-	my ($rem, $add) =3D @_;
+	my ($rem, $add, $is_combined) =3D @_;
 	my @r =3D split(//, $rem);
 	my @a =3D split(//, $add);
 	my ($esc_rem, $esc_add);
 	my ($prefix, $suffix_rem, $suffix_add) =3D (1, $#r, $#a);
 	my ($prefix_is_space, $suffix_is_space) =3D (1, 1);
=20
+	# In combined diff we must ignore two +/- characters.
+	$prefix =3D 2 if ($is_combined);
+
 	while ($prefix < @r && $prefix < @a) {
 		last if ($r[$prefix] ne $a[$prefix]);
=20
@@ -4988,11 +4991,42 @@ sub format_ctx_rem_add_lines {
 	my ($ctx, $rem, $add, $is_combined) =3D @_;
 	my (@new_ctx, @new_rem, @new_add);
 	my $num_add_lines =3D @$add;
+	my $can_highlight;
+
+	# Highlight if every removed line has a corresponding added line.
+	if ($num_add_lines > 0 && $num_add_lines =3D=3D @$rem) {
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
+			for (my $i =3D 0; $i < $num_add_lines; $i++) {
+				my $prefix_rem =3D substr($rem->[$i], 0, 2);
+				my $prefix_add =3D substr($add->[$i], 0, 2);
+
+				$prefix_rem =3D~ s/-/+/g;
+
+				if ($prefix_rem ne $prefix_add) {
+					$can_highlight =3D 0;
+					last;
+				}
+			}
+		}
+	} else {
+		$can_highlight =3D 0;
+	}
=20
-	if (!$is_combined && $num_add_lines > 0 && $num_add_lines =3D=3D @$re=
m) {
+	if ($can_highlight) {
 		for (my $i =3D 0; $i < $num_add_lines; $i++) {
 			my ($line_rem, $line_add) =3D format_rem_add_line(
-				$rem->[$i], $add->[$i]);
+				$rem->[$i], $add->[$i], $is_combined);
 			push @new_rem, $line_rem;
 			push @new_add, $line_add;
 		}
--=20
1.7.3.4
