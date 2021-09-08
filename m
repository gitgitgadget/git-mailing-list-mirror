Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E46C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 342EB61154
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348690AbhIHQkZ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 8 Sep 2021 12:40:25 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:35629 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhIHQkW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 12:40:22 -0400
Received: by mail-lf1-f54.google.com with SMTP id k13so6111632lfv.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 09:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yA7rSMLQTWT24rGCRxWw/G2V26cX9yLbhqsUZfkkN/U=;
        b=U3JwBsn+sXq7XnR8BKtDUk9vW1CE3PJUBVncFRmJEYLfZ6L8K9zF/Jq6qUt6fmgr8c
         6yZEVYb+pUud44fMT5oSCpmZLC3qH4wdTPH3+YoyODA478zShUQ74CYMdfS6TP0I4QQi
         EDzprSiitHekbxAQyG5z8yrWf+QDKNJKZ/UJJt+2b8YfptVHCYhXB11P29ldEPmmUjGU
         yYXSztlmRiI6mQK+HNdro9eOZqpNU+Tz0I7tIQvskVGVml4xWp3ElLH+g/hz/oRIHjnp
         dI5QYwsgJ4J+xekK7ZddrIRxtng4Y3psJdLe0+LVtFFJyDDa2LYe0JFIWoJ3Jpp8zAp2
         izRQ==
X-Gm-Message-State: AOAM5336+KbulOB6Bmz+ntuLNnU21+9aH3cNmsb6/dXVAk2X97GK17WT
        Gnx835o3cIqLD//2A+wi0uG8QIWvQvR/xRa5c0A=
X-Google-Smtp-Source: ABdhPJxoU6bU80sd5OA3+XfJWMmiAzhMZaTs+yzhvrbkqcdMsuIyTN8LglTCUZRBMktQMarf7j/eZylIQIdgtjkDNzU=
X-Received: by 2002:a05:6512:b8d:: with SMTP id b13mr3237275lfv.443.1631119153571;
 Wed, 08 Sep 2021 09:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com> <patch-5.6-bcc640d32a1-20210908T151949Z-avarab@gmail.com>
In-Reply-To: <patch-5.6-bcc640d32a1-20210908T151949Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 8 Sep 2021 12:39:02 -0400
Message-ID: <CAPig+cSK+wLPUDuGf1d41J_F5jQS+J=a=7kHQLV07-ZKZW9GsA@mail.gmail.com>
Subject: Re: [PATCH 5/6] help: correct logic error in combining --all and --config
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 8, 2021 at 11:24 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Fix a bug in the --config option that's been there ever since its
> introduction in 3ac68a93fd2 (help: add --config to list all available
> config, 2018-05-26). Die when --all and --config are combined,
> combining them doesn't make sense.
>
> The code for the --config option when combined with an earlier
> refactoring done to support the --guide option in
> 65f98358c0c (builtin/help.c: add --guide option, 2013-04-02) would
> cause us to take the "--all" branch early and ignore the --config
> option.
>
> Let's instead list these as incompatible, both in the synopsis and
> help output, and enforce it in the code itself.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/builtin/help.c b/builtin/help.c
> @@ -549,18 +550,26 @@ int cmd_help(int argc, const char **argv, const char *prefix)
> +       /* Incompatible options */
> +       if (show_all + !!show_config + show_guides > 1)
> +               usage_with_options(builtin_help_usage, builtin_help_options);

I personally find it highly frustrating when a program merely dumps
the usage statement without any explanation of what exactly it doesn't
like about the command-line. Printing out a simple:

    --all, --guides, --config are mutually exclusive

message would go a long way toward reducing the frustration level.

(Aside: I also find it more hostile than helpful when programs dump
the usage statement for a command-line invocation error -- even if
preceded by an explanation of the error -- since the explanation
usually gets drowned-out by the often multi-page usage text, and the
user has to go spelunking around the wall of output to try to figure
out what actually went wrong. It's much more helpful and easy to
figure out what went wrong with the invocation when only a simple
error message is printed -- without usage statement. However, that's a
separate battle, as Git already has plenty of places which dump the
usage statement in response to an invocation error.)
