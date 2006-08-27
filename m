From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: Make git_print_log generic; git_print_simplified_log uses it
Date: Sun, 27 Aug 2006 23:55:07 +0200
Message-ID: <200608272355.07625.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 27 23:55:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHSb4-0005YC-Mn
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 23:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWH0VzJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 17:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWH0VzI
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 17:55:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:57380 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750726AbWH0VzE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 17:55:04 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1124279nfa
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 14:55:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fUk2/Eh/LRqHsqKIFGN/c8ihufFSbGGX8M8mHrjKpLg6Oylq+nIe3Sj9LyjCSPQvbqv7SbI4ii8UWPIzHEETOTd8PHwT6ayKoWB3eaWnNmxgdeRV6mxvJJG5pxwSYqzSAJg/aIWfbz8CGs3P9Ki25ZpJrrAEa1ny0uzhqYfbuYc=
Received: by 10.49.55.13 with SMTP id h13mr8205199nfk;
        Sun, 27 Aug 2006 14:55:03 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id i1sm8074986nfe.2006.08.27.14.55.02;
        Sun, 27 Aug 2006 14:55:03 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26119>

Collapse git_print_log and git_print_simplified_log into one
subroutine git_print_log.  git_print_simplified_log now simply calls
git_print_log with proper options.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch doesn't change output any, but it makes it easy
to add signoff lines (to not remove them) to commitdiff and log views
(as requested by Linus).

The RFC is about style of git_print_log function. Is it a good idea
and good implementation to pass miscelaneus options as hash values
instead of using fixed order of parameters, and passing 1 or undef?
Is it a good naming of parameters like '-remove_title', or would
'remove_title' or 'remove-title' be better?


 gitweb/gitweb.perl |   63 ++++++++++++++++++++++++++--------------------------
 1 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ae18c27..b6c1620 100755
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
