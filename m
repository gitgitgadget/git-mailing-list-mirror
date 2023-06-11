Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A4EC7EE2E
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 18:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjFKSt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 14:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjFKSty (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 14:49:54 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67536E69
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:49:53 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6d7abe934so25058515e9.2
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686509392; x=1689101392;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6KT9WQG46CrZDtm8XKNJpdaUYuwHNxyMAC9Pl6emhs=;
        b=mKAGKIaNVEJmH8OhZHd3/KfDcSr+x7LKmadWkDMu8SI/2oxsrOUPWxmcmB4T8WWzkM
         g2vX549bg6ychzvDTWoR++XwCsOMNLhRtWkAl5PSsqYBUElMeD8ilCZKqJbB+pgRCMJI
         ivFTY0+VkEvryMAMdQG5AmC19ZWQ0FkLHcLofH9aYUXX2+NAz3i9fAWV47qvOcivvsuD
         Mcn930e3Beo+G419VL1WtO7mq54LojwWk9Dv0r8QvE1/ujXNMhvOrVPW1Sat5u4bQ9xm
         KrjoNvW1VQz+QeoAmi6y2evB/y3LT6ssfeUiT+RgNR6Mf5j3FV5hae6S5lNLj58LVsyl
         gDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686509392; x=1689101392;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6KT9WQG46CrZDtm8XKNJpdaUYuwHNxyMAC9Pl6emhs=;
        b=AmGJ36xpNMsMJC778UXLZdfaL5uGDoc1ty5VOtp5ViYGLoVeGDSaxKFInd6AJdTfbm
         f4FC9NeWk1DAd2gtacCpo+kFfztACml7GRav0O2iF8lubkg82wenLfEO+8i+jBloO9Zs
         D31IC3uR5AG7iD3CbndJpWxKSjsz5AmoFshl1hoYcE8OOAf58JFC+EnGF4Etsh/wcos4
         7ppmfRDI9uGA8vHmv2uYWqcw2e9GQN6sWR1UN8bV+iVN6W2QLh9m+bgnjmVG9/3fW41x
         e3YySef8M2Fg4mm9JAr0dBW8eto1la/LxfB2nOxYsUf6lcDmWmC7tqQM/meEheMm0rTw
         a8Wg==
X-Gm-Message-State: AC+VfDwH+vXaAdq0+cnZkPAVmSM+rEJ7TpCBa6g2PiocOH3l796DrCGs
        i2hiXWYZkts5GCONy8NhWhp5G+8spDw=
X-Google-Smtp-Source: ACHHUZ66JZAZbtALp0PGQoqIOU6BQt1Qg7GIeO6QjQC3lvP/mpJquUyfyT057J76AUjv5ytAniTbVw==
X-Received: by 2002:a05:600c:2204:b0:3f6:91c:4e86 with SMTP id z4-20020a05600c220400b003f6091c4e86mr4554013wml.3.1686509391874;
        Sun, 11 Jun 2023 11:49:51 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b003f7cb42fa20sm9079917wmr.42.2023.06.11.11.49.51
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 11:49:51 -0700 (PDT)
Subject: [PATCH 05/11] branch: fix a leak in setup_tracking
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Message-ID: <49a4339b-d736-2c30-0c57-194ab33f377c@gmail.com>
Date:   Sun, 11 Jun 2023 20:49:51 +0200
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

In bdaf1dfae7 (branch: new autosetupmerge option "simple" for matching
branches, 2022-04-29) a new exit for setup_tracking() missed the
clean-up, producing a leak.

   $ git config branch.autoSetupMerge simple
   $ git remote add local .
   $ git update-ref refs/remotes/local/foo HEAD
   $ git branch bar local/foo

   Direct leak of 384 byte(s) in 1 object(s) allocated from:
       ... in xrealloc wrapper.c
       ... in string_list_append_nodup string-list.c
       ... in find_tracked_branch branch.c
       ... in for_each_remote remote.c
       ... in setup_tracking branch.c
       ... in create_branch branch.c
       ... in cmd_branch builtinbranch.c
       ... in run_builtin git.c

   Indirect leak of 24 byte(s) in 1 object(s) allocated from:
       ... in xrealloc wrapper.c
       ... in strbuf_grow strbuf.c
       ... in strbuf_add strbuf.c
       ... in match_name_with_pattern remote.c
       ... in query_refspecs remote.c
       ... in remote_find_tracking remote.c
       ... in find_tracked_branch branch.c
       ... in for_each_remote remote.c
       ... in setup_tracking branch.c
       ... in create_branch branch.c
       ... in cmd_branch builtinbranch.c
       ... in run_builtin git.c

The return introduced in bdaf1dfae7 was to avoid setting up the
tracking, but even in that case it is still necessary to do the
clean-up.  Let's do it.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index a7333a4c32..ff81c2266a 100644
--- a/branch.c
+++ b/branch.c
@@ -333,7 +333,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 		if (!skip_prefix(tracking.srcs->items[0].string,
 				 "refs/heads/", &tracked_branch) ||
 		    strcmp(tracked_branch, new_ref))
-			return;
+			goto cleanup;
 	}
 
 	if (tracking.srcs->nr < 1)
-- 
2.40.1
