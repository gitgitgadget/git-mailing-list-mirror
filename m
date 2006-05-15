From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] send-email: allow sendmail binary to be used instead of SMTP
Date: Sun, 14 May 2006 19:32:25 -0700
Message-ID: <1147660345772-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 15 04:32:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfSsx-0002Ve-1V
	for gcvg-git@gmane.org; Mon, 15 May 2006 04:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWEOCc1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 22:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWEOCc1
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 22:32:27 -0400
Received: from hand.yhbt.net ([66.150.188.102]:43168 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750978AbWEOCc1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 22:32:27 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id B10F17DC005;
	Sun, 14 May 2006 19:32:25 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 14 May 2006 19:32:25 -0700
To: Junio C Hamano <junkio@cox.net>, <git@vger.kernel.org>
X-Mailer: git-send-email 1.3.2.g0e5a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20009>

This should make local mailing possible for machines without
a connection to an SMTP server.

It'll default to using /usr/sbin/sendmail or /usr/lib/sendmail
if no SMTP server is specified (the default).  If it can't find
either of those paths, it'll fall back to connecting to an SMTP
server on localhost.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-send-email.perl |   55 +++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 42 insertions(+), 13 deletions(-)

1c9bacc5a2bfe382f68046aeba62302d28e4c976
diff --git a/git-send-email.perl b/git-send-email.perl
index d8c4b1f..d27a7a5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -40,7 +40,8 @@ # Variables we fill in automatically, or
 my (@to,@cc,@initial_cc,$initial_reply_to,$initial_subject,@files,$from,$compose,$time);
 
 # Behavior modification variables
-my ($chain_reply_to, $smtp_server, $quiet, $suppress_from, $no_signed_off_cc) = (1, "localhost", 0, 0, 0);
+my ($chain_reply_to, $quiet, $suppress_from, $no_signed_off_cc) = (1, 0, 0, 0);
+my $smtp_server;
 
 # Example reply to:
 #$initial_reply_to = ''; #<20050203173208.GA23964@foobar.com>';
@@ -179,8 +180,14 @@ if (!defined $initial_reply_to && $promp
 	$initial_reply_to =~ s/(^\s+|\s+$)//g;
 }
 
-if (!defined $smtp_server) {
-	$smtp_server = "localhost";
+if (!$smtp_server) {
+	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
+		if (-x $_) {
+			$smtp_server = $_;
+			last;
+		}
+	}
+	$smtp_server ||= 'localhost'; # could be 127.0.0.1, too... *shrug*
 }
 
 if ($compose) {
@@ -358,18 +365,39 @@ X-Mailer: git-send-email $gitversion
 ";
 	$header .= "In-Reply-To: $reply_to\n" if $reply_to;
 
-	$smtp ||= Net::SMTP->new( $smtp_server );
-	$smtp->mail( $from ) or die $smtp->message;
-	$smtp->to( @recipients ) or die $smtp->message;
-	$smtp->data or die $smtp->message;
-	$smtp->datasend("$header\n$message") or die $smtp->message;
-	$smtp->dataend() or die $smtp->message;
-	$smtp->ok or die "Failed to send $subject\n".$smtp->message;
+	if ($smtp_server =~ m#^/#) {
+		my $pid = open my $sm, '|-';
+		defined $pid or die $!;
+		if (!$pid) {
+			exec($smtp_server,'-i',@recipients) or die $!;
+		}
+		print $sm "$header\n$message";
+		close $sm or die $?;
+		if ($quiet) {
+			printf "Sent %s\n", $subject;
+		} else {
+			print "OK. Log says:
+Date: $date
+Sendmail: $smtp_server
+From: $from
+Subject: $subject
+Cc: $cc
+To: $to
 
-	if ($quiet) {
-		printf "Sent %s\n", $subject;
+Result: OK\n";
+		}
 	} else {
-		print "OK. Log says:
+		$smtp ||= Net::SMTP->new( $smtp_server );
+		$smtp->mail( $from ) or die $smtp->message;
+		$smtp->to( @recipients ) or die $smtp->message;
+		$smtp->data or die $smtp->message;
+		$smtp->datasend("$header\n$message") or die $smtp->message;
+		$smtp->dataend() or die $smtp->message;
+		$smtp->ok or die "Failed to send $subject\n".$smtp->message;
+		if ($quiet) {
+			printf "Sent %s\n", $subject;
+		} else {
+			print "OK. Log says:
 Date: $date
 Server: $smtp_server Port: 25
 From: $from
@@ -378,6 +406,7 @@ Cc: $cc
 To: $to
 
 Result: ", $smtp->code, ' ', ($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
+		}
 	}
 }
 
-- 
1.3.2.g1c9b
