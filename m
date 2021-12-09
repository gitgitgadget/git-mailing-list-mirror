Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C38C433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhLIFPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhLIFPr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:47 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2E8C061353
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:13 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id s11so4287028ilv.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2kwR0z6SdT67C3bUWupP02sxBPjRQS2JjE4/A4p8MOw=;
        b=jiBcfg58J2evXXmW5h5VG3rL/2YY1V86qsqnCcv/ypA386aak9WkYwSp0qDj6TQQWK
         FzMw3ygHTBWfIKNYSbkUbU9FLwq86VZrLVnDx4Vzi2RV5drUJU19CfUtu9kE7Q/l8Z9j
         gZkl88Ova+HJ56JJRFoOP0D5YhjvBuv4lABNoOJ9wHczYkrMsFSPr0UMaXwMzMX5zEBf
         aq4FkUsKSrVyGRkaz66kGEkx6i/blJ2hPHqRN02FyDZ1OLOQ820QSDE0+Ku5lOzoxSlv
         oO+v0g/YbVVlUZImIEUbvnJj5LPpU/vetgV3osGdcFt0C/mJ4WbX1z1iuFEglevc6LgV
         oaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2kwR0z6SdT67C3bUWupP02sxBPjRQS2JjE4/A4p8MOw=;
        b=7NecY74HdTJXCsxuERYvDrFLg5SFuoEsjhVq2y0QCVLrt03lAC3IHDMulQxno/cusD
         LmwaxE7BPngrH8QkRH0XODZISQ15J0ldee86Y8h8/wieh2diaPYse4YJUcKsv7Vf1o9/
         qTFkfMV/7DukLunMMmIxsibjJVTdCcdrAZ6cs10cBqF9Evk++zvucrOS0v4LwUhjUNgs
         bmWMAO7Ns2l9DTW3hDR7JAcXcLIqfuqqs2jEj5Agchlc/1GDpM7gyP8jyei4kNf7FxRo
         JX61fxO72iqUSrLadswJaXYZ3zB6aW2RjEwYHgX7Wdqf5VckEmMLFa5ZS9KHVpbiA9xS
         jqGg==
X-Gm-Message-State: AOAM5331DW6UdwazyobUca/Jsak3G4hGL0/IpwzK73gSvMpChihdEbXZ
        q+ahEAgkS7Y6FmNewuH9ZKIFnbZM4HBhQA==
X-Google-Smtp-Source: ABdhPJzvbx0PbalXM68CqAGnF99AVcsidlIuAe1/amviKRPGg02nGluR8/d3yEd/kwtTsuBpEX2E/A==
X-Received: by 2002:a92:8e46:: with SMTP id k6mr11195349ilh.249.1639026732647;
        Wed, 08 Dec 2021 21:12:12 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:12 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 06/19] t6300: make `%(raw:size) --shell` test more robust
Date:   Thu,  9 Dec 2021 00:11:02 -0500
Message-Id: <20211209051115.52629-7-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd
In-Reply-To: <20211209051115.52629-1-sunshine@sunshineco.com>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test populates its `expect` file solely by appending content but
fails to ensure that the file starts out empty. The test succeeds only
because no earlier test populated a file of the exact same name, however
this is an accident waiting to happen. Make the test more robust by
ensuring that it contains exactly the intended content.

While at it, simplify the implementation via a straightforward `sed`
application and by avoiding dropping out of the single-quote context
within the test body (thus eliminating a hard-to-digest combination of
apostrophes and backslashes).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Notes:
    An alternative simple fix would be to capture the output of the
    `while` loop itself rather than the output of `echo`:
    
        git for-each-ref ... | while read line
        do
            echo ...
        done >expect &&
    
    however, I prefer the conciseness of the `sed` approach,
    
    This patch makes no attempt to address `git` being upstream in a
    pipe. There are enough other such instances in this script that
    fixing them warrants a separate patch (if someone wants to tackle
    it).

 t/t6300-for-each-ref.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 9f2c706c12..aae57908f8 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -955,10 +955,7 @@ test_expect_success '%(raw) with --shell and --sort=raw must fail' '
 '
 
 test_expect_success '%(raw:size) with --shell' '
-	git for-each-ref --format="%(raw:size)" | while read line
-	do
-		echo "'\''$line'\''" >>expect
-	done &&
+	git for-each-ref --format="%(raw:size)" | sed "s/^/$SQ/;s/$/$SQ/" >expect &&
 	git for-each-ref --format="%(raw:size)" --shell >actual &&
 	test_cmp expect actual
 '
-- 
2.34.1.307.g9b7440fafd

