Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E7EC77B7A
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 18:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjFKSuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 14:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjFKSuT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 14:50:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8950AE64
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:50:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30af86a966eso2254929f8f.2
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686509417; x=1689101417;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMGH5694LA6mEBuhJb4jLEC639P9iTY2nBlFubRef20=;
        b=rWSnn9bcCvxiHz2WMVfoGHsmdvTjEpNMzAblqa43S8aTEQJ5iKf/SXeMQ/Az6poWz6
         MEw75D0lmpANjoA757pbp/1GxFal7bjACepSYLOOs+vpycuORYU2aTf4LWduzU5H9d75
         iWUI4Nr8ocvW52pjdfFb0GGZwowHrwxy45grhh2MY+HlHZ4G5UfpwH4RvYeIupTIrez4
         L0wzlomRer5oxx83jBqCwBsyTI5dnKB8R6ILhwkGtxa1jYnwdJvZHwNALTWfdTJNsS8q
         dstLg9o80f7TsGDoh9vpVVUiWDu/WMxQhkqhEhGwVN2+FbOZCaFEkq5HTmHF7ZORktT7
         Du0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686509417; x=1689101417;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMGH5694LA6mEBuhJb4jLEC639P9iTY2nBlFubRef20=;
        b=biyS1DMbgB4uyE/jD/kB01d154vlS8kmlkHg0SRNZI0m2kP8L9Blvc2hXdsDjsXzEs
         q40qNeuyhUEYgIAMRTPs//vhHQ2d2Xbj/WWOjbLj3lRoIkkd785WG2TYobB2UboM5sB/
         WLNkCAcl2wcd8SKdyCT31sMgOb1ypbHcfqFR6TDgS/y2SplCUwi1JFWWvlJytaLLsDju
         ulECoTHbpEasikuKXEFzsAWBIJ666I47G12L29SQeaZSNvMOdvF0jCVMFwFu9lK0JP35
         YMvJpkG2PZU0YC7P2X3BtFshiJxRwdcEW5XJZH5h6DrQRC4PUsx/Og1J2MFkiFhdU72D
         rqaw==
X-Gm-Message-State: AC+VfDwQwfMwUPK+E+rNA8Z9kGsoEOvhZoklnd1Cwsy171zWYxyH+OO4
        K/SFlQB92kNe37fLPSDRocjseuTPLeI=
X-Google-Smtp-Source: ACHHUZ6SmyqSwo3ZL+xqRNhSFno5Gf+koJJjrdjK2HWEjigpP+KTYdnnAZ2Qa3x9PH1QvfGhWgMLxQ==
X-Received: by 2002:adf:f68c:0:b0:30d:43ca:55ab with SMTP id v12-20020adff68c000000b0030d43ca55abmr2771033wrp.38.1686509417004;
        Sun, 11 Jun 2023 11:50:17 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm10320581wrv.108.2023.06.11.11.50.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 11:50:16 -0700 (PDT)
Subject: [PATCH 07/11] branch: fix a leak in inherit_tracking
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Message-ID: <25e68755-7073-9523-dacc-d79e4e10eb39@gmail.com>
Date:   Sun, 11 Jun 2023 20:50:16 +0200
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

In d3115660b4 (branch: add flags and config to inherit tracking,
2021-12-20) a new option was introduced to allow creating a new branch,
inheriting the tracking of another branch.

The new code, strdup()'d the remote_name of the existing branch, but
unfortunately it was not freed, producing a leak.

   $ git remote add local .
   $ git update-ref refs/remotes/local/foo HEAD
   $ git branch --track bar local/foo
   branch 'bar' set up to track 'local/foo'.
   $ git branch --track=inherit baz bar
   branch 'baz' set up to track 'local/foo'.

   Direct leak of 6 byte(s) in 1 object(s) allocated from:
       ... in xstrdup wrapper.c
       ... in inherit_tracking branch.c
       ... in setup_tracking branch.c
       ... in create_branch branch.c
       ... in cmd_branch builtin/branch.c
       ... in run_builtin git.c

Actually, the string we're strdup()'ing is from the struct branch
returned by get_branch().  Which, in turn, retrieves the string from the
global "struct repository".  This makes perfectly valid to use the
string throughout the entire execution of create_branch().  There is no
need to duplicate it.

Let's fix the leak, removing the strdup().

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index ff81c2266a..19d606d360 100644
--- a/branch.c
+++ b/branch.c
@@ -233,7 +233,7 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
 		return -1;
 	}
 
-	tracking->remote = xstrdup(branch->remote_name);
+	tracking->remote = branch->remote_name;
 	for (i = 0; i < branch->merge_nr; i++)
 		string_list_append(tracking->srcs, branch->merge_name[i]);
 	return 0;
-- 
2.40.1
