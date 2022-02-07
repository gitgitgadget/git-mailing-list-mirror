Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6559DC433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 08:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbiBGIIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 03:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243052AbiBGH6F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 02:58:05 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95296C043181
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 23:58:04 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id g8so1746722pfq.9
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 23:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uXJ3DFHQ4s7K2pCnA959hy4KMwLS9eBfkHIAT4f86ZQ=;
        b=c8/Q5IiIXoX4z/pmQ9XBJZ/AEyBEu/GGQkWUj/Wx2qLa33lwdF2al3YDjDSsvg9VtA
         CRjEc8/eepNAJJR0VvJcUnYbR96h6bH5W6j135KUUCNbJ/BMQt9aaB2l8RslwPsF2nD7
         MA+YpQhJzNaPvoskaOsvTBdB2DCE7nRkCj75gLeTPaG8OF8i4Vo3Sd9qeh4mEcKaZwBs
         PcdXdzfXAkexh69vralFDUa5/tFqkc6XP1owSI7mPIdaFyJt1j3ppNml4pMaV6Hv2W9I
         ZdRPEspvGb+hTRDf9rzC8VWYZawpZnxSrOAnuWQd8vSOEN8NBmWkahGuz6jo7f9EA+2P
         fxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXJ3DFHQ4s7K2pCnA959hy4KMwLS9eBfkHIAT4f86ZQ=;
        b=mcMug8x0OmZuw8HrfeJ0mi8dIicekkAsXIGFWsh2aHWti5SaqLGAwWa9K4HAM3ylaQ
         Hi/oQyMzYgvKgIy4QQoaPmYMGpAc0cYuuEAQeqmGdOAH+uBn6j7NC3WRugv8dpB6ROVT
         34BS5Gr6QCxyUWtzBttGdRDRZ0ds7NZwsxPADbEnvhwhUjQRqnOart30xPMdvEuqLolv
         TyEhDJ71tpL8mYzRDHe0g0cZQ8tBceaUQJW8pFTCiUYXBrhHk4eQgYgQUcZEA3WVU6Q6
         x7bSrXRX4wn4xYw5ToBHATo3cwVfBw7j3ZO9QM8UT10NoDRRRMI0/AHc9ZrMlQpFIrPx
         yspg==
X-Gm-Message-State: AOAM5306q9Mps73GDBg+cHNEoa1Cbpqm6jDxiKHbxUIVde9XLUuzQVHI
        IKp5c9jQpc7kecIiG+yZQgOWMLuwagsiO36/
X-Google-Smtp-Source: ABdhPJyim6ev+AE+DIhEClzzH6vd/7ZX+5I88bKK+U+2C4JxRCbkbvqKCn35Cl5pEqaVIUSw8t2FGw==
X-Received: by 2002:a05:6a00:10d5:: with SMTP id d21mr14439663pfu.2.1644220683388;
        Sun, 06 Feb 2022 23:58:03 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.97])
        by smtp.gmail.com with ESMTPSA id q11sm11863195pfk.149.2022.02.06.23.58.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Feb 2022 23:58:02 -0800 (PST)
From:   Chen BoJun <bojun.cbj@gmail.com>
To:     git@vger.kernel.org
Cc:     Chen Bojun <bojun.cbj@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v3 1/1] receive-pack: purge temporary data if no command is ready to run
Date:   Mon,  7 Feb 2022 15:57:21 +0800
Message-Id: <0b5793d1ea0522b53a755583fa575298680c5f69.1644219248.git.bojun.cbj@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <cover.1644219248.git.bojun.cbj@alibaba-inc.com>
References: <pull.1124.git.1642987616372.gitgitgadget@gmail.com> <cover.1644219248.git.bojun.cbj@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chen Bojun <bojun.cbj@alibaba-inc.com>

When pushing to "receive-pack", commands may have already been marked
with error_string or skip_update before being fed to the "pre-receive"
hook. E.g.:

 * inconsistent push-options for signed push.
 * not permited shallow updates.
 * encounter connectivity issues.
 * push to hidden references.

Take pushing to hidden references as an example.

In order to reduce the size of reference advertisement for git-push from
a client which does not support protocol v2 and push negotiation, the
administrator may set certain config variables to hide some references
like:

    $ git config --system --add receive.hideRefs refs/merge-requests

Then, if a user made a push like this:

    $ git push origin HEAD:refs/merge-requests/123/head

"receive-pack" would reject the request with an error message like this:

    ! [remote rejected] HEAD -> refs/merge-requests/123/head
                                (deny updating a hidden ref)

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

