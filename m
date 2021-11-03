Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD4DC433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 19:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E916109F
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 19:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhKCUAR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 3 Nov 2021 16:00:17 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:41975 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCUAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 16:00:16 -0400
Received: by mail-ed1-f45.google.com with SMTP id ee33so13505611edb.8
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 12:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xqOmbSLbEPTJ68b5abuSNmeqR0ugaJWedJDqj3jLLwA=;
        b=8Afu4ERBAtjSBiX59pUb6LeGsi8uVEevECtNbFotF5ZkKJFF0rxhBJvty6HUaj+6IP
         9ZZ+DPgUa2F2xHY5QphQYzSmibqJDFDsRMgF0dH2KaJ6dDzs3zpKzxLzpu/W97o1AcEf
         WJaeiIUpn4OOEbiYax7b+/nbTsDBJkYPRIjMlrT0aq6+/JHbTTBHF9fTq0hSj6c4F/zC
         oRllzejBm8bUnvG23QBeiYY8OY5qiIcvar1Af9BKY/1ng/2AHqvS+VIy1WvUoAshppiD
         yxVHvp2KzQX0fMxNOE5rlo3bhag+pNuqAn1MMTJ5ym2wnAUvurpr3QtvaIeyqUxONtkD
         KVug==
X-Gm-Message-State: AOAM531eIU9Q4eqfHJbwk+xdu6YemyPffLJXVZl8FtgzmPGuPawnmjIJ
        6Iq41c4ZdEtKFbDocWeQ3PiwDkFuew4lZ+5OsxVBG27DDig=
X-Google-Smtp-Source: ABdhPJxST8tdhW9NVWgroVs64bids/Jh6re5pje3bMRydfx9VfGK2r18cZE4HNu7UrAJmpDmTPmstaEYEMTJpEwPw6o=
X-Received: by 2002:a17:907:6e1c:: with SMTP id sd28mr24229765ejc.28.1635969458707;
 Wed, 03 Nov 2021 12:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqa6il6qxu.fsf@gitster.g> <20211103185331.599463-1-thomas@t-8ch.de>
In-Reply-To: <20211103185331.599463-1-thomas@t-8ch.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 3 Nov 2021 15:57:27 -0400
Message-ID: <CAPig+cR0PL-XtfC8v4-u1Taq6yOLO=2HSHsNBnzvzLCyM-whZA@mail.gmail.com>
Subject: Re: [PATCH v3] var: add GIT_DEFAULT_BRANCH variable
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 3, 2021 at 2:53 PM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> Introduce the logical variable GIT_DEFAULT_BRANCH which represents the
> the default branch name that will be used by "git init".
> [...]
> Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> ---
> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
> @@ -27,6 +27,25 @@ test_expect_success !FAIL_PREREQS,!AUTOIDENT 'requested identities are strict' '
> +test_expect_success 'get GIT_DEFAULT_BRANCH without configuration' '
> +       (
> +               sane_unset GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
> +               echo master >expect &&
> +               git var GIT_DEFAULT_BRANCH >actual &&
> +               test_cmp expect actual
> +       )
> +'

So that we don't have to worry about this test breaking if the default
branch ever is changed, would it make sense to stop hard-coding
"master" here and instead employ the trick that Dscho mentioned
earlier in the thread (i.e. create a dummy repo and ask it for its
default branch)? Something like this (untested):

    (
        sane_unset GIT_TEST_... &&
        git init defbranch &&
        git -C defbranch symbolic-ref --short HEAD >expect &&
        git var GIT_DEFAULT_BRANCH >actual &&
        test_cmp expect actual
    )

> +test_expect_success 'get GIT_DEFAULT_BRANCH with configuration' '
> +       test_config init.defaultbranch foo &&
> +       (
> +               sane_unset GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
> +               echo foo >expect &&
> +               git var GIT_DEFAULT_BRANCH >actual &&
> +               test_cmp expect actual
> +       )
> +'
