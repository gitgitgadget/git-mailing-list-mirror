Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270A7C7619A
	for <git@archiver.kernel.org>; Sun,  2 Apr 2023 17:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjDBRRW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 2 Apr 2023 13:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjDBRRU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2023 13:17:20 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9342A4EFF
        for <git@vger.kernel.org>; Sun,  2 Apr 2023 10:17:19 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id de37so8280566qkb.7
        for <git@vger.kernel.org>; Sun, 02 Apr 2023 10:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680455838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulZGUMXgMxZ3kXQNpJPBYMAwm3nDPYM7e/CdA/ZWolk=;
        b=Nv2LykVf/Ce1YyY+Js4IXjflXWbJB9bQDNHpwVtcbwtVnsDsdMszemaSgI4afw01d6
         Y94YlOiPHkOBeFOS0R89QHr+M9tHxgKnSonn7csSaaXTAGSdpYDaKqS0ksBfY9p6BQfP
         QEaORJwrLXntGdTFgzjHUv29kJOIxt1WHwCFZ8/UGIXn2XY2P/MUb4nGvassUuoE+i+N
         W3VPnn2sN/iUXaDt9GCyAzNXmaeLpV3bQjr73/CP/B7N9G3vQDslhCDxJac25zVwXhBp
         3Kidm2b3rD11GfcHEc5t019ebQfJ9mgeub80re1JuQt5kfO5raWHtboH5o9fO5SQw1ss
         +mug==
X-Gm-Message-State: AAQBX9dBXh7+zgGHxkFEPL1Ppqi1z/u0Hk85SWuyMWkhBbT27IxdM8fz
        sy1D5GCK49zFCDCDWgiCh7FvDHe/e/GeQ7lL67unF56mdRE=
X-Google-Smtp-Source: AKy350amztHkDsoi5xnG1PixBQ04NWko+LiHJY1FZ+VBnKQ41A4gGBexDXtcR+Tdd8DgwSoEdBBDPEhN/EeNl3rJAx4=
X-Received: by 2002:a05:620a:a98:b0:748:60ff:dff0 with SMTP id
 v24-20020a05620a0a9800b0074860ffdff0mr7120564qkg.8.1680455838577; Sun, 02 Apr
 2023 10:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230401194756.5954-1-edwinfernando734@gmail.com> <20230402113607.2394-1-edwinfernando734@gmail.com>
In-Reply-To: <20230402113607.2394-1-edwinfernando734@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 2 Apr 2023 13:17:07 -0400
Message-ID: <CAPig+cRs7u2gZC_Tb1Zx4UWn-Ut5yB4OW4RU3kJrT-bR73bfQA@mail.gmail.com>
Subject: Re: [GSOC][PATCH v3] t3701: don't lose "git" exit codes in test scripts
To:     Edwin Fernando <edwinfernando734@gmail.com>
Cc:     git@vger.kernel.org, Andrei Rybak <rybak.a.v@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 2, 2023 at 7:36 AM Edwin Fernando
<edwinfernando734@gmail.com> wrote:
> Exit codes are lost due to piping and command substitution:
>
> - "git ... | <command>"
> - "<command> $(git ... )"
>
> Fix these issues using the intermediate step of writing output to file.
>
> Signed-off-by: Edwin Fernando <edwinfernando734@gmail.com>
> ---
> Changes from v2:
> - use git rebase to squash commit history,
>   and diff with upstream commit for review
> - use present tense for code before the commit.

Thanks. The patch is looking a lot better. One comment, though...

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> @@ -311,9 +315,11 @@ test_expect_success FILEMODE 'stage mode and hunk' '
>         printf "y\\ny\\n" | git add -p &&
> -       git diff --cached file | grep "new mode" &&
> -       git diff --cached file | grep "+content" &&
> -       test -z "$(git diff file)"
> +       git diff --cached file >diff &&
> +       grep "new mode" diff &&
> +       grep "+content" diff &&
> +       git diff file >diff &&
> +       test_must_be_empty diff
>  '

The other changes in your patch are worthwhile, but it seems that you
have based this patch on an outdated copy of the repository. This
particular change had already been made by 9fdc79ecba (tests: don't
lose misc "git" exit codes, 2023-02-06) a couple months ago[1].

So, you'll want to update your repository to the latest available from
Junio, re-roll using "master" as a base for the patch, and drop this
change while keeping the others.

[1]: https://github.com/git/git/commit/9fdc79ecba0f4a3ef885f1409d2db5a1dbabd649
