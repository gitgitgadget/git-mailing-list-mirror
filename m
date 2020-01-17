Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F95C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB7220661
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAQNpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:45:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36110 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgAQNpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 08:45:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so7705260wma.1
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 05:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oNSwJpJSeOQ2UgBdL6sPY/BxS8JuU/M79Sbi7D0mk6w=;
        b=avBo3gK4asbLTpFAf2dJUfJkATzCKiMdoCrk2DQXWahxBe0OhsTvhv2xvi0kZ+A3os
         0SEjJrQ2AJsqDCTzUXO76R+rfg/fc10XbP1cwfb8SXIcyZWlsx2NENvHlXMrUPZQ7Bcw
         d+OohlpwYT6tuVBvZodFQ4xla1+SfhndKTYZZeaDKIlJw1nhT+mfehMqtncbf11GnZJg
         B/o8EaOJHha8aTqhBCllMiTNiy2d0BbkIx1PUNpEvTzrmKMhb4kD2j2rQGmo1psOasaJ
         qfcnRK2lT3CQZg7NKIPVzaS/hVFsbFwKM13Aoh5niifGnDU/v1eHZEGog4q1Xv85xHzh
         kdFA==
X-Gm-Message-State: APjAAAWZMXHjloK7s5kp7C3MQQSKjJWQ6cfD5rXxsBdYMCt4nvuOeb8K
        hDhTnRCmPgLEIhRqsBInLF99IVdiuQinJP1qCwo=
X-Google-Smtp-Source: APXvYqzH19D0n31z5iFzJnhRTUGXDiIGVXTRg4D8WYrq4eSq3PM3CTyNAovfQqFuxmruprsNlA+Rz3Ri9SONwwOTKto=
X-Received: by 2002:a1c:1b44:: with SMTP id b65mr4632186wmb.11.1579268723131;
 Fri, 17 Jan 2020 05:45:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.523.git.1579263809.gitgitgadget@gmail.com> <5060ce3d64419369b2912c395a880fb49a0a3137.1579263809.git.gitgitgadget@gmail.com>
In-Reply-To: <5060ce3d64419369b2912c395a880fb49a0a3137.1579263809.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 Jan 2020 08:45:12 -0500
Message-ID: <CAPig+cQgh+gmrDwSqJz1hHViBxTP6UDkuHjKTRLbackcxeQE9A@mail.gmail.com>
Subject: Re: [PATCH 2/4] t2405: use git -C and test_commit -C instead of subshells
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 17, 2020 at 7:24 AM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The subshells used in the setup phase of this test are unnecessary.
> Remove them by using 'git -C' and 'test_commit -C'.

The subshells may not be necessary, but the code feels cleaner before
this patch is applied since all the added "-C foo/bar" noise hurts
readability. So, I'm "meh" on this patch and wouldn't complain if it
was dropped (though I don't insist upon it).

> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
> diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
> @@ -6,32 +6,16 @@ test_description='Combination of submodules and multiple worktrees'
> -               git commit -m "file1 updated"
> +       git -C origin/main commit -m "add sub" &&
> +       test_commit -C origin/sub "file1-updated" file1 file1updated &&
> @@ -49,7 +33,7 @@ test_expect_success 'checkout main' '
> -       grep "file1 updated" out
> +       grep "file1-updated" out

Why this change? Is it because test_commit() mishandles the whitespace
in the commit message? If so, it might deserve mention in the commit
message of this patch. (Even better would be to fix test_commit(), if
that is the case.)
