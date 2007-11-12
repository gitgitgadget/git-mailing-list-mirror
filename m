From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH] git-send-email: show all headers when sending mail
Date: Mon, 12 Nov 2007 08:01:57 -0800
Message-ID: <1194883317-11161-1-git-send-email-ddkilzer@kilzer.net>
Cc: git@vger.kernel.org, "David D. Kilzer" <ddkilzer@kilzer.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 12 17:02:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irbjq-0000BX-CY
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbXKLQB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 11:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753932AbXKLQB5
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:01:57 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:57126 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902AbXKLQB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:01:56 -0500
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out4.apple.com (Postfix) with ESMTP id 07E2118FFC87;
	Mon, 12 Nov 2007 08:01:56 -0800 (PST)
Received: from relay11.apple.com (unknown [127.0.0.1])
	by relay11.apple.com (Symantec Mail Security) with ESMTP id D72542805A;
	Mon, 12 Nov 2007 08:01:55 -0800 (PST)
X-AuditID: 11807130-a48c8bb00000088f-3d-473878f2a767
Received: from localhost.localdomain (unknown [17.151.102.63])
	by relay11.apple.com (Apple SCV relay) with ESMTP id AE4DD2804D;
	Mon, 12 Nov 2007 08:01:54 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64645>

As a git newbie, it was confusing to set an In-Reply-To header but then
not see it printed when the git-send-email command was run.

This patch prints all headers that would be sent to sendmail or an SMTP
server instead of only printing From, Subject, Cc, To.  It also removes
the now-extraneous Date header after the "Log says" line.

Added test to t/t9001-send-email.sh.

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---

I'd like to see this applied to the maint branch.

 git-send-email.perl   |    4 ++--
 t/t9001-send-email.sh |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8760cf8..e3ea786 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -573,7 +573,7 @@ X-Mailer: git-send-email $gitversion
 	if ($quiet) {
 		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
 	} else {
-		print (($dry_run ? "Dry-" : "")."OK. Log says:\nDate: $date\n");
+		print (($dry_run ? "Dry-" : "")."OK. Log says:\n");
 		if ($smtp_server !~ m#^/#) {
 			print "Server: $smtp_server\n";
 			print "MAIL FROM:<$raw_from>\n";
@@ -581,7 +581,7 @@ X-Mailer: git-send-email $gitversion
 		} else {
 			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
 		}
-		print "From: $sanitized_sender\nSubject: $subject\nCc: $cc\nTo: $to\n\n";
+		print $header, "\n";
 		if ($smtp) {
 			print "Result: ", $smtp->code, ' ',
 				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 83f9470..fc03e40 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -41,4 +41,42 @@ test_expect_success \
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
+Date: Mon, 12 Nov 2007 15:01:19 +0000
+Message-Id: <1194879679-15720-1-git-send-email-from@example.com>
+X-Mailer: git-send-email 1.5.3.5.38.gb33cf-dirty
+In-Reply-To: <unique-message-id@example.com>
+References: <unique-message-id@example.com>
+
+Result: OK
+EOF
+
+replace_header () {
+	EXPECTED=expected-show-all-headers &&
+	ACTUAL=actual-show-all-headers &&
+	REPLACEMENT=`cat ${ACTUAL} | grep "^$1:"` &&
+	if [ ! -z "${REPLACEMENT}" ]; then \
+		cat ${EXPECTED} | sed -e "s/^$1: .*\$/${REPLACEMENT}/" > ${EXPECTED}.$$ && \
+		mv -f ${EXPECTED}.$$ ${EXPECTED}
+	fi
+}
+
+test_expect_success 'Show all headers' '
+	git send-email --dry-run --from="Example <from@example.com>" --to=to@example.com --cc=cc@example.com --bcc=bcc@example.com --in-reply-to="<unique-message-id@example.com>" --smtp-server relay.example.com $patches > actual-show-all-headers &&
+	replace_header "Date" &&
+	replace_header "Message-Id" &&
+	replace_header "X-Mailer" &&
+	diff -u expected-show-all-headers actual-show-all-headers
+'
+
 test_done
-- 
1.5.3.4
