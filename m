From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 8/8] gitweb: Use esc_html_match_hl() in 'grep' search
Date: Wed, 15 Feb 2012 21:38:52 +0100
Message-ID: <1329338332-30358-9-git-send-email-jnareb@gmail.com>
References: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 21:42:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxlfq-0006XA-TB
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 21:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423Ab2BOUln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 15:41:43 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51356 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498Ab2BOUlj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 15:41:39 -0500
Received: by mail-ey0-f174.google.com with SMTP id h12so496802eaa.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 12:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QQnTR1VrV8RGf4u+LndDYwaos9DgkcNVhM5Fe/ZH+jE=;
        b=fDXuo6HvtcRGrHxTeDTIlEIdu0O1JmxFaF/jNR/xIHUib7E7gHJwlsxlcW1xPfGNJ9
         V1jpIyFlekZie7qVboVQbKDbMucg5p7j22TIsrl8AF4dywSZyNFAzgAiSN9xiseODyUB
         fS9TFSYwVS5QcXt3PBmqh/8NelrOp4xz+5bs8=
Received: by 10.213.8.135 with SMTP id h7mr455104ebh.95.1329338498967;
        Wed, 15 Feb 2012 12:41:38 -0800 (PST)
Received: from localhost.localdomain (abwo207.neoplus.adsl.tpnet.pl. [83.8.238.207])
        by mx.google.com with ESMTPS id c16sm14922307eei.1.2012.02.15.12.41.37
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 12:41:38 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190859>

Use esc_html_match_hl() in git_search_files() i.e. subroutine that
implements "grep" search, instead of custom code which highlighted
only one, last match.

This required enhancing esc_html_match_hl() to accept -nbsp=>1 and
pass it down to esc_html().

Note that line is untabified (tabs turned into spaces) before
highlighting match, which means that highlighting won't work e.g. for
matching tab character "\t" explicitly; but this issue was present
before this commit, and is not that easy to fix.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch was not present in previous (v1) version of this patch
series.

The 'grep' search was chosen from other searches because of the
following reasons:
* 'pickaxe' search does not show matches in diff, only filenames.
* 'commit' search shortens leading text at beginning, one last match
  in the middle, and trailing text at the end; anyway I think this
  search should be rewritten to show just "log"-like view with match
  highlighting.

 gitweb/gitweb.perl |   34 ++++++++++++++--------------------
 1 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a2e2023..36a8cca 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1723,20 +1723,22 @@ sub chop_and_escape_str {
 # '<span class="mark">foo</span>bar'
 sub esc_html_hl_regions {
 	my ($str, $css_class, @sel) = @_;
-	return esc_html($str) unless @sel;
+	my %opts = grep { ref($_) ne 'ARRAY' } @sel;
+	@sel     = grep { ref($_) eq 'ARRAY' } @sel;
+	return esc_html($str, %opts) unless @sel;
 
 	my $out = '';
 	my $pos = 0;
 
 	for my $s (@sel) {
-		$out .= esc_html(substr($str, $pos, $s->[0] - $pos))
+		$out .= esc_html(substr($str, $pos, $s->[0] - $pos), %opts)
 			if ($s->[0] - $pos > 0);
 		$out .= $cgi->span({-class => $css_class},
-		                   esc_html(substr($str, $s->[0], $s->[1] - $s->[0])));
+		                   esc_html(substr($str, $s->[0], $s->[1] - $s->[0]), %opts));
 
 		$pos = $s->[1];
 	}
-	$out .= esc_html(substr($str, $pos))
+	$out .= esc_html(substr($str, $pos), %opts)
 		if ($pos < length($str));
 
 	return $out;
@@ -1744,23 +1746,23 @@ sub esc_html_hl_regions {
 
 # highlight match (if any), and escape HTML
 sub esc_html_match_hl {
-	my ($str, $regexp) = @_;
-	return esc_html($str) unless defined $regexp;
+	my ($str, $regexp, %opts) = @_;
+	return esc_html($str, %opts) unless defined $regexp;
 
-	return esc_html_match_hl_chopped($str, undef, $regexp);
+	return esc_html_match_hl_chopped($str, undef, $regexp, %opts);
 }
 
 
 # highlight match (if any) of shortened string, and escape HTML
 sub esc_html_match_hl_chopped {
-	my ($str, $chopped, $regexp) = @_;
-	return esc_html(defined $chopped ? $chopped : $str) unless defined $regexp;
+	my ($str, $chopped, $regexp, %opts) = @_;
+	return esc_html(defined $chopped ? $chopped : $str, %opts) unless defined $regexp;
 
 	my @matches;
 	while ($str =~ /$regexp/g) {
 		push @matches, [$-[0], $+[0]];
 	}
-	return esc_html(defined $chopped ? $chopped : $str) unless @matches;
+	return esc_html(defined $chopped ? $chopped : $str, %opts) unless @matches;
 
 	# filter matches so that we mark chopped string, if it is present
 	if (defined $chopped) {
@@ -1788,7 +1790,7 @@ sub esc_html_match_hl_chopped {
 		@matches = @filtered;
 	}
 
-	return esc_html_hl_regions($str, 'match', @matches);
+	return esc_html_hl_regions($str, 'match', @matches, %opts);
 }
 
 ## ----------------------------------------------------------------------
@@ -6070,15 +6072,7 @@ sub git_search_files {
 			print "<div class=\"binary\">Binary file</div>\n";
 		} else {
 			$ltext = untabify($ltext);
-			if ($ltext =~ m/^(.*)($search_regexp)(.*)$/i) {
-				$ltext = esc_html($1, -nbsp=>1);
-				$ltext .= '<span class="match">';
-				$ltext .= esc_html($2, -nbsp=>1);
-				$ltext .= '</span>';
-				$ltext .= esc_html($3, -nbsp=>1);
-			} else {
-				$ltext = esc_html($ltext, -nbsp=>1);
-			}
+			$ltext = esc_html_match_hl($ltext, qr/$search_regexp/i, -nbsp=>1);
 			print "<div class=\"pre\">" .
 				$cgi->a({-href => $file_href.'#l'.$lno,
 				        -class => "linenr"}, sprintf('%4i', $lno)) .
-- 
1.7.9
