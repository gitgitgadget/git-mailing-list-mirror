Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A91C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8203A6109F
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349833AbhIHQnH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 8 Sep 2021 12:43:07 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:45636 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349390AbhIHQnG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 12:43:06 -0400
Received: by mail-lj1-f178.google.com with SMTP id l18so4518930lji.12
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 09:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=acEFX7vbRtGeBP/u9t5fZG5uIQCj1jTvVe/ZUdTuPXw=;
        b=EE4wOV+lEZgnTNgAKn/eDfJ/gAxE7beNGSBBHsQ9hA83ALJKlDqjyl8NZIwpZtxxoG
         bYxIEsKoZj0RLg5xl1X2cWls5q08OlP0D21zhY+pMIB4x7YWVix6+RXPjqc5YUhooLR9
         i4r8+z4jdskoQri1OWlXKUAkD6vpbwt/rheapb6Ypbn+E6xH0glvUVG+4V610r3BJm0q
         zMNuAW+gkTbO51i0hSXIAkjH03Z1jTLrkaO+FlXrqs6NVlCvbiMKioufWFR9jMCslZTd
         RUu8f7Z3N0kNYfza2iSwjLzsZmXXXdUBlCVJcd4ygEBreJIcyyIVz9bVjJM4tSmoG1+4
         rBYA==
X-Gm-Message-State: AOAM531UGU5yA38cuwU1cxahWzxF1KeCY8jANee1rH+lV37HgDvvSpB2
        l3UkRZboCnaGovyVvjIgHV1NIiVMjst+KgSpdK6k1Y5V
X-Google-Smtp-Source: ABdhPJxgBIbHnbZ40CnNi+X/xmZyQp0GDFQ6GNK0rJmzOPY5/oW54jxRL1JMYQ9wu22wPTMi4xh4n3QIlKY+wYaUJxU=
X-Received: by 2002:a2e:bc2a:: with SMTP id b42mr3724302ljf.395.1631119317460;
 Wed, 08 Sep 2021 09:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com> <patch-4.6-e4bc7e57a6d-20210908T151949Z-avarab@gmail.com>
In-Reply-To: <patch-4.6-e4bc7e57a6d-20210908T151949Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 8 Sep 2021 12:41:46 -0400
Message-ID: <CAPig+cQVsFvkLMXrm7d3mCUoJKj7x+0PNcAYJ0-uFHaqbRw0ag@mail.gmail.com>
Subject: Re: [PATCH 4/6] help: refactor "for_human" control flow in cmd_help()
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
> Instead of having two lines that call list_config_help(for_human)
> let's setup the pager and print the trailer conditionally. This makes
> it clearer at a glance how the two differ in behavior.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> @@ -574,13 +574,12 @@ int cmd_help(int argc, const char **argv, const char *prefix)
> -               if (!for_human) {
> -                       list_config_help(for_human);
> -                       return 0;
> -               }
> -               setup_pager();
> +               if (for_human)
> +                       setup_pager();
>                 list_config_help(for_human);
> -               printf("\n%s\n", _("'git help config' for more information"));
> +               if (for_human)
> +                       printf("\n%s\n", _("'git help config' for more information"));
> +

For what it's worth, I find the original logic easier to reason about
since it gets the "simple" case out of the way early, thus I don't
have to keep as much (or any) state in mind as I'm reading the rest of
the code. However, it's highly subjective, of course; just one
person's opinion.
