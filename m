Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E923AC433DB
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 06:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD35622241
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 06:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbhABGND (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 01:13:03 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:46171 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbhABGND (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 01:13:03 -0500
Received: by mail-ej1-f51.google.com with SMTP id t16so185563ejf.13
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 22:12:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+CYXdLU8sqepybhnFtlLEsDFz+DbvkHRkSb5e8FbqE=;
        b=Wh/0fn2mO9FueHfQL26d7ZEo9f9M74/qzNjK7mHEWQX28pkggcylcq4BiwpDmrh51S
         TjVYajinuL5xAj4QyB6vI4ellcMFOYxX00PJCMnWERRu+MCF1zTzHYsavvoWXCPxk2T2
         JL0w0yVmygsOApi/e1qfAl1YvxP9E0TttsSn/AQkf+gRjXFrZFjvRP6CHp0HnXibmZJD
         K6sV5Dv0OvAPHkMqDtOt4p/d+44s9eWDYgR5N2WaqxJuFYFBzSBCmvWoy/S02ea3q/1T
         zszan4K8CDvEoTlS6QaTh1f8fz+UUcT/95bvCwoinlGzNXwbvbvcsXYIUPn+I7nfbfGS
         GKBg==
X-Gm-Message-State: AOAM530LMUKyt3sykUVP8+LXxVDfhwPOENnvZ0gxp5DIg5eDBSffLw84
        ZoZR2AXHRqisYCvu25F2+XsG9f6dzBYOwIKjdgQ=
X-Google-Smtp-Source: ABdhPJxAYrr3kcyI0VLb9sNg2XIDcm126YavrTXHmezbxvpFePWSTZIJ2xFk/JClv5UcXeVAF9ilzRHwF/ZdWt/peyA=
X-Received: by 2002:a17:906:1ed6:: with SMTP id m22mr61622281ejj.231.1609567941468;
 Fri, 01 Jan 2021 22:12:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.1609506428.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 2 Jan 2021 01:12:10 -0500
Message-ID: <CAPig+cS-oDfCX-LaDEW2U+9Aa9VNZUPs54isODoHCv6HxAdZeQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] Remove more index compatibility macros
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 1, 2021 at 8:09 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> My strategy for update-index was to create static globals "repo" and
> "istate" that point to the_repository and the_index, respectively. Then, I
> was able to remove macros one-by-one without changing method prototypes
> within the file.
>
> I had started trying to keep everything local to the method signatures, but
> I hit a snag when reaching the command-line parsing callbacks, which I could
> not modify their call signature. [...]

You should be able to do this, not by modifying the callback
signature, but by taking advantage of the `extra` member of `struct
option` which is available to callback functions or arbitrary use. If
you need to access the index in a callback, then assign a `struct
index_state *` to `extra`; likewise assign a `struct repository *` to
`extra` to access the repository. If you need access to both the index
and the repository, then just store the repository in `extra` since
the repository has an `index` field.

You won't be able to use any of the canned OPT_FOO() macros to
initialize an entry in the update-index.c `options[]` array which
needs `extra`-initialization since the macros don't let you specify
`extra`, but you can easily bypass the macro and initialize the
`struct option` manually. (After all, the macros exist for
convenience; they are not a hard requirement.)

Within the callback, extract the `repository` or `index_state` as you
would any other field. For instance:

    const struct repository *repo = opt->extra;

This should allow you to get rid of the globals introduced by patch
[4/12] (assuming passing the index and repo arguments around
everywhere doesn't get overly hairy).
