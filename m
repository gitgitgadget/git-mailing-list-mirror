From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3 07/13] send-email: 'References:' should only reference what is sent
Date: Mon, 13 Apr 2009 13:23:51 -0500
Message-ID: <1239647037-15381-8-git-send-email-mfwitten@gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-7-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:33:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtQxq-0001ys-0V
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbZDMSb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbZDMSb2
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:31:28 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:23665 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbZDMSb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:31:27 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2240722wff.4
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=iIydTcdiAD2Inx0os8YYv+c6EKLLqJRTFqCOuuWK2IA=;
        b=JYP7e2G+GXkiGIlYZ7jQ1neRGoFDI4YiV9LnZa4RGk36hP7c1DZjpW9kQPrbPB9USI
         YD8UURP17Bjrp1Jryp1pgn5BuErC0n5dY6kSolmSAdz0VYNQ1MQ0At96GpGnG6HfACW2
         DAunkVWuBuOFHXCRUoUPqk9K1cf6RA7jpXMfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=huM4F8s6bFtfoMUl0CY7Jfl9UrTeI+sNQYmkWjZOoIXNJKbcFBMA6/uq3d5teVO3sF
         PHWMSlxv64v/4bxLYRRjXXex/gF3TYpUGG7ZGiF/DsHbO6TWqtaA3EkiHlethjH8nFVZ
         yX7HZYXt/+XJDawWEu1Y6DOYpwlqSH++aOVeY=
Received: by 10.114.53.1 with SMTP id b1mr3301621waa.29.1239647486236;
        Mon, 13 Apr 2009 11:31:26 -0700 (PDT)
Received: from localhost.localdomain (97-116-116-167.mpls.qwest.net [97.116.116.167])
        by mx.google.com with ESMTPS id m30sm5963707wag.12.2009.04.13.11.31.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 11:31:25 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239647037-15381-7-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116468>

If someone responded with a negative (n|no) to the confirmation,
then the Message-ID of the discarded email is no longer used
in the References: header of subsequent emails.

Consequently, send_message() now returns 1 if the message was
sent and 0 otherwise.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-send-email.perl |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5bd818e..2b0ff80 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -801,6 +801,10 @@ sub sanitize_address
 
 }
 
+# Returns 1 if the message was sent, and 0 otherwise.
+# In actuality, the whole program dies when a there
+# is an error sending a message.
+
 sub send_message
 {
 	my @recipients = unique_email_list(@to);
@@ -869,7 +873,7 @@ X-Mailer: git-send-email $gitversion
 		         default => $ask_default);
 		die "Send this email reply required" unless defined $_;
 		if (/^n/i) {
-			return;
+			return 0;
 		} elsif (/^q/i) {
 			cleanup_compose_files();
 			exit(0);
@@ -950,7 +954,7 @@ X-Mailer: git-send-email $gitversion
 		$smtp->data or die $smtp->message;
 		$smtp->datasend("$header\n$message") or die $smtp->message;
 		$smtp->dataend() or die $smtp->message;
-		$smtp->ok or die "Failed to send $subject\n".$smtp->message;
+		$smtp->code =~ /250|200/ or die "Failed to send $subject\n".$smtp->message;
 	}
 	if ($quiet) {
 		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
@@ -971,6 +975,8 @@ X-Mailer: git-send-email $gitversion
 			print "Result: OK\n";
 		}
 	}
+
+	return 1;
 }
 
 $reply_to = $initial_reply_to;
@@ -1131,10 +1137,10 @@ foreach my $t (@files) {
 
 	@cc = (@initial_cc, @cc);
 
-	send_message();
+	my $message_was_sent = send_message();
 
 	# set up for the next message
-	if ($chain_reply_to || !defined $reply_to || length($reply_to) == 0) {
+	if ($message_was_sent and $chain_reply_to || not defined $reply_to || length($reply_to) == 0) {
 		$reply_to = $message_id;
 		if (length $references > 0) {
 			$references .= "\n $message_id";
-- 
1.6.2.2.479.g2aec
