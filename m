From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 6/7] gitweb: Assume parsed revision list in git_shortlog_body and git_history_body
Date: Wed,  6 Sep 2006 15:08:10 +0200
Message-ID: <11575480922345-git-send-email-jnareb@gmail.com>
References: <200609061504.40725.jnareb@gmail.com> <1157548091229-git-send-email-jnareb@gmail.com> <11575480912922-git-send-email-jnareb@gmail.com> <11575480922090-git-send-email-jnareb@gmail.com> <11575480922634-git-send-email-jnareb@gmail.com> <11575480921279-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 06 15:09:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKx8h-0005m3-6g
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 15:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWIFNIV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 09:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWIFNIU
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 09:08:20 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:41963 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1750856AbWIFNIS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 09:08:18 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k86D6qoV031865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Sep 2006 15:06:53 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k86D8CTT008425;
	Wed, 6 Sep 2006 15:08:12 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k86D8CLo008424;
	Wed, 6 Sep 2006 15:08:12 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11575480921279-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26528>

Assume that git_shortlog and git_history uses parse_rev_list
subroutine, and git_shortlog_body and git_history_body gets parsed
revision list as a parameter.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   35 ++++++++++++-----------------------
 1 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e665d94..be4db08 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1943,21 +1943,19 @@ sub git_shortlog_body {
 	print "<table class=\"shortlog\" cellspacing=\"0\">\n";
 	my $alternate = 0;
 	for (my $i = $from; $i <= $to; $i++) {
-		my $commit = $revlist->[$i];
-		#my $ref = defined $refs ? format_ref_marker($refs, $commit) : '';
+		my $co = $revlist->[$i];
+		my $commit = $co->{'id'};
 		my $ref = format_ref_marker($refs, $commit);
-		my %co = ref $commit ? %$commit : parse_commit($commit);
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
-		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 10)) . "</i></td>\n" .
+		print "<td title=\"$co->{'age_string_age'}\"><i>$co->{'age_string_date'}</i></td>\n" .
+		      "<td><i>" . esc_html(chop_str($co->{'author_name'}, 10)) . "</i></td>\n" .
 		      "<td>";
-		print format_subject_html($co{'title'}, $co{'title_short'},
+		print format_subject_html($co->{'title'}, $co->{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
 		print "</td>\n" .
 		      "<td class=\"link\">" .
@@ -1987,17 +1985,8 @@ sub git_history_body {
 	print "<table class=\"history\" cellspacing=\"0\">\n";
 	my $alternate = 0;
 	for (my $i = $from; $i <= $to; $i++) {
-		if (ref($revlist->[$i]) ne "HASH" &&
-		    $revlist->[$i] !~ m/^([0-9a-fA-F]{40})/) {
-			next;
-		}
-
-		my $commit = $1;
-		my %co = ref $commit ? %$commit : parse_commit($commit);
-		if (!%co) {
-			next;
-		}
-
+		my $co = $revlist->[$i];
+		my $commit = $co->{'id'};
 		my $ref = format_ref_marker($refs, $commit);
 
 		if ($alternate) {
@@ -2006,12 +1995,12 @@ sub git_history_body {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      # shortlog uses      chop_str($co{'author_name'}, 10)
-		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 3)) . "</i></td>\n" .
+		print "<td title=\"$co->{'age_string_age'}\"><i>$co->{'age_string_date'}</i></td>\n" .
+		      # shortlog uses      chop_str($co->{'author_name'}, 10)
+		      "<td><i>" . esc_html(chop_str($co->{'author_name'}, 15, 3)) . "</i></td>\n" .
 		      "<td>";
-		# originally git_history used chop_str($co{'title'}, 50)
-		print format_subject_html($co{'title'}, $co{'title_short'},
+		# originally git_history used chop_str($co->{'title'}, 50)
+		print format_subject_html($co->{'title'}, $co->{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
 		print "</td>\n" .
 		      "<td class=\"link\">" .
-- 
1.4.2
