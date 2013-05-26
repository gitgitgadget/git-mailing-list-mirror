From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4/6] send-email: make --suppress-cc=self sanitize input
Date: Sun, 26 May 2013 17:41:04 +0300
Message-ID: <1369579187-27573-5-git-send-email-mst@redhat.com>
References: <1369579187-27573-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 26 16:40:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugc7v-0000mt-5d
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 16:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853Ab3EZOkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 10:40:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56207 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753819Ab3EZOkm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 10:40:42 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4QEegvP006301
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Sun, 26 May 2013 10:40:42 -0400
Received: from redhat.com (vpn-202-184.tlv.redhat.com [10.35.202.184])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r4QEeed5015396
	for <git@vger.kernel.org>; Sun, 26 May 2013 10:40:41 -0400
Content-Disposition: inline
In-Reply-To: <1369579187-27573-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225549>

--suppress-cc=self fails to filter sender address in many cases where it
needs to be sanitized in some way, for example quoted:
"A U. Thor" <author@example.com>
To fix, make send-email sanitize both sender and the address it is
compared against.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 git-send-email.perl | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index a138615..92df393 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -760,6 +760,8 @@ if (!defined $sender) {
 	$sender = $repoauthor || $repocommitter || '';
 }
 
+$sender = sanitize_address($sender);
+
 my $prompting = 0;
 if (!@initial_to && !defined $to_cmd) {
 	my $to = ask("Who should the emails be sent to (if any)? ",
@@ -1113,10 +1115,9 @@ sub send_message {
 	if ($cc ne '') {
 		$ccline = "\nCc: $cc";
 	}
-	my $sanitized_sender = sanitize_address($sender);
 	make_message_id() unless defined($message_id);
 
-	my $header = "From: $sanitized_sender
+	my $header = "From: $sender
 To: $to${ccline}
 Subject: $subject
 Date: $date
@@ -1133,7 +1134,7 @@ X-Mailer: git-send-email $gitversion
 	}
 
 	my @sendmail_parameters = ('-i', @recipients);
-	my $raw_from = $sanitized_sender;
+	my $raw_from = $sender;
 	if (defined $envelope_sender && $envelope_sender ne "auto") {
 		$raw_from = $envelope_sender;
 	}
@@ -1308,8 +1309,9 @@ foreach my $t (@files) {
 			}
 			elsif (/^From:\s+(.*)$/i) {
 				($author, $author_encoding) = unquote_rfc2047($1);
+				my $sauthor = sanitize_address($author);
 				next if $suppress_cc{'author'};
-				next if $suppress_cc{'self'} and $author eq $sender;
+				next if $suppress_cc{'self'} and $sauthor eq $sender;
 				printf("(mbox) Adding cc: %s from line '%s'\n",
 					$1, $_) unless $quiet;
 				push @cc, $1;
@@ -1323,7 +1325,9 @@ foreach my $t (@files) {
 			}
 			elsif (/^Cc:\s+(.*)$/i) {
 				foreach my $addr (parse_address_line($1)) {
-					if (unquote_rfc2047($addr) eq $sender) {
+					my $qaddr = unquote_rfc2047($addr);
+					my $saddr = sanitize_address($qaddr);
+					if ($saddr eq $sender) {
 						next if ($suppress_cc{'self'});
 					} else {
 						next if ($suppress_cc{'cc'});
@@ -1370,7 +1374,8 @@ foreach my $t (@files) {
 			chomp;
 			my ($what, $c) = ($1, $2);
 			chomp $c;
-			if ($c eq $sender) {
+			my $sc = sanitize_address($c);
+			if ($sc eq $sender) {
 				next if ($suppress_cc{'self'});
 			} else {
 				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
@@ -1454,7 +1459,6 @@ foreach my $t (@files) {
 sub recipients_cmd {
 	my ($prefix, $what, $cmd, $file) = @_;
 
-	my $sanitized_sender = sanitize_address($sender);
 	my @addresses = ();
 	open my $fh, "-|", "$cmd \Q$file\E"
 	    or die "($prefix) Could not execute '$cmd'";
-- 
MST
