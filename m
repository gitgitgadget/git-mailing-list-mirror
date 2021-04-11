Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDB4C43460
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 12:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86FAF610CB
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 12:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhDKMzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 08:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbhDKMzC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 08:55:02 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53BBC061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 05:54:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1618145684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6BkyJj7dyJN6OaR5Iv+EM55YTYurL50wm+W5z+322pE=;
        b=HrKKXEv7FnvFmnpiOdrv39BR5ZsoBEXw9Ts+EsGX3FhKcv2ATYkckfxoC9/OQlM4qvs2Ea
        FeKuFXlCovmPke86cHjwC0SDASt1J6EX2G2yhQ+XHIPmcTE/RtBve5EJy/amK9/DJGZMPl
        CqbYoR/TdX0nGKrd3sfMq5uJ7uiQ6mCDomLxaxBpgT6rsJZ2m5R+lZ/gX4LThxiFRM+tML
        EmQiH3V8u/VZtAlcls32cHE2FlRihfS1x6STN//29lJ3zFliss8P62zNn10SdVeuzMoSJk
        JFoevZBS4yMeW5DQ+YNrmNheNrlL7IGg2mHNrhTzUBlapcLbplflEpsi9iKXuA==
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>
Subject: [PATCH v2 2/3] git-send-email: die on invalid smtp_encryption
Date:   Sun, 11 Apr 2021 08:54:30 -0400
Message-Id: <20210411125431.28971-3-sir@cmpwn.com>
In-Reply-To: <20210411125431.28971-1-sir@cmpwn.com>
References: <20210411125431.28971-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Drew DeVault <sir@cmpwn.com>
---
 Documentation/git-send-email.txt | 4 ++--
 git-send-email.perl              | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index c17c3b400a..520b355e50 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -171,8 +171,8 @@ Sending
 	Specify the encryption to use, either 'ssl' or 'tls'. 'ssl' enables
 	generic SSL/TLS support and is typically used on port 465.  'tls'
 	enables in-band STARTTLS support and is typically used on port 25 or
-	587.  Use whichever option is recommended by your mail provider.  Any
-	other value reverts to plain SMTP.  Default is the value of
+	587.  Use whichever option is recommended by your mail provider.  Leave
+	empty to disable encryption and use plain SMTP.  Default is the value of
 	`sendemail.smtpEncryption`.
 
 --smtp-domain=<FQDN>::
diff --git a/git-send-email.perl b/git-send-email.perl
index f5bbf1647e..bda5211f0d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -495,6 +495,9 @@ sub read_config {
 
 # 'default' encryption is none -- this only prevents a warning
 $smtp_encryption = '' unless (defined $smtp_encryption);
+if ($smtp_encryption ne "" && $smtp_encryption ne "ssl" && $smtp_encryption ne "tls") {
+	die __("Invalid smtp_encryption configuration: expected 'ssl', 'tls', or nothing.\n");
+}
 
 # Set CC suppressions
 my(%suppress_cc);
-- 
2.31.1

