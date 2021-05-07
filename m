Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FD8C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 23:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2B4F61155
	for <git@archiver.kernel.org>; Fri,  7 May 2021 23:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhEGXQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 19:16:57 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:45752 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhEGXQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 19:16:57 -0400
Received: by mail-ej1-f45.google.com with SMTP id u3so15856805eja.12
        for <git@vger.kernel.org>; Fri, 07 May 2021 16:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqPy9sMo+bwtrgwNZpDtCC+RFWo3jWrexTeiYX1lG8o=;
        b=RtPoUdlD/2JDmPpBpDVa9cJjx3v9HVP2XLPy1UirFFFkzIOI0x9PORQe+u/IcN7Pg7
         r7rUbopaNbj1nEnF7VfKJ8m4tzOuejXyFs1Z0gQV9Y1FtrxSvFpOY1BKxHoUWs6GuHeL
         e9Cmu6G6NTMzkRTtXm/lJOpji9wo6QChs2RZaxkb1EFpkP6d4kxRpcaZPXLBymWibaUT
         bJv87uuA37PpeMjlurGlrGROiqOY0dsBEn6/DNViiAJSrwmv/hI/99jLqd7vWUXvjXK+
         AXkwMLyUXQefkX2ZTluT9NmUprXlzFYQID47xfOIdTe331YFu9fNqB9E9Apgj3MbWe6w
         5dHg==
X-Gm-Message-State: AOAM531HVnRTWDbzAI8IdLL4KpG/dvt0k7vbMX6Uj9f0HE+cIKGKFv1N
        TaZu/UWAjpo6msoZ7b4yBIumeNkAbK+KofIvuk4=
X-Google-Smtp-Source: ABdhPJytieJNI0SebK1ypbMEVQZuULz5splIQ77kRdoS9Q28uES4+ZSebkL8ec23Kj2UnmVWsYaRJDQqxI1FAV2J2fo=
X-Received: by 2002:a17:906:3115:: with SMTP id 21mr12842165ejx.482.1620429349861;
 Fri, 07 May 2021 16:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
 <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620360300.git.gitgitgadget@gmail.com>
 <CAPig+cTzvKhUaNEXwRAVwV1Vkb7jpHNkcOytEPq0Gg33TrJXNg@mail.gmail.com>
 <CABPp-BGzUBF8S8t3nixi3TCkiBe7oS1fQ5cNCozicb20iZxshA@mail.gmail.com> <YJXHrXWVDSgg5TZw@coredump.intra.peff.net>
In-Reply-To: <YJXHrXWVDSgg5TZw@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 May 2021 19:15:38 -0400
Message-ID: <CAPig+cSP-5mvK0z=A21y4DQ_u07S+xHV3L+ADgaxzaK51yjX_w@mail.gmail.com>
Subject: Re: [PATCH 1/5] t7300: add testcase showing unnecessary traversal
 into ignored directory
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 7, 2021 at 7:05 PM Jeff King <peff@peff.net> wrote:
> I don't have a better way of checking the dir.c behavior. But I think
> the other half of Eric's question was: why can't we do this setup way
> more efficiently with "mkdir -p"?

I didn't really have that other half-question, as I understood the
portability ramifications. Rather, I just wanted to make sure the
reason I thought the code was doing the for-loop-plus-mv dance was
indeed correct, and that I wasn't overlooking something non-obvious. I
was also indirectly hinting that that bit of code might deserve an
in-code comment explaining why the for-loop is there so that someone
doesn't come along in the future and try replacing it with `mkdir -p`.

> I'd be suspicious that it would work portably because of the long path.
> But I think the perl I showed earlier would create it in much less time:
>
>   $ time perl -e '
>       for (reverse 1..400) {
>         my $d = "directory$_";
>         mkdir($d) and chdir($d) or die "mkdir($d): $!";
>       }
>       open(my $fh, ">", "some-file");
>     '

Yep, this and your other Perl code snippet for removing the directory
seemed much nicer than the far more expensive shell for-loop-plus-mv
(especially for Windows folk).
