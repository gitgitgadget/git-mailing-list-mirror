From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/7] gitweb: Expand href() function to use key as param name for no mapping
Date: Thu, 17 Aug 2006 11:21:25 +0200
Message-ID: <11558064893139-git-send-email-jnareb@gmail.com>
References: <11558064883957-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 17 11:22:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDe4j-0002Cb-Sa
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWHQJVv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWHQJVu
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:21:50 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:20360 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932463AbWHQJVl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 05:21:41 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7H9KPm3023248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Aug 2006 11:20:25 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7H9LTAc003707;
	Thu, 17 Aug 2006 11:21:29 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7H9LTaX003706;
	Thu, 17 Aug 2006 11:21:29 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11558064883957-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25569>

Expand href() function to use key name of params hash as a query param
name, if there is no mapping for given key name.

It is now safer to use href(); no errors, but links might not work
correctly if caller didn't provide correct arguments.

Future proofing.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |  143 +++++++++++++++++++++++++++-------------------------
 1 files changed, 73 insertions(+), 70 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 86266da..d37e7f1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -204,8 +204,13 @@ sub href(%) {
 
 	my $href = "$my_uri?";
 	$href .= esc_param( join(";",
-		map { "$mapping{$_}=$params{$_}" } keys %params
-	) );
+		map {
+			if (exists $mapping{$_}) {
+				"$mapping{$_}=$params{$_}";
+			} else {
+				"$_=$params{$_}";
+			}
+		} keys %params ) );
 
 	return $href;
 }
@@ -1174,66 +1179,6 @@ sub git_print_page_path {
 	}
 }
 
-sub git_print_log {
-	my $log = shift;
-
-	# remove leading empty lines
-	while (defined $log->[0] && $log->[0] eq "") {
-		shift @$log;
-	}
-
-	# print log
-	my $signoff = 0;
-	my $empty = 0;
-	foreach my $line (@$log) {
-		# print only one empty line
-		# do not print empty line after signoff
-		if ($line eq "") {
-			next if ($empty || $signoff);
-			$empty = 1;
-		} else {
-			$empty = 0;
-		}
-		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
-			$signoff = 1;
-			print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
-		} else {
-			$signoff = 0;
-			print format_log_line_html($line) . "<br/>\n";
-		}
-	}
-}
-
-sub git_print_simplified_log {
-	my $log = shift;
-	my $remove_title = shift;
-
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
-}
-
 ## ......................................................................
 ## functions printing large fragments of HTML
 
@@ -1322,7 +1267,7 @@ sub git_difftree_body {
 			      "<td class=\"link\">" .
 				$cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$file)}, "blob");
 			if ($to_id ne $from_id) { # modified
-				print " | " . $cgi->a({-href => href(action=>"blobdiff", hash=>$to_id, hash_parent=>$from_id, hash_base=>$hash, file_name=>$file)}, "diff");
+				print $cgi->a({-href => href(action=>"blobdiff", hash=>$to_id, hash_parent=>$from_id, hash_base=>$hash, file_name=>$file)}, "diff");
 			}
 			print " | " . $cgi->a({-href => href(action=>"history", hash_base=>$hash, file_name=>$file)}, "history") . "\n";
 			print "</td>\n";
@@ -2215,10 +2160,27 @@ sub git_log {
 		      "<br/>\n" .
 		      "</div>\n" .
 		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
-		      "</div>\n";
-
-		print "<div class=\"log_body\">\n";
-		git_print_simplified_log($co{'comment'});
+		      "</div>\n" .
+		      "<div class=\"log_body\">\n";
+		my $comment = $co{'comment'};
+		my $empty = 0;
+		foreach my $line (@$comment) {
+			if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
+				next;
+			}
+			if ($line eq "") {
+				if ($empty) {
+					next;
+				}
+				$empty = 1;
+			} else {
+				$empty = 0;
+			}
+			print format_log_line_html($line) . "<br/>\n";
+		}
+		if (!$empty) {
+			print "<br/>\n";
+		}
 		print "</div>\n";
 	}
 	git_footer_html();
@@ -2299,9 +2261,28 @@ sub git_commit {
 	}
 	print "</table>".
 	      "</div>\n";
-
 	print "<div class=\"page_body\">\n";
-	git_print_log($co{'comment'});
+	my $comment = $co{'comment'};
+	my $empty = 0;
+	my $signed = 0;
+	foreach my $line (@$comment) {
+		# print only one empty line
+		if ($line eq "") {
+			if ($empty || $signed) {
+				next;
+			}
+			$empty = 1;
+		} else {
+			$empty = 0;
+		}
+		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
+			$signed = 1;
+			print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
+		} else {
+			$signed = 0;
+			print format_log_line_html($line) . "<br/>\n";
+		}
+	}
 	print "</div>\n";
 
 	git_difftree_body(\@difftree, $parent);
@@ -2367,7 +2348,29 @@ sub git_commitdiff {
 	git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
 	git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
 	print "<div class=\"page_body\">\n";
-	git_print_simplified_log($co{'comment'}, 1); # skip title
+	my $comment = $co{'comment'};
+	my $empty = 0;
+	my $signed = 0;
+	my @log = @$comment;
+	# remove first and empty lines after that
+	shift @log;
+	while (defined $log[0] && $log[0] eq "") {
+		shift @log;
+	}
+	foreach my $line (@log) {
+		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
+			next;
+		}
+		if ($line eq "") {
+			if ($empty) {
+				next;
+			}
+			$empty = 1;
+		} else {
+			$empty = 0;
+		}
+		print format_log_line_html($line) . "<br/>\n";
+	}
 	print "<br/>\n";
 	foreach my $line (@difftree) {
 		# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M      ls-files.c'
-- 
1.4.1.1
