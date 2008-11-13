From: Ian Hilt <ian.hilt@gmx.com>
Subject: [PATCH v2] Edit recipient addresses with the --compose flag
Date: Wed, 12 Nov 2008 21:50:02 -0500
Message-ID: <1226544602-1839-1-git-send-email-ian.hilt@gmx.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 03:51:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0SJ3-0003ig-Os
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 03:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbYKMCuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 21:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbYKMCuO
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 21:50:14 -0500
Received: from mail.gmx.com ([74.208.5.67]:51083 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753510AbYKMCuN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 21:50:13 -0500
Received: (qmail invoked by alias); 13 Nov 2008 02:50:09 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com [75.185.223.130]
  by mail.gmx.com (mp-us002) with SMTP; 12 Nov 2008 21:50:09 -0500
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX19z3PpW9FtzSPphqhfyZ+BTtVTtoBhbWD5fSh2uqI
	j1/q+R/LOA9ZRx
X-Mailer: git-send-email 1.6.0.3.523.g304d0
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100847>

Sometimes specifying the recipient addresses can be tedious on the
command-line.  This commit allows the user to edit the recipient
addresses in their editor of choice.

Signed-off-by: Ian Hilt <ian.hilt@gmx.com>
---
Here's an updated commit with improved regex's from Junio and Francis.

 git-send-email.perl |   47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9039cfd..4d8aaa7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -480,6 +480,9 @@ if ($compose) {
 	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
 	my $tpl_subject = $initial_subject || '';
 	my $tpl_reply_to = $initial_reply_to || '';
+	my $tpl_to = join(', ', @to);
+	my $tpl_cc = join(', ', @initial_cc);
+	my $tpl_bcc = join(', ', @bcclist);
 
 	print C <<EOT;
 From $tpl_sender # This line is ignored.
@@ -489,6 +492,9 @@ GIT: for the patch you are writing.
 GIT:
 GIT: Clear the body content if you don't wish to send a summary.
 From: $tpl_sender
+To: $tpl_to
+Cc: $tpl_cc
+Bcc: $tpl_bcc
 Subject: $tpl_subject
 In-Reply-To: $tpl_reply_to
 
@@ -512,9 +518,31 @@ EOT
 	open(C,"<",$compose_filename)
 		or die "Failed to open $compose_filename : " . $!;
 
+	local $/;
+	my $c_file = <C>;
+	$/ = "\n";
+	close(C);
+
+	my (@tmp_to, @tmp_cc, @tmp_bcc);
+
+	if ($c_file =~ /^To:\s*(\S.+?)\s*\nCc:/ism) {
+		@tmp_to = get_recipients($1);
+	}
+	if ($c_file =~ /^Cc:\s*(\S.+?)\s*\nBcc:/ism) {
+		@tmp_cc = get_recipients($1);
+	}
+	if ($c_file =~ /^Bcc:\s*(\S.+?)\s*\nSubject:/ism) {
+		@tmp_bcc = get_recipients($1);
+	}
+
+
 	my $need_8bit_cte = file_has_nonascii($compose_filename);
 	my $in_body = 0;
 	my $summary_empty = 1;
+
+	open(C,"<",$compose_filename)
+		or die "Failed to open $compose_filename : " . $!;
+
 	while(<C>) {
 		next if m/^GIT: /;
 		if ($in_body) {
@@ -543,15 +571,21 @@ EOT
 		} elsif (/^From:\s*(.+)\s*$/i) {
 			$sender = $1;
 			next;
-		} elsif (/^(?:To|Cc|Bcc):/i) {
-			print "To/Cc/Bcc fields are not interpreted yet, they have been ignored\n";
-			next;
 		}
 		print C2 $_;
 	}
 	close(C);
 	close(C2);
 
+	if (@tmp_to) {
+		@to = @tmp_to;
+	}
+	if (@tmp_cc) {
+		@initial_cc = @tmp_cc;
+	}
+	if (@tmp_bcc) {
+		@bcclist = @tmp_bcc;
+	}
 	if ($summary_empty) {
 		print "Summary email is empty, skipping it\n";
 		$compose = -1;
@@ -1095,3 +1129,10 @@ sub file_has_nonascii {
 	}
 	return 0;
 }
+
+sub get_recipients {
+	my $match = shift(@_);
+	my @recipients = split(/\s*,\s*(?![^"]+(?:\"[^*]*)*")/, $match);
+
+	return @recipients;
+}
-- 
1.6.0.3.523.g304d0
