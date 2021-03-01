Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC84C433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 06:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1016F64E31
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 06:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhCAGtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 01:49:45 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:37307 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhCAGtm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 01:49:42 -0500
Received: by mail-ed1-f54.google.com with SMTP id d13so14141401edp.4
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 22:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxSA88SJWYffmD9FJhwQDZPwGyVqlAsaeBjnQvEIVF8=;
        b=Hv09tslBwLjcWsa+/FWYK8iEZgkMYwYnSZ6OimrO5OJbce6KxHeYutuwAtfu7+yCpT
         /Rr7o4qmdMKfzYMEEFi/6bTN5PbU8lpYezNjen3MLp9nh+lJxD5sPQ8ACktGO9BFIG5Z
         CkOu9xR7CuSO8pGD/ImWEUquWJbBHmzc6FjodYlTtDUE9AdgAYO3TW4nG64AeXD1ihXH
         epW9YUNbLGznAe5BV6+nkaM3MgwoZTxtWXXNOrZsasepCDF+VDSlBoZJV2PoQeSxfD9E
         5xOESKEUCVBD5OIF6AI/YCoFU/0yzfaxtYUnwHXnFuUhOmxxgd6R3TI8MMLG0Jzity/d
         K7iQ==
X-Gm-Message-State: AOAM533UUvtyU190dUtxcwUv3in/wxX0RPGVv56BoAtIyp4GvN1gtt1y
        ttIBW2Yfu7qoVLeGzSvLsCu9iu9bgEyOYqiLh/sS1H2ODaI=
X-Google-Smtp-Source: ABdhPJyVbppx0xLBWaQxKpjG3qSPKc8SymM3GVmkz4m8zegR04DEAFKukpd9Rc83JHb2uVSomfAKvj6olyI20ZyrPpA=
X-Received: by 2002:aa7:c944:: with SMTP id h4mr14812809edt.233.1614581340891;
 Sun, 28 Feb 2021 22:49:00 -0800 (PST)
MIME-Version: 1.0
References: <20210228231110.24076-1-sunshine@sunshineco.com>
In-Reply-To: <20210228231110.24076-1-sunshine@sunshineco.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 1 Mar 2021 01:48:49 -0500
Message-ID: <CAPig+cRQN4PjfxEOZ8ZBA_uttsRPS8DPDgToM_JFvichDDh_HQ@mail.gmail.com>
Subject: Re: [PATCH] git-gui: fix commit message comment line removal with
 older Tcl versions
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 28, 2021 at 6:12 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> git-gui was recently enhanced to remove comment lines from the commit
> message similar to the way git-commit does so (see `core.commentchar`
> and `git-stripspace`). Unfortunately, that change employs features which
> are unavailable in older versions of Tcl, such as 8.5.9 which is shipped
> with macOS (10.13), with the result that the commit operation errors
> out.
>
> There are two problems. First, to add a new informational message to the
> main window, it invokes string method `cat` which does not exist in
> older Tcl. Fix this by using `append` instead.
>
> Second, when passing the commit message through git-stripspace, it
> closes the "write" side of the bidirectional pipe after sending the
> commit message to git-stripspace in order to avoid deadlock before
> reading back the result, however the ability to close only one end of a
> pipe is not present in older Tcl. Fix this by employing a temporary file
> to received the output of git-stripspace.

s/received/receive/

(I noticed this immediately after sending the patch, of course.)

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> diff --git a/lib/commit.tcl b/lib/commit.tcl
> @@ -142,16 +142,18 @@ proc setup_commit_encoding {msg_wt {quiet 0}} {
>  proc strip_msg {msg} {
> -       set cmd [concat [list | ] [_git_cmd stripspace] --strip-comments]
> +       set strip_p [gitdir GITGUI_EDITMSG_STRIP]
> +       set cmd [concat [list | ] [_git_cmd stripspace] --strip-comments [list >$strip_p]]
>         _trace_exec $cmd
> -       set fd [open $cmd r+]
> +       set fd [open $cmd w]
>         fconfigure $fd -translation binary -encoding utf-8
> -
>         puts -nonewline $fd $msg
> -       close $fd w
> -       set result [read $fd]
>         close $fd
>
> +       set fd [open $strip_p r]

I had meant to insert:

    fconfigure $fd -translation binary -encoding utf-8

here but forgot. Would you like me to resend the patch or can you
tweak it locally?

> +       set result [read $fd]
> +       close $fd
> +       file delete $strip_p
>         return $result
>  }
