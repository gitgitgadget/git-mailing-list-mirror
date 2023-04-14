Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA348C77B76
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjDNMTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjDNMTO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:19:14 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE863A276
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:01 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id j12so11937022oij.3
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474741; x=1684066741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKQO50fjwdowKB4LaZ+2+KV3xegteDBZTkDGHkBbUvo=;
        b=sbRZkJ7wuUOKkxmQM1VSImD+AfWmsKdFvagrTwEiZ0agEm+k4T0zg7IkXULCd3dVVe
         9WnlBh5D2xCJdJwt34m+HEYRjIZnRY8aisPQKVVy3hKZcGE1O3Mjs9NP95J1jgQ33cX9
         lYthzOB0NJucFrJRjmXWt3asE1Qw1mcDy50G2U0Lcr/K8UFEY/dHdVBXMRhMc85qIlA+
         K2xlAkKHRf/LibpmaDC/Ls5WpWSqv0ddr808YXByPxeAZ7re0PeCgc7HgDR1G9qCOAQU
         I6UsxV6n6037Sg5EHSuyCZivSCoaNAU0HCRBaGpqWGV9m/cnQ3SCjOjmQJfhx9ImUTDI
         f//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474741; x=1684066741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKQO50fjwdowKB4LaZ+2+KV3xegteDBZTkDGHkBbUvo=;
        b=OwObwM7o3X19mwHEf2isTFxQOB36GSvFBvRqCNKlaVf0viKYrfLpTtdgMP2Y2oP0va
         FH+SKuUMBc193vxdhz/+cRClsmLTPTA2qAYkrloNtZwQyxC1LmIYMU/cG072bhWlUUdi
         gI6AXrFFJIc4Z9v6bVqOXkrxw9lbVUf2UsFPsmNREHvT6ppn/bTJUGWnPT5P8dCPeOUe
         CdRsZAOMaOE35sjQXs5qcc69Y1d5vkCGo5d8sZgtWZf0XjFahWyc8hqvXcg2bCaxG/OP
         XyULDISwyFADIFRuz5SwikWuq2iJAr1IBRowRzu3ibrnKrIlic2leIib7Brx0SdsTbzY
         Iqpw==
X-Gm-Message-State: AAQBX9dJkc0lfEtm0kx7DD+mfWI5nWlHKyZV4PdNNesS7bMI3nrHSY36
        +xm4+KFondmxSWx2K93hrOghX1jzCkE=
X-Google-Smtp-Source: AKy350Y3C3Z8wBA9OdQSpQZConqO0OJIfFj1MFNmocBw/I6FfF2VpsaZRRgh0SEFT1fduDjuq5/dlw==
X-Received: by 2002:a54:4892:0:b0:383:f66f:6276 with SMTP id r18-20020a544892000000b00383f66f6276mr2637000oic.0.1681474741042;
        Fri, 14 Apr 2023 05:19:01 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id n1-20020a4a5301000000b00541b86960d8sm1626037oob.24.2023.04.14.05.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:19:00 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/18] version-gen: refactor describe function
Date:   Fri, 14 Apr 2023 06:18:34 -0600
Message-Id: <20230414121841.373980-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 962b9441e4..d4de540249 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -4,7 +4,7 @@ GVF=GIT-VERSION-FILE
 DEF_VER=v2.40.GIT
 
 describe () {
-	VN=$(git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g') || return 1
+	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g'
 }
 
 # First see if there is a version file (included in release tarballs),
@@ -13,7 +13,7 @@ if test -f version
 then
 	VN=$(cat version)
 else
-	describe
+	VN=$(describe)
 fi
 
 : "${VN:=$DEF_VER}"
-- 
2.40.0+fc1

