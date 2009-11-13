From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb: Refactor 'log' action generation, adding git_log_body()
Date: Fri, 13 Nov 2009 02:02:12 +0100
Message-ID: <1258074134-27011-2-git-send-email-jnareb@gmail.com>
References: <1258074134-27011-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 02:02:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8kYG-0008Cr-NJ
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 02:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775AbZKMBBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 20:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754736AbZKMBBs
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 20:01:48 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:37548 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbZKMBBn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 20:01:43 -0500
Received: by fxm21 with SMTP id 21so2929464fxm.21
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 17:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+DihIakI+ROTTpBm1c3K+TEvpt+VJHFRv4vxc+brtQg=;
        b=r4pmmHVrlscIyB4rcYmQ0tCuvmRjgTH4ZKcM5s5pC40q9q3V+dF3kK1foeDt1fWwse
         lEhJ9vqcYdx95hOGNIfW3LHBh+Ms8MC4PLpaq3K51VpkhNS2WdexL0uFYTPlkBi+bVlQ
         eCeRUDlJR+jNpljDh1UCjyIgHTuh117Z90YuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AvtWoLgy14RFNiLuudv/1a3oaQDvdWbarzBTh8/GovjQrN3JSCZCo8wdJF27bwxLwx
         EPAWBfTimcXw7GTpKUqUwhYzHUhnqFZ9cLUZHPKBFWDHSP4i5A06eiPysfAyngJopBdN
         ii2E3SYQ4kdkjFG7gKXejEfNeTv2FDmXCz9+A=
Received: by 10.204.153.220 with SMTP id l28mr1714769bkw.86.1258074107612;
        Thu, 12 Nov 2009 17:01:47 -0800 (PST)
Received: from localhost.localdomain (abvv30.neoplus.adsl.tpnet.pl [83.8.219.30])
        by mx.google.com with ESMTPS id 16sm1114802fxm.8.2009.11.12.17.01.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 17:01:46 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nAD12Kad027047;
	Fri, 13 Nov 2009 02:02:20 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nAD12Kc3027046;
	Fri, 13 Nov 2009 02:02:20 +0100
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1258074134-27011-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132809>

Put the main part of 'log' view generation into git_log_body,
similarly how it is done for 'shortlog' and 'history' views (and
also for 'tags' and 'heads' views).

This is preparation for extracting common code between 'log',
'shortlog' and 'history' actions.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is pure refactoring: output should change.

 gitweb/gitweb.perl |   81 ++++++++++++++++++++++++++++++---------------------
 1 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e4cbfc3..68dbd9e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4361,6 +4361,46 @@ sub git_project_list_body {
 	print "</table>\n";
 }
 
+sub git_log_body {
+	# uses global variable $project
+	my ($commitlist, $from, $to, $refs, $extra) = @_;
+
+	$from = 0 unless defined $from;
+	$to = $#{$commitlist} if (!defined $to || $#{$commitlist} < $to);
+
+	for (my $i = 0; $i <= $to; $i++) {
+		my %co = %{$commitlist->[$i]};
+		next if !%co;
+		my $commit = $co{'id'};
+		my $ref = format_ref_marker($refs, $commit);
+		my %ad = parse_date($co{'author_epoch'});
+		git_print_header_div('commit',
+		               "<span class=\"age\">$co{'age_string'}</span>" .
+		               esc_html($co{'title'}) . $ref,
+		               $commit);
+		print "<div class=\"title_text\">\n" .
+		      "<div class=\"log_link\">\n" .
+		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") .
+		      " | " .
+		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") .
+		      " | " .
+		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") .
+		      "<br/>\n" .
+		      "</div>\n";
+		      git_print_authorship(\%co, -tag => 'span');
+		      print "<br/>\n</div>\n";
+
+		print "<div class=\"log_body\">\n";
+		git_print_log($co{'comment'}, -final_empty_line=> 1);
+		print "</div>\n";
+	}
+	if ($extra) {
+		print "<div class=\"page_nav\">\n";
+		print "$extra\n";
+		print "</div>\n";
+	}
+}
+
 sub git_shortlog_body {
 	# uses global variable $project
 	my ($commitlist, $from, $to, $refs, $extra) = @_;
@@ -5309,7 +5349,12 @@ sub git_log {
 	my @commitlist = parse_commits($hash, 101, (100 * $page));
 
 	my $paging_nav = format_paging_nav('log', $hash, $head, $page, $#commitlist >= 100);
-
+	my $next_link;
+	if ($#commitlist >= 100) {
+		$next_link =
+			$cgi->a({-href => href(-replay=>1, page=>$page+1),
+			         -accesskey => "n", -title => "Alt-n"}, "next");
+	}
 	my ($patch_max) = gitweb_get_feature('patches');
 	if ($patch_max) {
 		if ($patch_max < 0 || @commitlist <= $patch_max) {
@@ -5328,39 +5373,9 @@ sub git_log {
 		git_print_header_div('summary', $project);
 		print "<div class=\"page_body\"> Last change $co{'age_string'}.<br/><br/></div>\n";
 	}
-	my $to = ($#commitlist >= 99) ? (99) : ($#commitlist);
-	for (my $i = 0; $i <= $to; $i++) {
-		my %co = %{$commitlist[$i]};
-		next if !%co;
-		my $commit = $co{'id'};
-		my $ref = format_ref_marker($refs, $commit);
-		my %ad = parse_date($co{'author_epoch'});
-		git_print_header_div('commit',
-		               "<span class=\"age\">$co{'age_string'}</span>" .
-		               esc_html($co{'title'}) . $ref,
-		               $commit);
-		print "<div class=\"title_text\">\n" .
-		      "<div class=\"log_link\">\n" .
-		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") .
-		      " | " .
-		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") .
-		      " | " .
-		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") .
-		      "<br/>\n" .
-		      "</div>\n";
-		      git_print_authorship(\%co, -tag => 'span');
-		      print "<br/>\n</div>\n";
 
-		print "<div class=\"log_body\">\n";
-		git_print_log($co{'comment'}, -final_empty_line=> 1);
-		print "</div>\n";
-	}
-	if ($#commitlist >= 100) {
-		print "<div class=\"page_nav\">\n";
-		print $cgi->a({-href => href(-replay=>1, page=>$page+1),
-			       -accesskey => "n", -title => "Alt-n"}, "next");
-		print "</div>\n";
-	}
+	git_log_body(\@commitlist, 0, 99, $refs, $next_link);
+
 	git_footer_html();
 }
 
-- 
1.6.5
