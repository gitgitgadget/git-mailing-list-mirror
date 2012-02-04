From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFCv2 5/5] gitweb: Highlight matched part of shortened project description
Date: Sat, 4 Feb 2012 19:56:35 +0100
Message-ID: <201202041956.36309.jnareb@gmail.com>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com> <1328359648-29511-6-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 19:56:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtkn2-00069J-Nq
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 19:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639Ab2BDS4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 13:56:44 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51066 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381Ab2BDS4n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 13:56:43 -0500
Received: by mail-ee0-f46.google.com with SMTP id c14so1616566eek.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 10:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=ahIFxhVXpGEiK1cKgjXtIEqaN98q49+eaC10/1umTME=;
        b=atuP4F7S4aRF2Lv+gGl9BNZO/r4+QhgWaQvPS3y9IlmpxFbgqI2ssnsxcnkK0Snnrl
         XIUkw2EiC7+RgpB0dhEeO8DGSIbL/f/ZPidEVb6WBR7AqXOPfzsyI6AEA4l44da7sw7K
         8fZs8kfPbRLkGbWSd+fl0H3WgSUDPxpt4a6Ds=
Received: by 10.14.49.144 with SMTP id x16mr3758975eeb.25.1328381802735;
        Sat, 04 Feb 2012 10:56:42 -0800 (PST)
Received: from [192.168.1.13] (abwp204.neoplus.adsl.tpnet.pl. [83.8.239.204])
        by mx.google.com with ESMTPS id y12sm38135202eeb.11.2012.02.04.10.56.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 10:56:41 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1328359648-29511-6-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189892>

Previous commit make gitweb use esc_html_match_hl() to mark match in
the _whole_ description of a project when searching projects.

This commit makes gitweb highlight match in _shortened_ description,
based on match in whole description, using esc_html_match_hl_chopped()
subroutine.

If match is in removed (chopped) part, even partially, then trailing
"... " is highlighted.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This version removes code duplication from v1.

It is still marked as RFC, because I am not sure if it is right way
to highlight match in shortened string, or if we better use full string,
or full string if match is in chopped part.

 gitweb/gitweb.perl |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c650268..f71afe0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1720,11 +1720,46 @@ sub esc_html_match_hl {
 	my ($str, $regexp) = @_;
 	return esc_html($str) unless defined $regexp;
 
+	return esc_html_match_hl_chopped($str, undef, $regexp);
+}
+
+
+# highlight match (if any) of shortened string, and escape HTML
+sub esc_html_match_hl_chopped {
+	my ($str, $chopped, $regexp) = @_;
+	return esc_html($chopped) unless defined $regexp;
+
 	my @matches;
 	while ($str =~ /$regexp/g) {
 		push @matches, [$-[0], $+[0]];
 	}
-	return esc_html($str) unless @matches;
+	return esc_html(defined $chopped ? $chopped : $str) unless @matches;
+
+	# filter matches so that we mark chopped string, if it is present
+	if (defined $chopped) {
+		my $tail = "... "; # see chop_str
+		unless ($chopped =~ s/\Q$tail\E$//) {
+			$tail = '';
+		}
+		my $chop_len = length($chopped);
+		my $tail_len = length($tail);
+		my @filtered;
+
+		for my $m (@matches) {
+			if ($m->[0] > $chop_len) {
+				push @filtered, [ $chop_len, $chop_len + $tail_len ] if ($tail_len > 0);
+				last;
+			} elsif ($m->[1] > $chop_len) {
+				push @filtered, [ $m->[0], $chop_len + $tail_len ];
+				last;
+			}
+			push @filtered, $m;
+		}
+
+		# further operations are on chopped string
+		$str = $chopped . $tail;
+		@matches = @filtered;
+	}
 
 	my $out = '';
 	my $pos = 0;
@@ -5372,7 +5407,8 @@ sub git_project_list_rows {
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
