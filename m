Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E16AC001E0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 14:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjHJOk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 10:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbjHJOkz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 10:40:55 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D8DE53
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 07:40:54 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so8713745e9.3
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 07:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691678452; x=1692283252;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xu7l+qsAOMwKzvgAzO8VkWEzsnC9H+1izWFXL/XgSzA=;
        b=XsGAOxwI7//GpE8pv+A1rXzfxTMn2W7GZiVbUBs2Msv73IVDfPu1JmLkcCBMT827DI
         SNPPpnFd81wRYnWuP9mUkgqte9IIb1zZ7uBZSCrhGUVRnXq7uiuTWHBsNmNDdI2Tr3L/
         RhEz5sbkaoD5r8diw4GE9g0R1NrQQ3BfwgZRItoqHzkXeLIRKGUoSFEoQF8Gswvs3eBN
         iA0vRz9Mu6h0rEYwrJdO0GvlKIlM7GomQc+N/V/x0Jz1BYdUVECgokguW4qkVfuMmJBz
         w7a1S0+UXmZ+UX5VJFgOasx3mDpMR0IbDqSz7ML0PAkvZvVFXXgHOrV+PXBa2AZ1T4FJ
         5Xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691678452; x=1692283252;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xu7l+qsAOMwKzvgAzO8VkWEzsnC9H+1izWFXL/XgSzA=;
        b=eghUIqB/wVFgmUZMqkwOpWoPCwOv8cUUKj2dDD3FP910oMhMhqIt9oPd0BFre8TNPt
         gGNctubL32/7PZtE36Kr8MfOfq68AtyWzzxoiWffzVqLtKWMi/tpSV2n2v67ahyj974v
         +hCjFOg4vGCs75kSx6n2N9saPrOJaPsshHck2Pgsh4zqDwW46Kr0ykccQLT0jlIJmRku
         Ha19Li3AS/Wvf0ORT/5OoI8MpVOa1Q5zFIYe95vrgqCkiUD5pQPHA3p8Q3r8rTpDDaKs
         JDiOUezltxdsSsTcYSzVzZ6OUpnSD7oKusCJ0mjaA/yus/RH5XHiUlov1Km+qIZwLBHW
         OQyw==
X-Gm-Message-State: AOJu0YxDWKHPkFYAYOT2cKavmbsA+1jnbL0WaApcBtvDE/M+B9acjVJy
        AIS+OTq87242oH1OnMSUFm1Aucuyzbc=
X-Google-Smtp-Source: AGHT+IHFqPKerhPIRx6uvX9rgKuJE+93l+ttKXKpPHe6cUAd+rol41M4/XaClyF/T5agMyIXoatTCw==
X-Received: by 2002:a7b:c398:0:b0:3fe:173e:4a54 with SMTP id s24-20020a7bc398000000b003fe173e4a54mr2143039wmj.17.1691678452211;
        Thu, 10 Aug 2023 07:40:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d6641000000b00314367cf43asm2384995wrw.106.2023.08.10.07.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 07:40:51 -0700 (PDT)
Message-ID: <pull.1572.git.1691678450757.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 14:40:50 +0000
Subject: [PATCH] upload-pack: fix race condition in error messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Test t5516-fetch-push.sh has a test 'deny fetch unreachable SHA1,
allowtipsha1inwant=true' that checks stderr for a specific error
string from the remote. In some build environments the error sent
over the remote connection gets mingled with the error from the
die() statement. Since both signals are being output to the same
file descriptor (but from parent and child processes), the output
we are matching with grep gets split.

To reduce the risk of this failure, follow this process instead:

1. Write an error message to stderr.
2. Write an error message across the connection.
3. exit(1).

This reorders the events so the error is written entirely before
the client receives a message from the remote, removing the race
condition.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    upload-pack: fix race condition in error messages
    
    Here is another quick patch that we've been holding in the microsoft/git
    fork for years because it helped prevent some test flakiness, especially
    in our more involved functional test environment.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1572%2Fderrickstolee%2Fupload-pack-race-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1572/derrickstolee/upload-pack-race-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1572

 upload-pack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 94751477ab2..7b25129f0f6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -801,11 +801,12 @@ error:
 	for (i = 0; i < data->want_obj.nr; i++) {
 		struct object *o = data->want_obj.objects[i].item;
 		if (!is_our_ref(o, data->allow_uor)) {
+			error("git upload-pack: not our ref %s",
+			      oid_to_hex(&o->oid));
 			packet_writer_error(&data->writer,
 					    "upload-pack: not our ref %s",
 					    oid_to_hex(&o->oid));
-			die("git upload-pack: not our ref %s",
-			    oid_to_hex(&o->oid));
+			exit(1);
 		}
 	}
 }

base-commit: a82fb66fed250e16d3010c75404503bea3f0ab61
-- 
gitgitgadget
