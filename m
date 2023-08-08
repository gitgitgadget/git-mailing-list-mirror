Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996EFC001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 20:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbjHHUVh convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 8 Aug 2023 16:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbjHHUVW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 16:21:22 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E8759F47
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 12:28:23 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-63d10da0f26so38382596d6.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 12:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691522903; x=1692127703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEUIC+WYWF3wX9L9IaZjCsAHEsnJV6YufwpfPKjkwkk=;
        b=cnRVvdu5Vnrrr7V8pJEEMFOx4cTmwNHYOJGBUnJ3pvrZZzfBc3nipKKbIJ7ZaNsWCR
         DjBTgEFHjLPS+7WoaNGUfvoDQkp6cHddnSLEinNNpOG1TzPBy96647pas5rExf3LoVbq
         +ONMPRt8XpM3bYDn0DVhD3LWi9wRmtbeATO3gwr+Zp7EgLkmHSAeBbnrHBEfWCFL8kEY
         Z8p/HsI4nMtecxzsho/YdEwRcebhPVWy5xuM1lXlHZHvYb0c4z7LfXPzQOxL1I5pvy/i
         11uznQePxYnPQfHInDtRG3eaiyBDcXcQ08drGV8nFeu8IGDPxDaH7Ae1IzWCCFYdqaHN
         c+hg==
X-Gm-Message-State: AOJu0YwybAiamNAsbdC1RPhPOZZOpAxoXyxykU4GR6LXVHy/RRo1EMX7
        kQ2qgpR/R1qEaMj1bu58xQkElbJX3smCY+ARWxI=
X-Google-Smtp-Source: AGHT+IFkaGTxdc8hsfUjNIgx1SwBkn5c8EXgMxKhjb/d7v51CzGQWfxAF0cqIP/UmNAGjkXxigYLyuNkf54fIGE2xgw=
X-Received: by 2002:a05:6214:2a7:b0:635:fb19:2ebd with SMTP id
 m7-20020a05621402a700b00635fb192ebdmr440612qvv.13.1691522902833; Tue, 08 Aug
 2023 12:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <5260C6A0-C53C-4F6D-B899-6AD8601F8458@gmail.com> <20230808172624.14205-1-tboegi@web.de>
In-Reply-To: <20230808172624.14205-1-tboegi@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 8 Aug 2023 15:28:11 -0400
Message-ID: <CAPig+cSLoKc16AJkrZkVgQGd5deg+LLSaQYo29d8VCxPTsAO7g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] git stash needing mkdir deletes untracked file
To:     tboegi@web.de
Cc:     git@vger.kernel.org, friebetill@gmail.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 8, 2023 at 3:15 PM <tboegi@web.de> wrote:
> The following sequence leads to loss of work:
>  git init
>  mkdir README
>  touch README/README
>  git add .
>  git commit -m "Init project"
>  echo "Test" > README/README
>  mv README/README README2
>  rmdir README
>  mv README2 README
>  git stash
>  git stash pop
>
> The problem is, that `git stash` needs to create the directory README/
> and to be able to do this, the file README needs to be removed.
> And this is, where the work was lost.
> There are different possibilities preventing this loss of work:
> a)
>   `git stash` does refuse the removel of the untracked file,

s/removel/removal/

>    when a directory with the same name needs to be created

s/$/./

>   There is a small problem here:
>   In the ideal world, the stash would do nothing at all,
>   and not do anything but complain.
>   The current code makes this hard to achieve

s/$/./

>   An other solution could be to do as much stash work as possible,

s/An other/Another/

>   but stop when the file/directory conflict is detected.
>   This would create some inconsistent state.
>
> b) Create the directory as needed, but rename the file before doing that.
>   This would let the `git stash` proceed as usual and create a "new" file,
>   which may be surprising for some worlflows.

s/worlflows/workflows/

> This change goes for b), as it seems the most intuitive solution for
> Git users.
>
> Introdue a new function rename_to_untracked_or_warn() and use it

s/Introdue/Introduce/

> in create_directories() in entry.c
>
> Reported-by: Till Friebe <friebetill@gmail.com>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---
> diff --git a/entry.c b/entry.c
> @@ -15,6 +15,28 @@
> +static int rename_to_untracked_or_warn(const char *file)
> +{
> +       const size_t file_name_len = strlen(file);
> +       const static char *dot_untracked = ".untracked";
> +       const size_t dot_un_len = strlen(dot_untracked);
> +       struct strbuf sb;
> +       int ret;
> +
> +       strbuf_init(&sb, file_name_len + dot_un_len);
> +       strbuf_add(&sb, file, file_name_len);
> +       strbuf_add(&sb, dot_untracked, dot_un_len);
> +       ret = rename(file, sb.buf);

This could probably all be simplified to:

    char *to = xstrfmt("%s.untracked", file);
    ret = rename(...);
    ...
    free(to);

If there is already a file named "foo.untracked", then this will
overwrite it, thus potentially losing work, right? I wonder if it
makes sense to be a bit more careful.

> +       if (ret) {
> +               int saved_errno = errno;
> +               warning_errno(_("unable rename '%s' into '%s'"), file, sb.buf);
> +               errno = saved_errno;
> +       }
> +       strbuf_release(&sb);
> +       return ret;
> +}

Do we want to give the user some warning/notification that their file,
as a safety precaution, got renamed to "foo.untracked"?

> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> @@ -1512,4 +1512,27 @@ test_expect_success 'restore untracked files even when we hit conflicts' '
> +test_expect_success 'stash mkdir README needed - README.untracked created' '
> +       git init mkdir_needed_file_untracked &&
> +       (
> +               cd mkdir_needed_file_untracked &&
> +               mkdir README &&
> +               touch README/README &&

s/touch/>/

> +               git add . &&
> +               git commit -m "Add README/README" &&
> +               echo Version2 > README/README &&

s/> R/>R/

> +               mv README/README README2 &&
> +               rmdir README &&
> +               mv README2 README &&
> +               git stash &&
> +               test_path_is_file README.untracked &&
> +               echo Version2 >expect &&
> +               test_cmp expect README.untracked &&
> +               rm expect &&
> +               git stash pop &&
> +               test_path_is_file README.untracked &&
> +               echo Version2 >expect &&
> +               test_cmp expect README.untracked
> +       )
> +'
