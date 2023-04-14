Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863F2C77B7F
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjDNMTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjDNMTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:19:16 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F57A262
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:05 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id bb20so6972841oib.12
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474744; x=1684066744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXrPfLnmJSR6yRmMzk2YxqZceSYiIw+wWWP0ujdlVsk=;
        b=LH8Y8uRDLo+m5H6rNnum5EVoTX8nGShpGQdmMLDSwHeyGmnwm9QUX9jkRGCGhmkoMG
         SFFoQYYXKrDh1InmE98FRPzuFTImIuhy2iV17NvwklUxEBQ3iqbWV1CziAPBXutnBNEa
         BlWSjNFjk1JJnYwu1cWVQbIMfrwaWk4XO2hK51uzBqIsG8n1Odfp6NkCa8sQb9Ci5azq
         /11Fk4A6U+iJtYCB5oxhHWPxkzKvm7Usq2PI7pgkGF/wfIMjDX2QVtPhjjkvBQZWWvqS
         nejvmDirIrZiqYXUimv02lNs2x6aYTyQls3dso1/LoK/k4d884ceZT9WnQxaUrg2UEqs
         3eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474744; x=1684066744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXrPfLnmJSR6yRmMzk2YxqZceSYiIw+wWWP0ujdlVsk=;
        b=VZjsgBsP8tg4r3xRH2fVZgAaSWgozuTupHRVWTDENH72lk2Ld2iaqzGgaIB5OlxLAT
         mr5hf87yUN7N/57pmAhcQooU/b/AV6tnooxe7uprSl1lBY45qJU0ozrPuDff1cMsUiR2
         tWnhQSqifn3x3Y9EJrcDsEzSDzRUCzIb5L8zCXeT12Mbz+wFFLEd/+zW/J/wSuszs40X
         5p9HAeZxEhnoj3VOIx1v0z2tGABCTgFwaE41gPASxuG20tSMlVEvXLz/pXEOwmQ7PQ4u
         Cc61HNuA+snh7298hnfEp0x8Oo7Z+twF683cd5Tezgh8ErPOyiRUmj/rycgqauTfEwi/
         12/w==
X-Gm-Message-State: AAQBX9c3t+nwFDlXujZ1eIRsKlMGCP0n5G9mvCzokAYzZgQC4mvevzlk
        Ftj7HbILU2DDK5hQqZhHjVbgzv2prRo=
X-Google-Smtp-Source: AKy350YcbkUi3f+w/cinvCaYlxk1HcyXKuspysY+q/e+6YwrCEC4CYchiI1wvS8FFyDQCm/siE38ig==
X-Received: by 2002:a05:6808:3086:b0:38c:3ec8:83aa with SMTP id bl6-20020a056808308600b0038c3ec883aamr722125oib.44.1681474744081;
        Fri, 14 Apr 2023 05:19:04 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id v3-20020acade03000000b003646062e83bsm1593884oig.29.2023.04.14.05.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:19:03 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 13/18] version-gen: move v fix into sed
Date:   Fri, 14 Apr 2023 06:18:36 -0600
Message-Id: <20230414121841.373980-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are already using sed, might as well take advantage of it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 0691f481e4..fa0e72a32c 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -4,7 +4,7 @@ GVF=GIT-VERSION-FILE
 DEF_VER=2.40.GIT
 
 describe () {
-	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g'
+	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g' -e 's/^v//'
 }
 
 # First see if there is a version file (included in release tarballs),
@@ -14,7 +14,6 @@ then
 	VN=$(cat version)
 else
 	VN=$(describe)
-	VN=${VN#v}
 fi
 
 : "${VN:=$DEF_VER}"
-- 
2.40.0+fc1

