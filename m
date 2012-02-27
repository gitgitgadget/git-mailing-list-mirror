From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv4 4/4] gitweb: Highlight matched part of shortened project description
Date: Mon, 27 Feb 2012 02:55:22 +0100
Message-ID: <1330307722-25351-5-git-send-email-jnareb@gmail.com>
References: <1330307722-25351-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 02:56:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1pp3-0007tu-Ml
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 02:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559Ab2B0B4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 20:56:05 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63081 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503Ab2B0Bzh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 20:55:37 -0500
Received: by mail-ey0-f174.google.com with SMTP id h12so2006941eaa.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 17:55:36 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.23.7 as permitted sender) client-ip=10.213.23.7;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.23.7 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.23.7])
        by 10.213.23.7 with SMTP id p7mr922300ebb.66.1330307736716 (num_hops = 1);
        Sun, 26 Feb 2012 17:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=78qqtbl/gM24WmR5K6VrSr7upwf+KgXMF3hhFdIehJ8=;
        b=EzNk5lAg2GEucHoIBVBCkeXz1uz07dvuJCppC2me03V2zn5AgmJ5nLUEyQu97BcRQG
         ETMr3oWmBbjj71Ik+oOdMLIFjsOIShKIbofoEBComBxO3PZuLODmmAYgKfZHom9dXB5N
         tOHb4JPdh/mkJgRHeGBbkyDZ5CmvOYKthQvQQ=
Received: by 10.213.23.7 with SMTP id p7mr693613ebb.66.1330307736629;
        Sun, 26 Feb 2012 17:55:36 -0800 (PST)
Received: from localhost.localdomain (abvv154.neoplus.adsl.tpnet.pl. [83.8.219.154])
        by mx.google.com with ESMTPS id n17sm52112996eei.3.2012.02.26.17.55.35
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Feb 2012 17:55:36 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1330307722-25351-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191598>

Previous commit make gitweb use esc_html_match_hl() to mark match in
the _whole_ description of a project when searching projects.

This commit makes gitweb highlight match in _shortened_ description,
based on match in whole description, using esc_html_match_hl_chopped()
subroutine.

If match is in removed (chopped) part, even partially, then trailing
"... " is highlighted.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
It was marked as RFC, because I am not sure if it is right way to
highlight match in shortened string, or if we better use full string,
or full string if match is in chopped part.

Changes from v3:
* The relation between esc_html_match_hl() and esc_html_match_hl_chopped()
  got changed; instead of esc_html_match_hl() being wrapper and
  esc_html_match_hl_chopped() doing all the work, common part is
  refactored into matchpos_list(), and both esc_html_match_hl* are
  kept separate.  It results in a bit of code duplication, but
  hopefully it also makes code more clear (it is e.g. less nested).

* Brings back -title that was removed in previous commit, to show full
  description on mouseover (partial revert of previous commit).

Changes from v2:
* Harden esc_html_match_hl_chopped() against calling with both
  $chopped and $regexp undefined (even though it wouldn't happen
  with current code).

* esc_html_match_hl_chopped() uses now esc_html_hl_regions(),
  like esc_html_match_hl() used to do.

Changes from v1:
* Instead of esc_html_match_hl_chopped() duplicating much od code in
  esc_html_match_hl(), make esc_html_match_hl() call the *_chopped()
  one with $chopped set to undef.

  Now managing highlighting of $chopped part is just a matter of
  adjusting and filtering @matches to apply to $chopped rather than
  original $str where match was performed.

  As a side issue when match span past chop point current code uses
  one selection <span class+match">foo... </span> and not two
  <span class="match">foo</span><span class="match">... </span>

 gitweb/gitweb.perl |   52 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 03a8dd9..1fc5361 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1742,20 +1742,61 @@ sub esc_html_hl_regions {
 	return $out;
 }
 
-# highlight match (if any), and escape HTML
-sub esc_html_match_hl {
+# return positions of beginning and end of each match
+sub matchpos_list {
 	my ($str, $regexp) = @_;
-	return esc_html($str) unless defined $regexp;
+	return unless (defined $str && defined $regexp);
 
 	my @matches;
 	while ($str =~ /$regexp/g) {
 		push @matches, [$-[0], $+[0]];
 	}
+	return @matches;
+}
+
+# highlight match (if any), and escape HTML
+sub esc_html_match_hl {
+	my ($str, $regexp) = @_;
+	return esc_html($str) unless defined $regexp;
+
+	my @matches = matchpos_list($str, $regexp);
 	return esc_html($str) unless @matches;
 
 	return esc_html_hl_regions($str, 'match', @matches);
 }
 
+
+# highlight match (if any) of shortened string, and escape HTML
+sub esc_html_match_hl_chopped {
+	my ($str, $chopped, $regexp) = @_;
+	return esc_html_match_hl($str, $regexp) unless defined $chopped;
+
+	my @matches = matchpos_list($str, $regexp);
+	return esc_html($chopped) unless @matches;
+
+	# filter matches so that we mark chopped string
+	my $tail = "... "; # see chop_str
+	unless ($chopped =~ s/\Q$tail\E$//) {
+		$tail = '';
+	}
+	my $chop_len = length($chopped);
+	my $tail_len = length($tail);
+	my @filtered;
+
+	for my $m (@matches) {
+		if ($m->[0] > $chop_len) {
+			push @filtered, [ $chop_len, $chop_len + $tail_len ] if ($tail_len > 0);
+			last;
+		} elsif ($m->[1] > $chop_len) {
+			push @filtered, [ $m->[0], $chop_len + $tail_len ];
+			last;
+		}
+		push @filtered, $m;
+	}
+
+	return esc_html_hl_regions($chopped . $tail, 'match', @filtered);
+}
+
 ## ----------------------------------------------------------------------
 ## functions returning short strings
 
@@ -5412,9 +5453,10 @@ sub git_project_list_rows {
 		      "</td>\n" .
 		      "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
 		                        -class => "list",
-		                        $search_regexp ? () : -title => $pr->{'descr_long'}},
+		                        -title => $pr->{'descr_long'}},
 		                        $search_regexp
-		                        ? esc_html_match_hl($pr->{'descr_long'}, $search_regexp)
+		                        ? esc_html_match_hl_chopped($pr->{'descr_long'},
+		                                                    $pr->{'descr'}, $search_regexp)
 		                        : esc_html($pr->{'descr'})) .
 		      "</td>\n" .
 		      "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i></td>\n";
-- 
1.7.9
