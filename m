Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0006AC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 22:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345155AbiBJWq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:46:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345219AbiBJWqv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 17:46:51 -0500
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4B95F50
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 14:46:51 -0800 (PST)
Received: by mail-pf1-f181.google.com with SMTP id 9so10013075pfx.12
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 14:46:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RgQwPopRpAUyEmh976fnIQ6dzxN1Tud/GGLGVAJWV2c=;
        b=Uqq3w+e8hTcIEMC8JVPGRq3FU96fnIsPQTgu0EYbc/Dwn7hb3d15yJYTuvuxUMYvB4
         PS3P/G4a5GZ2LRSPdDOpU777bWkuU4HIf+E+WraOz9Q/+tPtMEMd4DS8raSIbCoZPgBC
         bgvT6fSz2JSTd8o+fHyxGWQQYnO/n0nQcdwmdVr3f0nr+6odt4SVoYR1cdnz4glbbnFy
         rRu2MgfrrcVppBeF2Eclx1PfEQmTYZzyeWXzw4y4KyQHGHiNegJ5AQtjqk3yLCeDcRAa
         xoqTP0yF57KF3XFZzpaD15ZQuiIAB5I5dg24DivALcccSOQYBLDQ5M46Ua2LTdvQ8ZDr
         8l8Q==
X-Gm-Message-State: AOAM5304yJ/sM9Du9kwlpNyfeZKXQHjmoBvpmuvVfv8YLCt38NjEuAVV
        9u244JcVr/2XRGqW+eGRcBBnrjgWbfVtlvcoTsM=
X-Google-Smtp-Source: ABdhPJwsBvD1UanpGXfjFha2BJy2za3r3d8XLyG2Q7VkjP86TLpwdmCoZOQBgDDUEZVUZtEI3Ze6mgsiBHFKzCRu3q4=
X-Received: by 2002:a63:571f:: with SMTP id l31mr4172364pgb.181.1644533210753;
 Thu, 10 Feb 2022 14:46:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
 <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com> <6c51324a6623b62c385ec707a773c21375596584.1644465706.git.gitgitgadget@gmail.com>
In-Reply-To: <6c51324a6623b62c385ec707a773c21375596584.1644465706.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 10 Feb 2022 17:46:39 -0500
Message-ID: <CAPig+cQ6mOipiCKSOUo-d0UgoGq+YwShiw0CgcqGvRqxV5K77g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] cat-file: add --batch-command mode
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 9, 2022 at 11:01 PM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Add a new flag --batch-command that accepts commands and arguments
> from stdin, similar to git-update-ref --stdin.

Some comments not offered by other reviewers...

> This patch adds the basic structure for adding command which can be
> extended in the future to add more commands. It also adds the following
> two commands (on top of the flush command):
>
> contents <object> LF
> info <object> LF
>
> The contents command takes an <object> argument and prints out the object
> contents.
>
> The info command takes a <object> argument and prints out the object
> metadata.
>
> These can be used in the following way with --buffer:
>
> info <sha1> LF
> contents <sha1> LF
> contents <sha1> LF
> info <sha1> LF
> flush
> info <sha1> LF
> flush

s/<sha1>/<object>/ for consistency with the usage information earlier
in the commit message, and since Git is migrating to SHA-256, and to
avoid reviewer confusion as occurred earlier[1].

Also: s/flush$/flush LF/

> When used without --buffer:
>
> info <sha1> LF
> contents <sha1> LF
> contents <sha1> LF
> info <sha1> LF
> info <sha1> LF

Ditto.

[1]: https://lore.kernel.org/git/CAPig+cTeqhOYTu9WBiY=LnZtt35hAp3Qa5RduC2yLut6p01_1w@mail.gmail.com/

> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> @@ -96,6 +96,30 @@ OPTIONS
> +--batch-command::
> +       Enter a command mode that reads commands and arguments from stdin.
> +       May not be combined with any other options or arguments except
> +       `--textconv` or `--filters`, in which case the input lines also need to
> +       specify the path, separated by whitespace.  See the section
> +       `BATCH OUTPUT` below for details.

