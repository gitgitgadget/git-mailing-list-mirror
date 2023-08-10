Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FBBC04A6A
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 14:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjHJOdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 10:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjHJOdR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 10:33:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9009F122
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 07:33:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso8956075e9.3
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691677995; x=1692282795;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2TG/UMVFWcMg0mSkt/LfPAlkAZzit/QkokCtaXH13RA=;
        b=fVwjJnqWjaJ4zfPfE2XMpdcaXIMvWZ52tAIKJFYGDZ1qCINC9D3YGQ4gHYaox89qmG
         YpE5MyoCS3rfuiO//pnlvS3XsfI3+TE+8gtP8E4sMST/CG1N520SVbYT6FpFDEILSEhr
         19BOk+XDNvUlO5p+36T7aG3axCxAhzeKIjMQE7N7Fhk3aZZFesw9GmHbAfTv1bmlBA77
         eqL+c19rVJOfB0VViol7oynPxod1JqpsyyAAxJC9JOGdFaLrqScdJCB6Crl7Jz7vtd9G
         un3HqapnuWxPi56WkR+IVzdXTtCn6DSmSnZcL2ocp47I8v1HIwO+0Mrtt9UD5FgkIaZx
         DHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691677995; x=1692282795;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TG/UMVFWcMg0mSkt/LfPAlkAZzit/QkokCtaXH13RA=;
        b=EHUqv6gSeCpARZPGp6l5K8yS/611RxGx01NP94pm1gdO9uW7bE8nTAk34XFc8zESN0
         DQ6lozarcpmtyhnNMqbND/v/DsGwPIbsmFsGarSQNw6sXlHjxqNyiT+hqVAo1pqwYM2l
         7n6+L9tcl0E+VmvCE96x2WkHH/R0C6l+FqVp3Yc+wH6pPaE9ygTxG2Qp7nwrQ7xrvX/G
         lCYkxLqOxU+NlNGk1LfJVEle63lXtieemPjhAz5UcBmr40XPXGq4yBYsrypRpJwEzmIl
         XMTe6LV5T9t/69GBvEivKrDlhCKCSnceoIHC3T1Qg6C0DupPLCc0qevrZ8nECwEnUXJk
         xMCQ==
X-Gm-Message-State: AOJu0YydeVsmQJN+po66FFJb28NN6jNyRP6+eLIH/KT7tjHv6LAfPWW3
        Fr9/u+dGZ1i04+BxRYil9lIlnO+933k=
X-Google-Smtp-Source: AGHT+IGzu+VcT2CLYmAg32bqIO00/lAdUvhqdutIMWWYkQFBKREfYSvtvnZ5NTnm15rTXzxIe/BCwQ==
X-Received: by 2002:a1c:7314:0:b0:3fe:1d34:908 with SMTP id d20-20020a1c7314000000b003fe1d340908mr2123281wmb.17.1691677994470;
        Thu, 10 Aug 2023 07:33:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5546000000b003142e438e8csm2385320wrw.26.2023.08.10.07.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 07:33:14 -0700 (PDT)
Message-ID: <pull.1571.git.1691677993195.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 14:33:13 +0000
Subject: [PATCH] t4053: avoid race when killing background processes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The test 'diff --no-index reads from pipes' starts a couple of
background processes that write to the pipes that are passed to "diff
--no-index". If the test passes then we expect these processes to exit
as all their output will have been read. However if the test fails
then we want to make sure they do not hang about on the users machine
and the test remembers they should be killed by calling

      test_when_finished  "! kill $!"

after each background process is created. Unfortunately there is a
race where test_when_finished may run before the background process
exits even when all its output has been read resulting in the kill
command succeeding which causes the test to fail. Fix this by ignoring
the exit status of the kill command. If the diff is successful we
could instead wait for the background process to exit and check their
status but that feels like it is testing the platform's printf
implementation rather than git's code.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    t4053: avoid race when killing background processes
    
    Thanks to Peff for reporting this. Junio - this fixes a regression
    introduced in the current cycle. It is fairly minor though so I'm not
    sure if you want to pick it up now or wait until 2.42.0 is out.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1571%2Fphillipwood%2Fdiff-no-index-pipes-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1571/phillipwood/diff-no-index-pipes-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1571

 t/t4053-diff-no-index.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index a28b9ff2434..1fb7d334620 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -248,11 +248,11 @@ test_expect_success PIPE,SYMLINKS 'diff --no-index reads from pipes' '
 	{
 		(test_write_lines a b c >old) &
 	} &&
-	test_when_finished "! kill $!" &&
+	test_when_finished "kill $! || :" &&
 	{
 		(test_write_lines a x c >new) &
 	} &&
-	test_when_finished "! kill $!" &&
+	test_when_finished "kill $! || :" &&
 
 	cat >expect <<-EOF &&
 	diff --git a/old b/new-link

base-commit: a82fb66fed250e16d3010c75404503bea3f0ab61
-- 
gitgitgadget
