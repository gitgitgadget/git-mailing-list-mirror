Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E945AC7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 22:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjDVWTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 18:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjDVWTr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 18:19:47 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6558326A4
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 15:19:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f1957e80a2so41258365e9.1
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 15:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682201984; x=1684793984;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IfNvuAOxcb1q/KCOIJTYtIR4eUBUGg27dSrRoUzm1Y=;
        b=mKtJLVdBdegIDUxIfLotkuLLkr1XNZGFrTrteCPaDDgRLVaZATU5W8Al/V9i5480Ji
         6rO/DXxyTqSv7y4uOVlCT0om6i5RSIgcKl+43159tFEMu5A+/9ZpxPWIfbVKiYeopBah
         IT1KFgVwdEK0RkpKv/W1vdisyPSK2R0QE1FH2JKTqRftDaJNE+39CmcW0RMRaX69cJn+
         9zfEPqA4fIXy950Mszx4Qokbhug23JBPx+zNgqb4YQbEJ4V50RIOZvfZzIte5iM6lWiM
         7svCeMrOHGrgNHtppqlkJAg04O+LEZI/LGl1lm79ZaHUnCAWeOTYj8trUag6MYcSHe++
         NnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682201984; x=1684793984;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2IfNvuAOxcb1q/KCOIJTYtIR4eUBUGg27dSrRoUzm1Y=;
        b=XhTTGqoKFJzc3rsENDG4z00bq5X6MFEfG4o4wXdEtOKnKE2kZAmhMVVVRMX+iqRD0d
         ThQ+H93TY7XaAvgdD2l6/ByZSirIG75Y+K/iUTsbSCn9sSOfrCN0fnfFsXVCZz+NlsWG
         5qAxRZ0tzfnIQ1OhHcMDVNTvAT8dE5gTIUlWbkoD0gHoBiz8bDjVWZrEKnKknD1VIczO
         QdxAlpWX7yJrMVncORR5kIG2AHwmF74VRkSoK0yoE/1LEiZodxw6YQ9xAO7FNyOAhy40
         nyc0lnkPV+rQc/cbNnF91vkdXsTESsYMoHZaPmmu0Q7d1+3nzoAUPxVKL2tPiDdUTplS
         I6AA==
X-Gm-Message-State: AAQBX9fS+aPfhgfLDH5pn8HtEZzTfdHwR+SbwFyQunXG6/uYl2TsYtfl
        HL933BEFo3m1WS1abBZaNxc=
X-Google-Smtp-Source: AKy350bC9FId5OW6ULERVqHGB3GospvZP17wFo0qm+K8nKOJGvbetRRBZjcPItmp4fls7/3ZwtxULg==
X-Received: by 2002:a05:6000:47:b0:2d9:10e7:57e8 with SMTP id k7-20020a056000004700b002d910e757e8mr9669723wrx.16.1682201983944;
        Sat, 22 Apr 2023 15:19:43 -0700 (PDT)
Received: from [192.168.2.52] (32.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.32])
        by smtp.gmail.com with ESMTPSA id q17-20020a1cf311000000b003eeb1d6a470sm8243890wmq.13.2023.04.22.15.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Apr 2023 15:19:43 -0700 (PDT)
Subject: [PATCH 3/3] checkout: warn when unreachable commits after using
 --orphan
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <f702476a-543a-da9b-ccd9-4431c80471e1@gmail.com>
Message-ID: <417ae16c-9ba7-1e6d-c8d7-5b20a188b4fe@gmail.com>
Date:   Sun, 23 Apr 2023 00:19:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f702476a-543a-da9b-ccd9-4431c80471e1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 8e2dc6ac06 (commit: give final warning when reattaching HEAD to leave
commits behind, 2011-02-18) we introduced a warning to be issued when,
while checking out, the tip commit being left behind is not connected to
any ref.

We assumed that if the commit to be checked out is the same commit
currently checked out, we would omit the warning.  This makes sense
because we're going to have HEAD pointing to the same commit anyway, so
there is nothing to warn about.

However, with "--orphan" the target commit is not going to be used as
HEAD in the worktree, but a new orphan branch being created, which is
not going to be connected to the previous commit.  Therefore, we need
to check if the commit it is reachable and warn otherwise.

Let's fix the condition we introduced in 8e2dc6ac06, considering the
"--orphan" flag situation.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/checkout.c         | 8 ++++++--
 t/t2020-checkout-detach.sh | 9 +++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 85ac4bca00..7fad3161b4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1050,8 +1050,12 @@ static int switch_branches(const struct checkout_opts *opts,
 		}
 	}
 
-	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit && new_branch_info->commit != old_branch_info.commit)
-		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit, 1);
+	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit) {
+		if (new_branch_info->commit != old_branch_info.commit)
+			orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit, 1);
+		else if (opts->new_orphan_branch)
+			orphaned_commit_warning(old_branch_info.commit, NULL, 1);
+	}
 
 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 2eab6474f8..6762a9a572 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -124,6 +124,15 @@ test_expect_success 'checkout warns on orphan commits: output' '
 	check_orphan_warning stderr "2 commits"
 '
 
+test_expect_success 'checkout --orphan warns on orphan commits' '
+	git checkout "$orphan2" &&
+	git checkout --orphan orphan 2>stderr
+'
+
+test_expect_success 'checkout --orphan warns on orphan commits: output' '
+	check_orphan_warning stderr "2 commits"
+'
+
 test_expect_success 'checkout warns orphaning 1 of 2 commits' '
 	git checkout "$orphan2" &&
 	git checkout HEAD^ 2>stderr
-- 
2.39.2
