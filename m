From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 3/3] send-email: add --no-cc, --no-to, and --no-bcc
Date: Sun,  7 Mar 2010 14:46:48 -0800
Message-ID: <1268002008-13426-4-git-send-email-bebarino@gmail.com>
References: <1267997598-20815-1-git-send-email-bebarino@gmail.com>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Steven Drake <sdrake@xnet.co.nz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 23:47:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoPFw-0003Tl-32
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 23:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041Ab0CGWrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 17:47:13 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50786 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037Ab0CGWrD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 17:47:03 -0500
Received: by gwb15 with SMTP id 15so2710888gwb.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 14:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/g4CaKWfau9uVlFWnt5TTW5xZaDoxS4UwHja3UKXMMA=;
        b=DfMi4faE50LJpCDt8iMCOpRa8qKHAJXm5WnyV2coc5RVmQdVMa18fgq4Z5m3HWZz9C
         ynjqLLhcjTMfCmM8xXEzziraS4rIB3Y++Dv6NxtCxoqWe0l3qDcgGGuRNcbd9iyymLht
         rGGbheZysw4VbMpjgYhZR4juMan2eXX8Gj10Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AesO/7R7BUMBy8NLxe9q81eODkkCdyhroOlNqzaoMaRYOMRUgmhc0gxSLg1jLGXsDU
         Tw7OA6lb1YpunYsAeOmYQXKadELVbbwJ7UqQRRnQ8v7rvkdWPElF0lYd66l1mZZT+5+D
         eOB4385XmcqJE8rseIlXrTrUH8U5VsyBnnNEw=
Received: by 10.150.235.11 with SMTP id i11mr3462934ybh.289.1268002021884;
        Sun, 07 Mar 2010 14:47:01 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 9sm220154yxf.11.2010.03.07.14.47.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 14:47:01 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.171.geb5ee
In-Reply-To: <1267997598-20815-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141744>

There's no way to override the sendemail.to, sendemail.cc, and
sendemail.bcc config settings. Add options allowing the user to tell
git to ignore the config settings and take whatever is on the command
line.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 git-send-email.perl   |   14 +++++++---
 t/t9001-send-email.sh |   66 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e05455f..d612ae8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -47,9 +47,9 @@ git send-email [options] <file | directory | rev-list options >
 
   Composing:
     --from                  <str>  * Email From:
-    --to                    <str>  * Email To:
-    --cc                    <str>  * Email Cc:
-    --bcc                   <str>  * Email Bcc:
+    --[no-]to               <str>  * Email To:
+    --[no-]cc               <str>  * Email Cc:
+    --[no-]bcc              <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
     --annotate                     * Review each patch that will be sent in an editor.
@@ -135,7 +135,7 @@ sub unique_email_list(@);
 sub cleanup_compose_files();
 
 # Variables we fill in automatically, or via prompting:
-my (@to,@cc,@initial_cc,@bcclist,@xh,
+my (@to,$no_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
 	$initial_reply_to,$initial_subject,@files,
 	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
 
@@ -261,8 +261,11 @@ my $rc = GetOptions("sender|from=s" => \$sender,
                     "in-reply-to=s" => \$initial_reply_to,
 		    "subject=s" => \$initial_subject,
 		    "to=s" => \@to,
+		    "no-to" => \$no_to,
 		    "cc=s" => \@initial_cc,
+		    "no-cc" => \$no_cc,
 		    "bcc=s" => \@bcclist,
+		    "no-bcc" => \$no_bcc,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "smtp-server=s" => \$smtp_server,
 		    "smtp-server-port=s" => \$smtp_server_port,
@@ -305,6 +308,9 @@ sub read_config {
 
 	foreach my $setting (keys %config_settings) {
 		my $target = $config_settings{$setting};
+		next if $setting eq "to" and defined $no_to;
+		next if $setting eq "cc" and defined $no_cc;
+		next if $setting eq "bcc" and defined $no_bcc;
 		if (ref($target) eq "ARRAY") {
 			unless (@$target) {
 				my @values = Git::config(@repo, "$prefix.$setting");
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index c09f375..640b3d2 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -852,4 +852,70 @@ test_expect_success 'no warning with sendemail.chainreplyto = true' '
 	! grep "no-chain-reply-to" errors
 '
 
+test_expect_success 'sendemail.to works' '
+	git config --replace-all sendemail.to "Somebody <somebody@ex.com>" &&
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		$patches $patches >stdout &&
+	grep "To: Somebody <somebody@ex.com>" stdout
+'
+
+test_expect_success '--no-to overrides sendemail.to' '
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--no-to \
+		--to=nobody@example.com \
+		$patches $patches >stdout &&
+	grep "To: nobody@example.com" stdout &&
+	! grep "To: Somebody <somebody@ex.com>" stdout
+'
+
+test_expect_success 'sendemail.cc works' '
+	git config --replace-all sendemail.cc "Somebody <somebody@ex.com>" &&
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		$patches $patches >stdout &&
+	grep "Cc: Somebody <somebody@ex.com>" stdout
+'
+
+test_expect_success '--no-cc overrides sendemail.cc' '
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--no-cc \
+		--cc=bodies@example.com \
+		--to=nobody@example.com \
+		$patches $patches >stdout &&
+	grep "Cc: bodies@example.com" stdout &&
+	! grep "Cc: Somebody <somebody@ex.com>" stdout
+'
+
+test_expect_success 'sendemail.bcc works' '
+	git config --replace-all sendemail.bcc "Other <other@ex.com>" &&
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server relay.example.com \
+		$patches $patches >stdout &&
+	grep "RCPT TO:<other@ex.com>" stdout
+'
+
+test_expect_success '--no-bcc overrides sendemail.bcc' '
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--no-bcc \
+		--bcc=bodies@example.com \
+		--to=nobody@example.com \
+		--smtp-server relay.example.com \
+		$patches $patches >stdout &&
+	grep "RCPT TO:<bodies@example.com>" stdout &&
+	! grep "RCPT TO:<other@ex.com>" stdout
+'
+
 test_done
-- 
1.7.0.1.171.geb5ee
