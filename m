From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 1/8] gitweb: Refactor diff body line classification
Date: Mon, 31 Oct 2011 00:36:20 +0100
Message-ID: <1320017787-18048-2-git-send-email-jnareb@gmail.com>
References: <1320017787-18048-1-git-send-email-jnareb@gmail.com>
Cc: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 00:40:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKezD-0005vG-HC
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 00:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250Ab1J3XkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 19:40:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64254 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720Ab1J3XkK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 19:40:10 -0400
Received: by faan17 with SMTP id n17so5068239faa.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 16:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qMpKwdh/sDKi68c7RPt4KW6mUZpktyQKdSjG03OzLS8=;
        b=XPFQEH8C2Ni+3r8yvpHtfcRr66I9wo1MKH3Z+7VkKevVLsuNlqzL7Snp0bnNEOaqKF
         gHP72Iw+DwJjV1qVTaHLuoyu9/SVn+oyY9SWTWCMWMHwZOL788uMl50SS1gkwTxLSfzX
         aC7D1jr/VIIwnAVl4UMdcB1jSKxeeHdxCjPPc=
Received: by 10.223.16.82 with SMTP id n18mr24888155faa.2.1320018008973;
        Sun, 30 Oct 2011 16:40:08 -0700 (PDT)
Received: from localhost.localdomain (aeho24.neoplus.adsl.tpnet.pl. [79.186.196.24])
        by mx.google.com with ESMTPS id a26sm19652514fac.2.2011.10.30.16.40.07
        (version=SSLv3 cipher=OTHER);
        Sun, 30 Oct 2011 16:40:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1320017787-18048-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184480>

Simplify classification of diff line body in format_diff_line(),
replacing two long if-elsif chains (one for ordinary diff and one for
combined diff of a merge commit) with a single regexp match.  Refactor
this code into diff_line_class() function.

While at it:

* Fix an artifact in that $diff_class included leading space to be
  able to compose classes like this "class=\"diff$diff_class\"', even
  when $diff_class was an empty string.  This made code unnecessary
  ugly: $diff_class is now just class name or an empty string.

* Introduce "ctx" class for context lines ($diff_class was set to ""
  in this case before this commit).

Idea and initial code by Junio C Hamano, polish and testing by Jakub
Narebski.  Inspired by patch adding side-by-side diff by Kato Kazuyoshi,
which required $diff_class to be name of class without extra space.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is new in this version of side-by-side diff series.

Junio, as your proposal was of "what if" variety, and not as a proper
patch, I have taken authorship (after reqorking and testing it).
Should I revert authorship to you?

 gitweb/gitweb.perl |   67 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4f0c3bd..914fd4c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2225,40 +2225,47 @@ sub format_diff_cc_simplified {
 	return $result;
 }
 
+sub diff_line_class {
+	my ($line, $from, $to) = @_;
+
+	# ordinary diff
+	my $num_sign = 1;
+	# combined diff
+	if ($from && $to && ref($from->{'href'}) eq "ARRAY") {
+		$num_sign = scalar @{$from->{'href'}};
+	}
+
+	my @diff_line_classifier = (
+		{ regexp => qr/^\@\@{$num_sign} /, class => "chunk_header"},
+		{ regexp => qr/^\\/,               class => "incomplete"  },
+		{ regexp => qr/^ {$num_sign}/,     class => "ctx" },
+		# classifier for context must come before classifier add/rem,
+		# or we would have to use more complicated regexp, for example
+		# qr/(?= {0,$m}\+)[+ ]{$num_sign}/, where $m = $num_sign - 1;
+		{ regexp => qr/^[+ ]{$num_sign}/,   class => "add" },
+		{ regexp => qr/^[- ]{$num_sign}/,   class => "rem" },
+	);
+	for my $clsfy (@diff_line_classifier) {
+		return $clsfy->{'class'}
+			if ($line =~ $clsfy->{'regexp'});
+	}
+
+	# fallback
+	return "";
+}
+
 # format patch (diff) line (not to be used for diff headers)
 sub format_diff_line {
 	my $line = shift;
 	my ($from, $to) = @_;
-	my $diff_class = "";
+
+	my $diff_class = diff_line_class($line, $from, $to);
+	my $diff_classes = "diff";
+	$diff_classes .= " $diff_class" if ($diff_class);
 
 	chomp $line;
-
-	if ($from && $to && ref($from->{'href'}) eq "ARRAY") {
-		# combined diff
-		my $prefix = substr($line, 0, scalar @{$from->{'href'}});
-		if ($line =~ m/^\@{3}/) {
-			$diff_class = " chunk_header";
-		} elsif ($line =~ m/^\\/) {
-			$diff_class = " incomplete";
-		} elsif ($prefix =~ tr/+/+/) {
-			$diff_class = " add";
-		} elsif ($prefix =~ tr/-/-/) {
-			$diff_class = " rem";
-		}
-	} else {
-		# assume ordinary diff
-		my $char = substr($line, 0, 1);
-		if ($char eq '+') {
-			$diff_class = " add";
-		} elsif ($char eq '-') {
-			$diff_class = " rem";
-		} elsif ($char eq '@') {
-			$diff_class = " chunk_header";
-		} elsif ($char eq "\\") {
-			$diff_class = " incomplete";
-		}
-	}
 	$line = untabify($line);
+
 	if ($from && $to && $line =~ m/^\@{2} /) {
 		my ($from_text, $from_start, $from_lines, $to_text, $to_start, $to_lines, $section) =
 			$line =~ m/^\@{2} (-(\d+)(?:,(\d+))?) (\+(\d+)(?:,(\d+))?) \@{2}(.*)$/;
@@ -2276,7 +2283,7 @@ sub format_diff_line {
 		}
 		$line = "<span class=\"chunk_info\">@@ $from_text $to_text @@</span>" .
 		        "<span class=\"section\">" . esc_html($section, -nbsp=>1) . "</span>";
-		return "<div class=\"diff$diff_class\">$line</div>\n";
+		return "<div class=\"$diff_classes\">$line</div>\n";
 	} elsif ($from && $to && $line =~ m/^\@{3}/) {
 		my ($prefix, $ranges, $section) = $line =~ m/^(\@+) (.*?) \@+(.*)$/;
 		my (@from_text, @from_start, @from_nlines, $to_text, $to_start, $to_nlines);
@@ -2309,9 +2316,9 @@ sub format_diff_line {
 		}
 		$line .= " $prefix</span>" .
 		         "<span class=\"section\">" . esc_html($section, -nbsp=>1) . "</span>";
-		return "<div class=\"diff$diff_class\">$line</div>\n";
+		return "<div class=\"$diff_classes\">$line</div>\n";
 	}
-	return "<div class=\"diff$diff_class\">" . esc_html($line, -nbsp=>1) . "</div>\n";
+	return "<div class=\"$diff_classes\">" . esc_html($line, -nbsp=>1) . "</div>\n";
 }
 
 # Generates undef or something like "_snapshot_" or "snapshot (_tbz2_ _zip_)",
-- 
1.7.6
