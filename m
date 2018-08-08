Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD47D208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 09:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeHHL6n (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 07:58:43 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35128 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeHHL6n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 07:58:43 -0400
Received: by mail-yw1-f66.google.com with SMTP id s68-v6so1083222ywg.2
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 02:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0sItUdoum7D37RRKVkR6B7zNxt25ytSzXwmd9JkmFiU=;
        b=gXs+J2DWPDXzGwudakWWbx4FTXbf5X/Un24U4XY8nQHWA6w2xOREKm8xVfRMJZbOio
         foSs0dpP+rekmybpKfaTXaLbv+buzvufu+YBwh44/NthGeGxruRNAJ8HuNvsxJnNM753
         MZg+cV/6Zbc2Gt7M1lHq25VdnGmpJLa/NWagMwUGuF+U4+yM+DPF/MLcPc8ni4/6Sb97
         AyrSEDxbc6c4b0BqOIGkQ3ur6BofOQ3UjDiIPChzzWrJ5U47HeFFmevPIw7dFp/mnik6
         AIdiIsqVpqxOGzc7fcuRd8l+TxUH5xCqLKuEVaxEn0dyf/+ngdoHii3hH5z+WvOWiiV/
         FoUQ==
X-Gm-Message-State: AOUpUlFVMF1lWBtJp5AwpYypvcOsRKc2jjvopWGdw20j+/3rzKuRK0ZD
        hw/aYtqz8i/rsrBP8zW/6QDbqGtCHk1vWNqjA64=
X-Google-Smtp-Source: AA+uWPzcDOfVtN9SqgFkSY9qdD7wDG9a9ntZ8/GybIogUl8CB+hWGLJ1vM4P8pkgG3HkXAxsmG+1dDwswjc2x8DVYsg=
X-Received: by 2002:a0d:e253:: with SMTP id l80-v6mr982570ywe.131.1533721189183;
 Wed, 08 Aug 2018 02:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180807093452.22524-1-phillip.wood@talktalk.net> <20180807093452.22524-3-phillip.wood@talktalk.net>
In-Reply-To: <20180807093452.22524-3-phillip.wood@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 8 Aug 2018 05:39:37 -0400
Message-ID: <CAPig+cR-O07v98SmjhKkXodN=SoSK3ahp2t2zNJ54uo3-_Fq3Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] sequencer: fix quoting in write_author_script
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 5:35 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> Single quotes should be escaped as \' not \\'. The bad quoting breaks
> the interactive version of 'rebase --root' (which is used when there
> is no '--onto' even if the user does not specify --interactive) for
> authors that contain "'" as sq_dequote() called by read_author_ident()
> errors out on the bad quoting.
> [...]
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -636,42 +636,64 @@ static int write_author_script(const char *message)
>  static int read_env_script(struct argv_array *env)
>  {
>         if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
>                 return -1;

Erm, again, not introduced by this patch, but this is leaking 'script'
in the error path. You had plugged this leak in the previous round but
that fix got lost when you reverted to this simpler approach. Not
critical, though; the leak probably ought to be fixed by a separate
patch anyhow (which doesn't necessarily need to be part of this
series).

> +       /* write_author_script() used to quote incorrectly */
> +       sq_bug = quoting_is_broken(script.buf, script.len);
>         for (p = script.buf; *p; p++)
> -               if (skip_prefix(p, "'\\\\''", (const char **)&p2))
> +               if (sq_bug && skip_prefix(p, "'\\\\''", &p2))
> +                       strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
> +               else if (skip_prefix(p, "'\\''", &p2))
>                         strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);

The two strbuf_splice() invocations are identical, so an alternate way
of expressing this would be:

     if ((sq_bug && skip_prefix(p, "'\\\\''", &p2)) ||
        skip_prefix(p, "'\\''", &p2))
        strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);

Not necessarily clearer, and certainly not worth a re-roll.

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> @@ -1382,9 +1382,21 @@ test_expect_success 'rebase -i --gpg-sign=<key-id> overrides commit.gpgSign' '
>  test_expect_success 'valid author header after --root swap' '
>         rebase_setup_and_clean author-header no-conflict-branch &&
>         set_fake_editor &&
> -       FAKE_LINES="2 1" git rebase -i --root &&
> -       git cat-file commit HEAD^ >out &&
> -       grep "^author ..*> [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
> +       git commit --amend --author="Au ${SQ}thor <author@example.com>" --no-edit &&
> +       git cat-file commit HEAD | grep ^author >expected &&
> +       FAKE_LINES="5 1" git rebase -i --root &&
> +       git cat-file commit HEAD^ | grep ^author >actual &&
> +       test_cmp expected actual
> +'

It probably would have been clearer to change to this test to use
test_cmp() instead of 'grep' in a separate patch since it's not
directly related to the fixes in this patch, and then to do the
"commit --amend" in this patch. However, probably not worth a re-roll.

> +test_expect_success 'valid author header when author contains single quote' '
> +       rebase_setup_and_clean author-header no-conflict-branch &&
> +       set_fake_editor &&
> +       git commit --amend --author="Au ${SQ}thor <author@example.com>" --no-edit &&
> +       git cat-file commit HEAD | grep ^author >expected &&
> +       FAKE_LINES="2" git rebase -i HEAD~2 &&
> +       git cat-file commit HEAD | grep ^author >actual &&
> +       test_cmp expected actual
>  '

This test is so similar to the one above that it is tempting to try to
refactor the code so the tests can share implementation, however, the
end result would probably be less readable, so they're probably fine
as-is.
