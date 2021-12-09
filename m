Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4336DC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhLIFPn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhLIFPm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:42 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF43AC0617A1
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:09 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id x6so5250152iol.13
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=16gb3bPti+IfZearu+Xawfae6rwgLko32pwEnlcrlnk=;
        b=gOT4xSnSNwBvqM3krE92cIYnW5vkpmj5krPmWsXxd4ocuLrVbDPTanww63pwZZJ267
         zCy+W64myWEPEWj7qcHqGgZp0sy+thIYcRRhLYcQgHFPuB+QZ6mRbL0ll8wwrH2sWFoJ
         +n96JopTFZus9AQm5qro0VDcqvup0nlb/oKlJ59sE8hYzV6N5GXVT8MIrXzjLj6CIXSf
         lkWw9yBX7IfaGCEqA7ILmptRVAUW+kQRMYXlkl5LNmZ0gEYo6UHzzXigRyBMfR1z+tlN
         4Xg/oCiVWoxj97f35VlTIuSchLdNDRdfWpSzua6f5HDluVYNzgdKbh4J+2sSZ3PYIgg7
         26Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=16gb3bPti+IfZearu+Xawfae6rwgLko32pwEnlcrlnk=;
        b=ln60Ro0C4B+0PZaAKkLiII2zx5vlgk5R2zumUGzYdaBK0PHAZdzZ4OBAxGYzUS8mSL
         sEqh2LtIABfpMNYG/NuRGAdyfGnfIz7RNbPbUVaBRk2LetYDO6/arNjWw/2ySEBUVqk8
         03Hn9zFPT5xe8mw/dvMtwrwnw7YQKYrDarvDiSFwOe2qxoSCVquMJ6nnc5W+QNbivyx4
         mM6cZEN9TNdO991qql7XQQ94ns+1vUQ1K41zQCHL0FJ63HchVoM40B6HHRr2QEh/aTWN
         sOMLSsT/Ab7ckArfF7+oNFctKfX/M4Kg64Q1zatWccB+WJIB22PLohPhLbdwvOR24JjS
         Ha5Q==
X-Gm-Message-State: AOAM5338geYVxmGulXfH1Awo618loYAH1zTA/YdYMxDr2XoVxCODLL+r
        ODlmNt4CZ2c+EjIqc/xeCGaDqdqQ0aVvbw==
X-Google-Smtp-Source: ABdhPJz39vxJB8LSiYG4/BOuT1EEyHyoDkfmY0Qmd4p0+OAl9fqW7yFEYRTunj0Kzvf9XmIk9dVO5g==
X-Received: by 2002:a05:6602:2d04:: with SMTP id c4mr12454253iow.56.1639026729143;
        Wed, 08 Dec 2021 21:12:09 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:08 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 01/19] t/lib-pager: use sane_unset() to avoid breaking &&-chain
Date:   Thu,  9 Dec 2021 00:10:57 -0500
Message-Id: <20211209051115.52629-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd
In-Reply-To: <20211209051115.52629-1-sunshine@sunshineco.com>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test intentionally breaks the &&-chain following `unset` since it
doesn't know if `unset` will succeed or fail and doesn't want a local
`unset` failure to abort the test overall. We can do better by using
sane_unset() which can be linked into the &&-chain as usual.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/lib-pager.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-pager.sh b/t/lib-pager.sh
index 3aa7a3ffd8..e5eb28df4e 100644
--- a/t/lib-pager.sh
+++ b/t/lib-pager.sh
@@ -3,7 +3,7 @@
 test_expect_success 'determine default pager' '
 	test_might_fail git config --unset core.pager &&
 	less=$(
-		unset PAGER GIT_PAGER;
+		sane_unset PAGER GIT_PAGER &&
 		git var GIT_PAGER
 	) &&
 	test -n "$less"
-- 
2.34.1.307.g9b7440fafd

