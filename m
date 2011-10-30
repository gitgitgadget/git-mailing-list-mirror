From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 2/8] gitweb: Extract formatting of diff chunk header
Date: Mon, 31 Oct 2011 00:36:21 +0100
Message-ID: <1320017787-18048-3-git-send-email-jnareb@gmail.com>
References: <1320017787-18048-1-git-send-email-jnareb@gmail.com>
Cc: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 00:41:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKf05-0006Cd-IM
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 00:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362Ab1J3XlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 19:41:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38444 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab1J3XlH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 19:41:07 -0400
Received: by faan17 with SMTP id n17so5068665faa.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 16:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5tDkUR2+bl9auc38dZozRyn/7u0m7oS1VncKyXOicTE=;
        b=Uqwk27Zr11AB8ebo/fSavwYmbaAM6N5uw2NWLWYoZB9ynWgOppbC2PSQHW7tTmmHVA
         E10r6NCqV7flWMihqru3mwHGaZMuw9cs4HSVRr11CUMGqWu5ZZ6jVEQb/jOCSbInDK0p
         tAduZeKPjuZzNVb2z5vQClh2jRXb2LovA07mc=
Received: by 10.223.76.135 with SMTP id c7mr24886643fak.14.1320018066024;
        Sun, 30 Oct 2011 16:41:06 -0700 (PDT)
Received: from localhost.localdomain (aeho24.neoplus.adsl.tpnet.pl. [79.186.196.24])
        by mx.google.com with ESMTPS id a26sm19652514fac.2.2011.10.30.16.41.04
        (version=SSLv3 cipher=OTHER);
        Sun, 30 Oct 2011 16:41:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1320017787-18048-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184481>

Refactor main parts of HTML-formatting for diff chunk headers
(formatting means here adding links and syntax hightlighting) into
separate subroutines:

 * format_unidiff_chunk_header for ordinary diff,
 * format_cc_diff_chunk_header for combined diff
   (more than one parent)

This makes format_diff_line() subroutine easier to follow.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is new in this version of side-by-side diff series.

After those changes format_diff_line() fits in one page (has less than
25 lines).  Nice, isn't it?

 gitweb/gitweb.perl |  114 ++++++++++++++++++++++++++++++---------------------
 1 files changed, 67 insertions(+), 47 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 914fd4c..95d278a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2254,6 +2254,69 @@ sub diff_line_class {
 	return "";
 }
 
