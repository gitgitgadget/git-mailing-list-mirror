From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 5/5] gitweb: Highlight matched part of shortened project description
Date: Sat,  4 Feb 2012 13:47:28 +0100
Message-ID: <1328359648-29511-6-git-send-email-jnareb@gmail.com>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 13:47:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtf1t-0003Yi-OM
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 13:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098Ab2BDMrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 07:47:43 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52260 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022Ab2BDMrm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 07:47:42 -0500
Received: by mail-ee0-f46.google.com with SMTP id c14so1494821eek.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 04:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7Z2ZiEJQK0TxjIpHw87nkiQfH73ypr6kMM99R5pD26k=;
        b=ukd0pbXlNhCwwhvcXaRkpIOh5GZJjy+mK7axgOyVTq+F0GtE2KeRQlzT+l9qbzpMog
         1ZF8kwjcI9Kdnxvm0Q9ExXLMfAeU83hiilyxioT6Fb84vrnaq0g5E8WPDgUXwQlqRYAk
         1z2ekNvv/otBhLUvQCXaGN7AW2v4k3nrbx1oo=
Received: by 10.14.130.208 with SMTP id k56mr3432269eei.123.1328359661882;
        Sat, 04 Feb 2012 04:47:41 -0800 (PST)
Received: from localhost.localdomain (abwn75.neoplus.adsl.tpnet.pl. [83.8.237.75])
        by mx.google.com with ESMTPS id z47sm26890568eeh.9.2012.02.04.04.47.40
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 04:47:41 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1328359648-29511-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189865>

Previous commit make gitweb use esc_html_match_hl() to mark match in
the _whole_ description of a project when searching projects.

This commit makes gitweb highlight match in _shortened_ description,
based on match in whole description, using esc_html_match_hl_chopped()
subroutine (with some code duplication with esc_html_match_hl()).
If match is in shortened part, then trailing "... " is highlighted.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is an RFC because of code duplication between esc_html_match_hl()
and esc_html_match_hl_chopped().

 gitweb/gitweb.perl |   41 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c650268..174b4d2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1739,6 +1739,44 @@ sub esc_html_match_hl {
 	return $out;
 }
 
+# highlight match (if any) of shortened string, and escape HTML
+sub esc_html_match_hl_chopped {
+	my ($str, $chopped, $regexp) = @_;
+	return esc_html($chopped) unless defined $regexp;
+	return esc_html_match_hl($str, $regexp) if ($str eq $chopped);
+
+	my @matches;
+	while ($str =~ /$regexp/g) {
+		push @matches, [$-[0], $+[0]];
+	}
+	return esc_html($chopped) unless @matches;
+
+	my $tail = "... ";
+	$chopped =~ s/\Q$tail\E$//; # see chop_str
+	my $len = length($chopped);
+	my $out = '';
+	my $pos = 0;
+	for my $m (@matches) {
+		if ($m->[0] > $len) {
+			$tail = $cgi->span({-class => 'match'}, $tail);
+			last;
+		}
+		$out .= esc_html(substr $str, $pos, $m->[0] - $pos);
+		$out .= $cgi->span({-class => 'match'},
+		                   esc_html(substr $chopped, $m->[0],
+		                            ($m->[1] > $len ? $len : $m->[1]) - $m->[0]));
+		if ($m->[1] > $len) {
+			$tail = $cgi->span({-class => 'match'}, $tail);
+			$pos = $len;
+			last;
+		}
+		$pos = $m->[1];
+	}
+	$out .= esc_html(substr($chopped, $pos)).$tail;
+
+	return $out;
+}
+
 ## ----------------------------------------------------------------------
 ## functions returning short strings
 
@@ -5372,7 +5410,8 @@ sub git_project_list_rows {
 		      "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
 		                        -class => "list", -title => $pr->{'descr_long'}},
 		                        $search_regexp
-		                        ? esc_html_match_hl($pr->{'descr_long'}, $search_regexp)
+		                        ? esc_html_match_hl_chopped($pr->{'descr_long'},
+		                                                    $pr->{'descr'}, $search_regexp)
 		                        : esc_html($pr->{'descr'})) .
 		      "</td>\n" .
 		      "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i></td>\n";
-- 
1.7.9
