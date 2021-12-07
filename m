Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927B9C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 03:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhLGDTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 22:19:43 -0500
Received: from mail-pj1-f52.google.com ([209.85.216.52]:41865 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbhLGDTk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 22:19:40 -0500
Received: by mail-pj1-f52.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso1517617pjb.0
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 19:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqVkK3xOcH5IQ6MrZ4YCHX7ZuoxTyP4e/FQCoZXo5RE=;
        b=sj5cnnqLJ8884uBDSXeyfIxWZiLL6ankUiTOoCDiLlVc93EmuAcjBLiFOYqj8ZabKz
         GHlfEaQhRgXT+FjIDkB5uJdwzIeVZwUCMHQEOvCX4WduTj06H8HftTaaJGd7y96D8o4/
         VXlAgJjDXwruoc41bfcXClaWtbNFv7e53vPeD1gMR2vgk/PMSPIXvQ9f4UhiS3HaMq4u
         wcQyOjEhrP0oWazlw7Ifm8KYqmsHlcIQ02xi97HnKQCCM1x32U8wCbMkR1JjsbGVJvzm
         20J26r4ejPmV3BFwMlYVxXpzTGYKDUG/Ete4XfLcQPghpLZc3OVCUN1bhZTnPiNFugfA
         Zk6w==
X-Gm-Message-State: AOAM532pYGxCsnNpjAfgO8OuyWyM8fNSi2mXVF3cjqOZTnJd8xIGqr5S
        59w64FhQyPwl+5PnahOucJIWoJEWeoB/+Od4eXCb6XW251bfcw==
X-Google-Smtp-Source: ABdhPJy+QlOw3BP1UidLpyslNlCEf3xmKoyt/QjQDwkfszjm/fWgLveeWAAHFBLY67mbP74HSED1hkcpkn7AVTmO8ps=
X-Received: by 2002:a17:90b:4d08:: with SMTP id mw8mr3381350pjb.236.1638846970767;
 Mon, 06 Dec 2021 19:16:10 -0800 (PST)
MIME-Version: 1.0
References: <CAHeq4YxktibxMBnMLwEq9Nvsgw0UqCrjW2WPcerJCM4mXKxiEw@mail.gmail.com>
In-Reply-To: <CAHeq4YxktibxMBnMLwEq9Nvsgw0UqCrjW2WPcerJCM4mXKxiEw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 6 Dec 2021 22:15:59 -0500
Message-ID: <CAPig+cQSEUguKRfCBLoDfLvH5orAX-_KZ+pZE=h4u2x3N_yNzQ@mail.gmail.com>
Subject: Re: BUG: git bash / python interaction with absolute paths as
 environment variables in Windows
To:     Leland Weathers <leland@lcweathers.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 6, 2021 at 10:01 PM Leland Weathers <leland@lcweathers.net> wrote:
> Issue: Using Git Bash for Windows (2.34.1-64) and Python 3.9.9, a git
> path is incorrectly prepended to environment variables in Python code.
>
> $ echo $TEST_DIR_BROKEN
> /foo/bar
> $ echo $TEST_DIR_WORKING
> foo/bar
> $ python foobar.py
> environ: C:/Users/Leland/AppData/Local/Programs/Git/foo/bar
> environ: foo/bar
>
> Is there anything else I'm missing on why the same Python script would
> read environment variables differently than what is read from Git Bash
> itself or why the exact same Python code reads the environment
> variable correctly when run from a command prompt and not in Git Bash?
>
> In both cases I am using the same Python virtual environment. Other
> environment variables (e.g. non-absolute directory paths) appear to be
> read correctly. I'm assuming that this is a git issue given the

This is probably not specific to Git, but rather a "feature" of MSYS2,
which Git for Windows happens to employ for its Bash shell. When
invoking Windows commands from within MSYS2, command-line arguments
and environment variables on the Unix side which appear to be paths
will be converted to Windows paths for the sake of the native Windows
program (since it won't know anything about the Unix paths coming out
of the MSYS2 environment).

This behavior is documented at [1]; in particular, see the
"Environment Variables" section.

[1]: https://www.msys2.org/docs/filesystem-paths/
