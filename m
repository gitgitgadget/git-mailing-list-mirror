From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 4/4] send-email: add --no-cc, --no-to, and --no-bcc
Date: Sun,  7 Mar 2010 13:33:18 -0800
Message-ID: <1267997598-20815-5-git-send-email-bebarino@gmail.com>
References: <7vk4torn8j.fsf@alter.siamese.dyndns.org>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Steven Drake <sdrake@xnet.co.nz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 22:33:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoO6e-0004xa-Nr
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 22:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947Ab0CGVde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 16:33:34 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63874 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929Ab0CGVdd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 16:33:33 -0500
Received: by mail-gy0-f174.google.com with SMTP id 3so553155gyh.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 13:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xSrKQx3DGeqmDuUoHSo5u5hZXRY+AFPGW1W87KpZA8g=;
        b=G3TTrP+Zb9/JZVDaxuaFXx6N05G7TnetcD3wmCDUJKm12IxoTP4PXsB1xERimniPu0
         ks3BnpIp7tScmAAC3Ho+TW2w0j6faaWcwIcMZhmINgJE5Iu/iQafa2BJIoX/UPeZoNR0
         omSNeOYLXrRQiMbrfR0UHzTOsOiD3u0MXDk8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vJbU1GgTPQBzDvilifxYbVWIACZf9d0w+EyM94AZEUkCvJzoKi6TZlKaLreFGcj5ve
         KTp6VHK74IdI1IInkW+Ogdi/jTj3w1NX4vEMsgjT7il0+jNphe/rk+bSoPzbYy2oNV8Y
         +qV8TMLgs+hq9n8z0nnzKNClhIAjAFxQcGIiQ=
Received: by 10.100.235.36 with SMTP id i36mr6268658anh.104.1267997613279;
        Sun, 07 Mar 2010 13:33:33 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 23sm1551016ywh.15.2010.03.07.13.33.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 13:33:32 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.171.geb5ee
In-Reply-To: <7vk4torn8j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141734>

There's no way to override the sendemail.to, sendemail.cc, and
sendemail.bcc config settings. Add options allowing the user to tell
git to ignore the config settings and take whatever is on the command
line.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 git-send-email.perl   |   14 ++++++++++----
 t/t9001-send-email.sh |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3d9c832..0a91f4a 100755
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
index db91721..60bca7e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -853,4 +853,42 @@ test_expect_success 'no warning with sendemail.chainreplyto = true' '
 	! grep "no-chain-reply-to" errors
 '
 
+test_expect_success '--no-to overrides sendemail.to' '
+	git config --replace-all sendemail.to "Somebody <somebody@ex.com>" &&
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
+test_expect_success '--no-cc overrides sendemail.cc' '
+	git config --replace-all sendemail.cc "Somebody <somebody@ex.com>" &&
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
+test_expect_success '--no-bcc overrides sendemail.bcc' '
+	git config --replace-all sendemail.bcc "Somebody <somebody@ex.com>" &&
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--no-bcc \
+		--bcc=bodies@example.com \
+		--to=nobody@example.com \
+		$patches $patches >stdout &&
+	grep "Bcc: bodies@example.com" stdout &&
+	! grep "Bcc: Somebody <somebody@ex.com>" stdout
+'
+
 test_done
-- 
1.7.0.1.171.geb5ee
