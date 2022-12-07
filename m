Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320E8C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 18:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLGS7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 13:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLGS7q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 13:59:46 -0500
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CF75C77E
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 10:59:45 -0800 (PST)
Received: by mail-pl1-f172.google.com with SMTP id y4so17904859plb.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 10:59:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELLspTjugl8PCu5ATOSOnpXjt/jR9ulHszdKqIl/JHU=;
        b=GOIWjbg0eXqsd1J3X0ZFq5Dhk7bTSAER3F2Q7OOY0mlR2Q4NvBMZrw4Ho0DitgcyUG
         4N+HL1W80n8VE/++836ANfO0UqFQ2BN/FHWyAOO2NVcl97BwDDsl4Qw11i4LdYw38SuD
         tSOZiVFV/LeAgexYbpFpjMlbqKMJMhcTS/EKlVToGlwM6R95Sw73cl2sPDb+Q6WSqCuZ
         KKRmmfggCt+ap3yBLKL3lY80Bh8W8h4d65AEX7TrDswteI9B5velorSI7doPFystrTkW
         JwFhc+lTjr+Q6vMzAb8ZGXqsnwtUSnT0a35MsPpItxdF16tBFsvO9qaujwbG8rJYbF6t
         NHWw==
X-Gm-Message-State: ANoB5pnGo/rH7mzQICCzhHiaIiLSzwdSkoy2swdc0TLBk/nsr/FzG2R2
        dkcFl6DiSznDcneVrFmfWx9yAN0UPBzwDwrsA6g=
X-Google-Smtp-Source: AA0mqf4/B1AsMoPrG2u64gpyUDhuq7keACRW2S8HyhwLX8V+FsgwE4RVBAJZBIhqahp9kg3zEWaUeg+/G3JcWfyWuSQ=
X-Received: by 2002:a17:902:8f96:b0:189:3803:23e6 with SMTP id
 z22-20020a1709028f9600b00189380323e6mr73494656plo.77.1670439584547; Wed, 07
 Dec 2022 10:59:44 -0800 (PST)
MIME-Version: 1.0
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com> <5fb4b5a36ac806f3ee07a614bcb93df2c430507c.1670433958.git.gitgitgadget@gmail.com>
In-Reply-To: <5fb4b5a36ac806f3ee07a614bcb93df2c430507c.1670433958.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 7 Dec 2022 13:59:33 -0500
Message-ID: <CAPig+cRSY+c-fOQBeC5ff0-s3+_kzFEjcBOSHP6C8ca9t7zr+w@mail.gmail.com>
Subject: Re: [PATCH 2/4] read-cache: add index.skipHash config option
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        avarab@gmail.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2022 at 12:27 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The previous change allowed skipping the hashing portion of the
> hashwrite API, using it instead as a buffered write API. Disabling the
> hashwrite can be particularly helpful when the write operation is in a
> critical path.
>
> One such critical path is the writing of the index. This operation is so
> critical that the sparse index was created specifically to reduce the
> size of the index to make these writes (and reads) faster.
>
> Following a similar approach to one used in the microsoft/git fork [1],
> add a new config option (index.skipHash) that allows disabling this
> hashing during the index write. The cost is that we can no longer
> validate the contents for corruption-at-rest using the trailing hash.
> [...]
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
> diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
> @@ -30,3 +30,11 @@ index.version::
> +index.skipHash::
> +       When enabled, do not compute the trailing hash for the index file.
> +       Instead, write a trailing set of bytes with value zero, indicating
> +       that the computation was skipped.
> ++
> +If you enable `index.skipHash`, then older Git clients may report that
> +your index is corrupt during `git fsck`.

This documentation is rather minimal. Given this description, are
readers going to understand the purpose of the option, when they
should use it, what the impact will be, when and why they should avoid
it, etc.?

> diff --git a/t/t1600-index.sh b/t/t1600-index.sh
> @@ -65,6 +65,14 @@ test_expect_success 'out of bounds index.version issues warning' '
> +test_expect_success 'index.skipHash config option' '
> +       (
> +               rm -f .git/index &&
> +               git -c index.skipHash=true add a &&
> +               git fsck
> +       )
> +'

What is the purpose of the subshell here?
