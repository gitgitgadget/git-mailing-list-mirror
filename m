From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3/RFC 7/8] gitweb: Highlight matched part of shortened project description
Date: Wed, 15 Feb 2012 21:38:51 +0100
Message-ID: <1329338332-30358-8-git-send-email-jnareb@gmail.com>
References: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 21:41:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxlfp-0006XA-P3
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 21:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512Ab2BOUlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 15:41:40 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52573 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280Ab2BOUli (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 15:41:38 -0500
Received: by eekc14 with SMTP id c14so521814eek.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 12:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ildcm/9yRWROIVHV6JDPkr7t5D7E8iuNlilHKn8PFZs=;
        b=OR860IUknlqw66xMyOwx1AuTzwf/XDsScMkBdWRKlGAb0WNfdO759LkMNH78l0urly
         PHDMgjfq4k9jIf63EMrk3eJL3DWIql5bNelOO/bgfm6BFf/Z23IH1JabFHZ8ps6703sf
         QBuuCwAIf71JRFArFxPWthdPTU8l83filPwp4=
Received: by 10.213.23.1 with SMTP id p1mr1569333ebb.0.1329338497292;
        Wed, 15 Feb 2012 12:41:37 -0800 (PST)
Received: from localhost.localdomain (abwo207.neoplus.adsl.tpnet.pl. [83.8.238.207])
        by mx.google.com with ESMTPS id c16sm14922307eei.1.2012.02.15.12.41.35
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 12:41:37 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190856>

Previous commit make gitweb use esc_html_match_hl() to mark match in
the _whole_ description of a project when searching projects.

This commit makes gitweb highlight match in _shortened_ description,
based on match in whole description, using esc_html_match_hl_chopped()
subroutine.

If match is in removed (chopped) part, even partially, then trailing
"... " is highlighted.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
It is marked as RFC, because I am not sure if it is right way to
highlight match in shortened string, or if we better use full string,
or full string if match is in chopped part.

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

 gitweb/gitweb.perl |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a109ebb..a2e2023 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1747,11 +1747,46 @@ sub esc_html_match_hl {
 	my ($str, $regexp) = @_;
 	return esc_html($str) unless defined $regexp;
 
+	return esc_html_match_hl_chopped($str, undef, $regexp);
+}
+
+
+# highlight match (if any) of shortened string, and escape HTML
+sub esc_html_match_hl_chopped {
+	my ($str, $chopped, $regexp) = @_;
+	return esc_html(defined $chopped ? $chopped : $str) unless defined $regexp;
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
 
 	return esc_html_hl_regions($str, 'match', @matches);
 }
@@ -5409,7 +5444,8 @@ sub git_project_list_rows {
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
