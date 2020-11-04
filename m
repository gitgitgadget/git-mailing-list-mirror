Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10749C388F9
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D19C720732
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbgKDRCI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:02:08 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:33634 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731545AbgKDRCI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:02:08 -0500
Received: by mail-ej1-f67.google.com with SMTP id 7so30796132ejm.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 09:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dU9jiHnVrgb3hrhLgpI9gdaEhB+NAFq66trVAqbyg9M=;
        b=oQ8ByeOYJ1LMavuMG9S8sLtTWmMjrawJ9hOitPx9yQ5US5cqUKVB/cahd8x6q641lA
         LarzPdgSk3Or+EgNrKfj3ZH1qGR7iBb8lA+9BzNmkTxKity9dXMzIsxRnngq8o1BB1KA
         r92tz74kKZFcHOjDFGYmVLHm8p91BliJ6oIbzKcliO4Nb8gZuBmT3imkllb0+L4nDyf0
         FpadUGZBZ1hUh7siFfx3VybUTdcjvdyLzzv2sLwrFheo0uokiiGUjFpSw9osoP/FkAwg
         LrPLIFLMP5zFsvGfuQOiIWl+d7F9bK83B84YK1Zoihv5/GkDTh2Z5WdaoGcUT+qWT6A0
         i+Pg==
X-Gm-Message-State: AOAM5320zO1gepbi8qKUw9aBLQv54p0ZBlhmdeNOzJzjhFxkndyRQYKA
        kcn9zZT0Mb08rA3eyEFFutfqcXpCsQkNhWi+W/4=
X-Google-Smtp-Source: ABdhPJwbWtezF97cUKn1ZnFbBNfqjc1Mv8QSQcidwdkZv++eY3OVRDIeZeeDzOcPm1qoIxne3iSM+8fgi5N3QmwJFtA=
X-Received: by 2002:a17:907:42cf:: with SMTP id nz23mr12616581ejb.138.1604509324654;
 Wed, 04 Nov 2020 09:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20201104132428.GA2491189@coredump.intra.peff.net> <20201104132522.GA3030146@coredump.intra.peff.net>
In-Reply-To: <20201104132522.GA3030146@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 4 Nov 2020 12:01:53 -0500
Message-ID: <CAPig+cRG4uPL1TDpEOgOZwSEJfyt-d0XmsVz3hcCebgwbO_v_A@mail.gmail.com>
Subject: Re: [PATCH 1/3] format-patch: refactor output selection
To:     Jeff King <peff@peff.net>
Cc:     Johannes Postler <johannes.postler@txture.io>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 4, 2020 at 8:25 AM Jeff King <peff@peff.net> wrote:
> The --stdout and --output-directory options are mutually exclusive, but
> it's hard to tell from reading the code. We have three separate
> conditionals that check for use_stdout, and it's only after we've set up
> the output_directory fully that we check whether the user also specified
> --stdout.
>
> Instead, let's check the exclusion explicitly first, then have a single
> conditional that handles stdout versus an output directory. This is
> slightly easier to follow now, and also will keep things sane when we
> add another output mode in a future patch.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/log.c b/builtin/log.c
> @@ -1942,20 +1942,20 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> +       if (use_stdout + !!output_directory > 1)
> +               die(_("specify only one of --stdout, --output, and --output-directory"));

Is mention of --output intentional here? The commit message only talks
about --stdout and --output-directory.

It's subjective, but "mutually exclusive" sounds a bit more consistent
with other similar error messages elsewhere:

    --stdout, --output, and --output-directory are mutually exclusive
