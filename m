Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CF9B1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 02:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeDSCUJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 22:20:09 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:48360 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbeDSCUI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 22:20:08 -0400
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Apr 2018 22:20:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1524104229; bh=d+o3ASdMIIZgxzatuoWPbGb+2qg9w3Ben2bQW6Qs/YM=;
        h=From:To:Cc:Subject:Date;
        b=OeqPnlOGvnkSjLFoGUHVGILVdD6MKGcvTix7Qbhz/2o1SnXKRVPscP/pl2VLQcElH
         FFEPC2kQt+P7kiCfzmEuNdStYaERzjRwGJ6VRditHdZsYUQQTKww7/UaqtZozaZhvH
         7mTLTj6lCpvKTAQ+sRJAUckCtS7UDnT0IV0adA1I=
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] send-email: allow re-editing of message
Date:   Wed, 18 Apr 2018 22:12:02 -0400
Message-Id: <20180419021202.16025-1-sir@cmpwn.com>
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
 git-send-email.perl | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2fa7818ca..14f2e8ae4 100755
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
@@ -1552,7 +1559,9 @@ $references = $initial_in_reply_to || '';
 $subject = $initial_subject;
 $message_num = 0;
 
-foreach my $t (@files) {
+sub process_file {
+	my ($t) = @_;
+
 	open my $fh, "<", $t or die sprintf(__("can't open file %s"), $t);
 
 	my $author = undef;
@@ -1755,6 +1764,10 @@ foreach my $t (@files) {
 	}
 
 	my $message_was_sent = send_message();
+	if ($message_was_sent == -1) {
+		do_edit($t);
+		return 0;
+	}
 
 	# set up for the next message
 	if ($thread && $message_was_sent &&
@@ -1776,6 +1789,14 @@ foreach my $t (@files) {
 		undef $auth;
 		sleep($relogin_delay) if defined $relogin_delay;
 	}
+
+	return 1;
+}
+
+foreach my $t (@files) {
+	while (!process_file($t)) {
+		# This space deliberately left blank
+	}
 }
 
 # Execute a command (e.g. $to_cmd) to get a list of email addresses
-- 
2.17.0

