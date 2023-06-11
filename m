Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2800DC7EE2E
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 18:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjFKStm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 14:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjFKStk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 14:49:40 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA07E6E
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:49:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6e1393f13so25962755e9.0
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686509376; x=1689101376;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jswaJzFsfNmadhlvtYRZBt2F7YSdIOMjRD6N3am+Ag=;
        b=T5zMnts7QW9uVptURb9ac732Y0QTqQt92PF7CUQae8aZSER9MlpfVabgGREDZ12Sb6
         c+u3dfwNIGCJ6wVfcAnoxwaugDfBlauAIIh83VxNegt0weP7vXZJDMDgSOmGccL/JfK+
         5//zco8HXB5imjvkCCaNZosWUVTDFXQ3GfP0Bagw1YFYQ2jDH2J9GeuFCrcO0ZV2bpiV
         deR8mDd/WTc7CPO0BOEq3uWQZAvzlLioSRXbcUgi9fyh8I1istDQJeSyGC7QVpq0egHE
         b0xNVl9Dld4GUz8LkwqckKcoWm74e2J+TP2gFvY0bWw8b666xnzAs7nwYsJcSiyLu2Mc
         DhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686509376; x=1689101376;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jswaJzFsfNmadhlvtYRZBt2F7YSdIOMjRD6N3am+Ag=;
        b=I7cC1zR8U1pJ7zQ+v2V+F9CUU5q8QvfKoKtKqux+vvsY32lveXUt26l1zfb6REVuSn
         pmtQO8Li/uMyGatd4sDnrT/gEmRRboAzdt7LcRVY+CwKex1wnYVwWZnUS4SEsG9f3cMa
         r0PxhR4kUE19vm7WH3dzm9lDo/SmLYXgpQW1C0vtPYmT4VtKUPv9G7sRyn9CrQdP9GtM
         BWk88OPX7BUbvOpsK1NfQ14Mrjqhe11SM0upNcM/GLZNELOjK4rHQ9DqV8klfjmzaiya
         rPwOAu4OE7UTAirVbCYzZYsTbFOqPar/ReRqhxa1inxMhv1dUvhrxX8IpAWz2zWSxRaI
         ilKw==
X-Gm-Message-State: AC+VfDxGLKrVt9TJgC9ovUywlWMi0jY0qb11A1Q/Ulf7Lz2WUCcuvS6f
        tUv/UfIMybeQbNS07cuzBY3rNu143Rs=
X-Google-Smtp-Source: ACHHUZ6JT7tVR7Ky9sROMo6TOiVjjBcqWbR/hiQf7GSoAn1XRQSBPmfDrzmXoqkGPdeFZIg9ouUdiw==
X-Received: by 2002:a1c:4b07:0:b0:3f8:1729:f876 with SMTP id y7-20020a1c4b07000000b003f81729f876mr1516100wma.33.1686509376321;
        Sun, 11 Jun 2023 11:49:36 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id x22-20020a05600c21d600b003f70a7b4537sm9124030wmj.36.2023.06.11.11.49.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 11:49:36 -0700 (PDT)
Subject: [PATCH 03/11] remote: fix a leak in query_matches_negative_refspec
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Message-ID: <a9b27053-ff2b-7b67-f2ba-5691f4bda961@gmail.com>
Date:   Sun, 11 Jun 2023 20:49:35 +0200
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

In c0192df630 (refspec: add support for negative refspecs, 2020-09-30)
query_matches_negative_refspec() was introduced.

The function was implemented as a two-loop process, where the former
loop accumulates and the latter evaluates.  To accumulate, a string_list
is used.

Within the first loop, there are three cases where a string is added to
the string_list.  Two of them add strings that do not need to be
freed.  But in the third case, the string added is returned by
match_name_with_pattern(), which needs to be freed.

The string_list is initialized with STRING_LIST_INIT_NODUP, i.e.  when
cleared, the strings added are not freed.  Therefore, the string
returned by match_name_with_pattern() is not freed, so we have a leak.

   $ git remote add local .
   $ git update-ref refs/remotes/local/foo HEAD
   $ git branch --track bar local/foo

   Direct leak of 24 byte(s) in 1 object(s) allocated from:
       ... in xrealloc wrapper.c
       ... in strbuf_grow strbuf.c
       ... in strbuf_add strbuf.c
       ... in match_name_with_pattern remote.c
       ... in query_matches_negative_refspec remote.c
       ... in query_refspecs remote.c
       ... in remote_find_tracking remote.c
       ... in find_tracked_branch branch.c
       ... in for_each_remote remote.c
       ... in setup_tracking branch.c
       ... in create_branch branch.c
       ... in cmd_branch builtin/branch.c
       ... in run_builtin git.c

   Direct leak of 24 byte(s) in 1 object(s) allocated from:
       ... in xrealloc wrapper.c
       ... in strbuf_grow strbuf.c
       ... in strbuf_add strbuf.c
       ... in match_name_with_pattern remote.c
       ... in query_matches_negative_refspec remote.c
       ... in query_refspecs remote.c
       ... in remote_find_tracking remote.c
       ... in check_tracking_branch branch.c
       ... in for_each_remote remote.c
       ... in validate_remote_tracking_branch branch.c
       ... in dwim_branch_start branch.c
       ... in create_branch branch.c
       ... in cmd_branch builtin/branch.c
       ... in run_builtin git.c

An interesting point to note is that while string_list_append() is used
in the first two cases described, string_list_append_nodup() is used in
the third.  This seems to indicate an intention to delegate the
responsibility for freeing the string, to the string_list.  As if the
string_list had been initialized with STRING_LIST_INIT_DUP, i.e.  the
strings are strdup()'d when added (except if the "_nodup" API is used)
and freed when cleared.

Switching to STRING_LIST_INIT_DUP fixes the leak and probably is what we
wanted to do originally.  Let's do it.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 0764fca0db..1bcd36e358 100644
--- a/remote.c
+++ b/remote.c
@@ -890,7 +890,7 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
 {
 	int i, matched_negative = 0;
 	int find_src = !query->src;
-	struct string_list reversed = STRING_LIST_INIT_NODUP;
+	struct string_list reversed = STRING_LIST_INIT_DUP;
 	const char *needle = find_src ? query->dst : query->src;
 
 	/*
-- 
2.40.1
