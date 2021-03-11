Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C585EC433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 06:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988D461583
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 06:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCKG0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 01:26:22 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49]:34160 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhCKGZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 01:25:56 -0500
Received: by mail-ej1-f49.google.com with SMTP id hs11so43828726ejc.1
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 22:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4SK8kaJ4+TRhOtP05an1ntuoorpufVhcri6xoaHv20I=;
        b=FaDynJyDvthwkpVf54wG8ZwMSAZ21Lojz6JcvV0lbnFxIBUk5nhQN1dyFZPbz3bHD3
         lZqwFUuZgO7zVKLrQoDwxWWmUsklOXDYXEsio3BtYTnguFXNsOQQXZB1E76tM1D+TSD4
         FCr1TXc4GLxjrdaLE05FqebMnbPqi/pTNVEQs6LOHSLIcRZZM/6b9p6Sltxb7n5+JTCn
         ivFeNrjkF95MJVPdFe8ylaLM9rac4aeiKwvTtHOy4c5TM5S0dOvXz3bVzLuLd5GUMMRo
         Z/YXDDTUqjMyyGdk26Oxs2+Ul+LAkFcTmuzwMJ5F24AKfT0Xt247GWmQDP2k/7r7HE+g
         LAaQ==
X-Gm-Message-State: AOAM531CvsfaBuWLJUC0oBrHIHgA3SfTSoilgGCr7WvrSbOeCOKQx+RF
        9vL6yyyzlGKqqJJN4bCjHnrT0C8VS/avtCBug3U=
X-Google-Smtp-Source: ABdhPJzWRgM8uV56XM6yEBc9vb+CHJEONKS6+pHIXTKskNKhfEA8t6AfGGSVRrkMYZBfYCYRR7ZDFWKgxttgpscetxo=
X-Received: by 2002:a17:906:bd2:: with SMTP id y18mr1521695ejg.482.1615443955410;
 Wed, 10 Mar 2021 22:25:55 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210310194306.32565-3-charvi077@gmail.com>
In-Reply-To: <20210310194306.32565-3-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 11 Mar 2021 01:25:44 -0500
Message-ID: <CAPig+cRxZFV7DDtnYOxRqEYU4PwXK8gb2HSehDyGorqdgsmoNQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2021 at 2:44 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> `git commit --fixup=amend:<commit>` will create an "amend!" commit.
> The resulting commit message subject will be "amend! ..." where
> "..." is the subject line of <commit> and the initial message
> body will be <commit>'s message.
>
> The "amend!" commit when rebased with --autosquash will fixup the
> contents and replace the commit message of <commit> with the
> "amend!" commit's message body.
> [...]
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
> diff --git a/builtin/commit.c b/builtin/commit.c
> @@ -681,6 +683,23 @@ static void adjust_comment_line_char(const struct strbuf *sb)
> +static int prepare_amend_commit(struct commit *commit, struct strbuf *sb,
> +                               struct pretty_print_context *ctx) {
> +
> +       const char *buffer, *subject, *fmt;

Two style nits:

* opening curly brace of function goes on its own line

* we don't normally have a blank line at the top of the function body
preceding the declarations

So:

    static int prepare_amend_commit(...)
    {
        const  char *buffer, *subject, *fmt;

> +       buffer = get_commit_buffer(commit, NULL);
> +       find_commit_subject(buffer, &subject);
> +       /*
> +        * If we amend the 'amend!' commit then we don't want to
> +        * duplicate the subject line.
> +        */
> +       fmt = starts_with(subject, "amend!") ? "%b" : "%B";
> +       format_commit_message(commit, fmt, sb, ctx);
> +       unuse_commit_buffer(commit, buffer);
> +       return 0;
> +}

What is the significance of this function's return value? At least in
this patch, the single caller of this function ignores the return
value, which suggests that the function need not return any value.
Will a later patch add other possible return values to indicate an
error or something?

> @@ -745,15 +764,32 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
> +               char *fmt = xstrfmt("%s! %%s\n\n", fixup_prefix);
> +               commit = lookup_commit_reference_by_name(fixup_commit);
>                 if (!commit)
> +                       die(_("could not lookup commit %s"), fixup_commit);
>                 ctx.output_encoding = get_commit_output_encoding();
> +               format_commit_message(commit, fmt, &sb, &ctx);
> +               free(fmt);

Nit: it would reduce the cognitive load slightly if `fmt` is prepared
just before it is used rather than being prepared at the top of the
block:

    fmt = xstrfmt("%s! %%s\n\n", fixup_prefix);
    format_commit_message(commit, fmt, &sb, &ctx);
    free(fmt);

Subjective and not at all worth a re-roll.

> @@ -1227,6 +1269,34 @@ static int parse_and_validate_options(int argc, const char *argv[],
> +       if (fixup_message) {
> +               /*
> +                * To check if fixup_message that contains ':' is a commit
> +                * reference for example: --fixup="HEAD^{/^area: string}" or
> +                * a suboption of `--fixup`.
> +                *
> +                * As `amend` suboption contains only alpha character.
> +                * So check if first non alpha character in fixup_message
> +                * is ':'.
> +                */

I have a tough time figuring out what this comment is trying to say,
and I don't think I would have understood it if Junio had not already
explained earlier in this thread why this code is as complex as it is
(rather than using, say, skip_prefix()). Perhaps the entire comment
can be replaced with this:

    Extract <option> (i.e. `amend`) from `--fixup=<option>:<commit>`,
    if present. To avoid being fooled by a legitimate ":" in <commit>
    (i.e. `--fixup="HEAD^{/^area: string}"`), <option> must be
    composed of only alphabetic characters.

Not necessarily worth a re-roll.

> +               size_t len = get_alpha_len(fixup_message);
> +               if (len && fixup_message[len] == ':') {
> +                       fixup_message[len++] = '\0';
> +                       fixup_commit = fixup_message + len;

An alternate -- just about as compact and perhaps more idiomatic --
way to write all this without introducing the new get_alpha_len()
function:

    char *p = fixup_mesage;
    while (isalpha(*p))
        p++;
    if (p > fixup_message && *p == ':') {
        *p = '\0';
        fixup_commit = p + 1;

Subjective and not at all worth a re-roll.

> +                       if (!strcmp("amend", fixup_message)) {
> +                               fixup_prefix = "amend";
> +                               allow_empty = 1;
> +                       } else {
> +                               die(_("unknown option: --fixup=%s:%s"), fixup_message, fixup_commit);
> +                       }
> +               } else {
> +                       fixup_commit = fixup_message;
> +                       fixup_prefix = "fixup";
> +                       use_editor = 0;
> +               }
> +       }
