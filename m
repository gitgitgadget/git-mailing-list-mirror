Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D074C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C15206CC
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgBMS4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:56:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42197 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgBMS4u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 13:56:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id k11so8000027wrd.9
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 10:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V3h1TR8R1AGC9yQQOgMLj27WBVJS+NnNiE/oX0djCjg=;
        b=ATj1R36jr1VuEwcZp4xGpl3ObPF5gNSSdmUPGeHHUkLC+qEonuAEpoD7KpbxuaNyuE
         q86R2eXc+6160piqEW+7N+Y6qUx5SyUE7OJl1/c3uapATidoY5Ag8C+PvlX8o3niB6pW
         Xw4+hGx+QTS9vZAYVqTyH6FGk9ZN+wjCZyWaOd2qQz2kwe/Oz3HiSzlQx9ucp03W9XR5
         H5C7X9lTy/+fuPs4L0pQgBtQktA1MnneooH+oeiVXsy787CDus3DgsgajBbziwRUOdiC
         3PUtTQmAz3pOux0J0dMqUy9K+W1fb3N/ZlenbUPWhbsVFffXe+OmJ0yGOUkATOCp3ujD
         PoeA==
X-Gm-Message-State: APjAAAU4Fpkta7h4fuTuadqbbOPQixFLceIJ3MggV6ovkxSQWqxUEMm8
        b7p35DDnx9eqW8JaGUXhLRrFKhWaD1co2IP+5Mg=
X-Google-Smtp-Source: APXvYqym7OejXqnaNmXeQh4GaA0yg9jf5+erkYgYzxEMSsEBPJPwBiRSRyxPFW/W09QTqLjh2/q3/sDcPXwGdoBleh8=
X-Received: by 2002:a05:6000:1201:: with SMTP id e1mr23599878wrx.386.1581620208697;
 Thu, 13 Feb 2020 10:56:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.553.git.1581619239467.gitgitgadget@gmail.com>
In-Reply-To: <pull.553.git.1581619239467.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 13 Feb 2020 13:56:37 -0500
Message-ID: <CAPig+cQrxKuE=a99zPF7EGUSbye_s5ATEvUkz+EqsTZAfy_CbQ@mail.gmail.com>
Subject: Re: [PATCH] mingw: workaround for hangs when sending STDIN
To:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 13, 2020 at 1:40 PM Alexandr Miloslavskiy via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> 3) Make `poll()` always reply "writable" for write end of the pipe
>    Afterall it seems that cygwin (accidentally?) does that for years.
>    Also, it should be noted that `pump_io_round()` writes 8MB blocks,
>    completely ignoring the fact that pipe's buffer size is only 8KB,
>    which means that pipe gets clogged many times during that single
>    write. This may invite a deadlock, if child's STDERR/STDOUT gets
>    clogged while it's trying to deal with 8MB of STDIN. Such deadlocks
>    could  be defeated with writing less then pipe's buffer size per

s/then/than/

>    round, and always reading everything from STDOUT/STDERR before
>    starting next round. Therefore, making `poll()` always reply
>    "writable" shouldn't cause any new issues or block any future
>    solutions.
> 4) Increase the size of the pipe's buffer
>    The difference between `BytesInQueue` and `QuotaUsed` is the size
>    of pending reads. Therefore, if buffer is bigger then size of reads,

s/then/than/

>    `poll()` won't hang so easily. However, I found that for example
>    `strbuf_read()` will get more and more hungry as it reads large inputs,
>    eventually surpassing any reasonable pipe buffer size.
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> +test_expect_success 'stash handles large files' '
> +       printf "%1023s\n%.0s" "x" {1..16384} >large_file.txt &&
> +       git stash push --include-untracked -- large_file.txt
> +'

Use of {1..16384} is not portable across shells. You should be able to
achieve something similar by assigning a really large value to a shell
variable and then echoing that value to "large_file.txt". Something
like:

    x=0123456789
    x=$x$x$x$x$x$x$x$x$x$x
    x=$x$x$x$x$x$x$x$x$x$x
    ...and so on...
    echo $x >large_file.txt &&

or any other similar construct.
