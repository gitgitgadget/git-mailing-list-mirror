Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C43EC7619A
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 00:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjDCASJ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 2 Apr 2023 20:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDCASI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2023 20:18:08 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC96E6182
        for <git@vger.kernel.org>; Sun,  2 Apr 2023 17:18:06 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id y7so8454631qky.1
        for <git@vger.kernel.org>; Sun, 02 Apr 2023 17:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680481086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNEn5z+BJ1HEtA04FBhpKYxN/ahomc2CItFvHDq5YTc=;
        b=kZvZ8JSJdqo5UhyFvOZtszenzOQAboYXZlWhvK4G5O2CYC3tqdtFCmqN6GkcSfVd9j
         B5EI+oa71CNcI7CglXAXgWvmyBQNmcGkFguz/R9RMzqbstnfj3WEZipviT9nI+zIC0CE
         H6gFTanasTEeP1cXpGk2p4CakGnQiBjQ6Fe6ycG3RONyzdKY7L2W3yiuXaxTUEIMWhX7
         1eRXgb5U35X5nXyWw7CtZ72tX1ZeZNoeLrujG9hWi93rgeaVfkoocFVWuBiRVJyd6Crx
         0xIjFjeqrmmDJwyI1ONtDtiMetJFOFyUU+p3oauiO/e70NjQbTirxikC+8/PLRewQgZg
         yFZA==
X-Gm-Message-State: AO0yUKWdLmvb77VFtSy5pPuCjv+ayRVTvnpLdFx1geUOOKf7UFrej9aq
        v3ZJMXS49faoIAFeBfqwhjbSzvy2qN5lzSIR/J5SeXDt
X-Google-Smtp-Source: AK7set/gVsln2bMdVsf7jgQ3iaotQMZN4ywHYTp5pa009DMgIh+MRwCl1rcUzWTQzsCcDB644Ua9HCrGpy9a61LvkCw=
X-Received: by 2002:ae9:e80d:0:b0:743:7dcc:282a with SMTP id
 a13-20020ae9e80d000000b007437dcc282amr8906145qkg.8.1680481085678; Sun, 02 Apr
 2023 17:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230402185635.302653-1-robin@jarry.cc>
In-Reply-To: <20230402185635.302653-1-robin@jarry.cc>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 2 Apr 2023 20:17:54 -0400
Message-ID: <CAPig+cSAvLcVTYF21ksyuhMtFxQkg71ktGd7tw595VRq1kcyvA@mail.gmail.com>
Subject: Re: [PATCH RESEND] hooks: add sendemail-validate-series
To:     Robin Jarry <robin@jarry.cc>
Cc:     git@vger.kernel.org, Tim Culverhouse <tim@timculverhouse.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 2, 2023 at 3:10 PM Robin Jarry <robin@jarry.cc> wrote:
> When sending patch series (with a cover-letter or not)
> sendemail-validate is called with every email/patch file independently
> from the others. When one of the patches depends on a previous one, it
> may not be possible to use this hook in a meaningful way.
>
> Changing sendemail-validate to take all patches as arguments would break
> backward compatibility.
>
> Add a new hook to allow validating patch series instead of patch by
> patch. The patch files are provided in the hook script standard input.

It's not clear from this description whether the pathnames of the
patches are fed to the hook on stdin or if the patch contents are fed
on stdin.

> git hook run cannot be used since it closes the hook standard input. Run
> the hook directly.
>
> Signed-off-by: Robin Jarry <robin@jarry.cc>
> ---
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> @@ -600,6 +600,23 @@ the name of the file that holds the e-mail to be sent.  Exiting with a
> +sendemail-validate-series
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +This hook is invoked by linkgit:git-send-email[1].  It allows performing
> +validation on a complete patch series at once, instead of patch by patch with
> +`sendemail-validate`.
> +
> +`sendemail-validate-series` takes no arguments, but for each e-mail to be sent
> +it receives on standard input a line of the format:
> +
> +  <patch-file> LF
> +
> +where `<patch-file>` is a name of a file that holds an e-mail to be sent,

This does a better job than the commit message of explaining that
stdin receives the names of the patches rather than the content of the
patches themselves. It's a nit, but it might be even clearer to say
that <patch-file> is the _pathname_ of the file rather than merely the
_name_.

> +If the hook exits with non-zero status, `git send-email` will abort before
> +sending any e-mails.

It was a bit startling to see this spelled "e-mail" rather than
"email", the latter of which is used far more frequently in the
documentation. However, "e-mail" does indeed appear in githooks.txt
more frequently than "email", so the use of "e-mail" here is probably
fine.

I doubt that any of the above comments warrant a reroll.