The SYNOPSIS probably needs an update too.

Perhaps say something like "Recognized commands include:" here before
enumerating the commands themselves?

> +--
> +contents <object>::
> +       Print object contents for object reference <object>. This corresponds to
> +       the output of --batch.

s/<object>/`<object>`/
s/--batch/`--batch`/

> +info <object>::
> +       Print object info for object reference <object>. This corresponds to the
> +       output of --batch-check.

s/<object>/`<object>`/
s/--batch/`--batch-check`/

> +flush::
> +       Used in --buffer mode to execute all preceding commands that were issued
> +       since the beginning or since the last flush was issued. When --buffer
> +       is used, no output will come until flush is issued. When --buffer is not
> +       used, commands are flushed each time without issuing `flush`.
> +--

s/--buffer/`--buffer`/g
s/flush/`flush`/g

This says that it's legal to use `--buffer` along with
`--batch-command`, but the description of `--batch-command` itself
just above says that it can be combined only with `--textconv` or
`--filters`. (I see you copied the problematic text from the other
batch options, so they also are guilty of not mentioning `--buffer`.
This series doesn't necessarily need to fix those existing
documentation problems, but perhaps don't repeat the problem with
newly-added text?)

The description of the `--buffer` option probably also needs to be
updated to mention the new `--batch-command` option, and there may be
other places in this document which should mention it, as well.

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> +static const struct parse_cmd {
> +       const char *prefix;
> +       parse_cmd_fn_t fn;
> +       unsigned takes_args;
> +} commands[] = {
> +       { "contents", parse_cmd_contents, 1},
> +       { "info", parse_cmd_info, 1},
> +};
> +
> +static void batch_objects_command(struct batch_options *opt,
> +                                   struct strbuf *output,
> +                                   struct expand_data *data)
> +{
> +       while (!strbuf_getline(&input, stdin)) {
> +               if (!input.len)
> +                       die(_("empty command in input"));
> +               if (isspace(*input.buf))
> +                       die(_("whitespace before command: '%s'"), input.buf);
> +
> +               if (skip_prefix(input.buf, "flush", &cmd_end)) {
> +                       if (!opt->buffer_output)
> +                               die(_("flush is only for --buffer mode"));
> +                       if (*cmd_end)
> +                               die(_("flush takes no arguments"));
> +
> +                       dispatch_calls(opt, output, data, queued_cmd, nr);
> +                       nr = 0;
> +                       continue;
> +               }
> +
> +               for (i = 0; i < ARRAY_SIZE(commands); i++) {
> +                       if (!skip_prefix(input.buf, commands[i].prefix, &cmd_end))
> +                               continue;

This prefix-matching is going to incorrectly match non-commands such
as "contentsify <object>" and "information <object>" and then treat
them as "contents fy <object>" and "info mation <object>",
respectively, with undesirable results. You need to verify that there
is a space or NUL at `*cmd_end` before treating `input.buf` as an
actual command.

> +                       cmd = &commands[i];
> +                       if (cmd->takes_args)

What happens if `cmd->takes_arg` is true but no arguments follow the
command? Should that be diagnosed as an error?

> +                               p = cmd_end + 1;

This unconditional +1 is going to make `p` point beyond the NUL
character if the input is just a bare command, such as "contents" or
"info" without any space or any argument...

> +                       break;
> +               }
> +
> +               if (!cmd)
> +                       die(_("unknown command: '%s'"), input.buf);
> +
> +               if (!opt->buffer_output) {
> +                       cmd->fn(opt, p, output, data);
> +                       continue;
> +               }
> +
> +               ALLOC_GROW(queued_cmd, nr + 1, alloc);
> +               call.fn = cmd->fn;
> +               call.line = xstrdup_or_null(p);

... which means that xstrdup_or_null() will be copying whatever random
garbage is in memory following the bare command.

> +               queued_cmd[nr++] = call;
> +       }
> +
> +       if (opt->buffer_output && nr)
> +               dispatch_calls(opt, output, data, queued_cmd, nr);
> +
> +       free(queued_cmd);
> +       strbuf_release(&input);
> +}
