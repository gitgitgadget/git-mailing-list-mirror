Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5248CEE57CD
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 23:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345118AbjIIXIV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 19:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240174AbjIIXIS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 19:08:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B569019F
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 16:08:14 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401187f8071so20227405e9.0
        for <git@vger.kernel.org>; Sat, 09 Sep 2023 16:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694300893; x=1694905693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0rVMtcilkx1Hx5CJZggIzhCjIdAmHono7cCqDPhyC0=;
        b=dP6vDPViyJGfBVKDw10fC1ynHayR2cushS3sAUnM9PiyploVrE/XHXnZjwv3/FlnWi
         f0xiNgXHWAGXmE7LKGWPh+Ri6wqwHzbOjCmEffyJQzFWBodJ2detrRk5S7kHfTphE7Mu
         veNXrLHT0VdK/W22NvHw9W62Lm4Dz0v0LKffna7FeyX9cDwwbN+we2f1sdWZotfU9t/4
         39If71EEsN2asDNPWcOAy2LCVF9o7VikZvDJlaNwdeEUfNLp+ZDAnqcL0UZddx25mlpP
         BY5FHBjNVKr1IvYHb6T62jve0AVfulmubydzwIIMUre4mdzSNpoQDbLo0BdSZXlPNmRP
         lTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694300893; x=1694905693;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0rVMtcilkx1Hx5CJZggIzhCjIdAmHono7cCqDPhyC0=;
        b=FQrXIgDZaF3xHJY0Pds1CvG9z+0l1qviDr2QhiRU/JoQWxyzr1ZAnL2hKTq9f8y+ge
         Uh5GvvndWU8zCf/nnOr16ch0N7X6QR9ok3lvtc/+waXWddw8fWx0MY3l8FspXMTFPsm0
         V3Bds6tiU0gPQhZUWOkcf6gNE6/cqSgaJ9n24k+XygljscQXhVR0IxfIwCN9Ck2mI8t0
         PFrI8KQ38q74rYlhqoVGoMY2ZosyYWypwTTsKDnpZk/YKFnUJnuoZA4qsyOkKLREofxI
         Iv4lVoIxYBMsv7IFRegX05GEMdKMF0P4EDbMI8oxJ9rIRDFGk8D2wGkGVW89rdJuGJsS
         W8cw==
X-Gm-Message-State: AOJu0YxB3JQcGXyPclvVjmvnaVErA8l8es3vC+3esifoul239325rS7t
        ZcjXSRNFmPsfLtVf56cJaXF1bIghbWo=
X-Google-Smtp-Source: AGHT+IGR2y8SRh/YCNepkpXjcKBWeBwTMQKb9A0Qp+37oRk2R2sdgD7/QbeGwd5zFzXD4a+vOW0erw==
X-Received: by 2002:a05:600c:2241:b0:3fe:1b5e:82 with SMTP id a1-20020a05600c224100b003fe1b5e0082mr3409290wmm.20.1694300892751;
        Sat, 09 Sep 2023 16:08:12 -0700 (PDT)
Received: from [192.168.2.52] (16.red-88-14-199.dynamicip.rima-tde.net. [88.14.199.16])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c231700b003fed4fa0c19sm9033486wmo.5.2023.09.09.16.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 16:08:12 -0700 (PDT)
Subject: [PATCH 1/2] test-lib: prevent misuses of --invert-exit-code
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
Message-ID: <1a60a1ca-0ef0-ecf5-d0aa-a28d7c148a82@gmail.com>
Date:   Sun, 10 Sep 2023 01:08:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GIT_TEST_PASSING_SANITIZE_LEAK=true and GIT_TEST_SANITIZE_LEAK_LOG=true
use internnlly the --invert-exit-code machinery.  Therefore if the user
wants to use --invert-exit-code in combination with them, the result
will be confusing.

For the same reason, we are already using BAIL_OUT if the user tries to
combine GIT_TEST_PASSING_SANITIZE_LEAK=check with --invert-exit-code.

Let's do the same for GIT_TEST_PASSING_SANITIZE_LEAK=true and
GIT_TEST_SANITIZE_LEAK_LOG=true.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/test-lib.sh | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 293caf0f20..88a34fba67 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1557,15 +1557,25 @@ then
 			say "in GIT_TEST_PASSING_SANITIZE_LEAK=check mode, setting --invert-exit-code for TEST_PASSES_SANITIZE_LEAK != true"
 			invert_exit_code=t
 		fi
-	elif test -z "$passes_sanitize_leak" &&
-	     test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
+	elif test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
 	then
-		skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
-		test_done
+		if test -n "$invert_exit_code"
+		then
+			BAIL_OUT "cannot use --invert-exit-code under GIT_TEST_PASSING_SANITIZE_LEAK=true"
+		elif test -z "$passes_sanitize_leak"
+		then
+			skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
+			test_done
+		fi
 	fi
 
 	if test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
 	then
+		if test -n "$invert_exit_code"
+		then
+			BAIL_OUT "cannot use --invert-exit-code and GIT_TEST_SANITIZE_LEAK_LOG=true"
+		fi
+
 		if ! mkdir -p "$TEST_RESULTS_SAN_DIR"
 		then
 			BAIL_OUT "cannot create $TEST_RESULTS_SAN_DIR"
-- 
2.40.1

