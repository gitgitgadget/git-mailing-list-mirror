Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A155B1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 06:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeGPHVa (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 03:21:30 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:41765 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeGPHVa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 03:21:30 -0400
Received: by mail-yw0-f194.google.com with SMTP id q129-v6so11024963ywg.8
        for <git@vger.kernel.org>; Sun, 15 Jul 2018 23:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ro6LS/dxSVsr6nno0vcbOedf0QvZcnrWQFz1BAI+ec=;
        b=q7GSN+sOpCwqsus0hVUWoy+KxAu4t0TG4/dAHlWLGe/hilINYb2WlHVRpkKH/ow3Oa
         oFIcfHXp7V5JVesHPk7uX9QK23cLWgn1F3qhj4IlbX3VBlAGlz5z5L+X8qNb2FmlWGnP
         qmDFAaAPN2mHcMMtTloXRpOAAVd3hYqxUOgCH4zNhtP22kX6nZmgHNwSOm6w/3FfsdFj
         +/f+ikC5Cfmi8YrZ5TPwpSFWL4fUG/E6Z2k5wD66Va58lEKFrJ9mZ7iO5/10kVTuCAE4
         fnnJIEJAHtyAaDFVwEYtYNiiBy0DPS/ktuojvxljN6FZzqKmMcySqgbjMnFxQOfvDStO
         ZcsA==
X-Gm-Message-State: AOUpUlH12NIH9EJBgw5DyHEJjt7Ezx2o4/Y5pAJPWcR2WLdIJohOxEal
        knpSc5T/qi1Qq8hTZI8iB4VG7z33vUmMgeb28l8=
X-Google-Smtp-Source: AAOMgpcotNyM/a6gB8bCykjTll0GOheGWLo+BVab6ttqj+U/13HSkdaap+WcDvNNMX104QGtqetWpYYfrYdOzht3ASs=
X-Received: by 2002:a81:1001:: with SMTP id 1-v6mr7598811ywq.120.1531724137341;
 Sun, 15 Jul 2018 23:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
 <pull.1.v3.git.gitgitgadget@gmail.com> <076e1192d15562d868a8a6014f36155f360da83d.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <076e1192d15562d868a8a6014f36155f360da83d.1530617166.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 16 Jul 2018 02:55:25 -0400
Message-ID: <CAPig+cQo1hM59P5eB4YTw=zvMAWh0OO8zsf0PMcwYoJtGwLKCQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/20] range-diff: first rudimentary implementation
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 3, 2018 at 7:27 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> At this stage, `git range-diff` can determine corresponding commits
> of two related commit ranges. This makes use of the recently introduced
> implementation of the Hungarian algorithm.

Did you want s/Hungarian/Jonker-Volgenant/ here? (Not worth a re-roll.)

> The core of this patch is a straight port of the ideas of tbdiff, the
> apparently dormant project at https://github.com/trast/tbdiff.
> [...]
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> @@ -17,9 +18,49 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
> +       int res = 0;
> +       struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
>
> -       argc = parse_options(argc, argv, NULL, options,
> -                            builtin_range_diff_usage, 0);
> +       argc = parse_options(argc, argv, NULL, options, builtin_range_diff_usage,
> +                            0);

This parse_options() change appears to be merely a re-wrapping of the
line between patches 2 and 3.

> -       return 0;
> +       if (argc == 2) {
> +               if (!strstr(argv[0], ".."))
> +                       warning(_("no .. in range: '%s'"), argv[0]);
> +               strbuf_addstr(&range1, argv[0]);
> +
> +               if (!strstr(argv[1], ".."))
> +                       warning(_("no .. in range: '%s'"), argv[1]);
> +               strbuf_addstr(&range2, argv[1]);

Should these die() (like the "..." case below) rather than warning()?
Warning and continuing doesn't seem like intended behavior. When I
test this with on git.git and omit the "..", git sits for a long, long
time consuming the CPU. I guess it's git-log'ing pretty much the
entire history.

    % GIT_TRACE=1 git range-diff v1 v2
    warning: no .. in range: 'v1'
    warning: no .. in range: 'v2'
    trace: git log --no-color -p --no-merges --reverse \
        --date-order --decorate=no --no-abbrev-commit v1
    ^C
    %

> +       } else if (argc == 3) {
> +               strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
> +               strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
> +       } else if (argc == 1) {
> +               const char *b = strstr(argv[0], "..."), *a = argv[0];
> +               int a_len;
> +
> +               if (!b)
> +                       die(_("single arg format requires a symmetric range"));
> diff --git a/range-diff.c b/range-diff.c
> @@ -0,0 +1,307 @@
> +static int read_patches(const char *range, struct string_list *list)
> +{
> +       while (strbuf_getline(&line, in) != EOF) {
> +               if (skip_prefix(line.buf, "commit ", &p)) {
> +                       [...]
> +                       in_header = 1;
> +                       continue;
> +               }
> +               if (starts_with(line.buf, "diff --git")) {
> +                       in_header = 0;
> +                       [...]
> +               } else if (in_header) {
> +                       if (starts_with(line.buf, "Author: ")) {
> +                               [...]
> +                       } else if (starts_with(line.buf, "    ")) {
> +                               [...]
> +                       }
> +                       continue;
> +               } else if (starts_with(line.buf, "@@ "))
> +                       strbuf_addstr(&buf, "@@");
> +               else if (line.buf[0] && !starts_with(line.buf, "index "))
> +                       /*
> +                        * A completely blank (not ' \n', which is context)
> +                        * line is not valid in a diff.  We skip it
> +                        * silently, because this neatly handles the blank
> +                        * separator line between commits in git-log
> +                        * output.
> +                        */
> +                       strbuf_addbuf(&buf, &line);

This comment had me confused for a bit since it doesn't seem to agree
with the 'then' part of the 'if', but rather applies more to the
'else'.  Had it been split into two parts (one for 'then' and one for
'else'), it might have been easier to digest. That is, something like:

    else if (line.buf[0] && !starts_with(..., "index "))
        /* A line we wish to keep. */
        strbuf_addbuf(...);
    else
        /*
         * A completely blank line between commits or
         * or one in which we are otherwise not interested.
         */
        continue;

or something. Structuring it a bit differently might have helped, as well:

    else if (!line.buf[0])
        /* A completely blank line between commits. */
        continue;
    else if (starts_with(..., "index "))
        /* A line in which we are not interested. */
        continue;
    else
        strbuf_addbuf(&buf, &line);

Not at all worth a re-roll.

> +               else
> +                       continue;
> +       if (util)
> +               string_list_append(list, buf.buf)->util = util;

So, the parser is grabbing each commit and shoving all the
"interesting" information about the commit in a 'patch_util'. It grabs
the OID, author, the commit message (indented), the "diff --git",
"+++", "---" lines (but ignores "index" line), "@@" lines (but
ignoring the gunk after "@@"), and all context and patch lines.

Looks good.

> +       strbuf_release(&buf);
> +
> +       if (finish_command(&cp))
> +               return -1;
> +
> +       return 0;
> +}
