Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79175C4332F
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 17:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiL2Rp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 12:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2Rp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 12:45:57 -0500
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E57E017
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 09:45:56 -0800 (PST)
Received: by mail-pf1-f172.google.com with SMTP id e21so3486534pfl.1
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 09:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2NSWj8IX5Ryoo8G3nUYry0lIcFa+lMDkkkrHrWgdhk=;
        b=b6WXaS/Az3vQi5khHqA/RtFC+vRrZZuWV0hacIW/VH72gb2SvIpjI+i1cnNB3VkTdq
         pLnYtKRqeZIu0HHn2BsGhMqyQF4ixA2xw8F8CFXdNl67KZu7L+ZX1oRmQ9iEtHN2x+4H
         De7iIidYrFb6ua9IKRXeCrZCYvyer6uLF2QxloDMyJ0++SPTYbw3Rx7uKqcN6NJGmlwR
         ZBW6N8ImyJ/8FcXWwjrSVFnabyysYdYdWzI+PltKnVbFi/QeifCtooXrxlcl2nxvTG+m
         g7FkYxK0WKvAhqchSKlPxFty+4kZc9dyCZGwnzmEY6W7nuEZt+Yvf/0RcmN6jezmOkm8
         n15g==
X-Gm-Message-State: AFqh2ko+Dome0VvUWtTvz9SfHsg2o6b7NvTfrMDk6wjMFPnTljIDCanq
        k1JqtUAHyxbQxqJmcgbrCgM6GthfttnSvGQ+K0BblzpTjyk=
X-Google-Smtp-Source: AMrXdXvZU4cy3ShjBj33GbQrdBXfTOApaUGrkk3ymCkPHQ4nheTdsNezJFypMexYIzCt+423GjFx/OStZ1vDgwv6l4g=
X-Received: by 2002:a65:6202:0:b0:497:5369:ac2d with SMTP id
 d2-20020a656202000000b004975369ac2dmr877864pgv.130.1672335956089; Thu, 29 Dec
 2022 09:45:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.1418.git.git.1672333122193.gitgitgadget@gmail.com> <pull.1418.v2.git.git.1672334314401.gitgitgadget@gmail.com>
In-Reply-To: <pull.1418.v2.git.git.1672334314401.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 29 Dec 2022 12:45:44 -0500
Message-ID: <CAPig+cTmW_7eXhH0-y0cj_r1UqDc+JJvMWVSFKOYSYFvpkjQJw@mail.gmail.com>
Subject: Re: [PATCH v2] grep: simplify is_empty_line
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 29, 2022 at 12:18 PM Rose via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---
> diff --git a/grep.c b/grep.c
> @@ -1483,9 +1483,12 @@ static int fill_textconv_grep(struct repository *r,
>  static int is_empty_line(const char *bol, const char *eol)
>  {
> -       while (bol < eol && isspace(*bol))
> +       while (bol < eol) {
> +               if (!isspace(*bol))
> +                       return 0;
>                 bol++;
> -       return bol == eol;
> +       }
> +       return 1;
>  }

It is subjective (personal opinion) whether or not the new code is
clearer than the original. As a general policy, this project tends not
to accept patches like this which merely "churn" the code without
improving it. From Documentation/SubmittingPatches:

   "Once it _is_ in the tree, it's not really worth the patch noise to
   go and fix it up."
   Cf. http://lkml.iu.edu/hypermail/linux/kernel/1001.3/01069.html

One reason for avoiding churn is that even simple and innocuous
changes like this can introduce bugs or unwanted behavior, as v1 of
this patch illustrated[1]. Another reason is that it eats up reviewer
time.

Did the Git test suite pass with v1 of this patch even though it was
buggy? If so, a better use of your time and reviewer time would be to
improve test coverage so that it detects the sort of breakage caused
by v1.

[1]: https://lore.kernel.org/git/CAPig+cSFAUcU74qULYkN7OX4-OqU_3VJeTdb1ZH_QoOW9FBwZQ@mail.gmail.com/
