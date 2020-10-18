Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D827BC388CF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 19:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56AB204FD
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 19:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732985AbgJRTfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:35:19 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:37701 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731431AbgJRTZw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 15:25:52 -0400
Received: by mail-ej1-f66.google.com with SMTP id e22so10935468ejr.4
        for <git@vger.kernel.org>; Sun, 18 Oct 2020 12:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xlH3JKcHtVNDHNkrn0auCzGZ2b90t8SDKcElee36oes=;
        b=rap1CnCL2y5tBp+OtO8vo6xlYDmde/XDPlcu5lNZGaOIVYJTmWiMr6i9DnQvdNg/sI
         Dnks2tVUGP1+4Snb+Uvajhenkdv7YIDwxx3Bu/d0SxBKgAcF2QBgji+R0xnGn+Ik11+n
         ilhvL6fzZWlsv69kz8DxTaXXtdf/rI0z6TFyPlTevTs1C1DpEThFqVklDkiZRO7m1gYo
         vdb8Hndci7dKeDxuitHQmWA3bjBegm1aUABCpkqw+pvyYjNyNkF7ttOYh0SyU+UKTc2n
         YCSHbCQTSvXIZ7JHjeEq75kPBSvVTxjk3Q/FT7igJHW5nX967MFsNZf/ZHuMXr5hTgaU
         hRTA==
X-Gm-Message-State: AOAM533N+7pOB+bkGhvKlwb2zmwbHBNcEASm99dnCb1klSDiSrvoYM1C
        iQMwv2o0PPmBg3sGySPH8sKYIhngSoRkTYsTKbU=
X-Google-Smtp-Source: ABdhPJxj5bq5xvm0BiWSi35P9JaBquKDHBzaFjH97A3sLxUJHD3ZLzx2oFLVq+p+0udQlCqHJ+8WVIds0Rw2M5Jx0pI=
X-Received: by 2002:a17:906:f24b:: with SMTP id gy11mr14406216ejb.371.1603049150858;
 Sun, 18 Oct 2020 12:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.git.git.1602950552.gitgitgadget@gmail.com> <pull.885.v2.git.git.1603032125151.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.v2.git.git.1603032125151.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 18 Oct 2020 15:25:40 -0400
Message-ID: <CAPig+cR7Hm9m1EiWkr5tKYS3r_zJf98XT7OQ+-Jt4EWkaFQTDw@mail.gmail.com>
Subject: Re: [PATCH v2] t9832,t2200: avoid using pipes in git commands
To:     Amanda Shafack via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Amanda Shafack <shafack.likhene@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 18, 2020 at 10:42 AM Amanda Shafack via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> t9832,t2200: avoid using pipes in git commands

The subject is a bit confusing since pipes aren't used in Git
commands; instead, Git commands may be components of pipes. However,
even that is too imprecise. The issue this patch is addressing is that
we want to avoid Git commands _upstream_ in a pipe. It's perfectly
acceptable for the Git command to be the final element of a pipe since
the pipe returns the exit code of the final command. So, to be more
precise, the subject could say:

    t2200,t9832: avoid using `git` upstream in a pipe

Nit: It's subjective, but it feels a bit more natural to list the test
numbers in ascending order rather than descending order, which is why
I swapped them around in the example above.

> When a git command is upstream in a pipe, an unexpected failure of
> the git command will go unnoticed.
>
> Write out the output of the git command to a file, so as to actively
> catch a failure of the git command.

It's easy to see from the patch itself that the output of the Git
command is now written to a file, so it's not necessary to say so in
the commit message. Therefore, the entire body of the commit message
could be written more succinctly, perhaps like this:

    Avoid placing `git` upstream in a pipe since doing so throws away
    its exit code, thus an unexpected failure may go unnoticed.

The actual patch itself looks fine, and these comments about the
commit message are quite minor, thus there probably is no need to
re-roll (though feel free to do so if you think the bit of extra
polishing of the commit message is worthwhile).

Thanks.
