Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24636EB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 23:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjFPXef (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 19:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjFPXed (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 19:34:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB4F3AB5
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:34:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f8f3786f20so11256865e9.2
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686958463; x=1689550463;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgZNO4N7Lp3aOL0RIWfyplzy3WbAoT4TzJnAt4E1rDw=;
        b=XeTrYFycksceqDCwuI56fDqADluFJrcofRNk+aab5u2iOxkhtEJAzITOvRGVMcs34O
         Q1ox57ryzJKcXWQ6kzzIf3NlJjgusabxVVeJbStDbVy7nNozcVJf7aMRKw7eGFu6iQz9
         suXaHrzeocMXY0REBQofi9lYqWMvu5tIjaGNycyk56fntngYUfE1qdU5LH7ialw+PILv
         aEDyiNhpkHN3zUsjO72srFHDPdlhvn+RVD/v7uKuSbgcm2WqBMDlxqkBOL8pg27lY8NI
         zMzNlWheu/Z9u645cPv/ko0ijcQGnQj/59RECE6nd6N1fCmFUKpuJcCac27YiHSs4R2H
         ue/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686958463; x=1689550463;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MgZNO4N7Lp3aOL0RIWfyplzy3WbAoT4TzJnAt4E1rDw=;
        b=e1z7BWUydNWPbo09x06tTnK2oDrCVdQdVHFrrsHXLR/ePBvYXxImyLcG8+WAm/WeGs
         WeDKZq32JOXdM+4vITohjGaHRCb7G1oy6goZOe7pVmu54GK65P+6Yo5oVW3qQ7UPUfmO
         NKTG9ltAbWf9N1psKJEiOigw7wRP3WLl/NwkZuB4Wq+kKEg1KPPDD1JXx2jR5e6pivpo
         fUQ8/mCY/6rcegsXvfetqCeFTshix6zW0tp7xirdEskjP5fh/mt6eha7fZIbvhjQMpF6
         RTh8Vhik0q0wMm1m2zx6J6nGustBQtxQ8ZfiEgGTbiMXWPLn4rTJm/Xi7HcBECbDR7OW
         dU0w==
X-Gm-Message-State: AC+VfDyupHFgKtjJxaNNw+fCTe4+8WHkuV3BOwgbKwU5O/N+oCt0RYsW
        SrKL8wh1CtEoTsF13pmUyQE=
X-Google-Smtp-Source: ACHHUZ4MhIzzE5i8/NMwt5obft4nweZ/P0M1g2HR9M3E/Yj8d5CiM2YyG7fLNZn0o+bxHD1c5CrVnQ==
X-Received: by 2002:a1c:4c09:0:b0:3f8:fb07:b20d with SMTP id z9-20020a1c4c09000000b003f8fb07b20dmr1902956wmf.2.1686958463539;
        Fri, 16 Jun 2023 16:34:23 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id h25-20020a1ccc19000000b003f42158288dsm3367850wmb.20.2023.06.16.16.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 16:34:22 -0700 (PDT)
Subject: [PATCH v2 2/5] branch: fix a leak in setup_tracking
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Tao Klerks <tao@klerks.biz>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
Message-ID: <7943ec83-8ef3-4397-0d2e-47f47069de16@gmail.com>
Date:   Sat, 17 Jun 2023 01:34:22 +0200
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
