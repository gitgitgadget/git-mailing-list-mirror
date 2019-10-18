Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD6A81F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 00:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438941AbfJRAMJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 20:12:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52233 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfJRAMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 20:12:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id r19so4293797wmh.2
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 17:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+C/jJiMI7vkealUUa2Pgd+zeHOjxZosbO9mmBV58rT8=;
        b=VPUbDlmQ9z1fh9+7IHWNL9Jm6jOJVUni+nnWF8tEAiYk1Vexg/E+PzSL12i0YI9NPj
         /W7OlQi2qFas395veLt/KvSmnLwU8KCDbKySp7UPu3c9+eXJ/qmyjYX9izQqzpPfWQd1
         j5yy9dMJJ6UOa/Xd01e8hwkAkXt6FppH5Tg0Eb+spSMkki6HnBkzpyhdeynJptgNcRTe
         w38JdlWZzTWxQniez0ObFw1kO74dNJx5Rtz+BkKNG2VrGXf/xMPfl7MwdE8qRdpbS+yP
         Zuitd+icnObGi3Lh1AuWLchBHk63Fn57c2pPGRHjFfc8ugwQo5S0NQH4UfqNUGFR9xH9
         YU+g==
X-Gm-Message-State: APjAAAUV1Pa8MturkbQFLia/HxVunt/rXUxSdQ0TR4LyuekSpbjO3AL9
        RBqSyBAGFyC221h7Z5tT0+cMnIxUJvhp+xnqKcn4xWkQ
X-Google-Smtp-Source: APXvYqx1aM6Nr6yJ8GEaIUo+6USuamA4CNm37PS8HbZOgx5qX7S/B7o64NZQOXmgXQhuL9qRSALiNeKzQiAFYiPQMhg=
X-Received: by 2002:a1c:9dcf:: with SMTP id g198mr5164928wme.101.1571357527026;
 Thu, 17 Oct 2019 17:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <f3cb583110f508b4a421326ea6667280e848930d.1571354136.git.liu.denton@gmail.com>
 <542cd04c2ebda88b8fa63dc4dcb1c42d10afc844.1571355109.git.liu.denton@gmail.com>
In-Reply-To: <542cd04c2ebda88b8fa63dc4dcb1c42d10afc844.1571355109.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 17 Oct 2019 20:11:56 -0400
Message-ID: <CAPig+cTEHkWn528uMfrMNxrFFMnj8942wP0XmAEGuv_jZ1-6Lw@mail.gmail.com>
Subject: Re: [PATCH 4.5/12] t5520: replace test -f with test-lib functions
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 7:35 PM Denton Liu <liu.denton@gmail.com> wrote:
> Although `test -f` has the same functionality as test_path_is_file(), in
> the case where test_path_is_file() fails, we get much better debugging
> information.
>
> Replace `test -f` with test_path_is_file() so that future developers
> will have a better experience debugging these test cases. Also, in the
> case of `! test -f`, replace it with test_path_is_missing().
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> I just realised that test_path_is_missing() is a much better replacement
> than `test_must_fail test_path_is_file`.

That depends upon context...

> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> @@ -99,7 +99,7 @@ test_expect_success 'pulling into void must not create an octopus' '
> -               ! test -f file
> +               test_path_is_missing file

There is a semantic difference between checking that "file" is not a
_file_ versus checking that the a path itself (which may be a
directory or a "special file") does not exist. In this particular
test, the difference doesn't matter, so the conversion is sensible
enough, but it would save reviewers time if you, as author of the
patch, state that you carefully considered the distinction before
making each change.
