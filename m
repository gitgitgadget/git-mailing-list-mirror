Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10296C433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 23:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFAFD64E27
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 23:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhB1XBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 18:01:43 -0500
Received: from mail-ej1-f52.google.com ([209.85.218.52]:41796 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhB1XBm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 18:01:42 -0500
Received: by mail-ej1-f52.google.com with SMTP id lr13so24822958ejb.8
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 15:01:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fcu6dHhsp59eRrWbnjkuUqKZSgCc0JpIWd0ZxK5+dV8=;
        b=INlDj0BbwQ87Pl+JummQlGcbDbwSGWRF+AL0XNYeOhXhP70ZtSqXKLzOmWa4lyIj1e
         LyyhLh3SvUt7l9/d+TuugyObowndpv2q+YtHDIdz47JzJCTaNfuTCDcKf1Ki/JpYs/Jf
         agtjkbp/6TPoZ54U+mBMxFv23V9B4/Gd/TRdn/u/ag+xvgyahxFfzWVVnxQqQwRo55bi
         BVayTXoo9wwA4ItQDyj364BfWaDZdKPe0opL0cnKj7qHcx6vr/ZImyCGKI/gFSx/TCOa
         Hcnnw72bZFIrhYE7yMFJvCLAN/uaBepLAwOhicIIafNrA4V7yZlBRpNeWuKK8zog+0cQ
         +HPg==
X-Gm-Message-State: AOAM531CPUDIZDg7KqzKFAg5Fl+XLmikJdLy/vA5pyKyzdGEA7Y0BZEO
        Ot+SDflz9p43JMkMLmozWuQBIbuC6sKb66eIE38=
X-Google-Smtp-Source: ABdhPJyPL3WA8qZkkmcEdsjAezKxRGSshz92HEgnUPSyt810npoi8EJFmnvu/VKjWOQPfUXSnMzzcfPBvECx6aYY7oY=
X-Received: by 2002:a17:906:a1c2:: with SMTP id bx2mr13543278ejb.138.1614553260838;
 Sun, 28 Feb 2021 15:01:00 -0800 (PST)
MIME-Version: 1.0
References: <20210218181937.83419-1-me@yadavpratyush.com>
In-Reply-To: <20210218181937.83419-1-me@yadavpratyush.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 28 Feb 2021 18:00:49 -0500
Message-ID: <CAPig+cT-sfgMDi9-6AEKF85NtOiXeqddJjk-pYuhDtTVAE-UEw@mail.gmail.com>
Subject: Re: [PATCH v2] git-gui: remove lines starting with the comment character
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Junio: please do not pull the latest git-gui changes yet; they break
on macOS, making git-gui unusable]

On Thu, Feb 18, 2021 at 1:20 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> The comment character is specified by the config variable
> 'core.commentchar'. Any lines starting with this character is considered
> a comment and should not be included in the final commit message.
>
> Teach git-gui to filter out lines in the commit message that start with
> the comment character using git-stripspace. If the config is not set,
> '#' is taken as the default. Also add a message educating users about
> the comment character.

Thanks for working on this. I've been looking forward to the
improvement; the old behavior of not stripping comment lines has been
a long-time annoyance.

Unfortunately, however, the changes break git-gui badly on macOS. See below...

> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> ---
> diff --git a/git-gui.sh b/git-gui.sh
> @@ -3436,6 +3437,10 @@ proc trace_commit_type {varname args} {
> +       set comment_char [get_config core.commentchar]
> +       set txt [string cat $txt \
> +                                [mc " (Lines starting with '$comment_char' will be ignored)"]]

The old Tcl 8.5.9 on macOS does not have a string `cat` method, so
`string cat` crashes:

    can't set "commit_type": unknown or ambiguous subcommand "cat":
        must be bytelength, compare, equal, first, index, is, last,
        length, map, match, range, repeat, replace, reverse, tolower,
        totitle, toupper, trim, trimleft, trimright, wordend, or
        wordstart
    unknown or ambiguous subcommand "cat": must be bytelength,
        compare, equal, first, index, is, last, length, map, match,
        range, repeat, replace, reverse, tolower, totitle, toupper,
        trim, trimleft, trimright, wordend, or wordstart while
        executing
    "string cat $txt [mc " (Lines starting with '$comment_char' will
        be ignored)"]"

> diff --git a/lib/commit.tcl b/lib/commit.tcl
> @@ -141,6 +141,20 @@ proc setup_commit_encoding {msg_wt {quiet 0}} {
> +proc strip_msg {msg} {
> +       set cmd [concat [list | ] [_git_cmd stripspace] --strip-comments]
> +       _trace_exec $cmd
> +       set fd [open $cmd r+]
> +       fconfigure $fd -translation binary -encoding utf-8
> +       puts -nonewline $fd $msg
> +       close $fd w
> +       set result [read $fd]
> +       close $fd
> +       return $result
> +}

The old Tcl on macOS does not support closing one end of a
bidirectional pipe, so `close $fd w` errors out:

    wrong # args: should be "close channelId"
    wrong # args: should be "close channelId"
        while executing
    "close $fd w"

I'll send a patch which resolves both problems.