+# assumes that $from and $to are defined and correctly filled,
+# and that $line holds a line of chunk header for unified diff
+sub format_unidiff_chunk_header {
+	my ($line, $from, $to) = @_;
+
+	my ($from_text, $from_start, $from_lines, $to_text, $to_start, $to_lines, $section) =
+		$line =~ m/^\@{2} (-(\d+)(?:,(\d+))?) (\+(\d+)(?:,(\d+))?) \@{2}(.*)$/;
+
+	$from_lines = 0 unless defined $from_lines;
+	$to_lines   = 0 unless defined $to_lines;
+
+	if ($from->{'href'}) {
+		$from_text = $cgi->a({-href=>"$from->{'href'}#l$from_start",
+		                     -class=>"list"}, $from_text);
+	}
+	if ($to->{'href'}) {
+		$to_text   = $cgi->a({-href=>"$to->{'href'}#l$to_start",
+		                     -class=>"list"}, $to_text);
+	}
+	$line = "<span class=\"chunk_info\">@@ $from_text $to_text @@</span>" .
+	        "<span class=\"section\">" . esc_html($section, -nbsp=>1) . "</span>";
+	return $line;
+}
+
+# assumes that $from and $to are defined and correctly filled,
+# and that $line holds a line of chunk header for combined diff
+sub format_cc_diff_chunk_header {
+	my ($line, $from, $to) = @_;
+
+	my ($prefix, $ranges, $section) = $line =~ m/^(\@+) (.*?) \@+(.*)$/;
+	my (@from_text, @from_start, @from_nlines, $to_text, $to_start, $to_nlines);
+
+	@from_text = split(' ', $ranges);
+	for (my $i = 0; $i < @from_text; ++$i) {
+		($from_start[$i], $from_nlines[$i]) =
+			(split(',', substr($from_text[$i], 1)), 0);
+	}
+
+	$to_text   = pop @from_text;
+	$to_start  = pop @from_start;
+	$to_nlines = pop @from_nlines;
+
+	$line = "<span class=\"chunk_info\">$prefix ";
+	for (my $i = 0; $i < @from_text; ++$i) {
+		if ($from->{'href'}[$i]) {
+			$line .= $cgi->a({-href=>"$from->{'href'}[$i]#l$from_start[$i]",
+			                  -class=>"list"}, $from_text[$i]);
+		} else {
+			$line .= $from_text[$i];
+		}
+		$line .= " ";
+	}
+	if ($to->{'href'}) {
+		$line .= $cgi->a({-href=>"$to->{'href'}#l$to_start",
+		                  -class=>"list"}, $to_text);
+	} else {
+		$line .= $to_text;
+	}
+	$line .= " $prefix</span>" .
+	         "<span class=\"section\">" . esc_html($section, -nbsp=>1) . "</span>";
+	return $line;
+}
+
 # format patch (diff) line (not to be used for diff headers)
 sub format_diff_line {
 	my $line = shift;
@@ -2267,56 +2330,13 @@ sub format_diff_line {
 	$line = untabify($line);
 
 	if ($from && $to && $line =~ m/^\@{2} /) {
-		my ($from_text, $from_start, $from_lines, $to_text, $to_start, $to_lines, $section) =
-			$line =~ m/^\@{2} (-(\d+)(?:,(\d+))?) (\+(\d+)(?:,(\d+))?) \@{2}(.*)$/;
-
-		$from_lines = 0 unless defined $from_lines;
-		$to_lines   = 0 unless defined $to_lines;
-
-		if ($from->{'href'}) {
-			$from_text = $cgi->a({-href=>"$from->{'href'}#l$from_start",
-			                     -class=>"list"}, $from_text);
-		}
-		if ($to->{'href'}) {
-			$to_text   = $cgi->a({-href=>"$to->{'href'}#l$to_start",
-			                     -class=>"list"}, $to_text);
-		}
-		$line = "<span class=\"chunk_info\">@@ $from_text $to_text @@</span>" .
-		        "<span class=\"section\">" . esc_html($section, -nbsp=>1) . "</span>";
+		$line = format_unidiff_chunk_header($line, $from, $to);
 		return "<div class=\"$diff_classes\">$line</div>\n";
+
 	} elsif ($from && $to && $line =~ m/^\@{3}/) {
-		my ($prefix, $ranges, $section) = $line =~ m/^(\@+) (.*?) \@+(.*)$/;
-		my (@from_text, @from_start, @from_nlines, $to_text, $to_start, $to_nlines);
-
-		@from_text = split(' ', $ranges);
-		for (my $i = 0; $i < @from_text; ++$i) {
-			($from_start[$i], $from_nlines[$i]) =
-				(split(',', substr($from_text[$i], 1)), 0);
-		}
-
-		$to_text   = pop @from_text;
-		$to_start  = pop @from_start;
-		$to_nlines = pop @from_nlines;
-
-		$line = "<span class=\"chunk_info\">$prefix ";
-		for (my $i = 0; $i < @from_text; ++$i) {
-			if ($from->{'href'}[$i]) {
-				$line .= $cgi->a({-href=>"$from->{'href'}[$i]#l$from_start[$i]",
-				                  -class=>"list"}, $from_text[$i]);
-			} else {
-				$line .= $from_text[$i];
-			}
-			$line .= " ";
-		}
-		if ($to->{'href'}) {
-			$line .= $cgi->a({-href=>"$to->{'href'}#l$to_start",
-			                  -class=>"list"}, $to_text);
-		} else {
-			$line .= $to_text;
-		}
-		$line .= " $prefix</span>" .
-		         "<span class=\"section\">" . esc_html($section, -nbsp=>1) . "</span>";
+		$line = format_cc_diff_chunk_header($line, $from, $to);
 		return "<div class=\"$diff_classes\">$line</div>\n";
+
 	}
 	return "<div class=\"$diff_classes\">" . esc_html($line, -nbsp=>1) . "</div>\n";
 }
-- 
1.7.6
