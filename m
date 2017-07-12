Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5982202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 23:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbdGLXpM (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 19:45:12 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34498 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbdGLXpL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 19:45:11 -0400
Received: by mail-pg0-f43.google.com with SMTP id t186so20359175pgb.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 16:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CiwFxJGVzMnPR93h3UAMTboH2cVXCTD+S8ouP38CvFM=;
        b=Sp7NbpnliX1BXLELaPI0rlNtQpJf8pMN55wlI6gGu75nkDPMkMbXRCawiQEx2Bep8H
         zrJcU7fwc3re4AosnkBX27/WGqQjgMD5SwuXIt0+18aFHGa8ZO42MpY6DeQ7AJeDEtUC
         IK9HgDoZDxoVA7rIvNfSmOmEA2dU28XIP3WI/VymxeeZ+seTzdCsUMzMYvUuT6RAq10t
         oyWKihKEcfVpV8T3yyqIYOIMzuDIyXZuupSaxhl4DAT4bFNIs27UIOIs5HyAr991ubb7
         bzP0uMiDyFpsMQXXj+vEa9Fvc2YpTBgK7c8TRBSTFeC3K7fPFM/ou+CyIe7N83min1cr
         iDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CiwFxJGVzMnPR93h3UAMTboH2cVXCTD+S8ouP38CvFM=;
        b=jOp1KRxIM4I+Qm1nUQRfgr+1h9fglyWNZWSf78grG5TN1GXJiybZUu9FTKvJQUjImU
         MftYv5XluFcnUFODRF7Hh2A2t5/oliRCsb08vGfs7xxbnmGkRhEhGyVMH+XpewjFXdIz
         akYL/ojFvrpAbZHQ7ZhLoD2IoSUD9uxCK+48xahs6euLdYmXdZg2n7Ae/B/sW/Q6A0la
         xPJYk1H71J2L5a4GRmOqa0PnxIUm3jxWjlKasnVp4P85ZWR7dFcbzOhWdiEVXcFxodl1
         LMIZxdoDiWUKbVbk96u74gDFr+C0salMVSwdUfiEApfN1hLVKHYgqHs7gx7FUsGltJ2H
         R+gw==
X-Gm-Message-State: AIVw1135IfSFRyl6lbDpzH6J/JDgzUDBrC0qtONa2o1uHE2mKYEoOL3f
        RENOlLaEGcvfxfguRoVyZA==
X-Received: by 10.84.234.2 with SMTP id m2mr6905443plk.268.1499903110903;
        Wed, 12 Jul 2017 16:45:10 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:68de:f6b3:e0e6:2d13])
        by smtp.gmail.com with ESMTPSA id v64sm7704060pfk.126.2017.07.12.16.45.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 16:45:10 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule: use cheaper check for submodule pushes
Date:   Wed, 12 Jul 2017 16:45:04 -0700
Message-Id: <20170712234504.15811-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.2.695.g117ddefdb4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the function push_submodule[1] we use add_submodule_odb[2] to determine
if a submodule has been populated. However the function does not work with
the submodules objects that are added, instead a new child process is used
to perform the actual push in the submodule.

Use is_submodule_populated[3] that is cheaper to guard from unpopulated
submodules.

[1] 'push_submodule' was added in eb21c732d6 (push: teach
    --recurse-submodules the on-demand option, 2012-03-29)
[2] 'add_submodule_odb' was introduced in 752c0c2492 (Add the
    --submodule option to the diff option family, 2009-10-19)
[3] 'is_submodule_populated' was added in 5688c28d81 (submodules:
    add helper to determine if a submodule is populated, 2016-12-16)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index da2b484879..55afad3e8c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -976,7 +976,9 @@ static int push_submodule(const char *path,
 			  const struct string_list *push_options,
 			  int dry_run)
 {
-	if (add_submodule_odb(path))
+	int code;
+
+	if (!is_submodule_populated_gently(path, &code))
 		return 1;
 
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
-- 
2.13.2.695.g117ddefdb4

