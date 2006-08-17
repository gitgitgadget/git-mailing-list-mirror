From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/7] gitweb: Refactor printing commit message
Date: Thu, 17 Aug 2006 11:21:23 +0200
Message-ID: <11558064891330-git-send-email-jnareb@gmail.com>
References: <11558064883957-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 17 11:22:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDe4l-0002Cb-HC
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWHQJVm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWHQJVl
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:21:41 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:18312 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932459AbWHQJVh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 05:21:37 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7H9KPlo023244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Aug 2006 11:20:25 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7H9LTKG003695;
	Thu, 17 Aug 2006 11:21:29 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7H9LTiO003694;
	Thu, 17 Aug 2006 11:21:29 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11558064883957-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25571>

Separate pretty-printing commit message (comment) into git_print_log
and git_print_simplified_log subroutines. As of now the former is used
in git_commit, the latter in git_log and git_commitdiff.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |  132 ++++++++++++++++++++++++++--------------------------
 1 files changed, 67 insertions(+), 65 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7c92ac3..0d869f2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1174,6 +1174,66 @@ sub git_print_page_path {
 	}
 }
 
+sub git_print_log {
+	my $log = shift;
+
+	# remove leading empty lines
+	while (defined $log->[0] && $log->[0] eq "") {
+		shift @$log;
+	}
+
+	# print log
+	my $signoff = 0;
+	my $empty = 0;
+	foreach my $line (@$log) {
+		# print only one empty line
+		# do not print empty line after signoff
+		if ($line eq "") {
+			next if ($empty || $signoff);
+			$empty = 1;
+		} else {
+			$empty = 0;
+		}
+		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
+			$signoff = 1;
+			print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
+		} else {
+			$signoff = 0;
+			print format_log_line_html($line) . "<br/>\n";
+		}
+	}
+}
+
+sub git_print_simplified_log {
+	my $log = shift;
+	my $remove_title = shift;
+
+	shift @$log if $remove_title;
+	# remove leading empty lines
+	while (defined $log->[0] && $log->[0] eq "") {
+		shift @$log;
+	}
+
+	# simplify and print log
+	my $empty = 0;
+	foreach my $line (@$log) {
+		# remove signoff lines
+		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
+			next;
+		}
+		# print only one empty line
+		if ($line eq "") {
+			next if $empty;
+			$empty = 1;
+		} else {
+			$empty = 0;
+		}
+		print format_log_line_html($line) . "<br/>\n";
+	}
+	# end with single empty line
+	print "<br/>\n" unless $empty;
+}
+
 ## ......................................................................
 ## functions printing large fragments of HTML
 
@@ -2155,27 +2215,10 @@ sub git_log {
 		      "<br/>\n" .
 		      "</div>\n" .
 		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
-		      "</div>\n" .
-		      "<div class=\"log_body\">\n";
-		my $comment = $co{'comment'};
-		my $empty = 0;
-		foreach my $line (@$comment) {
-			if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
-				next;
-			}
-			if ($line eq "") {
-				if ($empty) {
-					next;
-				}
-				$empty = 1;
-			} else {
-				$empty = 0;
-			}
-			print format_log_line_html($line) . "<br/>\n";
-		}
-		if (!$empty) {
-			print "<br/>\n";
-		}
+		      "</div>\n";
+
+		print "<div class=\"log_body\">\n";
+		git_print_simplified_log($co{'comment'});
 		print "</div>\n";
 	}
 	git_footer_html();
@@ -2256,28 +2299,9 @@ sub git_commit {
 	}
 	print "</table>".
 	      "</div>\n";
+
 	print "<div class=\"page_body\">\n";
-	my $comment = $co{'comment'};
-	my $empty = 0;
-	my $signed = 0;
-	foreach my $line (@$comment) {
-		# print only one empty line
-		if ($line eq "") {
-			if ($empty || $signed) {
-				next;
-			}
-			$empty = 1;
-		} else {
-			$empty = 0;
-		}
-		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
-			$signed = 1;
-			print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
-		} else {
-			$signed = 0;
-			print format_log_line_html($line) . "<br/>\n";
-		}
-	}
+	git_print_log($co{'comment'});
 	print "</div>\n";
 
 	git_difftree_body(\@difftree, $parent);
@@ -2343,29 +2367,7 @@ sub git_commitdiff {
 	git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
 	git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
 	print "<div class=\"page_body\">\n";
-	my $comment = $co{'comment'};
-	my $empty = 0;
-	my $signed = 0;
-	my @log = @$comment;
-	# remove first and empty lines after that
-	shift @log;
-	while (defined $log[0] && $log[0] eq "") {
-		shift @log;
-	}
-	foreach my $line (@log) {
-		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
-			next;
-		}
-		if ($line eq "") {
-			if ($empty) {
-				next;
-			}
-			$empty = 1;
-		} else {
-			$empty = 0;
-		}
-		print format_log_line_html($line) . "<br/>\n";
-	}
+	git_print_simplified_log($co{'comment'}, 1); # skip title
 	print "<br/>\n";
 	foreach my $line (@difftree) {
 		# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M      ls-files.c'
-- 
1.4.1.1
