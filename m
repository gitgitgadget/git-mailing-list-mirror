Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35131C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 05:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123B961074
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 05:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhJZFUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 01:20:39 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:44009 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbhJZFUi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 01:20:38 -0400
Received: by mail-ed1-f47.google.com with SMTP id u13so8645390edy.10
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 22:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRH5AICpftAq11ERu3SIhlu+zL8Q9uOuDhbOU2OVPRg=;
        b=vY5U7sir2DjSV/mo+zgoVlstA0uYkd3Kvgdl9M69sEHV9FkYVXcHOUEGiplZQW6+sY
         Nmxfm+ur6CyDUhk91CIfuoxyDd4pAOTbIexMVlIVOUcoCp5GKWTPkAnHq2OXK77WkT2y
         HeOKR+M0bACXPOm9Nta4nHhNwNKIDqgiQsnOAZWCyPbyNnqIc07VunD8K8lBJtjwpOWc
         P0uMHpomly9YZUMmCrNNLDGsWlBu3zGxFt9qXtaP1d2fLwMc3wjyXhfu/QnEaaunOu1B
         ooara2/2Z/DPK7xuckorg7GdtAYtV9akxMC8TMe0UTY92SjpQtH5mw/ySF7qLH2TmzBL
         5juQ==
X-Gm-Message-State: AOAM530F+hvXRdxBH9glGP9prbK0j4bxSWtvR5RoYx9gYO1Vqa1zJ+73
        v6eRvHHLfP5QEou3GxA7s84JJHj8hQ+LtpeAVQj9vMp7
X-Google-Smtp-Source: ABdhPJzyvLjSJwK+mdN4Mcx/5o3JWCAtxk/yRbIOiWKwCWO4/SSOWO2C5givcbTR+oQaEo7XgXchvjHzUckSao/I+ks=
X-Received: by 2002:a17:906:3842:: with SMTP id w2mr28767551ejc.28.1635225494318;
 Mon, 25 Oct 2021 22:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211026013452.1372122-1-eschwartz@archlinux.org> <20211026013452.1372122-2-eschwartz@archlinux.org>
In-Reply-To: <20211026013452.1372122-2-eschwartz@archlinux.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Oct 2021 01:18:03 -0400
Message-ID: <CAPig+cTWeN9_Z1jNLyyMsbRS4oOoyrPAWa3+JdCtsgE2B-rKFg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] pretty.c: rework describe options parsing for
 better extensibility
To:     Eli Schwartz <eschwartz@archlinux.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 25, 2021 at 9:36 PM Eli Schwartz <eschwartz@archlinux.org> wrote:
> It contains option arguments only, not options. We would like to add
> option support here too, but to do that we need to distinguish between
> different types of options.
>
> Lay out the groundwork for distinguishing between bools, strings, etc.
> and move the central logic (validating values and pushing new arguments
> to *args) into the successful match, because that will be fairly
> conditional on what type of argument is being parsed.
>
> Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
> ---
> diff --git a/pretty.c b/pretty.c
> @@ -1216,28 +1216,37 @@ int format_set_trailers_options(struct process_trailer_options *opts,
>  static size_t parse_describe_args(const char *start, struct strvec *args)
>  {
> +       struct {
> +               char *name;
> +               enum { OPT_STRING } type;
> +       }  option[] = {
> +               { "exclude", OPT_STRING },
> +               { "match", OPT_STRING },
> +       };
>         const char *arg = start;
>
>         for (;;) {
> +               int found = 0;
>                 const char *argval;
>                 size_t arglen = 0;
>                 int i;
>
> +               for (i = 0; !found && i < ARRAY_SIZE(option); i++) {
> +                       switch(option[i].type) {
> +                       case OPT_STRING:
> +                               if (match_placeholder_arg_value(arg, option[i].name, &arg,
> +                                                               &argval, &arglen) && arglen) {
> +                                       if (!arglen)
> +                                               return 0;

I may be missing something obvious, but how will it be possible for:

    if (!arglen)
        return 0;

to trigger if the `if` immediately above it:

    if (... && arglen) {

 has already asserted that `arglen` is not 0?

> +                                       strvec_pushf(args, "--%s=%.*s", option[i].name, (int)arglen, argval);
> +                                       found = 1;
> +                               }
>                                 break;
>                         }
>                 }
> +               if (!found)
>                         break;

The use of `found` to break out of a loop from within a `switch` seems
a bit clunky. An alternative would be to `goto` a label...

>         }
>         return arg - start;

... which could be introduced just before the `return`. Of course,
this is highly subjective, so not necessarily worth changing.
