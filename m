Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F4FEB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 06:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346128AbjFQGm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 02:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbjFQGmc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 02:42:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB1F44A7
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 23:41:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-311099fac92so1261251f8f.0
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 23:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686984084; x=1689576084;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCuO7aOmHMwsehHwZAAEQvDE9lIDN1cQAtYHsydL2EU=;
        b=GQchUqOdkCjEl04MtQeHwOqN0M/5u/2NuI+1zn4pHUIf0X7xZdadTd6Uvnqb/AMzoC
         rkTcycDiUZDhS9OZFWP/9b0QCK91s6vmD2lrH6sjcfc3/r7WLDQ91R31WgXKEBR8d6Ql
         Zj6lg07CLTQOPrw67kk28pI2I6oqoMkQobSQs9RBio+4dtcDV721mnoJTm6iZjYEivfe
         K2rb1wcUQ9daJTqSHTq5mYKA8/CcpfUMBLoN1PHyw0do4IW6nDior99SGuJhr1urYcAC
         o4tgWlfjLdqhSrJbO3iIwWMKIGKB5DMbFO1/ISFhHZjP0cNNHei45+wHKX6WOrSAZijm
         cXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686984084; x=1689576084;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCuO7aOmHMwsehHwZAAEQvDE9lIDN1cQAtYHsydL2EU=;
        b=lqpNg7Ee6pAPDbS8ElyXc/uGlHXrucxHks/q8iaIoI8ldn6AaEi0Occr6ClVVPXKMS
         XPkRKC13kktXAdHuuHGarf3lsR88YTfZmidw2v2jKFHoNnBksiexJJAkwhByZYgWRa4F
         H/+OQa9E7aUP7HXr/IQ/UA1keMqqtInjUkIcpOf8jt3VaAOgtUr1YZKN1ky7BfDeo3jh
         mjl5qFTma57BsnXB5ynV3fKknSLr4q0TkqsduPTjk1e4c03bxLWKmPIKJqfwIPej72VW
         2QnCmkLpAGLJeo812qInqK+GlM5T2YEu9PxbRbHZ1UnHgdOqFGLpZlBAzSXZkvRaVYB2
         APvg==
X-Gm-Message-State: AC+VfDxoC65ajb5crE54dC5bA231jczVSqaPYBFupUwDuLfmNa9l77ve
        K+iCS1SR+3af1KfIiWk09fs=
X-Google-Smtp-Source: ACHHUZ6w84eKJuL0SYQ0kna1rAytXtjHU5m+jifAdPXeNsMTAbo9kAx2RjQtAxjBwrMM9sukRKn1rw==
X-Received: by 2002:adf:f18f:0:b0:30f:b9de:ab21 with SMTP id h15-20020adff18f000000b0030fb9deab21mr3118660wro.14.1686984083645;
        Fri, 16 Jun 2023 23:41:23 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d4291000000b003047ea78b42sm25472867wrq.43.2023.06.16.23.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 23:41:23 -0700 (PDT)
Subject: [PATCH v3 3/5] branch: fix a leak in cmd_branch
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
 <71b49be1-eeef-2f60-38f1-cfcbe4c8252f@gmail.com>
Message-ID: <510e9029-c424-2861-ab3c-30046333f715@gmail.com>
Date:   Sat, 17 Jun 2023 08:41:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <71b49be1-eeef-2f60-38f1-cfcbe4c8252f@gmail.com>
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
