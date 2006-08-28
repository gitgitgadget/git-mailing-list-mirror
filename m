From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/5] gitweb: Make git_print_log generic; git_print_simplified_log uses it
Date: Mon, 28 Aug 2006 14:48:10 +0200
Message-ID: <11567692952496-git-send-email-jnareb@gmail.com>
References: <11567692943154-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 28 14:48:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHgXU-0005XD-Md
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 14:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWH1Ms0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 08:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWH1Ms0
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 08:48:26 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:8882 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1750730AbWH1MsV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 08:48:21 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7SCl27p031907
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Aug 2006 14:47:02 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7SCmFMj017608;
	Mon, 28 Aug 2006 14:48:15 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7SCmFlH017607;
	Mon, 28 Aug 2006 14:48:15 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11567692943154-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26149>

Collapse git_print_log and git_print_simplified_log into one
subroutine git_print_log.  git_print_simplified_log now simply calls
git_print_log with proper options.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   63 ++++++++++++++++++++++++++--------------------------
 1 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 59f1a87..e318f50 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1364,9 +1364,15 @@ sub git_print_page_path {
 	}
 }
 
-sub git_print_log {
+# sub git_print_log (\@;%) {
+sub git_print_log ($;%) {
 	my $log = shift;
+	my %opts = @_;
 
+	if ($opts{'-remove_title'}) {
+		# remove title, i.e. first line of log
+		shift @$log;
+	}
 	# remove leading empty lines
 	while (defined $log->[0] && $log->[0] eq "") {
 		shift @$log;
@@ -1376,6 +1382,19 @@ sub git_print_log {
 	my $signoff = 0;
 	my $empty = 0;
 	foreach my $line (@$log) {
+		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
+			$signoff = 1;
+			if (! $opts{'-remove_signoff'}) {
+				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
+				next;
+			} else {
+				# remove signoff lines
+				next;
+			}
+		} else {
+			$signoff = 0;
+		}
+
 		# print only one empty line
 		# do not print empty line after signoff
 		if ($line eq "") {
@@ -1384,13 +1403,13 @@ sub git_print_log {
 		} else {
 			$empty = 0;
 		}
-		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
-			$signoff = 1;
-			print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
-		} else {
-			$signoff = 0;
-			print format_log_line_html($line) . "<br/>\n";
-		}
+
+		print format_log_line_html($line) . "<br/>\n";
+	}
+
+	if ($opts{'-final_empty_line'}) {
+		# end with single empty line
+		print "<br/>\n" unless $empty;
 	}
 }
 
@@ -1398,30 +1417,10 @@ sub git_print_simplified_log {
 	my $log = shift;
 	my $remove_title = shift;
 
-	shift @$log if $remove_title;
-	# remove leading empty lines
-	while (defined $log->[0] && $log->[0] eq "") {
-		shift @$log;
-	}
-
-	# simplify and print log
-	my $empty = 0;
-	foreach my $line (@$log) {
-		# remove signoff lines
-		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
-			next;
-		}
-		# print only one empty line
-		if ($line eq "") {
-			next if $empty;
-			$empty = 1;
-		} else {
-			$empty = 0;
-		}
-		print format_log_line_html($line) . "<br/>\n";
-	}
-	# end with single empty line
-	print "<br/>\n" unless $empty;
+	git_print_log($log,
+		-final_empty_line=> 1,
+		-remove_signoff => 1,
+		-remove_title => $remove_title);
 }
 
 ## ......................................................................
-- 
1.4.1.1
