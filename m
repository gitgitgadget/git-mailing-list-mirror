From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] send-email: allow sendmail binary to be used instead of SMTP
Date: Mon, 15 May 2006 02:34:44 -0700
Message-ID: <11476856841695-git-send-email-normalperson@yhbt.net>
References: <20060515092704.GB6855@localdomain>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 15 11:36:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfZUW-0008TU-M0
	for gcvg-git@gmane.org; Mon, 15 May 2006 11:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWEOJfr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 05:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWEOJfr
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 05:35:47 -0400
Received: from hand.yhbt.net ([66.150.188.102]:9891 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932361AbWEOJfq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 05:35:46 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id F33C37DC005
	for <git@vger.kernel.org>; Mon, 15 May 2006 02:35:44 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 15 May 2006 02:35:44 -0700
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 05D7A7DC005;
	Mon, 15 May 2006 02:34:44 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 15 May 2006 02:34:44 -0700
To: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, Greg KH <greg@kroah.com>
X-Mailer: git-send-email 1.3.2.g7d11
In-Reply-To: <20060515092704.GB6855@localdomain>
X-CRM114-Status: Good  ( pR: 15.4115 )
X-CRM114-Version: 20060118-BlameTheReavers ( TRE 0.7.2 (GPL) ) MF-9D8703B0 [pR: 15.4115]
X-DSPAM-Confidence: 0.9973
X-DSPAM-Probability: 0.0000
X-DSPAM-Processed: Mon May 15 02:35:16 2006
X-DSPAM-Result: Whitelisted
X-DSPAM-Signature: 44684b4f270221389117998
X-Spam-Checker-Version: SpamAssassin 3.1.0 (2005-09-13) on cpma
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=10.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20037>

This should make local mailing possible for machines without
a connection to an SMTP server.

It'll default to using /usr/sbin/sendmail or /usr/lib/sendmail
if no SMTP server is specified (the default).  If it can't find
either of those paths, it'll fall back to connecting to an SMTP
server on localhost.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-send-email.perl |   60 ++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 40 insertions(+), 20 deletions(-)

d4248a8ab7c883ab0f4dc080374bf60dc582f0f4
diff --git a/git-send-email.perl b/git-send-email.perl
index d8c4b1f..0540e93 100755
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
@@ -358,26 +365,39 @@ X-Mailer: git-send-email $gitversion
 ";
 	$header .= "In-Reply-To: $reply_to\n" if $reply_to;
 
-	$smtp ||= Net::SMTP->new( $smtp_server );
-	$smtp->mail( $from ) or die $smtp->message;
-	$smtp->to( @recipients ) or die $smtp->message;
-	$smtp->data or die $smtp->message;
-	$smtp->datasend("$header\n$message") or die $smtp->message;
-	$smtp->dataend() or die $smtp->message;
-	$smtp->ok or die "Failed to send $subject\n".$smtp->message;
-
+	if ($smtp_server =~ m#^/#) {
+		my $pid = open my $sm, '|-';
+		defined $pid or die $!;
+		if (!$pid) {
+			exec($smtp_server,'-i',@recipients) or die $!;
+		}
+		print $sm "$header\n$message";
+		close $sm or die $?;
+	} else {
+		$smtp ||= Net::SMTP->new( $smtp_server );
+		$smtp->mail( $from ) or die $smtp->message;
+		$smtp->to( @recipients ) or die $smtp->message;
+		$smtp->data or die $smtp->message;
+		$smtp->datasend("$header\n$message") or die $smtp->message;
+		$smtp->dataend() or die $smtp->message;
+		$smtp->ok or die "Failed to send $subject\n".$smtp->message;
+	}
 	if ($quiet) {
 		printf "Sent %s\n", $subject;
 	} else {
-		print "OK. Log says:
-Date: $date
-Server: $smtp_server Port: 25
-From: $from
-Subject: $subject
-Cc: $cc
-To: $to
-
-Result: ", $smtp->code, ' ', ($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
+		print "OK. Log says:\nDate: $date\n";
+		if ($smtp) {
+			print "Server: $smtp_server\n";
+		} else {
+			print "Sendmail: $smtp_server\n";
+		}
+		print "From: $from\nSubject: $subject\nCc: $cc\nTo: $to\n\n";
+		if ($smtp) {
+			print "Result: ", $smtp->code, ' ',
+				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
+		} else {
+			print "Result: OK\n";
+		}
 	}
 }
 
-- 
1.3.2.g7d11
