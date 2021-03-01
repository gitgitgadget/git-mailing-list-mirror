Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9C4C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 22:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC89060231
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 22:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbhCAWVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 17:21:04 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:33959 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241137AbhCAWP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 17:15:59 -0500
Received: by mail-ej1-f42.google.com with SMTP id hs11so31294592ejc.1
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 14:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QONqDzuNDSmMLImXNAkbOMHS0qLZpZnJ1jIJYUxCNoQ=;
        b=XOOC9aXNV4PZ5Kv2ciuYpVHmkVNlDGifmejTSTyJjaiY57WlJBt9PHWJODiCWoPruo
         vGxpdrA5B4Funfs5MV4HqAJPSbvfnkIgu4vePK2bce3mj0IWJ25OY7ekqV66lPpyGU3X
         7zWxHFvhMX/vwLbREf2vbUmiQJ/sC5KxPKbVnAosMJJ8rUxsDnTebG2o7sL6geHZVwcL
         Qg27vyIPo9QLJEkr0tV0rgtk55B5rI86NQJLkG+oXU/vMw1aKNXzIriR7GSfiMNgo1eQ
         T8XAg1UVBUM6qdWfDLyEiVDX24ruANjg8Monvhq3XSoYl20b2DT8azhj5mufyMkmofTL
         X19g==
X-Gm-Message-State: AOAM532id96A/iVMN1JWaM+knH/eWqgKBd5BBV6L9F4luKpADvamjEqV
        V+ls/bZnAO51Gx/dU/EQCeI3oFfefBjSQ61mb9I=
X-Google-Smtp-Source: ABdhPJziTZNb1/fgQOewdtxvFVcl1brSAI1XKqQirFn0EqgGeRNaOO7EuLuhvrHMWCbCN0pMf9aI4vdzuR/jiJKZedw=
X-Received: by 2002:a17:906:68c5:: with SMTP id y5mr1831977ejr.371.1614636916283;
 Mon, 01 Mar 2021 14:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-3-charvi077@gmail.com>
In-Reply-To: <20210301084512.27170-3-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 1 Mar 2021 17:15:05 -0500
Message-ID: <CAPig+cQAG3p6rhGHzBNGPUxMXQbbLZgiw-uUpizNiEWY9wm-3A@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     20210217072904.16257-1-charvi077@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 1, 2021 at 3:50 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> `git commit --fixup=amend:<commit>` will create an "amend!" commit.
> The resulting commit message subject will be "amend! ..." where
> "..." is the subject line of <commit> and the initial message
> body will be <commit>'s message. -m can be used to override the
> message body.
>
> The "amend!" commit when rebased with --autosquash will fixup the
> contents and replace the commit message of <commit> with the
> "amend!" commit's message body.
>
> In order to prevent rebase from creating commits with an empty
> message we refuse to create an "amend!" commit if commit message
> body is empty.
>
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
> diff --git a/builtin/commit.c b/builtin/commit.c
> @@ -105,7 +105,8 @@ static const char *template_file;
> +static int prepare_amend_commit(struct commit *commit, struct strbuf *sb,
> +                                                                struct pretty_print_context *ctx) {
> +       /*
> +        * If we amend the 'amend!' commit then we don't want to
> +        * duplicate the subject line.
> +        */
> +       const char *format = NULL;
> +       if (starts_with(sb->buf, "amend! amend!"))

Is the content of the incoming strbuf created mechanically so that we
know that there will only ever be one space between the two "amend!"
literals? If not, then this starts_with() check feels fragile.
(Compare with the code in sequencer.c which checks for this sort of
duplication but is tolerant of one or more spaces, not just a single
space.)

> +               format = "%b";
> +       else
> +               format = "%B";

It's subjective and minor, but this could be expressed more compactly as:

    const char *fmt = starts_with(...) ? "%b" : "%B";

Also, no need to initialize `format` to NULL since it gets assigned in
all code paths.

Not worth a re-roll.

> @@ -745,15 +761,33 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
> +               if (!strcmp(fixup_prefix, "amend")) {
> +                       if (have_option_m)
> +                               die(_("cannot combine -m with --fixup:%s"), fixup_message);
> +                       else
> +                               prepare_amend_commit(commit, &sb, &ctx);
> +               }

This is minor, but the way this is written, the error case and the
normal case appear to have the same significance, whereas, if you
write it like this:

    if (!strcmp(...)) {
        if (have_option_m)
            die(...);
        prepare_amend_commit(...);
    }

then it's easier to see that you're checking for and getting an error
case out of the way early, which allows the reader to concentrate
without distraction on the normal case. As a minor benefit, you also
get to eliminate an indentation level for the normal case, which could
be important if more code is added to that case.

Not worth a re-roll.

> @@ -1227,6 +1267,28 @@ static int parse_and_validate_options(int argc, const char *argv[],
> +       if (fixup_message) {
> +               /*
> +                * As `amend` suboption contains only alpha
> +                * character. So check if first non alpha
> +                * character in fixup_message is ':'.
> +                */
> +               size_t len = get_alpha_len(fixup_message);
> +               if (len && fixup_message[len] == ':') {
> +                       fixup_message[len++] = '\0';
> +                       fixup_commit = fixup_message + len;
> +                       if (starts_with("amend", fixup_message))
> +                               fixup_prefix = "amend";
> +                       else
> +                               die(_("unknown option: --fixup=%s:%s"), fixup_message, fixup_commit);

I haven't read ahead in the series yet, but I presume you're making
this code extra generic because you plan to support additional `fixup`
options (such as `reword`), but I wonder if the cognitive overhead is
warranted or you could get by with something simpler, such as:

    if (skip_prefix(msg, "amend:", &arg) ||
        skip_prefix(msg, "reword:", &arg)) {
        ...
    }

Also, am I misreading when I think that the use of starts_with() could
be replaced with a simple strcmp() since you've already inserted a
'\0' immediately after the final alphabetic character?

Not necessarily worth a re-roll.

> @@ -1663,6 +1729,19 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
> +               if (message_is_empty(&body, cleanup_mode)) {
> +                       rollback_index_files();
> +                       fprintf(stderr, _("Aborting commit due to empty commit message body.\n"));
> +                       exit(1);

I was wondering why you are capitalizing the error message (these days
we don't) and using exit() instead of die(), but I see that you're
mirroring existing practice in this function. Okay.
