Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFFEEB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 06:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345997AbjFQGmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 02:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjFQGmI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 02:42:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8D030E4
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 23:41:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f8c74af64fso11747135e9.1
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 23:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686984069; x=1689576069;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgZNO4N7Lp3aOL0RIWfyplzy3WbAoT4TzJnAt4E1rDw=;
        b=HGep0XQcyOKcVRZgxh9zsZOGZGNh6lc3Ru2OiX+sRqHMKSArXP7tJcyL19kPH5jrRv
         bwp9KLT8Wx+MXDgfeYvUu2hmF9l1FLm82eHgBAqDwOLt44zgvMsuP89PWYQCovpgWj2O
         Dct9UfuTa52JGT7Kt9Bokv4tutGEXI0PcMxFEPCNEtVSUWm0i2R3D0W9rjB2OORmiRBG
         dvgMgwTUsyOSuTf7/q8pDbV56mV208Mcs7k0Tjeixt3eTb2Hg+VtQMaCPH8R1sPyVLZ0
         l1UudLJvRyOoZlSvk8IYtw9solWp6wJb2V8KfD9Y65xYqMnIQHMCLB1QhIvFEhoOFJ/z
         KcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686984069; x=1689576069;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MgZNO4N7Lp3aOL0RIWfyplzy3WbAoT4TzJnAt4E1rDw=;
        b=VdmX5W3+HxK223vU7PacKTOfQU+eCQBQ0G46foWSOzCnqSr5hFKBkCALtIWDPB6cYu
         Zo6HRPf+Zr4rpmiz4Prz7ooY/TnCi/TwCRHIoekofhwjnLkl2AqH1tm62h+b9hp+CIwE
         NV6fzABaA5x/vqfVXkcMgM78D0rZ33LnDKmDR4PnMwgX+oUO1uVtmXILKXh8UijDpPeF
         e2lJJqikM1nGx4eJmx50Y615YZvdooci8aRrfsCWXntSFRFIkEhA8I/+VMB6RrZNjl+r
         SqOFltsfevFhVzL/yHeBua6vY7oyBYX/AKQc/6rAxvnDP0JmrABa7KUc9gzng1TsXof7
         U40g==
X-Gm-Message-State: AC+VfDy5ODmi5tkjVESp9DLzBIB9OIvwZR1AqEN+AWMEdYLHQYv+qz5S
        6sWv6J9+jFO0lZtmFCaAkIw=
X-Google-Smtp-Source: ACHHUZ4OMXGUNpdcI3uK77j9dMkoV7qUSiuMUag4P3uRdT7ppw7KL1/jiPw4qpJx/tNV0XPQHTakwg==
X-Received: by 2002:a1c:7203:0:b0:3f8:f42a:a2c5 with SMTP id n3-20020a1c7203000000b003f8f42aa2c5mr2268493wmc.36.1686984069242;
        Fri, 16 Jun 2023 23:41:09 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id d6-20020adffd86000000b0030ae87bd3e3sm25417608wrr.18.2023.06.16.23.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 23:41:08 -0700 (PDT)
Subject: [PATCH v3 2/5] branch: fix a leak in setup_tracking
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
 <71b49be1-eeef-2f60-38f1-cfcbe4c8252f@gmail.com>
Message-ID: <3d33cd59-d4f3-9112-457f-7d1bfdd08714@gmail.com>
Date:   Sat, 17 Jun 2023 08:41:08 +0200
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
index 427bde896f..d88f50a48a 100644
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
