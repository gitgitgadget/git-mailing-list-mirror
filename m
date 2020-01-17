Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F288C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E06A2082F
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgAQVYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:24:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33481 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQVYt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 16:24:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so24081305wrq.0
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 13:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5Xfwomnfb0xpk8uSBszKT7AAFFDXCnML33aE1MC/v8=;
        b=qYR4xAshuXsLPHJano1pNZFSi7FfBvUiCxLN/sluZ53eQLzcHwVut8WUN6UymO0mGg
         Ab7iIjDR7jdK3jcxNDWlspItnYFC+Aa55Epqpf9giJRHpm55NZQKaFayz4XG4aPOymDO
         cZc7mkoHN+ccvVVYoeyQFAFMHzPcZ80ShISXswcxhDUX1gZ10tjZ9XPqfSQIlste/bTj
         tGDiJBrtN2Vi9l4OFr/02ykYPPcer4CvHMBLMC7r1bVkO6eewOON3RX9UKH4H9bEWwLK
         58TZy4P/6I94rXFBCKa1iKomYeMKlCM+gF1fzpRmYogKIe7jot8fBW+BCxiWpB7pNyBe
         /2AQ==
X-Gm-Message-State: APjAAAUdE3Vc1zeeDWKJke15M5T8YXEPmHDXDnDZct66nX+D9KIeP6MO
        sfPvjZThAOgmQZBpz6t9VDtKBtPnrg1P/OVmJW8=
X-Google-Smtp-Source: APXvYqzJ67a7VMFnOdCuukJMyYX80oOXEGg7I0rPZ01VNDCDidBR9x5GFwfkMEJ4wwTX2yhwEoJjhDmiU9/ELACAins=
X-Received: by 2002:adf:e74a:: with SMTP id c10mr5166601wrn.386.1579296287377;
 Fri, 17 Jan 2020 13:24:47 -0800 (PST)
MIME-Version: 1.0
References: <xmqqblr3f1q3.fsf@gitster-ct.c.googlers.com> <20200117204426.9347-1-shouryashukla.oo@gmail.com>
 <20200117204426.9347-3-shouryashukla.oo@gmail.com>
In-Reply-To: <20200117204426.9347-3-shouryashukla.oo@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 Jan 2020 16:24:36 -0500
Message-ID: <CAPig+cQX=jB1KTKcOMVE9u0jX-ZXt_vQBndkzqqQWORu5iFxeA@mail.gmail.com>
Subject: Re: [PATCH 2/3] t6025: replace pipe with redirection operator
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 17, 2020 at 3:45 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
> The exit code of pipes(|) are always ignored, which will create
> errors in subsequent statements. Let's handle it by redirecting
> its output to a file and capturing return values. Replace pipe
> with redirect(>) operator.

This is not an accurate description. The proper way to explain this is
that exit code of a command upstream of a pipe is lost; the exit code
of a command downstream is not lost. We don't want to lose the exit
code of a git command, so a git command should not be upstream. (We
don't care about non-git commands being upstream when that command's
exit code is not relevant.)

> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
> diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
> @@ -17,14 +17,13 @@ test_expect_success 'setup' '
>         git commit -m initial &&
>         git branch b-symlink &&
>         git branch b-file &&
> -       l=$(printf file | git hash-object -t blob -w --stdin) &&

This command is fine as-is. We are interested in the exit code of the
git command (which is correctly downstream), and we don't care about
the exit code of 'printf' (which is upstream), so there is no reason
to rewrite this to use temporary files instead.

> +       printf file >file &&
> +       l=$(git hash-object -t blob -w --stdin) &&

Sorry, but this just doesn't make sense. You're telling "git
hash-object" to take its input from the standard input stream, yet you
don't feed anything to it on that stream. If anything, it should have
been written like this:

     l=$(git hash-object -t blob -w --stdin <file) &&

however, as noted above, there is no reason to avoid pipes in this
case, so this rewrite is unnecessary.

By the way, it's hard to imagine that this test passed once this
change was made (and, if it did pass, then that would likely indicate
that the test is somehow flawed.)
