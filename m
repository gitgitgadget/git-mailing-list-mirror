Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9ABC433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 20:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F942077D
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 20:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgF3U4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:56:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39803 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgF3U4i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 16:56:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5so21465726wru.6
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 13:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XOEFvtMB0BXy/w863LhiJ/mT5haWx+2wUCuPC8gwRpA=;
        b=OCpizBeZhqSNcN9x8aq3sr9o/ENNdv3iz4bsmLkqp4bvbjBmZz0QeOw3vpgL9DOryT
         X/kyWQ11Jjq7jYyTQM/kmZErqOnTMzSf7Cqbc/Vo8cIWZZJuPrGjqMdiBPHTFJbb97tu
         L2+y6LzBGyXb9mHWbBnfAL2YnuvOAXjQTNSA4Mgtf9el1vvKyo8S3DN/waGv/ViOwxgj
         4Wy6MPHVc8hKCsKj+KqLM6osz+hNy9RklXWh919ri5yQM4/wqYdIPRibtCyzC+J637Sp
         aIyPwUN0xxRJmGsPi3OsgkMJ8QyRmZ7AWtxpL4W3q2/yx568EXIr15xSUWfib6E0FWoH
         Erzg==
X-Gm-Message-State: AOAM532JsUmt6GwrDwMSOGnKoWe5dAw3eYUH4EwEFvxDaS3NXH/8qqoR
        c2HITZ45pplb/ICC+QRu8jYhevjVem/blYU6pYut1G8Q
X-Google-Smtp-Source: ABdhPJyt8DJDWR9f4muQ4PLeqh3jiIA8TdCO1KO2+9KVbAAI1LSoy+CKSqWG9sdsbo2ZpUjUhSJWwKX1jsVymcw6zfU=
X-Received: by 2002:a5d:44c7:: with SMTP id z7mr25001069wrr.226.1593550594043;
 Tue, 30 Jun 2020 13:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593529394.git.liu.denton@gmail.com> <01e29450fe51a4ba13e07c611d8795ffd0282b9e.1593529394.git.liu.denton@gmail.com>
In-Reply-To: <01e29450fe51a4ba13e07c611d8795ffd0282b9e.1593529394.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 30 Jun 2020 16:56:22 -0400
Message-ID: <CAPig+cSNK1MDitZyh7Ax-eRAh6NjG_QsoF0feEo4475GjZ5ezw@mail.gmail.com>
Subject: Re: [PATCH 5/5] test-lib-functions: restrict test_must_fail usage
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 30, 2020 at 11:03 AM Denton Liu <liu.denton@gmail.com> wrote:
> In previous commits, we removed the usage of test_must_fail() for most
> commands except for a set of pre-approved commands. Since that's done,
> only allow test_must_fail() to run those pre-approved commands.
>
> Obviously, we should allow `git`.
>
> We allow `__git*` as some completion functions return an error code that
> comes from a git invocation. It's good to avoid using test_must_fail
> unnecessarily but it wouldn't hurt to err on the side of caution when
> we're potentially wrapping a git command (like in these case).

s/case/cases/

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> +# Returns success if the arguments indicate that a command should be
> +# accepted by test_must_fail(). If the command is run with env, the env
> +# and its corresponding variable settings will be stripped before we
> +# test the command being run.
> +test_must_fail_acceptable () {
> +       while test "$1" = "env"

I was surprised to see a 'while' loop for stripping 'env'. Did you
actually run across cases in the test suite in which 'env' was
invoking 'env'? If so, were such cases legitimate (as opposed to
accidental)? Perhaps the commit message or an in-code comment could
help readers understand why it needs to strip multiple 'env's.

> +       do
> +               shift
> +               while test $# -gt 0
> +               do
> +                       case "$1" in *?=*) ;; *) break ;; esac
> +                       shift
> +               done
> +       done

Isn't '*?=*' the same as '?=', or am I misunderstanding the intention?
Also, I wonder how important it is to insist that there must be at
least one character before the '=' sign. (It doesn't necessarily hurt,
but I'm curious if it is protecting against legitimate weird cases.)

This logic would be easier to follow written this way:

    case "$1" in
        =) shift ;;
        *) break ;;
    esac

That is, place the 'shift' in the appropriate case-arm rather than
suspending it below all cases.

> +       case "$1" in
> +       git|__git*|test-tool|test-svn-fe|test_terminal)
> +               return 0
> +               ;;
> +       *)
> +               return 1
> +               ;;
> +       esac
> +}

Would it make sense to error out if "$1" has no value? That is, if the
author wrote:

    test_must_fail &&

or

    test_must_fail env foo=bar &&

then that surely is a programmer error, which could be diagnosed here
(though the original 'test_must_fail' didn't bother diagnosing that
problem so it may be overkill and outside the scope of this series to
do so here).

> @@ -817,6 +842,15 @@ list_contains () {
> +# Do not use this to run anything but "git" and other specific testable
> +# commands (see test_must_fail_acceptable()).  We are not in the
> +# business of vetting system supplied commands -- in other words, this
> +# is wrong:
> +#
> +#    test_must_fail grep pattern output
> +#
> +# Just use '!' instead.

I find this somewhat ambiguous; it's not clear at first sight what I'm
supposed to do with '!'. t/README is slightly clearer by saying "use
'! cmd' instead". It might be even clearer to spell it out explicitly
with an example:

    Instead use '!':

        ! grep pattern output
