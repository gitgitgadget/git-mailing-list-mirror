From: "Robin H\. Johnson" <robbat2@gentoo.org>
Subject: [PATCH] Make envelope-sender fully configurable.
Date: Tue, 10 Apr 2007 15:02:14 -0700
Message-ID: <1176242534838-git-send-email-robbat2@gentoo.org>
References: 11762424311160-git-send-email-robbat2@gentoo.org <11762425341841-git-send-email-robbat2@gentoo.org>
Cc: junkio@cox.net, Robin@orbis-terrarum.net,
	H.Johnson@orbis-terrarum.net, <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 07:19:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbOPu-0002K6-6l
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 00:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936AbXDJWCT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 18:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753939AbXDJWCS
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 18:02:18 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:52326 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753936AbXDJWCR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 18:02:17 -0400
Received: (qmail 8796 invoked from network); 10 Apr 2007 22:02:16 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Tue, 10 Apr 2007 22:02:16 +0000
Received: (qmail 23113 invoked from network); 10 Apr 2007 15:02:14 -0700
Received: from buck-int.local.orbis-terrarum.net (HELO buck-int.orbis-terrarum.net) (172.16.9.3)
  by curie-int-1.local.orbis-terrarum.net with SMTP; 10 Apr 2007 15:02:14 -0700
Received: (nullmailer pid 25788 invoked by uid 0);
	Tue, 10 Apr 2007 22:02:14 -0000
X-Mailer: git-send-email 1.5.1
In-Reply-To: <11762425341841-git-send-email-robbat2@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44184>

From: Robin H. Johnson <robbat2@gentoo.org>

This patch makes envelope sender fully configurable, and also allows it to be
use with Net::SMTP instead of just the sendmail binary.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 git-send-email.perl |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2436aec..133a844 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -76,6 +76,8 @@ Options:
    --quiet	  Make git-send-email less verbose.  One line per email
                   should be all that is output.
 
+   --envelope-sender Specify the sender address used for the email envelope.
+
 EOT
 	exit(1);
 }
@@ -130,7 +132,8 @@ my $compose_filename = ".msg.$$";
 
 # Variables we fill in automatically, or via prompting:
 my (@to,@cc,@initial_cc,@bcclist,@xh,
-	$initial_reply_to,$initial_subject,@files,$from,$compose,$time);
+	$initial_reply_to,$initial_subject,@files,$from,$compose,$time,
+	$envelope_sender);
 
 # Behavior modification variables
 my ($chain_reply_to, $quiet, $suppress_from, $no_signed_off_cc,
@@ -169,6 +172,7 @@ my $rc = GetOptions("from=s" => \$from,
 		    "bcc=s" => \@bcclist,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "smtp-server=s" => \$smtp_server,
+		    "envelope-sender=s" => \$envelope_sender,
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
 		    "suppress-from" => \$suppress_from,
@@ -445,7 +449,10 @@ sub send_message
 		my ($name, $addr) = ($from =~ /^(.*?)(\s+<.*)/);
 		$from = "\"$name\"$addr";
 	}
-	my ($author_addr) = ($from =~ /^.*?\s+<(.*?)>/);
+	if(!defined $envelope_sender or -z $envelope_sender) {
+		$from =~ /^.*?\s+<(.*?)>/;
+		$envelope_sender = $1;
+	}
 	my $header = "From: $from
 To: $to
 Cc: $cc
@@ -463,9 +470,10 @@ X-Mailer: git-send-email $gitversion
 		$header .= join("\n", @xh) . "\n";
 	}
 	
-	my @sendmail_args = ('-f',$author_addr,'-i', map { extract_valid_address($_) } @recipients);
+	my @sendmail_args = ('-f',$envelope_sender,'-i', map { extract_valid_address($_) } @recipients);
 	if ($dry_run) {
 		# We don't want to send the email.
+		$smtp = !($smtp_server =~  m#^/#);
 	} elsif ($smtp_server =~ m#^/#) {
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
@@ -477,7 +485,7 @@ X-Mailer: git-send-email $gitversion
 	} else {
 		require Net::SMTP;
 		$smtp ||= Net::SMTP->new( $smtp_server );
-		$smtp->mail( $from ) or die $smtp->message;
+		$smtp->mail( $envelope_sender ) or die $smtp->message;
 		$smtp->to( @recipients ) or die $smtp->message;
 		$smtp->data or die $smtp->message;
 		$smtp->datasend("$header\n$message") or die $smtp->message;
@@ -489,17 +497,15 @@ X-Mailer: git-send-email $gitversion
 	} else {
 		print "OK. Log says:\nDate: $date\n";
 		if ($smtp) {
-			print "Server: $smtp_server\n";
+			print "SMTP Server: $smtp_server\n";
+			print "SMTP MAIL FROM: $envelope_sender\n";
+			print "SMTP RCPT TO: ".join(', ',@recipients)."\n";
 		} else {
 			print "Sendmail: $smtp_server\n";
-			my $s = "";
-			foreach my $a (@sendmail_args) {
-				$s .= " \'".$a."\'";
-			}
-			print "Args:$s\n";
+			print "Args: '".join("' '",@sendmail_args)."'\n";
 		}
 		print "From: $from\nSubject: $subject\nCc: $cc\nTo: $to\n\n";
-		if ($smtp) {
+		if ($smtp and not $dry_run) {
 			print "Result: ", $smtp->code, ' ',
 				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
 		} else {
@@ -616,7 +622,7 @@ sub cleanup_compose_files() {
 
 }
 
-$smtp->quit if $smtp;
+$smtp->quit if ($smtp and not $dry_run);
 
 sub unique_email_list(@) {
 	my %seen;
-- 
1.5.1
