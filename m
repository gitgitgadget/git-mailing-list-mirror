Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E662AC27C76
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 01:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjAVB2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 20:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAVB2O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 20:28:14 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81281193F5
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 17:28:13 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l8so6633109wms.3
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 17:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjHBNeqLSs/pYqIMWgX8unSi3QbAzvP0xO/zdCMIkHo=;
        b=iWHQ89PtGkw0oZQTZAWSBpkbNlUdcjC2AGHxTWwyQ2QKCNaQhFgFkzennrcPYBZQ+E
         +GZb2S+YJ/rawdq8ewETMg4cJfhQq/eXx818K1104gy9lDJivEkOoKTKSwIgAMan6z0h
         coitwBh9bl3g3rZ2sptv/FUfqj7yY0zcDYbiuQ2nqGmpu5w3mUYCkxKpO6tstM3ibVF3
         eh4dg1Jsucbib0W1aoroi2vDnxeV1uxirz64jA8vCAGewbVu8vAeQiKC4LxFTvq9r0ZV
         qWNIMs4jb8x75mc6VbJhIArJbxv+fenO+g96waEAfihd3rAIgvb8fTuJctC9U5UnaaJ4
         9PlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjHBNeqLSs/pYqIMWgX8unSi3QbAzvP0xO/zdCMIkHo=;
        b=7V8O1tm3RYeSL38ztcVd20dQ0iQP/XplFl4F6FmkKb+9wBETbidAFY/nSUK78Tq5kF
         okvrTgUQ/JQyHjFzobCyCK3gtq9biaStPOxugJdWhYQkbqYOdn3JaklLdSJBFmRr3rP1
         UX+qLzFsJVDbot5KMRZXx5WnVup5z34z8g315DcVHBbSCFZnuXlfRN9/3pJR65iwTpAH
         45gvwtGoWENoaOiqLdIlEQeNtkE4nXHcKbZlcG+y+bVd+Eg7Q4qGeBkv4EQhDmfzfRzl
         uvLKPLjGLKzXzAGAbF5LUAKJBH4uHvHJeI027Q0QPJMreCsbxka0Tbi3buw/bxZ6lhFB
         IdFw==
X-Gm-Message-State: AFqh2kq1u33llTcXyi4tusC/4HSxv3+ceT/9J8IO7CYsjR0gVRG2TCeD
        aZ15kyIZILlxy0Gdnba024g=
X-Google-Smtp-Source: AMrXdXuKJ2MxHJsAAyl6p5Ky++Evvm6V8YqRpXExDH/48tPaf7Vz1uQKO0Jho1eyAM8XeMsYugRKfw==
X-Received: by 2002:a05:600c:3b13:b0:3db:26b8:5023 with SMTP id m19-20020a05600c3b1300b003db26b85023mr10429682wms.10.1674350892083;
        Sat, 21 Jan 2023 17:28:12 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003c6bbe910fdsm8606418wmo.9.2023.01.21.17.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 17:28:11 -0800 (PST)
Subject: [PATCH v2 2/3] rebase: refuse to switch to a branch already checked
 out elsewhere (test)
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
Message-ID: <3452517b-1efa-4ea9-a7d9-ed27715c750c@gmail.com>
Date:   Sun, 22 Jan 2023 02:28:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In b5cabb4a9 (rebase: refuse to switch to branch already checked out
elsewhere, 2020-02-23) we add a condition to prevent a rebase operation
involving a switch to a branch that is already checked out in another
worktree.

A bug has recently been fixed that caused this to not work as expected.

Let's add a test to notice if this changes in the future.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t3400-rebase.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index d5a8ee39fc..3ce918fdb8 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -388,6 +388,20 @@ test_expect_success 'switch to branch checked out here' '
 	git rebase main main
 '
 
+test_expect_success 'switch to branch checked out elsewhere fails' '
+	test_when_finished "
+		git worktree remove wt1 &&
+		git worktree remove wt2 &&
+		git branch -d shared
+	" &&
+	git worktree add wt1 -b shared &&
+	git worktree add wt2 -f shared &&
+	# we test in both worktrees to ensure that works
+	# as expected with "first" and "next" worktrees
+	test_must_fail git -C wt1 rebase shared shared &&
+	test_must_fail git -C wt2 rebase shared shared
+'
+
 test_expect_success 'switch to branch not checked out' '
 	git checkout main &&
 	git branch other &&
-- 
2.39.0
