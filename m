Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22330C7EE2E
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 18:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjFKStw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 14:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjFKSts (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 14:49:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95569E6A
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:49:45 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f732d37d7bso25485905e9.0
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686509384; x=1689101384;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2/Tw0uepHAlXppAx+Jppg6bKIxRe4qPeS+gdVaI8h0=;
        b=Pa11FA+Eq4W/Ql16OIZ0Nb+zUMGL9rAleQ4xUKB1rtviOQrvWdOftRogRr3z3CYjc1
         1k5JuQej8u+HWiBEcqDnLIDhOe3krgbHr5iGh59oG9i/FasCIEe0921ZbGu00XXwUwn5
         RDR25eH4Puee78BObJL8Ya2ZrdMVlYx/DAzqmQBHFP4wTGlFXf1tF/FfpKvuupndzyFT
         2r4q+n9jETo9meKzCrJYXE+fqx+0HUE26uNQx+C7yEaGDBFxF8gOgzE6JNPEqUK+vree
         UJUcfEnWVgboM6/x7w6Vf7B4y0f9pb33OzsWvSUHhmuDrnxkzWZLJrQDFH77f+FJHyrm
         UKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686509384; x=1689101384;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2/Tw0uepHAlXppAx+Jppg6bKIxRe4qPeS+gdVaI8h0=;
        b=OCT8PK7DsO8mcNQbVagNUwZPX74rGAzCH4sUvtCnyyhtPTDz+hzjY6jv0supNWHogt
         G6MJ+wC9LXkQgOQyafdqSoE/wldGtrv9OtLrHeuGZN3PjR/SvfBZgnttw51rR6ihh4dk
         ZuFQ71PCBYDPO9s8WjSch992IPw2pYzZqEcnWbPud+KD1gt8AHAbpW8VisiLuDnhikIf
         GYhe/8VC3qqBrsU28fIDyE2+kHM7uf1GCUpTu8UNjIwHr9TxelydfZL9wv8eAaNGuHb6
         skOoq+BvrkDJfhsQu+Dcl4t0Q3QvPO9+uD44Pa+5d13mihxx3OWHmKFhE6Zpb21ZWEnF
         Jw3A==
X-Gm-Message-State: AC+VfDzXW2uzh0y9QDNUREh21TT1i2j4K4pOXCQyeTXUsTSvLmqw3JT0
        5awYIHc0uD8G/Ub1IR5/X/t0cSarQSY=
X-Google-Smtp-Source: ACHHUZ5tJy/Bi9iz3uCM3RyE1q91x2QSGOfKA827MGwSHwfOEJ7hcLmX7uAqWwH3eEL+3JHOjw9fDg==
X-Received: by 2002:a05:600c:219a:b0:3f1:9b85:e305 with SMTP id e26-20020a05600c219a00b003f19b85e305mr4937236wme.34.1686509383855;
        Sun, 11 Jun 2023 11:49:43 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id f16-20020a1c6a10000000b003f60fb2addbsm9104992wmc.44.2023.06.11.11.49.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 11:49:43 -0700 (PDT)
Subject: [PATCH 04/11] branch: fix a leak in dwim_and_setup_tracking
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Message-ID: <a6fec1ab-4006-2896-a2d9-dc0d8fa1c132@gmail.com>
Date:   Sun, 11 Jun 2023 20:49:43 +0200
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

In e89f151db1 (branch: move --set-upstream-to behavior to
dwim_and_setup_tracking(), 2022-01-28) the string returned by
dwim_branch_start() was not freed, resulting in a memory leak.

It can be reviewed with:

   $ git remote add local .
   $ git update-ref refs/remotes/local/foo HEAD
   $ git branch --set-upstream-to local/foo foo

   Direct leak of 23 byte(s) in 1 object(s) allocated from:
       ... in xstrdup wrapper.c
       ... in expand_ref refs.c
       ... in repo_dwim_ref refs.c
       ... in dwim_branch_start branch.c
       ... in dwim_and_setup_tracking branch.c
       ... in cmd_branch builtin/branch.c
       ... in run_builtin git.c

Let's free it now.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 branch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index ba3914adf5..a7333a4c32 100644
--- a/branch.c
+++ b/branch.c
@@ -638,9 +638,10 @@ void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
 			     const char *orig_ref, enum branch_track track,
 			     int quiet)
 {
-	char *real_orig_ref;
+	char *real_orig_ref = NULL;
 	dwim_branch_start(r, orig_ref, track, &real_orig_ref, NULL);
 	setup_tracking(new_ref, real_orig_ref, track, quiet);
+	free(real_orig_ref);
 }
 
 /**
-- 
2.40.1
