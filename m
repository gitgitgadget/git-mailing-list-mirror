Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B896C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 16:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbhL1QSO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 28 Dec 2021 11:18:14 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:38739 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbhL1QSN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 11:18:13 -0500
Received: by mail-pl1-f179.google.com with SMTP id c3so703963pls.5
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 08:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=97dba4gmsMfiEUavsE9FMHeV5lNyBYzs64UxctZKlBk=;
        b=mBWcIJn3rTTJNP2wMCEljnk/NvYI91A4cSzuaAkcoQ/ynTwWYzQITITathUhdbKOwX
         lZijX4XUSbpX1OexG8HAhWgjEv10XmHVNxr4sXpbHAhaUOJUDDMzX7aLYjcy/hhdp6wz
         gg6JoGCvmzIxcyRlBShGLvPvR9t5k2I6fsOQdrTu9f3DPGjRf7qqc4PwFt5ctRBY/pbF
         uHVkkZu8r4OGN3B0Hqx4DRq3sLW9ATZxYlJHfm5Wvsqd7Y+yIGo6q7PnkaNyo2/MyM1I
         QvNxNgD8lrRuNGPyqyRuNzYZnlcMU8/kbBtKp1WSY1cdfQlqQJqjtyGQRIVh3xjYqMiE
         obAg==
X-Gm-Message-State: AOAM531rUd+vvh++V1KnlJim6EH4e2PLtQ+/uHIQwIqlKvFkMbDrNvGy
        4L4Eliv8Rx5+GyuCGN1Yi8XyoLpcS4ukmdGz6lbpuw+5Yfk=
X-Google-Smtp-Source: ABdhPJxY8QXFYkiBhutYGpEzjhwmThv7+uYVniTHExXtbBNYIsZEB8yYnO34MLX8UgVcFpJBG51/gBtUqD3z1VuKloc=
X-Received: by 2002:a17:902:8346:b0:148:997d:f60b with SMTP id
 z6-20020a170902834600b00148997df60bmr22521068pln.64.1640708293112; Tue, 28
 Dec 2021 08:18:13 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com> <patch-5.7-12ff152bd57-20211228T153456Z-avarab@gmail.com>
In-Reply-To: <patch-5.7-12ff152bd57-20211228T153456Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Dec 2021 11:18:02 -0500
Message-ID: <CAPig+cSVLPiGUAiK8tt1dp3BVLAwXCAeMvM9LenBUY4s_xBQ+A@mail.gmail.com>
Subject: Re: [PATCH 5/7] help: error if [-a|-g|-c] and [-i|-m|-w] are combined
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 10:36 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Add more sanity checking to "git help" usage by erroring out if these
> man viewer options are combined with incompatible command-modes that
> will never use these documentation viewers.
>
> This continues the work started in d35d03cf93e (help: simplify by
> moving to OPT_CMDMODE(), 2021-09-22) of adding more sanity checking to
> "git help". Doing this allows us to clarify the "SYNOPSIS" in the
> documentation, and the "git help -h" output.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/builtin/help.c b/builtin/help.c
> @@ -581,6 +581,13 @@ static void no_extra_argc(int argc)
> +static void no_format(void)
> +{
> +       if (help_format != HELP_FORMAT_NONE)
> +               usage_msg_opt(_("[-a|--all] cannot be combined with [[-i|--info] [-m|--man] [-w|--web]]"),
> +                             builtin_help_usage, builtin_help_options);
> +}

Nit: The square brackets in the message may be unnecessarily
confusing. (Indeed, what exactly do they mean in this context?) Also,
the short options may not add much value: the user who typed `-w`
knows presumably that it is shorthand for `--web`. So, one
simplification would be:

    '--all' cannot be combined with '--info', '--man', or '--web'
