Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B63C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 11:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjDKLsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 07:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjDKLsR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 07:48:17 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6BBB8
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 04:47:57 -0700 (PDT)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id 592E4240003;
        Tue, 11 Apr 2023 11:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1681213664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3YlWldvmeQlR4NzvvQKcD71dubaRKQE0fhVY9wBGLPs=;
        b=mazw8yRJMiOhlZszeL3Lr+k41OStonZJiWci1TFPmbwmhRASKXdZJdA+fqHX8x5eM2RvvL
        pJyLiNmYW7w6biRq2+pr/xulcIFsJABPbPNt4GppGn9WKtgrnjspwdm3Ltfua3bmEqOREG
        X9N1qKB94Jte9kC4h7ixrAir5EccIU2czJ/VxLQOdMTjTvwZEkDmQj9xtyqVwSwTDebB8E
        acAIQ4TJHNd1IbdYtrWnwOW8PQIab3BIcHsVMtPPNMR1GRCAPNDRgwuvC+W0TBTf4ATXc9
        tSbB4lJid83EATohYVqhlGp127fVzETeTwt3f0TlviBiCCPJ0InX6B1cQ/DsOw==
From:   Robin Jarry <robin@jarry.cc>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Tim Culverhouse <tim@timculverhouse.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Robin Jarry <robin@jarry.cc>
Subject: [PATCH] send-email: export patch counters in validate environment
Date:   Tue, 11 Apr 2023 13:47:23 +0200
Message-Id: <20230411114723.89029-1-robin@jarry.cc>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When sending patch series (with a cover-letter or not)
sendemail-validate is called with every email/patch file independently
from the others. When one of the patches depends on a previous one, it
may not be possible to use this hook in a meaningful way. A hook that
wants to check some property of the whole series needs to know which
patch is the final one.

Expose the current and total number of patches to the hook via the
GIT_SENDEMAIL_PATCH_COUNTER and GIT_SENDEMAIL_PATCH_TOTAL environment
variables so that both incremental and global validation is possible.

Sharing any other state between successive invocations of the validate
hook must be done via external means. For example, by storing it in
a GIT_DIR/SENDEMAIL_VALIDATE file.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Robin Jarry <robin@jarry.cc>
---

Notes:
    Follow up on:
    https://lore.kernel.org/git/9b8d6cc4-741a-5081-d5de-df0972efec37@gmail.com/
    
    As suggested by Phillip, this is a less intrusive change which allows
    validating whole series. Let me know what you think.

 Documentation/githooks.txt | 10 ++++++++++
 git-send-email.perl        |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 62908602e7be..55f00e0f6f8c 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -600,6 +600,16 @@ the name of the file that holds the e-mail to be sent.  Exiting with a
 non-zero status causes `git send-email` to abort before sending any
 e-mails.
 
+The following environment variables are set when executing the hook.
+
+`GIT_SENDEMAIL_PATCH_COUNTER`::
+	A 1-based counter incremented by one for every file.
+
+`GIT_SENDEMAIL_PATCH_TOTAL`::
+	The total number of files.
+
+These variables can be used to validate patch series.
+
 fsmonitor-watchman
 ~~~~~~~~~~~~~~~~~~
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 07f2a0cbeaad..e962d5e15983 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -795,10 +795,17 @@ sub is_format_patch_arg {
 @files = handle_backup_files(@files);
 
 if ($validate) {
+	my $num = 1;
+	my $num_patches = @files;
 	foreach my $f (@files) {
 		unless (-p $f) {
+			$ENV{GIT_SENDEMAIL_PATCH_COUNTER} = "$num";
+			$ENV{GIT_SENDEMAIL_PATCH_TOTAL} = "$num_patches";
 			validate_patch($f, $target_xfer_encoding);
+			delete $ENV{GIT_SENDEMAIL_PATCH_COUNTER};
+			delete $ENV{GIT_SENDEMAIL_PATCH_TOTAL};
 		}
+		$num += 1;
 	}
 }
 
-- 
2.40.0

