Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D32C74A5B
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 22:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCZWds (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 18:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCZWdp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 18:33:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A845A5BB0
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:33:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so6213810wmq.4
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679870022;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0eDrvLFfET3SCwzd47DF8gAlmuhuF22T0GNWHaMMlo=;
        b=F6I6TnxeKAE7GGjZk9A71fZY3PJdoukAGD5gZEiOD95X3DWGYtSzBHDqu/CyeiImca
         C334FD9FSN4RsEZSPiRujPYpskIrXLIFIps7S41fhhFSN6XjEkPiTAnyRN22AXouwcgh
         rR9T2W/1ze8XFCSVc7DA6pk9LCG3yTC9lZfKr8SwhG6JRMcOp7+rruBby67WZDcKXre+
         NeyDm+eZNBFMvKc9bdFMvxvmuMiIIf0wQJy2HpwyvH7+fjm+WFdb5VyJW+MgBYd/25e0
         wLOke4EshfnDBPoR5Fsyt3AMi4Bl0N0kU4e8sMuCyfK5asuvXwxfXpZEQcA1mJ0SKn86
         HzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679870022;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0eDrvLFfET3SCwzd47DF8gAlmuhuF22T0GNWHaMMlo=;
        b=5AV8VwWwit1oJnPqjiYYUNRuT++ZQS6vXOwDJZQAqdE66Q0pYdFnzUCz5+iW9JgWXW
         0g7B+sl7faz/QN4BpcWUqjyE4lQKWeipIA0/7bJXj4VUUzNWZpRLJj4pDnKPtRGQ2ZCk
         tolLtdTY8TOVvySFUW82V5CPRMxwvwWWC7LQNl/KttwrhtZ+3b31wptcir8w0sPoS7aa
         OGcUP1exl+VHYTRJNXaoKrePdh/oTeNtgzLPhJIyHode/HAYB9tWVnUCzTd2XuERjCsh
         ZIJOEdLx8Br6RLlvY7/KWzLhuybndMVCWpEBe9uyco8gBgP/sXkwO2+q/aIrznoacI2P
         o+4A==
X-Gm-Message-State: AO0yUKXPmrZz5Ehac4P5aMKYsElMD2+knp8x5856mns5AqlQYVWUDBW5
        f5TQwG3lJR8z5K5fI4xT8YM=
X-Google-Smtp-Source: AK7set8LE6kRtREjbqY3hPtzrXB9snmVmxP5/B3gEEr3YZ0iLGEaifZlCNIJBt4jPOGQ6ApnBWL+iw==
X-Received: by 2002:a7b:c84e:0:b0:3db:8de:6993 with SMTP id c14-20020a7bc84e000000b003db08de6993mr7261567wml.4.1679870022122;
        Sun, 26 Mar 2023 15:33:42 -0700 (PDT)
Received: from [192.168.2.52] (96.red-88-14-208.dynamicip.rima-tde.net. [88.14.208.96])
        by smtp.gmail.com with ESMTPSA id n20-20020a7bc5d4000000b003ee10fb56ebsm11727359wmk.9.2023.03.26.15.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 15:33:41 -0700 (PDT)
Subject: [PATCH v5 5/5] branch: avoid unnecessary worktrees traversals
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
 <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>
 <f8e6447e-5cd3-98fa-f567-39e1c60dacb0@gmail.com>
Message-ID: <c54e35a5-3887-9192-0c9d-8673feaa10ba@gmail.com>
Date:   Mon, 27 Mar 2023 00:33:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f8e6447e-5cd3-98fa-f567-39e1c60dacb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we rename a branch ref, we need to update any worktree that have
its HEAD pointing to the branch ref being renamed, so to make it use the
new ref name.

If we know in advance that we're renaming a branch that is not currently
checked out in any worktree, we can skip this step entirely.  Let's do
it so.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a93b9fc0ab..6a564b22b0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -617,7 +617,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 				interpreted_oldname);
 	}
 
-	if (!copy &&
+	if (!copy && (oldref_usage & IS_HEAD) &&
 	    replace_each_worktree_head_symref(worktrees, oldref.buf, newref.buf,
 					      logmsg.buf))
 		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
-- 
2.39.2
