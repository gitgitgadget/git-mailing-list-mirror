Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3211C1F405
	for <e@80x24.org>; Sun, 16 Dec 2018 13:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbeLPNTH convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 16 Dec 2018 08:19:07 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33263 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730197AbeLPNTG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 08:19:06 -0500
Received: by mail-qt1-f194.google.com with SMTP id l11so11359725qtp.0
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 05:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+f/7JehQHl4abOas9KzsmNPTQEpiUTpRKdLbIBPhF+0=;
        b=pg29/aSTtGIwL30Y9AQdMNO/52wCatWxWpx4ITDnyl6CitrwC4u/BztR1xR7xNnWHd
         weu0t3DTurKWtjU1pB8gtIIRQ2UON+Su+UC/+D2foaF079aCnWYv2VoR2Hm0bSXU6EZE
         9470kpMPvXdb6LHfsY5M6qpz0PpRjXa5dnBhk1MCH1tfvMow8RLQihXspJhJy0atHGFV
         ZhxBNhmfq6j0XUyuQFgF0X4OiYp3B70EPCPnDj3ZEUq1eQ9WGXtbyvU5yslj41q479Q/
         okCj32/EW/a+pd6Z0HU8dPDk67ZP6v1MTwzmE48xtv1xaIZdqls4XUBrDpdBAinstasq
         0kMQ==
X-Gm-Message-State: AA+aEWZe5NVt/hjiSBb14OEJSlbLC28OwnKIH0GZdZ2/mmSoA41QNb/u
        mB5evTH84Upj971YKM5QWkORGsoCSYcAwNjg5CY=
X-Google-Smtp-Source: AFSGD/V8wzXIM0wJ9oJm3VFWPq0Lb/pZv27+gr8KQ1j99DHnFZ/CI24qO39d5s3watp6HVt2pvY8McfT45CEq36llXw=
X-Received: by 2002:a0c:9359:: with SMTP id e25mr9784169qve.203.1544966345856;
 Sun, 16 Dec 2018 05:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20181216121239.10017-1-pclouds@gmail.com>
In-Reply-To: <20181216121239.10017-1-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 16 Dec 2018 08:18:55 -0500
Message-ID: <CAPig+cQLz+mx8pXMCsYW_0=1C8GzFvzBb=uatfwLK0Dpj944Jg@mail.gmail.com>
Subject: Re: [PATCH] worktree: allow to (re)move worktrees with uninitialized submodules
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 16, 2018 at 7:12 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> Uninitialized submodules have nothing valueable for us to be worried
> about. They are just SHA-1. Let "worktree remove" and "worktree move"
> continue in this case so that people can still use multiple worktrees
> on repos with optional submodules that are never populated, like
> sha1collisiondetection in git.git when checked out by doc-diff script.
> [...]
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -724,20 +725,32 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
>  static void validate_no_submodules(const struct worktree *wt)
>  {
> +       if (is_directory(worktree_git_path(wt, "modules")))
> +               die(_("working trees containing submodules cannot be moved or removed"));
> +
>         if (read_index_from(&istate, worktree_git_path(wt, "index"),
>                             get_worktree_git_dir(wt)) > 0) {
>                 [...]
> +                       found_submodules = 1;
> +                       break;
>         }
>         if (found_submodules)
>                 die(_("working trees containing submodules cannot be moved or removed"));

Not worth a re-roll, but an alternate way to structure this to avoid
duplicating the die() message would be:

    if (is_directory(...))
        found_submodules = 1;
    else if (read_index_from(...)) {
        ...
        found_submodules = 1;
        break;
    }
    if (found_submodules)
        die(...);
