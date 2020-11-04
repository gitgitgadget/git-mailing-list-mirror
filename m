Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06D1C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CF6020759
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgKDR1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:27:43 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:37228 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKDR1n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:27:43 -0500
Received: by mail-ej1-f67.google.com with SMTP id gn41so13598537ejc.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 09:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8dNLEOcqcnMp1j9aZ5eGR6Fs5IA5ydMQm+++Gm96WlY=;
        b=FGAWkNH0Q18lcypcx9euauvJz38CZRWLPrOEDRrjk+TZxj95SvjMANyZ7VwsmsvDMF
         /04MgN0VFDna4tiWFKXPcNlW6hrKuzw7AhsMOCYa6hZTDWCZd8sH+avVZSMyZKAYrxn8
         iTIuopeao/0JaIsKKiCT8fVUYhYVXX/TiwP0Zu6tekzjxQY3k4vZQqteTOmUVILLc6Le
         Gw4A7M204GHPDC8zJGyfxISsVwrAgEVRyzfdxbfonD2dLa+xj4R/gqRl+mGni5/UJ0qk
         SWwwMj/wb7BoQW/2S21bDl6LyqYXHPJvEkRA2pckKtZJihPyBOOqybTPSQSzEuo/iiLx
         bMyQ==
X-Gm-Message-State: AOAM530LlslWb5xdgG9Bc2sv1E2+Foa7kagdll/nHZEA3973YgBDCt3Q
        vCdt5Z0ege89R+fKaAuMas04ZayidPNfWh3ZrQ4=
X-Google-Smtp-Source: ABdhPJyuOFNmHkuHkQpDRIa8E7ZLrbFlMaWA4tkR49Go8emvTa3j1dlY08zDDpA7aIUTECruPJvF7jjRtrIMyvWvgJw=
X-Received: by 2002:a17:907:42cf:: with SMTP id nz23mr12730231ejb.138.1604510861088;
 Wed, 04 Nov 2020 09:27:41 -0800 (PST)
MIME-Version: 1.0
References: <20201104132428.GA2491189@coredump.intra.peff.net> <20201104132907.GC3030146@coredump.intra.peff.net>
In-Reply-To: <20201104132907.GC3030146@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 4 Nov 2020 12:27:30 -0500
Message-ID: <CAPig+cQ7t1by2X0xwddyo40sQdb9BPBKmERpqKR6oMD82kUwgg@mail.gmail.com>
Subject: Re: [PATCH 3/3] format-patch: support --output option
To:     Jeff King <peff@peff.net>
Cc:     Johannes Postler <johannes.postler@txture.io>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 4, 2020 at 8:29 AM Jeff King <peff@peff.net> wrote:
> [...]
> The simplest solution would be to just disallow --output with
> format-patch, as nobody ever intended it to work. However, we have
> accidentally documented it (because format-patch includes diff-options).
> And it does work with "git log", which writes the whole output to the
> specified file. It's easy enough to make that work for format-patch,
> too: it's really the same as --stdout, but pointed at a specific file.
> [...]
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/log.c b/builtin/log.c
> @@ -1942,11 +1942,18 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> +       } else if (rev.diffopt.close_file) {
> +               /*
> +                * The diff code parsed --output; it has already opened the
> +                * file, but but we must instruct it not to close after each
> +                * diff.
> +                */
> +               rev.diffopt.close_file = 0;
>         } else {

The commit message's justification for supporting --output seems
reasonable. However, my knee-jerk reaction to the implementation was
that it feels overly magical and a bit too hacky. I can see the logic
in it but it also leaves a bad taste when the implementation has to
"undo" a side-effect of some other piece of code, which makes it feel
unplanned and fragile. The question which popped into my mind
immediately was "why not handle --output explicitly via
builtin_format_patch_options[] along with other first-class options?".
This review comment may or may not be actionable; it's just expressing
surprise and a bit of nose-wrinkling I experienced.

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> @@ -1919,6 +1919,39 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
> +test_expect_success 'format-patch forbids multiple outputs' '
> +       rm -fr outfile outdir &&
> +       test_must_fail \
> +               git format-patch --stdout --output=outfile &&
> +       test_must_fail \
> +               git format-patch --stdout --output-directory=outdir &&
> +       test_must_fail \
> +               git format-patch --output=outfile --output-directory=outdir
> +'

I would have expected to see this test added in patch [1/3], and then
extended by this patch with the addition of the --output case(s).
