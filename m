Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA8AC433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 14:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbiAFO7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 09:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240242AbiAFO7F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 09:59:05 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F64C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 06:59:04 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id q4so2530577qvh.9
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 06:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3yujLFVvV1ldi0YusmJnKAsdvCFGWmA/5EDWqqucy5w=;
        b=HaTwYY3Op3WOumuq2MGO8iapazX08pN8XHxX0jEQuil0loytzIe71cTDVpn5NIIbSv
         ivv2Z1IlXe8XPZ3wfb9CIfP97ktUBwOVHhJXKIlMNrvdasgfI9ls7RlIn/klrgJKdsi5
         GgSpfIhychHW5pvZiMyj7xkg3KutwdMTfzFyFyW9SqM5e7Zcy75SH+RF2NSSxGK+eBjn
         upa+4+1UZxIsxBFsY9S2KUv5iXWOSxCablHMLuBFSy5UTWttCu6bQgE3T2U74hNpeHXV
         5hgFppg9iUONicHDqbEpd1gEqtc06LKUHWSoT2WYKn7q9czFPjUQ0qZ4tL7YKN1aEHDz
         e2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3yujLFVvV1ldi0YusmJnKAsdvCFGWmA/5EDWqqucy5w=;
        b=vsYoJIPBoSiCS8n0/6hHsbGUorJSi11mZAA2pjoaGViDNkoViJYUMpagel2e9HwIss
         Pnhk+gvpQk11/M36tOLyEXwu7Ceg5m4d5Wo30pKmobNkelniZ72LqqTCpXs861hKQYV2
         G+X42zK2K2lJtnXkuSc20c32SeceJGIj4e5dkwh6AH8yhLR+so2A0mxQBHzXWM0UZGfB
         ktoSa57gOZ32egGBERIsAoUmPYGW3I2q6RB+wNjHXrKBom7VgmenUydHGUCc5xLiRb7M
         aG+HTlIB6fOZVrTHpH9eP9FqjmYW9fjseZFAPEiU+lsCI4RDtvcnKrCqpqwmbt4tAC+M
         TlvA==
X-Gm-Message-State: AOAM533Lbz2IKIGdmjAo1KqFwlXH7++FIyZebrgetCUsHzkwmnmRZpiv
        OAiPGJsvTukEctxhTPHPn6FiGxegc//D3g==
X-Google-Smtp-Source: ABdhPJxuVo2eyL9s0xqEBNavl/tB9ethbxGmnSYCmSX5jV9ajtPzWKSKNe7vI2yo4SHbZVPF6vY55Q==
X-Received: by 2002:a05:6214:2622:: with SMTP id gv2mr54833759qvb.128.1641481143780;
        Thu, 06 Jan 2022 06:59:03 -0800 (PST)
Received: from Johns-MBP.myfiosgateway.com (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id m9sm1647266qkn.59.2022.01.06.06.59.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Jan 2022 06:59:03 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     git@vger.kernel.org
Cc:     levraiphilippeblain@gmail.com, phillip.wood123@gmail.com,
        John Cai <johncai86@gmail.com>,
        "Tilman Vogel" <tilman.vogel@web.de>,
        "Junio C Hamano" <gister@pobox.com>
Subject: [PATCH v2] builtin/pull.c: teach run_merge() to honor rebase.autostash config
Date:   Thu,  6 Jan 2022 09:58:51 -0500
Message-Id: <20220106145851.77154-1-johncai86@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On a git pull --rebase, if fast forward is possible we run merge.
However, merge will not honor rebase.autostash if it is configured. This
has the unfortunate result of

$ git config rebase.autostash true
$ git pull --rebase

to ignore the rebase.autostash value.

Allow run_merge() to honor rebase.autostash by passing in
config_autostash if --autostash or --no-autostash flags are not
explicitly set.

Reported-by: "Tilman Vogel" <tilman.vogel@web.de>
Co-authored-by: "Junio C Hamano" <gister@pobox.com>
Signed-off-by: "John Cai" <johncai86@gmail.com>
---

Notes:
    Fix a bug that prevents git pull --rebase from honoring the rebase.autostash
    config value.

    Changes since V1:
    - used simpler fix as proposed by Junio
    - removed redundant test cases

 builtin/pull.c          |  9 ++++++++-
 t/t5521-pull-options.sh | 12 ++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 100cbf9fb8..8423e420ee 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1133,7 +1133,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("cannot rebase with locally recorded submodule modifications"));
 
 		if (can_ff) {
-			/* we can fast-forward this without invoking rebase */
+			/*
+			* We can fast-forward without invoking
+			* rebase, by calling run_merge().  But we
+			* have to allow rebase.autostash=true to kick
+			* in.
+			*/
+			if (opt_autostash < 0)
+				opt_autostash = config_autostash;
 			opt_ff = "--ff-only";
 			ret = run_merge();
 		} else {
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 66cfcb09c5..66fac99d2b 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -252,4 +252,16 @@ test_expect_success 'git pull --no-verify --verify passed to merge' '
 	test_must_fail git -C dst pull --no-ff --no-verify --verify
 '
 
+test_expect_success 'git pull --rebase --autostash succeeds on ff' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src "initial" file "content" &&
+	git clone src dst &&
+	test_commit -C src --printf "more_content" file "more content\ncontent\n" &&
+	echo "dirty" >>dst/file &&
+	git -C dst pull --rebase --autostash >actual 2>&1 &&
+	grep -q "Fast-forward" actual &&
+	grep -q "Applied autostash." actual
+'
+
 test_done
-- 
2.34.1

