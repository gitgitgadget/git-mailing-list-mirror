From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC 06/10] send-email: References: should only reference what is actually sent
Date: Sat, 11 Apr 2009 14:08:24 -0500
Message-ID: <1239476908-25944-6-git-send-email-mfwitten@gmail.com>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-2-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-3-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-4-git-send-email-mfwitten@gmail.com>
 <1239476908-25944-5-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 21:15:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsifn-0002eX-QM
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758189AbZDKTN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757365AbZDKTNz
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:13:55 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:61984 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756839AbZDKTNy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:13:54 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1617460yxl.1
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 12:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yOnQo7Lt7gP7PLf+PXvmmSAhieozva9EKygRQpmTOXw=;
        b=WB5R3lVNfM/eNDiv31Eg1zl9NnYgNz2UFtc0HDbP1IAflRMXQlBES03GTKU1qrMmmm
         Fgr3eEBvJqHKc+hO45dpPIG9M9eeNyU9HS3Vhes9w+ICNj0IOGZbeBnHpPsM+k+tAIAc
         Y91gNfQ340xb5GfovnQ0T9/8qvsDN8H8y07zI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qKhMW7KnH2XfYZzV87FA4GEtilj4SwI0DrkfrnNSS7fK8SGuB22YHiKvVQyiNfmW6E
         adzYSIgoek8pBlU8Nhts5m9Q6T6OxKp+F8bTRDr7tzQYVFKlXdb3mqg3FBndbjtO7VYn
         00HQ+nMd3/BoudwGbsyZ7kfTPwcJ6qxJuq2UY=
Received: by 10.100.41.9 with SMTP id o9mr4822903ano.65.1239477233699;
        Sat, 11 Apr 2009 12:13:53 -0700 (PDT)
Received: from localhost.localdomain (97-116-109-29.mpls.qwest.net [97.116.109.29])
        by mx.google.com with ESMTPS id 9sm5461438ywf.6.2009.04.11.12.13.52
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Apr 2009 12:13:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239476908-25944-5-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116315>

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
index 502f5af..d90c76e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -802,6 +802,10 @@ sub sanitize_address
 
 }
 
+# returns 1 of the message was sent, 0 otherwise.
+# In actuality, the whole program dies when a there
+# is an error sending a message.
+
 sub send_message
 {
 	my @recipients = unique_email_list(@to);
@@ -870,7 +874,7 @@ X-Mailer: git-send-email $gitversion
 		         default => $ask_default);
 		die "Send this email reply required" unless defined $_;
 		if (/^n/i) {
-			return;
+			return 0;
 		} elsif (/^q/i) {
 			cleanup_compose_files();
 			exit(0);
@@ -951,7 +955,7 @@ X-Mailer: git-send-email $gitversion
 		$smtp->data or die $smtp->message;
 		$smtp->datasend("$header\n$message") or die $smtp->message;
 		$smtp->dataend() or die $smtp->message;
-		$smtp->ok or die "Failed to send $subject\n".$smtp->message;
+		$smtp->code =~ /250|200/ or die "Failed to send $subject\n".$smtp->message;
 	}
 	if ($quiet) {
 		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
@@ -972,6 +976,8 @@ X-Mailer: git-send-email $gitversion
 			print "Result: OK\n";
 		}
 	}
+
+	return 1;
 }
 
 $reply_to = $initial_reply_to;
@@ -1132,10 +1138,10 @@ foreach my $t (@files) {
 
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
