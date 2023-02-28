Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17489C64EC4
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 23:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjB1Xj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjB1Xj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 18:39:26 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280F5199CE
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:20 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q23so6701990pgt.7
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDkrS7zfhNNpyFxaR0v0V4i8sTNpZgdrMYGAYMusGx8=;
        b=HA7NvZi0axJmZ13SrHr1dXuaqecp8/MWop4A5sifKqwJ6SjJguRNze9pMV7OsDrO/X
         n8rj4FzLt+ia5BWK9UjD/4jZwbyAVufiBoaH3dnex2G3AS4cjPDZqCi6xoS+d570XMuj
         myviMeVy7XzYBecdhL+3eoMWB1paw4HAoCjMhxdCIqTUIK/XegP9DsI3c/r4cEWZJp6x
         /TZyZYerYjOGwUCMJVUAYdAKIFJAbh2kBhPHpcSaPWchPzWeEZz/y1pSFDa2e1QAM/6G
         MOUsaknKVh04tgoATVYMCVwz4O06pFBoN0vHzRuKcEgkKzvL31WBAsYzL28Owno9UHTp
         0M7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XDkrS7zfhNNpyFxaR0v0V4i8sTNpZgdrMYGAYMusGx8=;
        b=3n/ORZzhmagZxEo+n7bmWALFvOUByGc3+4Pao7gC2atCY/jXV8qz99Jotb19IZnxI2
         pJEKlx7WHNQzBbypsoKe5b/FP3RyHAiR9NJEkoVI2TTplpbAMM5ozOj78uBLc7xd6T6D
         ZjsL64Pn+/P9fgv8DzwGIzWmb9nJePswPJdUK5laZzkqGM9ye2cOAMBpvHyHOgbEXUmQ
         LVsRtgqXuAvzcp+z86/THp0aq3o4mYTJgBK/qrJ2vR7/67OtMWfQvbx6WgDhzQ2f48Gk
         rOK22nFAJWIZ/AQW/auXy4PZ+XMxdW5cr3XlGGyDOKSyzc4ebGj7Sv/p3XNsD5pwCtbl
         mlVQ==
X-Gm-Message-State: AO0yUKUUJpLen8VecBkTtUodfjS8Z5FRv8bAQJe0fuOQu3lPDFxF3GKr
        KbxbJ96QNJkanIvO2CEst4a9HHshILQ=
X-Google-Smtp-Source: AK7set+EKYx4cIVXUM8xRSNNmwt8KyBEK4oDDJrs6MbtiYJn1fCWTW/LB/0/Opok+mwoWaseoUlUsg==
X-Received: by 2002:aa7:8f33:0:b0:5aa:464e:8c46 with SMTP id y19-20020aa78f33000000b005aa464e8c46mr3737524pfr.22.1677627558966;
        Tue, 28 Feb 2023 15:39:18 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id t20-20020a62ea14000000b005a91d570972sm6572459pfh.41.2023.02.28.15.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:39:18 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 06/20] t5551: handle HTTP/2 when checking curl trace
Date:   Tue, 28 Feb 2023 15:38:59 -0800
Message-Id: <20230228233913.684853-6-gitster@pobox.com>
X-Mailer: git-send-email 2.40.0-rc0-32-ga0f05f6840
In-Reply-To: <20230228233913.684853-1-gitster@pobox.com>
References: <20230228233913.684853-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We check that the curl trace of a clone has the lines we expect, but
this won't work when we run the test under t5559, because a few details
are different under HTTP/2 (but nobody noticed because it only happens
when you manually set GIT_TEST_PROTOCOL_VERSION to "0").

We can handle both HTTP protocols with a few tweaks:

  - we'll drop the HTTP "101 Switching Protocols" response, as well as
    various protocol upgrade headers. These details aren't interesting
    to us. We just want to make sure the correct protocol was used (and
    we do in the main request/response lines).

  - successful HTTP/2 responses just say "200" and not "200 OK"; we can
    normalize these

  - replace HTTP/1.1 with a variable in the request/response lines. We
    can use the existing $HTTP_PROTO for this, as it's already set to
    "HTTP/2" when appropriate. We do need to tweak the fallback value to
    "HTTP/1.1" to match what curl will write (prior to this patch, the
    fallback value didn't matter at all; we only checked if it was the
    literal string "HTTP/2").

Note that several lines still expect HTTP/1.1 unconditionally. The first
request does so because the client requests an upgrade during the
request. The POST request and response do so because you can't do an
upgrade if there is a request body. (This will all be different if we
trigger HTTP/2 via ALPN, but the tests aren't yet capable of that).

This is enough to let:

  GIT_TEST_PROTOCOL_VERSION=0 ./t5559-http-fetch-smart-http2.sh

pass the "clone http repository" test (but there are some other failures
later on).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5551-http-fetch-smart.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index a81f852cbf..716c9dbb69 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-: ${HTTP_PROTO:=HTTP}
+: ${HTTP_PROTO:=HTTP/1.1}
 test_description="test smart fetching over http via http-backend ($HTTP_PROTO)"
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
@@ -33,13 +33,13 @@ test_expect_success 'create http-accessible bare repository' '
 setup_askpass_helper
 
 test_expect_success 'clone http repository' '
-	cat >exp <<-\EOF &&
+	cat >exp <<-EOF &&
 	> GET /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
 	> accept: */*
 	> accept-encoding: ENCODINGS
 	> accept-language: ko-KR, *;q=0.9
 	> pragma: no-cache
-	< HTTP/1.1 200 OK
+	< $HTTP_PROTO 200 OK
 	< pragma: no-cache
 	< cache-control: no-cache, max-age=0, must-revalidate
 	< content-type: application/x-git-upload-pack-advertisement
@@ -83,6 +83,14 @@ test_expect_success 'clone http repository' '
 			s/^/> /
 		}
 
+		/^< HTTP/ {
+			s/200$/200 OK/
+		}
+		/^< HTTP\\/1.1 101/d
+		/^[><] connection: /d
+		/^[><] upgrade: /d
+		/^> http2-settings: /d
+
 		/^> user-agent: /d
 		/^> host: /d
 		/^> POST /,$ {
-- 
2.40.0-rc0-32-ga0f05f6840

