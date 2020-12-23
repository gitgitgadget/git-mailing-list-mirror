Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312E1C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 11:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE5AE207AA
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 11:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgLWLpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 06:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbgLWLpV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 06:45:21 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04903C0613D3
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 03:44:41 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w5so18315872wrm.11
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 03:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ALE0mm36NBwbOAKCxLdGLXXHXnrXdJ8y9nL8J4ber5E=;
        b=RNeBCyQbA+4AdBPe3wNcttFE6vL1f0CaY8SzOv9BdH6+7tYV8eePfsFmDGaFVAmJrF
         w1Hxeq5CumDez0vQSxkQyoQm4QaQsO5YOqYWr5UA0FOLv+OExm82eVD9DY48R2OtfpZ0
         pgSmmzsNrIL1S26KxBYwpNlYCTEE1Ujs5U54A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALE0mm36NBwbOAKCxLdGLXXHXnrXdJ8y9nL8J4ber5E=;
        b=cxqxkAuNFYGpb1Mmo/1B7iJeM1fJltQdPcmzrsgQvnVBynsF3W+MZaIuIQtP0iAtID
         Abapm3ly7Mr/JdDRjXXZT7c8dInQFNBStMoz0VlSW27N3h0I90+ofGDOGlCYz2jp6ZJE
         8tS6sykv4TksP7QWodPr7dVnL7REXSOof1p0PsC+F5EMB9vRv628+DCZWR87rYH4B7q2
         Drv5nwoc4pGspFUJSotnX43saT9d2Rp/+vU8mHNjDvf/jxaS/kXph49I91CAaIi0HeY+
         uh8MeVzI3AUGLvPVIJV5i0JFdI3bl5UcEt5HsSxLBd6z7HTSwXOl1illhOO+1oONxIMU
         buAA==
X-Gm-Message-State: AOAM532gGARoWwrPFTpp+hfnUYcsHYJwVz1atj+meQKrBqcu4VBfA0Qi
        TJsEVPxFNMW/n4hLRzmrP6g76a+ZeGm/Zdhy
X-Google-Smtp-Source: ABdhPJzj/ulH3R0AMkPVnaEfw67AR/BSSCBKNRFSq1YiYYyi2hqfsXTLGn6GGO6DDE70TcnUXjHNyw==
X-Received: by 2002:adf:ba48:: with SMTP id t8mr8637309wrg.288.1608723879472;
        Wed, 23 Dec 2020 03:44:39 -0800 (PST)
Received: from localhost.localdomain (77.116.2.81.in-addr.arpa. [81.2.116.77])
        by smtp.gmail.com with ESMTPSA id h29sm38156531wrc.68.2020.12.23.03.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 03:44:38 -0800 (PST)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Achim Gratz <Stromeko@nexgo.de>
Subject: [PATCH] t4129: fix setfacl-related permissions failure
Date:   Wed, 23 Dec 2020 11:44:31 +0000
Message-Id: <20201223114431.4595-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.30.0.rc1
In-Reply-To: <CAHd-oW7XJL_a1zMAUetHzvrh8DrLT4g2awv-fjbTdeLVLKVsew@mail.gmail.com>
References: <CAHd-oW7XJL_a1zMAUetHzvrh8DrLT4g2awv-fjbTdeLVLKVsew@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running this test in Cygwin, it's necessary to remove the inherited
access control lists from the Git working directory in order for later
permissions tests to work as expected.

As such, fix an error in the test script so that the ACLs are set for
the working directory, not a nonexistent subdirectory.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
 t/t4129-apply-samemode.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index 41818d8315..576632f868 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -78,7 +78,7 @@ test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
 	test_config core.sharedRepository 0666 &&
 	(
 		# Remove a default ACL if possible.
-		(setfacl -k newdir 2>/dev/null || true) &&
+		(setfacl -k . 2>/dev/null || true) &&
 		umask 0077 &&
 
 		# Test both files (f1) and leading dirs (d)
-- 
2.30.0.rc1

