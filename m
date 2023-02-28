Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4868C7EE30
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 23:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjB1Xjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjB1Xj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 18:39:27 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F92367F2
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:22 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so15440225pjh.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/I+66L1IypLt7t9h2cE75ol4sjs/KWpdYIdNaT67+U=;
        b=o60H5dRjmlGrU/kMz3DM+OwA2bAqVrNCvBsavQ+jKe8A43dXAxWkGCP4mVmQhp6MHy
         xpQBJBIBNuc4+ynrN5yQUC1jCpnRb7gHZIjM54eqvPQRQ/X4VsYa6s58v4l02MgRC4MY
         b98PDmRHi2e2IcTJmZD7ZBF3gSJF3Tj603fC2FCKmOzg4oucAIqEu71fKQpORw3hLAWp
         FUwqiixgPCflispUiO13BTegc7XpCwXs88rJFJiAoKVbnK9ws6k5LjuCTZUqgLLEVKpq
         zaY4p7QcWvZwmR2k3Uk0JgibmEyolwBvQ/Q/Hc+x7Z8gdBDKmtyHwg8YmKB5FRdlq+MM
         SGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/I+66L1IypLt7t9h2cE75ol4sjs/KWpdYIdNaT67+U=;
        b=ZSQ80U2LGOMu1XGStSJG3F+wzlZZfEcY87IBI+mSajkoScjhsTPTQBEhcPgAXJRlb+
         6I907iJqVgozsN5UaPttrknjQmj6J8tG7FLlPRCIlzvGE7J9artE5tsNDYWZv3Yz/3HQ
         MEg3gz+fx5QzXIzegiIwggvDgACovptnsGPZfpqU8OCqITRnQOr9ARgIm9zcj04CHeFG
         IYoD8fMef+4DmChsszNR7dijJ7op2oOqD5CInWs6P/Rr9/IAX0Uqqh1JdvB+gBoxuqeC
         D+C3VAiyKoSSzlzemHmZsuvB27Y9cDVq0UIAYL00j7bFR+8iQwk/Ydcwwb90O9tjoz1U
         F6fQ==
X-Gm-Message-State: AO0yUKUu6aQkcMw/Gbz6WkWOj7myMcvKZldVAeyMg7XrObKxE0ZaXlD6
        SXOYNCHe1xgLyeHYdCh9eXSYfip61BM=
X-Google-Smtp-Source: AK7set8WTDULlI7c7Fv63jODehhTifGIwIWUuHB5Ru0tg/pg4+rs42E5MM09jpxzuw10bB4YGhGWQg==
X-Received: by 2002:a17:902:f542:b0:19a:81c1:e743 with SMTP id h2-20020a170902f54200b0019a81c1e743mr4634593plf.2.1677627561789;
        Tue, 28 Feb 2023 15:39:21 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id z8-20020a1709027e8800b0019a91895cdfsm7048347pla.50.2023.02.28.15.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:39:21 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 09/20] t5551: handle v2 protocol in upload-pack service test
Date:   Tue, 28 Feb 2023 15:39:02 -0800
Message-Id: <20230228233913.684853-9-gitster@pobox.com>
X-Mailer: git-send-email 2.40.0-rc0-32-ga0f05f6840
In-Reply-To: <20230228233913.684853-1-gitster@pobox.com>
References: <20230228233913.684853-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We perform a clone and a fetch, and then check that we saw the expected
requests in Apache's access log. In the v2 protocol, there will be one
extra request to /git-upload-pack for each operation (since the initial
/info/refs probe is just used to upgrade the protocol).

As a result, this test is a noop unless the use of the v0 protocol is
forced. Which means that hardly anybody runs it, since you have to do so
manually.

Let's update it to handle v2 and run it always. We could do this by just
conditionally adding in the extra POST lines. But if we look at the
origin of the test in 7da4e2280c (test smart http fetch and push,
2009-10-30), the point is really just to make sure that the smart
git-upload-pack service was used at all. So rather than counting up the
individual requests, let's just make sure we saw each of the expected
types. This is a bit looser, but makes maintenance easier.

Since we're now matching with grep, we can also loosen the HTTP/1.1
match, which allows this test to pass when run with HTTP/2 via t5559.
That lets:

  GIT_TEST_PROTOCOL_VERSION=0 ./t5559-http-fetch-smart-http2.sh

run to completion, which previously failed (and of course it works if
you use v2, as well).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5551-http-fetch-smart.sh | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 9d99cefb92..b912958518 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -143,19 +143,9 @@ test_expect_success 'fetch changes via http' '
 '
 
 test_expect_success 'used upload-pack service' '
-	cat >exp <<-\EOF &&
-	GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
-	POST /smart/repo.git/git-upload-pack HTTP/1.1 200
-	GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
-	POST /smart/repo.git/git-upload-pack HTTP/1.1 200
-	EOF
-
-	# NEEDSWORK: If the overspecification of the expected result is reduced, we
-	# might be able to run this test in all protocol versions.
-	if test "$GIT_TEST_PROTOCOL_VERSION" = 0
-	then
-		check_access_log exp
-	fi
+	strip_access_log >log &&
+	grep "GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/[0-9.]* 200" log &&
+	grep "POST /smart/repo.git/git-upload-pack HTTP/[0-9.]* 200" log
 '
 
 test_expect_success 'follow redirects (301)' '
-- 
2.40.0-rc0-32-ga0f05f6840

