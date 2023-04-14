Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244C8C77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjDNMTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjDNMTD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:19:03 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AB29EF7
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:56 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id ec6so5162960oib.8
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474735; x=1684066735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbCi9XPr9DESQfzQE6XslMYNVOqL92PE+o6ZiXHbhRw=;
        b=IOajNvnyN3bFG6j5NUWS7SuN1V2Ez9pFCMJzDFkF0pbYeDTNxGH6ysHIehY9HNHxlX
         0MUUXsA4gBXbAMVvCMdS7h5Vrmfc4MfG+GDcBHY1K4I90qmr1OtIrgRZUZlxIW+EOq/u
         Yn2IL23W9XzsD3JOHh87B5urGF0fQwTTQPY5MQtCByOkrRDU2xJeO1sYpQHSqekkmMRR
         bGi3Vt2WexUYixGVu3t1rWk5pPK2gvCZGwn11l1xsboNgbWaSQItBxD8NDxe9TWC510J
         70HdY2SruOCVaAe6k9rQy/u0uyG16kl/Dijy9aEg59h/UuToyOXU35sZkGftGHbo+Bzw
         5asA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474735; x=1684066735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbCi9XPr9DESQfzQE6XslMYNVOqL92PE+o6ZiXHbhRw=;
        b=lQj6DMEUbrhA3A+mwUI75jdMfaWHLudaDK7hrMCHw4cIhos37SdEg068d0bSXWIAWt
         vD31hoISZpRiLlRAw0ci12yHPV5JvAdd28x2xLwqpKyeriGIvO5r6T/WZxBouuOdpve+
         8VyYzh/n33ymECdwLjwPjRUkcFsP4+REH1VmqW0lNK0M4KSw3Ie9v4WdYzsz9P3/AtNh
         O0+FyQ+W7J5Q5Ys3h7a371zmLUgDirl4m0ZT/G85S9q8+0wXibjlQrKxSa44+mAXYxGL
         OpKJaQc7HLjLsCjzifj19xalc0zJIouYyS+u03aNy3VW1YTFz4wjP/sDMfBP9dKtCENK
         FCjA==
X-Gm-Message-State: AAQBX9cX/5nW0yB+YvM9brjJwPmrazdkkMKAGjFE8CMB3iiYLS0WwlbC
        HdowFB6N2b1MPbdvmeDki/cY7WQmnYQ=
X-Google-Smtp-Source: AKy350Z7WrKoeFYk+JEotZ+UiUpIQltsyAAMM+fCrnJvHLSsOdve3sCqaAThwHpR27yhFwhlgttMAw==
X-Received: by 2002:aca:ead6:0:b0:38c:9f8:e6b4 with SMTP id i205-20020acaead6000000b0038c09f8e6b4mr3636192oih.21.1681474735622;
        Fri, 14 Apr 2023 05:18:55 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id bg15-20020a056808178f00b003896f132821sm1587169oib.41.2023.04.14.05.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:18:54 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/18] version-gen: simplify dirty check
Date:   Fri, 14 Apr 2023 06:18:31 -0600
Message-Id: <20230414121841.373980-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 0021e88cdc..9be9e14204 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -4,10 +4,7 @@ GVF=GIT-VERSION-FILE
 DEF_VER=v2.40.GIT
 
 describe () {
-	VN=$(git describe --match "v[0-9]*" 2>/dev/null) || return 1
-	git update-index -q --refresh
-	test -z "$(git diff-index --name-only HEAD --)" ||
-	VN="$VN-dirty"
+	VN=$(git describe --match "v[0-9]*" --dirty 2>/dev/null) || return 1
 }
 
 # First see if there is a version file (included in release tarballs),
-- 
2.40.0+fc1

