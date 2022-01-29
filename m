Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB9CC433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 06:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242009AbiA2Gf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 01:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiA2Gfy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 01:35:54 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D8EC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 22:35:54 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d18so8150257plg.2
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 22:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wGdigUX+S2mrov1qCPjKp1XLpN5W7vslaiRZwd/rKJk=;
        b=bp/RCZCEgnKAcWb5cY2QkHzamY9AXC9X4tk5mAOszkq+NrsqoxwSu5TwjgSvPrd1th
         aGJ1k9TS3i9ZWk5RiBdePT8nAie7aJhUOqwL65ZIEAR7Ilf6IqGtNgJGZnyrDyA1HBVB
         6IUbcfajC8drlR8p1N9xbYC+dxYDWQtkpPPO1Y3svtrcbjQE9Tf4qPIuETEH+EQCS+hS
         MHJ1+eUVFBZ//EKCLanc2mhmGKDLtdupHFvnGs8mQM9oUJJiZ+1VllUL4yZMAOW75QAI
         nhn+ZShcnT9QitXp9iQax9Lo07V4B4YGDyjbthfgltlGfIFIOAZDN8u0sGBIDThcfzsY
         O+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGdigUX+S2mrov1qCPjKp1XLpN5W7vslaiRZwd/rKJk=;
        b=gBuF0JTFwiCR55hzYEGlPSt6/Jqi5WzPtfvLe1uOmcTJsKhAGbYhspJNO1+E68NGrn
         himCkoBKgLNdW4QmZn9YpfqASQkhxONnzfAdzzJl3D7AXi41XZy0of16QkApDwYhNrjk
         dZhm7bYSk+1MB7kjZv3KZf14VN/cOkd7LFX8mlrzpP28TkFPZzNBBaEKjTXaUqApbL99
         cKFhWVORvfVu4iVJ/UrKGnlPIW1i8mdJuu+D0wtdGWu45EdOX9yGmPg1++75o76EJ7pk
         Hh68dvXlYj/LVuf5nHY9atc61uZw1jwi2h/EuEQBKXzgP1HuOYSbSjifDsgXH1zzR1aN
         CvNw==
X-Gm-Message-State: AOAM5314ww62IbEfmc014iXIWoq5VReNwqd/jjXjsuiY4T72lh++LtkX
        gtEZiB0kXAMTWt4DOgPNgI9keQrAvvHbUWiT6M4=
X-Google-Smtp-Source: ABdhPJwAFuIi34cSYEd3hgkNzECoYb5dTAMLe6pjQ1llzpkLIKweekl7uiiyXvW6JyoJ556zWA+z+A==
X-Received: by 2002:a17:902:a508:: with SMTP id s8mr11347892plq.173.1643438153208;
        Fri, 28 Jan 2022 22:35:53 -0800 (PST)
Received: from localhost.localdomain ([122.231.171.238])
        by smtp.gmail.com with ESMTPSA id bf23sm4077196pjb.52.2022.01.28.22.35.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Jan 2022 22:35:52 -0800 (PST)
From:   Chen BoJun <bojun.cbj@gmail.com>
To:     git@vger.kernel.org
Cc:     Chen Bojun <bojun.cbj@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v2] receive-pack: purge temporary data if no command is ready to run
Date:   Sat, 29 Jan 2022 14:35:38 +0800
Message-Id: <20220129063538.24038-1-bojun.cbj@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
References: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chen Bojun <bojun.cbj@alibaba-inc.com>

When pushing a hidden ref, e.g.:

    $ git push origin HEAD:refs/hidden/foo

"receive-pack" will reject our request with an error message like this:

    ! [remote rejected] HEAD -> refs/hidden/foo (deny updating a hidden ref)

The remote side ("git-receive-pack") will not create the hidden ref as
expected, but the pack file sent by "git-send-pack" is left inside the
remote repository. I.e. the quarantine directory is not purged as it
should be.

Add a checkpoint before calling "tmp_objdir_migrate()" and after calling
the "pre-receive" hook to purge that temporary data in the quarantine
area when there is no command ready to run.

The reason we do not add the checkpoint before the "pre-receive" hook,
but after it, is that the "pre-receive" hook is called with a switch-off
"skip_broken" flag, and all commands, even broken ones, should be fed
by calling "feed_receive_hook()".

Add a new test case in t5516 as well.

Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Helped-by: Teng Long <dyroneteng@gmail.com>
Signed-off-by: Chen Bojun <bojun.cbj@alibaba-inc.com>
---
 builtin/receive-pack.c | 9 +++++++++
 t/t5516-fetch-push.sh  | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9f4a0b816c..a0b193ab3f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1971,6 +1971,15 @@ static void execute_commands(struct command *commands,
 		return;
 	}
 
+	/*
+	 * If there is no command ready to run, should return directly to destroy
+	 * temporary data in the quarantine area.
+	 */
+	for (cmd = commands; cmd && cmd->error_string; cmd = cmd->next)
+		; /* nothing */
+	if (!cmd)
+		return;
+
 	/*
 	 * Now we'll start writing out refs, which means the objects need
 	 * to be in their final positions so that other processes can see them.
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 2f04cf9a1c..da70c45857 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1809,4 +1809,12 @@ test_expect_success 'refuse fetch to current branch of bare repository worktree'
 	git -C bare.git fetch -u .. HEAD:wt
 '
 
+test_expect_success 'refuse to push a hidden ref, and make sure do not pollute the repository' '
+	mk_empty testrepo &&
+	git -C testrepo config receive.hiderefs refs/hidden &&
+	git -C testrepo config receive.unpackLimit 1 &&
+	test_must_fail git push testrepo HEAD:refs/hidden/foo &&
+	test_dir_is_empty testrepo/.git/objects/pack
+'
+
 test_done
-- 
2.32.0 (Apple Git-132)

