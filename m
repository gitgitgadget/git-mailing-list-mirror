Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A8E91F453
	for <e@80x24.org>; Thu, 25 Oct 2018 19:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbeJZEEk (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 00:04:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45569 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeJZEEj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 00:04:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9-v6so11286407qtj.12
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 12:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZrewLWcU8kQ2WRJz2Lq5OCpK7Nmwl4B5CFfkZC4H/Q=;
        b=A63eJVHJJO6bRIT+gqHIsFCdtEFseYH093HJzuabd+l/6w1VHvsC+HACGmjD+chyzm
         1xwIi4gefwhAwgu9ybggtFXWj+o2cj2emn+mOiha4dUkm4K3hI+24cfQK5153pTRl60a
         nFmIeTeMRrAA2YpOExpP7MMTD8LmdueDkJASZsNY8i+cCl6/+AbeSNs3Yo/bWgB0IuOJ
         a8v7dDCAEekCRG7fH65LjO0AObaQM17puAuqDmZC7LnDInlC3ejmCcHVKE/X9m9Cxrxc
         bVwKvNJodyvIwakFR4KZtgH+QRPbcMLeNJ1m8wSOsLjofnCFlSY2805jv4wxvVJsr3ma
         EVeg==
X-Gm-Message-State: AGRZ1gLjj3Z5/y8SfEQZKR/RpKajCkaYTe5VK6NzQZ6R3k0rCd0SPx31
        hiJBz8WhqO1RZbTPiyRWYs3ZlTHCcVXWXakVyiGwp9Nl
X-Google-Smtp-Source: AJdET5cIbKwbVX+q8w7xa60tOX0BDzUf4/Amm0WUE8Jh4FD2+oEz+JkGeaU7WXYPyIfIO5ZpUhXoYbvmLFBT1RRPRCg=
X-Received: by 2002:ac8:73c5:: with SMTP id v5-v6mr528375qtp.352.1540495834879;
 Thu, 25 Oct 2018 12:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181025190421.15022-1-daniels@umanovskis.se>
In-Reply-To: <20181025190421.15022-1-daniels@umanovskis.se>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 25 Oct 2018 15:30:23 -0400
Message-ID: <CAPig+cRVdogY8VLXcftbY=n9tQ9wDo4YrnrdU6+pZ3ch6uhZGA@mail.gmail.com>
Subject: Re: [PATCH v5] branch: introduce --show-current display option
To:     Daniels Umanovskis <daniels@umanovskis.se>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 25, 2018 at 3:04 PM Daniels Umanovskis
<daniels@umanovskis.se> wrote:
> When called with --show-current, git branch will print the current
> branch name and terminate. Only the actual name gets printed,
> without refs/heads. In detached HEAD state, nothing is output.
>
> Signed-off-by: Daniels Umanovskis <daniels@umanovskis.se>
> ---
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> @@ -100,6 +100,50 @@ test_expect_success 'git branch -v pattern does not show branch summaries' '
> +test_expect_success 'git branch `--show-current` works properly when tag exists' '
> +       cat >expect <<-\EOF &&
> +       branch-and-tag-name
> +       EOF
> +       test_when_finished "
> +               git checkout branch-one
> +               git branch -D branch-and-tag-name
> +       " &&
> +       git checkout -b branch-and-tag-name &&
> +       test_when_finished "git tag -d branch-and-tag-name" &&
> +       git tag branch-and-tag-name &&

If git-tag crashes before actually creating the new tag, then "git tag
-d", passed to test_when_finished(), will error out too, which is
probably undesirable since "cleanup code" isn't expected to error out.
You could fix it this way:

    test_when_finished "git tag -d branch-and-tag-name || :" &&
    git tag branch-and-tag-name &&

or, even better, just swap the two lines:

    git tag branch-and-tag-name &&
    test_when_finished "git tag -d branch-and-tag-name" &&

However, do you even need to clean up the tag? Are there tests
following this one which expect a certain set of tags and fail if this
new one is present? If not, a simpler approach might be just to leave
the tag alone (and the branch too if that doesn't need to be cleaned
up).

> +       git branch --show-current >actual &&
> +       test_cmp expect actual
> +'
