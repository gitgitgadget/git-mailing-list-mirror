From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] send-email: Change from Mail::Sendmail to Net::SMTP
Date: Sat, 25 Mar 2006 17:20:48 -0800
Message-ID: <1143336048205-git-send-email-normalperson@yhbt.net>
References: <20060325235859.GO26071@mythryan2.michonline.com>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git <git@vger.kernel.org>, Ryan Anderson <ryan@michonline.com>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Mar 26 03:21:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNJwd-0003Uf-BB
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 03:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWCZBVS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 20:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWCZBVS
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 20:21:18 -0500
Received: from hand.yhbt.net ([66.150.188.102]:40078 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751250AbWCZBVR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 20:21:17 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 203252DC033;
	Sat, 25 Mar 2006 17:21:15 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email
In-Reply-To: <20060325235859.GO26071@mythryan2.michonline.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18015>

Net::SMTP is in the base Perl distribution, so users are more
likely to have it.  Net::SMTP also allows reusing the SMTP
connection, so sending multiple emails is faster.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 Notes: Reverted printf => print change from earlier.

 git-send-email.perl |   64 ++++++++++++++++++++++++++++++++-------------------
 1 files changed, 40 insertions(+), 24 deletions(-)

8d65a0a4121ade9f48f186d0dcf9f41adc62b22c
diff --git a/git-send-email.perl b/git-send-email.perl
index b220d11..25daf16 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -19,11 +19,17 @@
 use strict;
 use warnings;
 use Term::ReadLine;
-use Mail::Sendmail qw(sendmail %mailcfg);
 use Getopt::Long;
 use Data::Dumper;
+use Net::SMTP;
 use Email::Valid;
 
+# most mail servers generate the Date: header, but not all...
+$ENV{LC_ALL} = 'C';
+use POSIX qw/strftime/;
+
+my $smtp;
+
 sub unique_email_list(@);
 sub cleanup_compose_files();
 
@@ -271,35 +277,45 @@ $cc = "";
 
 sub send_message
 {
-	my $to = join (", ", unique_email_list(@to));
-
-	%mail = (	To	=>	$to,
-			From	=>	$from,
-			CC	=>	$cc,
-			Subject	=>	$subject,
-			Message	=>	$message,
-			'Reply-to'	=>	$from,
-			'In-Reply-To'	=>	$reply_to,
-			'Message-ID'	=>	$message_id,
-			'X-Mailer'	=>	"git-send-email",
-		);
-
-	$mail{smtp} = $smtp_server;
-	$mailcfg{mime} = 0;
-
-	#print Data::Dumper->Dump([\%mail],[qw(*mail)]);
-
-	sendmail(%mail) or die $Mail::Sendmail::error;
+	my @recipients = unique_email_list(@to);
+	my $to = join (",\n\t", @recipients);
+	@recipients = unique_email_list(@recipients,@cc);
+	my $date = strftime('%a, %d %b %Y %H:%M:%S %z', localtime(time));
+
+	my $header = "From: $from
+To: $to
+Cc: $cc
+Subject: $subject
+Reply-To: $from
+Date: $date
+Message-Id: $message_id
+X-Mailer: git-send-email
+";
+	$header .= "In-Reply-To: $reply_to\n" if $reply_to;
+
+	$smtp ||= Net::SMTP->new( $smtp_server );
+	$smtp->mail( $from ) or die $smtp->message;
+	$smtp->to( @recipients ) or die $smtp->message;
+	$smtp->data or die $smtp->message;
+	$smtp->datasend("$header\n$message") or die $smtp->message;
+	$smtp->dataend() or die $smtp->message;
+	$smtp->ok or die "Failed to send $subject\n".$smtp->message;
 
 	if ($quiet) {
 		printf "Sent %s\n", $subject;
 	} else {
-		print "OK. Log says:\n", $Mail::Sendmail::log;
-		print "\n\n"
+		print "OK. Log says:
+Date: $date
+Server: $smtp_server Port: 25
+From: $from
+Subject: $subject
+Cc: $cc
+To: $to
+
+Result: ", $smtp->code, ' ', ($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
 	}
 }
 
-
 $reply_to = $initial_reply_to;
 make_message_id();
 $subject = $initial_subject;
@@ -390,7 +406,7 @@ sub cleanup_compose_files() {
 
 }
 
-
+$smtp->quit if $smtp;
 
 sub unique_email_list(@) {
 	my %seen;
-- 
1.2.4.gb622a
