Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A2AC61DA4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 22:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjBVWuJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 17:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBVWuH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 17:50:07 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F78193F6
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 14:50:06 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p18-20020a05600c359200b003dc57ea0dfeso8037607wmq.0
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 14:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrBc81mum7l8xKGGxm4m2bSWOZYw0yPzetd9J5+GV7s=;
        b=GIqsmjUmPYYQTbd6zJjgxF+fmgYajDfwbs+cVwrsbUwFxJkLNS+zLFas6iOwV127mV
         HUOUpaObNqGwsWq4DNwja5fSslus2/KCluUaFuHql7M0pM6BE51FNKNBUthjXkTBCc0O
         K+wJ6I/NorK20HZjpp1ZAZ7mMr+V1p4uQxVSJi6yQDtbdx8oc5x+3mf8FJStNA/xLkS5
         Y1LrjOdvTLX2nHnaj3s4kKkBuUlPyTkf/jLUBKZjgRS/XXi3mKROHiRXdW6s108xcnTr
         g6IN0zsSZbgOCaAimHbakh+AgZcgzUuw8BHWV7+gUTzBby4ICYMKb0wtjF0TJni+uzzp
         7zoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nrBc81mum7l8xKGGxm4m2bSWOZYw0yPzetd9J5+GV7s=;
        b=IImh3mT31obTOsVZUKG9KZj0D4woZR8WMb273gcVVGrme4aBTY1QdtqTwbN8qUEDMT
         xN6qkdiJ9zhaavPzUcM+avt53kBXqy2heorsl8nCDngejfRnrjHjpWwsD8WSP1gRNi8l
         JBrKsLYWqaSST5Ht+buAb/lMxtmCGMJOiksHul2xynl7H+9fIJwKkkDWShLk7IvinGmJ
         C5aJ12o01KdEl/u/CWw0tZOMrMvc8o1G/L4CTnu0WX038wc5qFx89NwaFoRbBflnbEUx
         XerO6ZdwIKXy6ibmNIgIZOCp9Rdj0WZXeCkXsG5ROKykHRu8/GySFNdfGLPfwvRb3BrB
         MTzQ==
X-Gm-Message-State: AO0yUKWeVO827ye26Y6OFyjMN1QKrQWiA3W6sQTn1Hz1kER+j96ANOGA
        vCTEYMICJ1Nh+ljgXem894w=
X-Google-Smtp-Source: AK7set/HYcJlw5p8n25BN8Hn1pwezfqn0bpDRP/s1bUkSnD7ilW+qXU5vWJcnWIGfs6Z3ZirUKqzPg==
X-Received: by 2002:a05:600c:130f:b0:3dc:557f:6126 with SMTP id j15-20020a05600c130f00b003dc557f6126mr7637674wmf.4.1677106204776;
        Wed, 22 Feb 2023 14:50:04 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id l3-20020a1ced03000000b003dd1bd66e0dsm6726069wmh.3.2023.02.22.14.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 14:50:04 -0800 (PST)
Subject: [PATCH v4 0/3] branch: operations on orphan branches
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
Message-ID: <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>
Date:   Wed, 22 Feb 2023 23:50:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid some confusing errors operating with orphan branches when working
with worktrees.

Changes from v3:

This is a major refactoring based on the comments from the reviews of
v3.  The intention is to make no functional changes in this iteration,
except a change to maintain unchanged the user-visible behavior, as
Jonathan suggested.

Summary of changes:

  - Inlined reject_rebase_or_bisect_branch() and
    replace_each_head_symref() into copy_or_rename_branch(). 

  - Used names to define HEAD states.

  - Moved die("Branch foo is being rebased/bisected...") after the call
    to validate_branchname(), to maintain the user-visible behavior.

  - Removed the use of ternary operators to avoid introducing unneeded
    noise in the patch.
 

Rubén Justo (3):
  branch: avoid unnecessary worktrees traversals
  branch: description for orphan branch errors
  branch: rename orphan branches in any worktree

 branch.c               | 27 ------------
 branch.h               |  8 ----
 builtin/branch.c       | 99 ++++++++++++++++++++++++++++--------------
 t/t3200-branch.sh      | 14 ++++++
 t/t3202-show-branch.sh | 18 ++++++++
 5 files changed, 98 insertions(+), 68 deletions(-)

-- 
2.34.1

