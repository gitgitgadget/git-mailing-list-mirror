From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] send-email: lazy-load Email::Valid and make it optional
Date: Sat, 25 Mar 2006 16:47:12 -0800
Message-ID: <11433340323396-git-send-email-normalperson@yhbt.net>
References: <7v8xqyuuvo.fsf@assigned-by-dhcp.cox.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git <git@vger.kernel.org>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Mar 26 01:47:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNJQ1-0007Sf-Lf
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 01:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWCZArl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 19:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWCZArl
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 19:47:41 -0500
Received: from hand.yhbt.net ([66.150.188.102]:15758 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932103AbWCZArk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 19:47:40 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id EBFD52DC033;
	Sat, 25 Mar 2006 16:47:39 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email
In-Reply-To: <7v8xqyuuvo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18010>

It's not installed on enough machines, and is overkill most of
the time.  We'll fallback to a very basic regexp just in case,
but nothing like the monster regexp Email::Valid has to offer :)

Small cleanup from Merlyn.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-send-email.perl |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

3f09a822e3871eeae521da80c748602862fc52ce
diff --git a/git-send-email.perl b/git-send-email.perl
index 5e08817..7cbf11d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -22,12 +22,12 @@ use Term::ReadLine;
 use Getopt::Long;
 use Data::Dumper;
 use Net::SMTP;
-use Email::Valid;
 
 # most mail servers generate the Date: header, but not all...
 $ENV{LC_ALL} = 'C';
 use POSIX qw/strftime/;
 
+my $have_email_valid = eval { require Email::Valid; 1 };
 my $smtp;
 
 sub unique_email_list(@);
@@ -250,6 +250,16 @@ EOT
 # Variables we set as part of the loop over files
 our ($message_id, $cc, %mail, $subject, $reply_to, $message);
 
+sub extract_valid_address {
+	my $address = shift;
+	if ($have_email_valid) {
+		return Email::Valid->address($address);
+	} else {
+		# less robust/correct than the monster regexp in Email::Valid,
+		# but still does a 99% job, and one less dependency
+		return ($address =~ /([^\"<>\s]+@[^<>\s]+)/);
+	}
+}
 
 # Usually don't need to change anything below here.
 
@@ -259,7 +269,7 @@ our ($message_id, $cc, %mail, $subject, 
 # 1 second since the last time we were called.
 
 # We'll setup a template for the message id, using the "from" address:
-my $message_id_from = Email::Valid->address($from);
+my $message_id_from = extract_valid_address($from);
 my $message_id_template = "<%s-git-send-email-$message_id_from>";
 
 sub make_message_id
@@ -412,7 +422,7 @@ sub unique_email_list(@) {
 	my @emails;
 
 	foreach my $entry (@_) {
-		my $clean = Email::Valid->address($entry);
+		my $clean = extract_valid_address($entry);
 		next if $seen{$clean}++;
 		push @emails, $entry;
 	}
-- 
1.2.4.gb622a
