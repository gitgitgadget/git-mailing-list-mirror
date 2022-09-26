Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D01C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 18:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiIZSG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiIZSGe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 14:06:34 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587C17FFA5
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:50:37 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-324ec5a9e97so76669507b3.7
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9dtS0bjIEIOdhO5yJVhrX7v/djownadEE+WHj9kiDkA=;
        b=Z7XDRP0wE4XDmrxlWPTf3/NOfcf+X9oEeRtoaJXnvBCt+T15y5HxKAZ8lPYDiLUtN8
         EArg/Cvesjm0IdGkgJw1tW56ly5Zt90/KLUkH8ESPWSB7Jf7J9xpnnO+5oW/peOAKg1r
         /AIvwu2cFMNbnfGzaSfqaNioC/vVrj32fEukWXCPOU0uJyTqx+gqNaF5sbXYW8wOW6n/
         q8PpW+7iXqDFQxZMfSbH2I8cqvbborFu1eCDoSPoPqTJJoD78DnAacE3QXf+ljWHYiKB
         kxx+zBmiCt1egMfi2xbSruM4xlnF0uDeJ1LYfvp7VZolLljxIukEw8XmfdXRpSF1Hng0
         pklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9dtS0bjIEIOdhO5yJVhrX7v/djownadEE+WHj9kiDkA=;
        b=H9wraNSFYLT/iPXtYKuwaT3LdCamLhHBjVY4CmiwYfml27nYmw7OOUHjvxhqS1UqUY
         RaNtvQKierFHB57jRAH+5lfsFAuKyaLjamhxaRp8KupTt6TscNuHGP79EHRe4eXhHnm/
         v7YNN/31GZ497JR4+y/vSA3rRlzgBIyjB02CA/R3H0T+g7C1oPNYZf8sNEeJbkULbg4x
         2ffo45l7x4WFxjpQTzoVoz8Oh2haED3lFwMmHgzE2UPR7+3EtAqyMHLfYIIsdMcMgpFI
         2re859dECwJDbHPRU5UJ/O+3pEys7HF4mvFW8Bs/1InqhkYyKN+YOXYyFovo3ASzh+l1
         ufqQ==
X-Gm-Message-State: ACrzQf3m4/wWvRnRdKjZnzppFWgEkMA2tZd+19M2qOZD0NPoD5aNCKVP
        aY2fPgYUNakD1uI2ZdkMpAC/GcCfnqNssxw4vWnIPA==
X-Google-Smtp-Source: AMsMyM4oTe+TIYiHstOGkIrrAkE9fqCKcGRwcw3bzN/uGeN2tdojrh9vb/Si/211zBzH0k3EWK9glUJZT/GOd0NTZ3U=
X-Received: by 2002:a81:ae4d:0:b0:345:7bc1:8eaa with SMTP id
 g13-20020a81ae4d000000b003457bc18eaamr21777962ywk.369.1664214636499; Mon, 26
 Sep 2022 10:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220922232947.631309-1-calvinwan@google.com> <20220922232947.631309-5-calvinwan@google.com>
 <220923.86o7v64ik0.gmgdl@evledraar.gmail.com>
In-Reply-To: <220923.86o7v64ik0.gmgdl@evledraar.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 26 Sep 2022 10:50:25 -0700
Message-ID: <CAFySSZBf7iOkAMBJm3hAJHLA5cGMb0ZJj7xOfn8E3Tn7AU7ebg@mail.gmail.com>
Subject: Re: [PATCH 4/4] diff-lib: parallelize run_diff_files for submodules
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +status.parallelSubmodules::
> > +     When linkgit:git-status[1] is run in a superproject with
> > +     submodules, a status subprocess is spawned for every submodule.
> > +     This option specifies the number of submodule status subprocesses
> > +     to run in parallel. If unset, it defaults to 1.
>
> Why do we default to 1, instead of e.g. grep.threads defaulting to the
> "cores available"?

In my cover letter, I noted that with too many processes, status starts to
slow down (but is still better than the baseline). This is because the
expensive part of status is IO, specifically reading objects from the index.
Much of the speedup of this patch comes from taking advantage of the
ability to do parallel reads on an SSD, rather than splitting up the work
of status. However, this doesn't work with an HDD, so status may
actually be slower than baseline with multiple processes since there is
now scheduling/switching overhead.

>
> > +struct submodule_status_util {
> > +     int changed, ignore_untracked;
>
> nit: we tend not to group by type, which also makes adding API docs
> later easier.
>
> Except that we tend to do that if all the things are really boolean flags, which these are, so maybe:
>
>         unsigned int changed:1,
>                      ignore_untracked:1;
>
> ?

ack.
