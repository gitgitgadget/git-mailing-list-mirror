Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B04EB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 23:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345651AbjFPXen (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 19:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjFPXeh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 19:34:37 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FB23AAE
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:34:33 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b448cf5d83so17708121fa.1
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686958472; x=1689550472;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCuO7aOmHMwsehHwZAAEQvDE9lIDN1cQAtYHsydL2EU=;
        b=F42KoRyqjeYrxMuRlLpJkcQwAfPr5daUCPqxx8IW/0W6hNFCrJIGLO/wJ+hLi2reZi
         uMniyZx2nLupi1rsZey0exdGK/yamMHmZkMt6m48Cpv36HIZF2MW66hdXvvBcffs2dkN
         f0OMWGS6e27NQQrfvWQvF/iJg7zQj3DLfh8gPEsP8q2HaH533rW05VLL3FveNZBB+5km
         bx+M7cpfbEvEPFp8VK84jvljwcE3ejalqpdVC4bTQYCdWdjU4ya9xVDMOH5LFQnf1Gm+
         CJABFL0C7to+VoGxkq3N8pDBis/4iNraLvi484X/LAzgNqm5sEPKVOwD8O7VwnFvV5YZ
         iWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686958472; x=1689550472;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCuO7aOmHMwsehHwZAAEQvDE9lIDN1cQAtYHsydL2EU=;
        b=Zdoo0PShHGbqsbHTE2nEKbXCAxp74KlPOy3tDnAgmkLdzS7wh99BtZTcEXag+gk3QO
         XYwC8my/BjAUQ6hhzj2IEIRb5DnST7B3MsfVe/Jc2o9mp9DGLQGW3W6OxyE1wj76YFzN
         QkMe2JYIEi6iRYLJFiFpWUZVfWSdIM5byRQ/rTaAkp3dGtP1pd9ccZfOYqWOcHDaJfYj
         lyvbK0dYY6YZxKJXgaKwgvvUWPA5bA3JpSkZyZ/t3PdntwfAb4oh0H3lula86RlVVTow
         cdkbW4s0QD52Tifq4Qbj0BvbXQ7W/gAVtb+A5B2J4I9jaXV6sLPei2GY0wwzO/kuEtSy
         oubw==
X-Gm-Message-State: AC+VfDznl7ZdLuWY7xsnQytviqkO6SpjBgi4B3F5nL8+KEXUV4gwADhn
        3S1a7HDdOMxkHMUINUKV9m+4TeLShkg=
X-Google-Smtp-Source: ACHHUZ40MJVnrLBRc7D6Qko8Qn2vXliCfy6Sf96iSIi5OS2MFdlwyX5XkbsjWWoMy02jH/1dk20BQQ==
X-Received: by 2002:a2e:8ed7:0:b0:2b3:4cb5:ded4 with SMTP id e23-20020a2e8ed7000000b002b34cb5ded4mr3410718ljl.21.1686958471992;
        Fri, 16 Jun 2023 16:34:31 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id x7-20020a1c7c07000000b003f809461162sm3372488wmc.16.2023.06.16.16.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 16:34:31 -0700 (PDT)
Subject: [PATCH v2 3/5] branch: fix a leak in cmd_branch
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
Message-ID: <cfb18a2d-381f-b9ae-865a-26c1669da3b5@gmail.com>
Date:   Sat, 17 Jun 2023 01:34:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 98e7ab6d42 (for-each-ref: delay parsing of --sort=<atom> options,
2021-10-20) a new string_list was introduced to accumulate any
"branch.sort" setting.

That string_list is cleared in ref_sorting_options(), which is only
called when processing the "--list" sub-command.  Therefore, with other
sub-command, while having any sort option set, a leak is produced, e.g.:

   $ git config branch.sort invalid_sort_option
   $ git branch --edit-description

   Direct leak of 384 byte(s) in 1 object(s) allocated from:
       ... in xrealloc wrapper.c
       ... in string_list_append_nodup string-list.c
       ... in string_list_append string-list.c
       ... in git_branch_config builtin/branch.c
       ... in configset_iter config.c
       ... in repo_config config.c
       ... in git_config config.c
       ... in cmd_branch builtin/branch.c
       ... in run_builtin git.c

   Indirect leak of 20 byte(s) in 1 object(s) allocated from:
       ... in xstrdup wrapper.c
       ... in string_list_append string-list.c
       ... in git_branch_config builtin/branch.c
       ... in configset_iter config.c
       ... in repo_config config.c
       ... in git_config config.c
       ... in cmd_branch builtin/branch.c
       ... in run_builtin git.c

We don't have a common clean-up section in cmd_branch().  To avoid
refactoring, keep the fix simple, and while we find a better solution
which hopefuly will avoid entirely that string_list, when no sort
options are needed; let's squelch the leak sanitizer using UNLEAK().

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index e6c2655af6..075e580d22 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -832,6 +832,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (list)
 		setup_auto_pager("branch", 1);
 
+	UNLEAK(sorting_options);
+
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-- 
2.40.1
