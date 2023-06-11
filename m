Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57E8C7EE2E
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 18:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjFKSuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 14:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjFKSuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 14:50:09 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716D4E64
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:50:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f81b449357so2509065e9.0
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686509407; x=1689101407;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tt1FB1kn+UlodWOOSYnStELOGQ4ptiZzYdo3jNYafQ4=;
        b=Fm5oI8yV8WylDHSCL2EdyZkE3YnlYX0sOcM4SOHsPGVwbsOF5hKBsLQnDeV11uiBH7
         bSEeSrOZJpjkEuAq1MnoGnz0MYgWLJwSypyTIcAO7PzE2WJwp6WK0+xOlKOKJUkqLmc9
         n0wnxP/ihNuNvHdS02lHNitO8fBAxUedqPtIZFfS+0uufHqZtCLJ/XCFh2DYCokTbdkb
         BlUVn57Yl1L9eYYYj701ztl/Gvu/nJ11oCBr/HgaiG0xtkY6JEN7YZHaeHALseGRoix5
         IxEyHwJ+ex3xq66I/Jsb3p/TFvH8335oViLJzZb9/2zpbzHJ1FqvwJiYoZINN5TfP5tW
         eXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686509407; x=1689101407;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt1FB1kn+UlodWOOSYnStELOGQ4ptiZzYdo3jNYafQ4=;
        b=POhMcy4IM5ejOrbQzRvXWnfVMiK+LvlC+cCPbL7hNpFQ5uzg1CQ2kr6xT47G1qFIm+
         jMt6pheNLrYNkYsTeADJB21QqkXzoDtMnEFWHmmYWH4+jDCJVvPDFvPIQJ4eRnsQQ976
         MQFxZ4JTMAgEdIAgjgJlygc3d7x6y7QsIHA6S6IhzbjKu7y0Fcmf3Dhm079cWdcZ77Wb
         PcMMvl806Fof4Upbz7MOVuVk6u00WZPJklrDHxjdld/OpYhkuTXLWhIpMW3QqPxkE/l+
         AY9Int5pciQObKtQ3vUIG/OGAFfSqF5AjMyYLNnOOV8ho+AGju0AUy8cGB5zf81DwJMX
         x6CQ==
X-Gm-Message-State: AC+VfDzcTWAHpO3us0/JCyVYGbZgFoA8Sg9/bRU10gQG0TdiqHPyZ6t8
        WOTd1wVZUAnp93ODhvuca1YZnrUHcLQ=
X-Google-Smtp-Source: ACHHUZ7p1QDWqnxffam0vfIXWxBqNDknpF9J/OGKbAQuZNe9xPLxdBzB4mbpZsROV3omUAkTRYBlEA==
X-Received: by 2002:a7b:c84c:0:b0:3f7:371a:ec8f with SMTP id c12-20020a7bc84c000000b003f7371aec8fmr5483354wml.15.1686509406688;
        Sun, 11 Jun 2023 11:50:06 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id y19-20020a05600c365300b003f7f60203ffsm9073946wmq.25.2023.06.11.11.50.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 11:50:06 -0700 (PDT)
Subject: [PATCH 06/11] branch: fix a leak in cmd_branch
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Message-ID: <6cbdf9b9-227a-4665-5725-6a863676e95d@gmail.com>
Date:   Sun, 11 Jun 2023 20:50:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
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
refactoring and keep the fix simple, and while we find a better
solution, let's silence the leak-hunter making the list static.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index e6c2655af6..759480fe8d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -709,7 +709,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	enum branch_track track;
 	struct ref_filter filter;
 	static struct ref_sorting *sorting;
-	struct string_list sorting_options = STRING_LIST_INIT_DUP;
+	static struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
 
 	struct option options[] = {
-- 
2.40.1
