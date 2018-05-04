Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 360CB200B9
	for <e@80x24.org>; Fri,  4 May 2018 13:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeEDNIZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 09:08:25 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:32908 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751199AbeEDNIY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 09:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1525439643; bh=mPIRis/0gn3G0HXg0r/6j1W8cv4sVgUlDqp1duDsdkw=;
        h=From:To:Cc:Subject:Date;
        b=J/opP6vBwEUqRAzfyaD2qEcyEJLt1UqMbeFv0y+PSsp2NfOef0heA8oFvxUPJWjXh
         tLolYVvaBhwAg4c4/GxNb0/RvfKKMPZ1p3UYJHZJJJ23oX+S+zfAB7UqAw7ljN/9V/
         O5+cfj/sfp/nIKLjxn7Z7XU5Al+ZUwOK55+z5guY=
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>, Simon Ser <contact@emersion.fr>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCHv2] git-send-email: allow re-editing of message
Date:   Fri,  4 May 2018 09:08:11 -0400
Message-Id: <20180504130811.3398-1-sir@cmpwn.com>
X-Mailer: git-send-email 2.17.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When shown the email summary, an opportunity is presented for the user
to edit the email as if they had specified --annotate. This also permits
them to edit it multiple times.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
Reviewed-by: Simon Ser <contact@emersion.fr>

---
Thanks for the review Eric, updated to address your feedback.

 git-send-email.perl | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2fa7818ca..b45953733 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1330,9 +1330,14 @@ sub file_name_is_absolute {
 	return File::Spec::Functions::file_name_is_absolute($path);
 }
 
-# Returns 1 if the message was sent, and 0 otherwise.
-# In actuality, the whole program dies when there
-# is an error sending a message.
+# Prepares the email, then asks the user what to do.
+#
+# If the user chooses to send the email, it's sent and 1 is returned.
+# If the user chooses not to send the email, 0 is returned.
+# If the user decides they want to make further edits, -1 is returned and the
+# caller is expected to call send_message again after the edits are performed.
+#
+# If an error occurs sending the email, this just dies.
 
 sub send_message {
 	my @recipients = unique_email_list(@to);
@@ -1404,15 +1409,17 @@ Message-Id: $message_id
 
 EOF
 		}
-		# TRANSLATORS: Make sure to include [y] [n] [q] [a] in your
+		# TRANSLATORS: Make sure to include [y] [n] [e] [q] [a] in your
 		# translation. The program will only accept English input
 		# at this point.
-		$_ = ask(__("Send this email? ([y]es|[n]o|[q]uit|[a]ll): "),
-		         valid_re => qr/^(?:yes|y|no|n|quit|q|all|a)/i,
+		$_ = ask(__("Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): "),
+		         valid_re => qr/^(?:yes|y|no|n|edit|e|quit|q|all|a)/i,
 		         default => $ask_default);
 		die __("Send this email reply required") unless defined $_;
 		if (/^n/i) {
 			return 0;
+		} elsif (/^e/i) {
+			return -1;
 		} elsif (/^q/i) {
 			cleanup_compose_files();
 			exit(0);
@@ -1552,7 +1559,12 @@ $references = $initial_in_reply_to || '';
 $subject = $initial_subject;
 $message_num = 0;
 
-foreach my $t (@files) {
+# Prepares the email, prompts the user, sends it out
+# Returns 0 if an edit was done and the function should be called again, or 1
+# otherwise.
+sub process_file {
+	my ($t) = @_;
+
 	open my $fh, "<", $t or die sprintf(__("can't open file %s"), $t);
 
 	my $author = undef;
@@ -1755,6 +1767,10 @@ foreach my $t (@files) {
 	}
 
 	my $message_was_sent = send_message();
+	if ($message_was_sent == -1) {
+		do_edit($t);
+		return 0;
+	}
 
 	# set up for the next message
 	if ($thread && $message_was_sent &&
@@ -1776,6 +1792,14 @@ foreach my $t (@files) {
 		undef $auth;
 		sleep($relogin_delay) if defined $relogin_delay;
 	}
+
+	return 1;
+}
+
+foreach my $t (@files) {
+	while (!process_file($t)) {
+		# user edited the file
+	}
 }
 
 # Execute a command (e.g. $to_cmd) to get a list of email addresses
-- 
2.17.0

