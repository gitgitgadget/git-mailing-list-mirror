Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5865B1F744
	for <e@80x24.org>; Tue, 21 Jun 2016 11:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbcFULrb (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 07:47:31 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:47577 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752018AbcFULqE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 07:46:04 -0400
Received: (qmail 29003 invoked from network); 21 Jun 2016 11:46:02 -0000
Received: (qmail 3317 invoked from network); 21 Jun 2016 11:46:02 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 21 Jun 2016 11:45:56 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 07/11] i18n: add--interactive: mark edit_hunk message for translation
Date:	Tue, 21 Jun 2016 11:44:09 +0000
Message-Id: <20160621114413.9467-7-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.9.0.47.g9ba0c31
In-Reply-To: <20160621114413.9467-1-vascomalmeida@sapo.pt>
References: <20160621114413.9467-1-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mark message of edit_hunk_manually displayed in the editing file when
user chooses 'e' option.  The message had to be unfolded to allow
translation of the $participle verb.

Some messages end up being exactly the same for some uses cases, but
left it for easer change in the future, e.g., wanting to change wording
of one particular use case.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-add--interactive.perl | 60 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 11 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index af715b3..1652a57 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1057,22 +1057,60 @@ sub edit_hunk_manually {
 	my $fh;
 	open $fh, '>', $hunkfile
 		or die sprintf __("failed to open hunk edit file for writing: %s"), $!;
-	print $fh "# Manual hunk edit mode -- see bottom for a quick guide\n";
+	print $fh __("# Manual hunk edit mode -- see bottom for a quick guide\n");
 	print $fh @$oldtext;
-	my $participle = $patch_mode_flavour{PARTICIPLE};
 	my $is_reverse = $patch_mode_flavour{IS_REVERSE};
 	my ($remove_plus, $remove_minus) = $is_reverse ? ('-', '+') : ('+', '-');
-	print $fh <<EOF;
-# ---
-# To remove '$remove_minus' lines, make them ' ' lines (context).
-# To remove '$remove_plus' lines, delete them.
+	print $fh (sprintf __(
+"# ---
+# To remove '%s' lines, make them ' ' lines (context).
+# To remove '%s' lines, delete them.
 # Lines starting with # will be removed.
-#
-# If the patch applies cleanly, the edited hunk will immediately be
-# marked for $participle. If it does not apply cleanly, you will be given
+#"), $remove_minus, $remove_plus),
+"\n";
+	if ($patch_mode eq 'stage') {
+		print $fh __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for staging. If it does not apply cleanly, you will be given
+# an opportunity to edit again. If all lines of the hunk are removed,
+# then the edit is aborted and the hunk is left unchanged.");
+	} elsif ($patch_mode eq 'stash') {
+		print $fh __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for stashing. If it does not apply cleanly, you will be given
+# an opportunity to edit again. If all lines of the hunk are removed,
+# then the edit is aborted and the hunk is left unchanged.");
+	} elsif ($patch_mode eq 'reset_head') {
+		print $fh __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for unstaging. If it does not apply cleanly, you will be given
+# an opportunity to edit again. If all lines of the hunk are removed,
+# then the edit is aborted and the hunk is left unchanged.");
+	} elsif ($patch_mode eq 'reset_nothead') {
+		print $fh __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for applying. If it does not apply cleanly, you will be given
 # an opportunity to edit again. If all lines of the hunk are removed,
-# then the edit is aborted and the hunk is left unchanged.
-EOF
+# then the edit is aborted and the hunk is left unchanged.");
+	} elsif ($patch_mode eq 'checkout_index') {
+		print $fh __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for discarding. If it does not apply cleanly, you will be given
+# an opportunity to edit again. If all lines of the hunk are removed,
+# then the edit is aborted and the hunk is left unchanged.");
+	} elsif ($patch_mode eq 'checkout_head') {
+		print $fh __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for discarding. If it does not apply cleanly, you will be given
+# an opportunity to edit again. If all lines of the hunk are removed,
+# then the edit is aborted and the hunk is left unchanged.");
+	} elsif ($patch_mode eq 'checkout_nothead') {
+		print $fh __(
+"# If the patch applies cleanly, the edited hunk will immediately be
+# marked for applying. If it does not apply cleanly, you will be given
+# an opportunity to edit again. If all lines of the hunk are removed,
+# then the edit is aborted and the hunk is left unchanged.");
+	}
 	close $fh;
 
 	chomp(my $editor = run_cmd_pipe(qw(git var GIT_EDITOR)));
-- 
2.6.6

