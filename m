Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8B5C7EE2E
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 18:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjFKStd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 14:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFKStb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 14:49:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E57FD9
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:49:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6d7abe9a4so25259195e9.2
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 11:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686509369; x=1689101369;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXEJOulljTjJ99ishYgib4Weo3Vy06cpAuDJtQSY0lA=;
        b=Ua5rpms/cljqNDv2VO8sx6cz+ODmNu6M2VOtbewjQKiNkaoYLuBgomHKJ4j5zsVvoL
         /FrvYh5q5Uvf8LTjE6DFQw4DS8A6xCrb0viUct1GuUv64FQLcYAITGdwNIwM3BCPRFbZ
         Qk3kdTK9o9SEZd2MUuPfL1JZqKR8AJQPoHX4RNrDirIuUilrlyK9gol2grGw2Z4SArIx
         4J7u079JQ9aqrJBiMBZCIZJgKgIVEOrx1kHbIFe6/nk+Mpz7VNZ8sXTu5Bu8vqLUV6h0
         B3C+1x5ZAzvvXpSKw7FDPSPUKxLBYzwq3n7Q/mSyfvY1+ODgrDvc6UuKkcsju75WXQAr
         +Zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686509369; x=1689101369;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXEJOulljTjJ99ishYgib4Weo3Vy06cpAuDJtQSY0lA=;
        b=M+Mi8d3QC2Giv4RxOUkBi1PgqsOOMVFCEsjZ0HDwMhBaaHUh9pB4b0yCImL1/YzgEt
         0sB1xY2z4cVp+3VBggEw6glC2p0ww6WxRIcWm44FCfO1ODIYB9daLVL/q9AlTf2XbQVi
         SxNTUqxjP1Iead82dlqTHQW6dh+8RoVmAJCWBEwpzGnFlwLrRLFQXi5tYL3EGvt4xFKx
         HVtqHaozBpo6DMREzl2A+V3Cn8iDf6MiXRgs4nTeOeJFII5YJYUM/HXCz3108GQPBeU1
         6nLyztULokDyWL2rsS7w0h84lBJ2DFoP7AfhV0uRbxTCH8cm22+oK5/M6YLdM/t4cwD0
         vYbw==
X-Gm-Message-State: AC+VfDzBPeWeB1RZMICHyEKQnf5dfto1w3EkqHbmxmMRz5yYvbfoYXns
        s1XMoumJhzcSlGnQJFnf6jOayzBPqr8=
X-Google-Smtp-Source: ACHHUZ6B9IECVZ/KCS3Qi3oExpn1Vye5N1kTBEwK9FTFCiGR9NxqqYmP99yuQYfsCMkRQGmfYfEP1w==
X-Received: by 2002:a7b:c7d8:0:b0:3f4:2365:e5ac with SMTP id z24-20020a7bc7d8000000b003f42365e5acmr4581326wmk.13.1686509369049;
        Sun, 11 Jun 2023 11:49:29 -0700 (PDT)
Received: from [192.168.2.52] (151.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.151])
        by smtp.gmail.com with ESMTPSA id v16-20020adfe4d0000000b00307a83ea722sm10357392wrm.58.2023.06.11.11.49.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 11:49:28 -0700 (PDT)
Subject: [PATCH 02/11] config: fix a leak in
 git_config_copy_or_rename_section_in_file
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
Message-ID: <2ce6f067-9d02-2a10-5eb9-6820e66f0b84@gmail.com>
Date:   Sun, 11 Jun 2023 20:49:28 +0200
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

In 52d59cc645 (branch: add a --copy (-c) option to go with --move (-m),
2017-06-18) a new strbuf variable was introduced, but not released.

Thus, when copying a branch that has any configuration, we have a
leak.

   $ git branch foo
   $ git config branch.foo.some-key some_value
   $ git branch -c foo bar

   Direct leak of 65 byte(s) in 1 object(s) allocated from:
       ... in xrealloc wrapper.c
       ... in strbuf_grow strbuf.c
       ... in strbuf_vaddf strbuf.c
       ... in strbuf_addf strbuf.c
       ... in store_create_section config.c
       ... in git_config_copy_or_rename_section_in_file config.c
       ... in git_config_copy_section_in_file config.c
       ... in git_config_copy_section config.c
       ... in copy_or_rename_branch builtin/branch.c
       ... in cmd_branch builtin/branch.c
       ... in run_builtin git.c

Let's fix that leak.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.c b/config.c
index b79baf83e3..39a7d7422c 100644
--- a/config.c
+++ b/config.c
@@ -3879,6 +3879,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 	free(filename_buf);
 	config_store_data_clear(&store);
 	strbuf_release(&buf);
+	strbuf_release(&copystr);
 	return ret;
 }
 
-- 
2.40.1
