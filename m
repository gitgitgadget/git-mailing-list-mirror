From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] send-email: remove warning about unset chainreplyto
Date: Fri, 24 May 2013 22:44:52 -0500
Message-ID: <1369453492-20972-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 05:46:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug5RO-0000ue-DP
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 05:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584Ab3EYDqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 23:46:31 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:56211 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881Ab3EYDqa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 23:46:30 -0400
Received: by mail-oa0-f43.google.com with SMTP id o6so7021759oag.30
        for <git@vger.kernel.org>; Fri, 24 May 2013 20:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=MwGU+pCg57tkgaRLk2ACj2uYQe9MgvPOLinNGIEH12o=;
        b=cHO/i5P0zDscvGuDPn4j/8HNsVR1abU6hVL2fzLnTThhZYIn2GFiGtxLLwtoqF6Bxp
         lyi5nETAhnvl1JMbCf3DvzueY5KP9N51Ri/DEUD0BvFPfK8vVkEZ5nUdQFkHW6jF4Wxt
         1XmrZv61suqRFhz75p/mwq+5fXhvE/A/QSgm1NDALBeBUqUDTmKl+C2nIxkoYtufNjal
         RxN8pvZRQH6G+snWa6BwDv1pUnbfNUwg3+tZgCW/i/xFyS8F8eXc1E0NiKOD7NyTCb1l
         +7/kReC+SrsVnVqgJndsD257IeO1GIo2c3n8dt540b5LM0TTICFO+NT85Jho0DcZOMKh
         BzGQ==
X-Received: by 10.60.23.9 with SMTP id i9mr13391136oef.109.1369453589507;
        Fri, 24 May 2013 20:46:29 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b5sm20277791oby.12.2013.05.24.20.46.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 20:46:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225486>

Three years and a half is probably more than enough time to give users
the opportunity to configure Git to do what they want. If they haven't
changed the configuration by now, this warning message is not going to
do anything for them anyway.

This effectively reverts commit 528fb08 (prepare send-email for smoother
change of --chain-reply-to default).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-send-email.perl   | 19 ++-----------------
 t/t9001-send-email.sh | 49 -------------------------------------------------
 2 files changed, 2 insertions(+), 66 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index bd13cc8..ec1d6ce 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -203,11 +203,9 @@ my ($compose_encoding);
 
 my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
 
-my $not_set_by_user = "true but not set by the user";
-
 my %config_bool_settings = (
     "thread" => [\$thread, 1],
-    "chainreplyto" => [\$chain_reply_to, $not_set_by_user],
+    "chainreplyto" => [\$chain_reply_to, 0],
     "suppressfrom" => [\$suppress_from, undef],
     "signedoffbycc" => [\$signed_off_by_cc, undef],
     "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
@@ -241,19 +239,6 @@ my %config_path_settings = (
     "aliasesfile" => \@alias_files,
 );
 
-# Help users prepare for 1.7.0
-sub chain_reply_to {
-	if (defined $chain_reply_to &&
-	    $chain_reply_to eq $not_set_by_user) {
-		print STDERR
-		    "In git 1.7.0, the default has changed to --no-chain-reply-to\n" .
-		    "Set sendemail.chainreplyto configuration variable to true if\n" .
-		    "you want to keep --chain-reply-to as your default.\n";
-		$chain_reply_to = 0;
-	}
-	return $chain_reply_to;
-}
-
 # Handle Uncouth Termination
 sub signal_handler {
 
@@ -1437,7 +1422,7 @@ foreach my $t (@files) {
 
 	# set up for the next message
 	if ($thread && $message_was_sent &&
-		(chain_reply_to() || !defined $reply_to || length($reply_to) == 0 ||
+		($chain_reply_to || !defined $reply_to || length($reply_to) == 0 ||
 		$message_num == 1)) {
 		$reply_to = $message_id;
 		if (length $references > 0) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index ebd5c5d..5d2dbe9 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1003,55 +1003,6 @@ test_expect_success $PREREQ 'threading but no chain-reply-to' '
 	grep "In-Reply-To: " stdout
 '
 
-test_expect_success $PREREQ 'warning with an implicit --chain-reply-to' '
-	git send-email \
-	--dry-run \
-	--from="Example <nobody@example.com>" \
-	--to=nobody@example.com \
-	outdir/000?-*.patch 2>errors >out &&
-	grep "no-chain-reply-to" errors
-'
-
-test_expect_success $PREREQ 'no warning with an explicit --chain-reply-to' '
-	git send-email \
-	--dry-run \
-	--from="Example <nobody@example.com>" \
-	--to=nobody@example.com \
-	--chain-reply-to \
-	outdir/000?-*.patch 2>errors >out &&
-	! grep "no-chain-reply-to" errors
-'
-
-test_expect_success $PREREQ 'no warning with an explicit --no-chain-reply-to' '
-	git send-email \
-	--dry-run \
-	--from="Example <nobody@example.com>" \
-	--to=nobody@example.com \
-	--nochain-reply-to \
-	outdir/000?-*.patch 2>errors >out &&
-	! grep "no-chain-reply-to" errors
-'
-
-test_expect_success $PREREQ 'no warning with sendemail.chainreplyto = false' '
-	git config sendemail.chainreplyto false &&
-	git send-email \
-	--dry-run \
-	--from="Example <nobody@example.com>" \
-	--to=nobody@example.com \
-	outdir/000?-*.patch 2>errors >out &&
-	! grep "no-chain-reply-to" errors
-'
-
-test_expect_success $PREREQ 'no warning with sendemail.chainreplyto = true' '
-	git config sendemail.chainreplyto true &&
-	git send-email \
-	--dry-run \
-	--from="Example <nobody@example.com>" \
-	--to=nobody@example.com \
-	outdir/000?-*.patch 2>errors >out &&
-	! grep "no-chain-reply-to" errors
-'
-
 test_expect_success $PREREQ 'sendemail.to works' '
 	git config --replace-all sendemail.to "Somebody <somebody@ex.com>" &&
 	git send-email \
-- 
1.8.3.rc3.312.g47657de
