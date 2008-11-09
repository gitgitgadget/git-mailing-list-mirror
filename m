From: Ian Hilt <ian.hilt@gmx.com>
Subject: [PATCH] git send-email: edit recipient addresses with the --compose flag
Date: Sun,  9 Nov 2008 07:59:48 -0500
Message-ID: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com>
Cc: Pierre Habouzit <madcoder@debian.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 14:01:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kz9ub-0007Ea-QJ
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 14:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281AbYKIM7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 07:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755283AbYKIM7y
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 07:59:54 -0500
Received: from mail.gmx.com ([74.208.5.67]:54538 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752654AbYKIM7x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 07:59:53 -0500
Received: (qmail invoked by alias); 09 Nov 2008 12:59:49 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com [75.185.223.130]
  by mail.gmx.com (mp-us003) with SMTP; 09 Nov 2008 07:59:49 -0500
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX1/5pbt/KFX5ZQFB5V8e+Uz45xcgXaL/fodEwzWXCo
	Lsf3xR9z8uFYUL
X-Mailer: git-send-email 1.6.0.3.523.g304d0
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100442>

Sometimes specifying the recipient addresses can be tedious on the
command-line.  This commit will allow the user to edit the recipient
addresses in their editor of choice.

Signed-off-by: Ian Hilt <ian.hilt@gmx.com>
---
This is on top of Pierre's most recent series.  I'm not exactly happy
with the way it turned out, but it seems to function correctly.
Comments are most welcome.

  [ This is a resend.  I don't know what happened to the first mail I
    sent to the list. ]

 git-send-email.perl |   60 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index fd72127..3a22767 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -455,6 +455,9 @@ if ($compose) {
 	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
 	my $tpl_subject = $initial_subject || '';
 	my $tpl_reply_to = $initial_reply_to || '';
+	my $tpl_to = join(', ', @to);
+	my $tpl_cc = join(', ', @initial_cc);
+	my $tpl_bcc = join(', ', @bcclist);
 
 	print C <<EOT;
 From $tpl_sender # This line is ignored.
@@ -464,6 +467,9 @@ GIT: for the patch you are writing.
 GIT:
 GIT: Clear the body content if you don't wish to send a summary.
 From: $tpl_sender
+To: $tpl_to
+Cc: $tpl_cc
+Bcc: $tpl_bcc
 Subject: $tpl_subject
 In-Reply-To: $tpl_reply_to
 
@@ -487,9 +493,31 @@ EOT
 	open(C,"<",$compose_filename)
 		or die "Failed to open $compose_filename : " . $!;
 
+	local $/;
+	my $c_file = <C>;
+	$/ = "\n";
+	close(C);
+
+	my (@tmp_to, @tmp_cc, @tmp_bcc);
+
+	if ($c_file =~ /^To:\s*+(.+)\s*\nCc:/ism) {
+		@tmp_to = get_recipients($1);
+	}
+	if ($c_file =~ /^Cc:\s*+(.+)\s*\nBcc:/ism) {
+		@tmp_cc = get_recipients($1);
+	}
+	if ($c_file =~ /^Bcc:\s*+(.+)\s*\nSubject:/ism) {
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
@@ -518,15 +546,21 @@ EOT
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
 		print "Summary email is empty, skpping it\n";
 		$compose = -1;
@@ -1070,3 +1104,23 @@ sub file_has_nonascii {
 	}
 	return 0;
 }
+
+sub get_recipients {
+	my $match = shift(@_);
+	my @recipients = split(/\s*,\s*/, $match);
+	for (my $i = 0; $i <= $#recipients; ++$i) {
+		if ($recipients[$i] eq "") {
+			splice(@recipients, $i, 1);
+		} elsif ($recipients[$i] =~ /"/) {
+			my $x = $i;
+			my $tmp;
+			while ($recipients[$i] !~ /</) {
+				$tmp = join(', ', $recipients[$i],$recipients[$i+1]);
+				++$i;
+				splice(@recipients, $i, 1, $tmp);
+			}
+			splice(@recipients, $x, $i, $tmp);
+		}
+	}
+	return @recipients;
+}
-- 
1.6.0.3.523.g304d0
