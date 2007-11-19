From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH v2] git-send-email: show all headers when sending mail
Date: Sun, 18 Nov 2007 20:14:55 -0800
Message-ID: <1195445695-27262-1-git-send-email-ddkilzer@kilzer.net>
References: <7vbq9ywqmq.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, "David D. Kilzer" <ddkilzer@kilzer.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 19 05:15:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ity2u-0007qE-Kt
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 05:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956AbXKSEPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 23:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbXKSEPG
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 23:15:06 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:65317 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbXKSEPE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 23:15:04 -0500
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out3.apple.com (Postfix) with ESMTP id 76C7F18EEC44;
	Sun, 18 Nov 2007 20:15:03 -0800 (PST)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id 5E62C28057;
	Sun, 18 Nov 2007 20:15:03 -0800 (PST)
X-AuditID: 11807134-a6f6abb000001d52-ac-47410dc78859
Received: from localhost.localdomain (unknown [17.151.88.135])
	by relay14.apple.com (Apple SCV relay) with ESMTP id 0D45928060;
	Sun, 18 Nov 2007 20:15:03 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <7vbq9ywqmq.fsf@gitster.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65403>

As a git newbie, it was confusing to set an In-Reply-To header but then
not see it printed when the git-send-email command was run.

This patch prints all headers that would be sent to sendmail or an SMTP
server instead of only printing From, Subject, Cc, To.  It also removes
the now-extraneous Date header after the "Log says" line.

Added test to t/t9001-send-email.sh.

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---

Updated t/t9001-send-email.sh per feedback from Junio C Hamano.

 git-send-email.perl   |    4 ++--
 t/t9001-send-email.sh |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2b1f1b5..f4539a0 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -575,7 +575,7 @@ X-Mailer: git-send-email $gitversion
 	if ($quiet) {
 		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
 	} else {
-		print (($dry_run ? "Dry-" : "")."OK. Log says:\nDate: $date\n");
+		print (($dry_run ? "Dry-" : "")."OK. Log says:\n");
 		if ($smtp_server !~ m#^/#) {
 			print "Server: $smtp_server\n";
 			print "MAIL FROM:<$raw_from>\n";
@@ -583,7 +583,7 @@ X-Mailer: git-send-email $gitversion
 		} else {
 			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
 		}
-		print "From: $sanitized_sender\nSubject: $subject\nCc: $cc\nTo: $to\n\n";
+		print $header, "\n";
 		if ($smtp) {
 			print "Result: ", $smtp->code, ' ',
 				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 83f9470..659f9c7 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -41,4 +41,41 @@ test_expect_success \
     'Verify commandline' \
     'diff commandline expected'
 
+cat >expected-show-all-headers <<\EOF
+0001-Second.patch
+(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
+Dry-OK. Log says:
+Server: relay.example.com
+MAIL FROM:<from@example.com>
+RCPT TO:<to@example.com>,<cc@example.com>,<author@example.com>,<bcc@example.com>
+From: Example <from@example.com>
+To: to@example.com
+Cc: cc@example.com, A <author@example.com>
+Subject: [PATCH 1/1] Second.
+Date: DATE-STRING
+Message-Id: MESSAGE-ID-STRING
+X-Mailer: X-MAILER-STRING
+In-Reply-To: <unique-message-id@example.com>
+References: <unique-message-id@example.com>
+
+Result: OK
+EOF
+
+test_expect_success 'Show all headers' '
+	git send-email \
+		--dry-run \
+		--from="Example <from@example.com>" \
+		--to=to@example.com \
+		--cc=cc@example.com \
+		--bcc=bcc@example.com \
+		--in-reply-to="<unique-message-id@example.com>" \
+		--smtp-server relay.example.com \
+		$patches |
+	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
+		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
+		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
+		>actual-show-all-headers &&
+	diff -u expected-show-all-headers actual-show-all-headers
+'
+
 test_done
-- 
1.5.3.4
