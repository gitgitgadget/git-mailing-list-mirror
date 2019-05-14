Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCB551F461
	for <e@80x24.org>; Tue, 14 May 2019 00:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfENATg (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 20:19:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37825 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfENATg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 20:19:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so977442wmo.2
        for <git@vger.kernel.org>; Mon, 13 May 2019 17:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqWnPw8NU9/1HDkyirH7ewNvsDrg+XiFAOdAa7tv0PA=;
        b=EGR7uCSuRiXKdYTWmVildCUNfB3dQXSoMy4mExN9NcAr1BNLw6fAZNWRMLun03eXV8
         vtTmJeX+AvemmhjudsEXbqIM/2iXH3jtp+iwSXJuSqbw2ZDGlCslPRf/z/Q9kaozMipl
         OWvHg81+Kydvx7PIAP8uqIfI1rbuKpFS9WKc+6+32AZzLqNZ7uED53tAc826q0Yjsmpe
         /Qnqa+74eSNDVuPe6soFQ/BQA9rm6ejKvMZlg3MTryqwWWz/rzBvzoI8Os/u1W3FIlDq
         thicdLnArCu2h5DRtlOhOgj5v/hllF4IeIF6H2Tm8SBSzDJerbiUW7XE8erFzmWh60Ld
         0FYg==
X-Gm-Message-State: APjAAAXWOnV5gemGasr49yjvc0oFY9vOatXzwsl6KO2BuB9O59YRIyj0
        O1wpJG2SueGfdpLFbfKs/Alx+UOxZzrNUJka3RY=
X-Google-Smtp-Source: APXvYqxBhGtFhGvJgDRWun5Gsje5TJvrnZbEY+e3y8LKo71BK70AWp2IKmOpZ5/MoH+uEBgkvQzX2V5rAWHsHu/IDbM=
X-Received: by 2002:a1c:760f:: with SMTP id r15mr4001702wmc.134.1557793174200;
 Mon, 13 May 2019 17:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190513164722.31534-1-newren@gmail.com> <20190513231726.16218-1-newren@gmail.com>
 <20190513231726.16218-6-newren@gmail.com>
In-Reply-To: <20190513231726.16218-6-newren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 May 2019 20:19:23 -0400
Message-ID: <CAPig+cTmgPnFud0NVcP0qcQ08t3h-QanyhSTtkx05fQVo3qV9Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] fast-export: do automatic reencoding of commit
 messages only if requested
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 13, 2019 at 7:17 PM Elijah Newren <newren@gmail.com> wrote:
> Automatic re-encoding of commit messages (and dropping of the encoding
> header) hurts attempts to do reversible history rewrites (e.g. sha1sum
> <-> sha256sum transitions, some subtree rewrites), and seems
> inconsistent with the general principle followed elsewhere in
> fast-export of requiring explicit user requests to modify the output
> (e.g. --signed-tags=strip, --tag-of-filtered-object=rewrite).  Add a
> --reencode flag that the user can use to specify, and like other
> fast-export flags, default it to 'abort'.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> @@ -77,6 +78,31 @@ static int parse_opt_tag_of_filtered_mode(const struct option *opt,
> +static int parse_opt_reencode_mode(const struct option *opt,
> +                                  const char *arg, int unset)
> +{
> +       if (unset) {
> +               reencode_mode = REENCODE_ABORT;
> +               return 0;
> +       }
> +
> +       switch (git_parse_maybe_bool(arg)) {
> +       case 0:
> +               reencode_mode = REENCODE_NO;
> +               break;
> +       case 1:
> +               reencode_mode = REENCODE_YES;
> +               break;
> +       default:
> +               if (arg && !strcasecmp(arg, "abort"))

If 'arg' is NULL, git_parse_maybe_bool() will have returned 1, which
is already handled above, so no need to check it here. So, dropping
the "arg &&" from the conditional...

> +                       reencode_mode = REENCODE_ABORT;
> +               else
> +                       return error("Unknown reencoding mode: %s", arg);

...makes it clear that you won't ever be passing NULL to "%s", which
is undefined behavior.

> +       }
> +
> +       return 0;
> +}
