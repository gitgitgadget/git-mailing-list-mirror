Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DC0C43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 00:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbiFTAqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jun 2022 20:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbiFTAqR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jun 2022 20:46:17 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A114CDEDB
        for <git@vger.kernel.org>; Sun, 19 Jun 2022 17:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1655685884; x=1687221884;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MzGj9U2UHESWPmtQ5rcEWV51pM4Pnpm/hurNhrjEN9w=;
  b=nE5c1CFOPKrvQQDbh5FSg0KEj6c5VBSU+7O/hQpJN7C424HDwZ9TvAOg
   Vxfgb8W6iZ0eHlCdvpPFdH2F7eqU1UFONukxO2tVY7RbfpCpEBpsCeO5c
   MGfNfeTCVMW/vHyiXtPyx3pU1tLxXK+C/95V0debkXWZcgb2W0gVcNV/c
   0=;
X-IronPort-AV: E=Sophos;i="5.92,306,1650931200"; 
   d="scan'208";a="212629044"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-a264e6fe.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 20 Jun 2022 00:44:35 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-a264e6fe.us-west-2.amazon.com (Postfix) with ESMTPS id AFB7640B9C;
        Mon, 20 Jun 2022 00:44:34 +0000 (UTC)
Received: from EX13D35UWB003.ant.amazon.com (10.43.161.65) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Mon, 20 Jun 2022 00:44:34 +0000
Received: from localhost (10.43.162.133) by EX13D35UWB003.ant.amazon.com
 (10.43.161.65) with Microsoft SMTP Server (TLS) id 15.0.1497.36; Mon, 20 Jun
 2022 00:44:34 +0000
From:   Stewart Smith <trawets@amazon.com>
To:     <git@vger.kernel.org>
CC:     Stewart Smith <trawets@amazon.com>, Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] git-send-email: Add --no-validate-email option
Date:   Sun, 19 Jun 2022 17:44:27 -0700
Message-ID: <20220620004427.3586240-1-trawets@amazon.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.133]
X-ClientProxiedBy: EX13D08UWC004.ant.amazon.com (10.43.162.90) To
 EX13D35UWB003.ant.amazon.com (10.43.161.65)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The perl Email::Valid module gets things right, but this may not always
be what you want, as can be seen in
https://bugzilla.redhat.com/show_bug.cgi?id=2046203

So, add a --validate-email (default, current behavior) and
the inverse --no-validate-email option to be able to skip the check
while still having the Email::Valid perl module installed.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2046203
Suggested-by: Todd Zullinger <tmz@pobox.com>
Signed-off-by: Stewart Smith <trawets@amazon.com>
---
 git-send-email.perl   | 9 +++++++++
 t/t9902-completion.sh | 1 +
 2 files changed, 10 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5861e99a6e..c75b08f9ce 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -103,6 +103,7 @@ sub usage {
     --quiet                        * Output one line of info per email.
     --dry-run                      * Don't actually send the emails.
     --[no-]validate                * Perform patch sanity checks. Default on.
+    --[no-]validate-email          * Perform email address sanity checks. Default on.
     --[no-]format-patch            * understand any non optional arguments as
                                      `git format-patch` ones.
     --force                        * Send even if safety checks would prevent it.
@@ -281,6 +282,7 @@ sub do_edit {
 my $chain_reply_to = 0;
 my $use_xmailer = 1;
 my $validate = 1;
+my $validate_email = 1;
 my $target_xfer_encoding = 'auto';
 my $forbid_sendmail_variables = 1;
 
@@ -293,6 +295,7 @@ sub do_edit {
     "tocover" => \$cover_to,
     "signedoffcc" => \$signed_off_by_cc,
     "validate" => \$validate,
+    "validateemail" => \$validate_email,
     "multiedit" => \$multiedit,
     "annotate" => \$annotate,
     "xmailer" => \$use_xmailer,
@@ -531,6 +534,8 @@ sub config_regexp {
 		    "no-thread" => sub {$thread = 0},
 		    "validate!" => \$validate,
 		    "no-validate" => sub {$validate = 0},
+		    "validate-email!" => \$validate_email,
+		    "no-validate-email" => sub {$validate_email = 0},
 		    "transfer-encoding=s" => \$target_xfer_encoding,
 		    "format-patch!" => \$format_patch,
 		    "no-format-patch" => sub {$format_patch = 0},
@@ -1132,6 +1137,10 @@ sub extract_valid_address {
 	# check for a local address:
 	return $address if ($address =~ /^($local_part_regexp)$/);
 
+	# Email::Valid isn't always correct, so support a way to bypass
+	# See https://bugzilla.redhat.com/show_bug.cgi?id=2046203
+	return 1 if not $validate_email;
+
 	$address =~ s/^\s*<(.*)>\s*$/$1/;
 	my $have_email_valid = eval { require Email::Valid; 1 };
 	if ($have_email_valid) {
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 31526e6b64..6e363c46f3 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2302,6 +2302,7 @@ test_expect_success PERL 'send-email' '
 	EOF
 	test_completion "git send-email --val" <<-\EOF &&
 	--validate Z
+	--validate-email Z
 	EOF
 	test_completion "git send-email ma" "main "
 '
-- 
2.36.1

