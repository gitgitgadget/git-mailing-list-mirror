Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94A5C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 23:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB31A60FC0
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 23:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243368AbhIMXdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 19:33:40 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:38511 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240144AbhIMXdf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 19:33:35 -0400
Received: by mail-ej1-f53.google.com with SMTP id n27so24592289eja.5
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 16:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFHkL4j1X1Zmk2C1tF22KKckTW9Imz6tNQtGR8PfS6U=;
        b=16lwVWTy/2mkHmqzge1duMnUPIeIc6kIKc/lEWeSYJpIx+c6i8muY3T3ucTfI16DUm
         t0bk0HZqriK9oSRpHsOsCALF0UkN7jpkqKwQMCwi4brcl2GoTQOs047m2uza0uK6JXlE
         BFkUDyz4pStFr4sQdYFymvnbLTz1d4r8UnLfA1usJY9NW1UM9xrmmDf+32BPtw4GYdQw
         w5X8JdU/viRUBOF3gLkwGNAUUqEn8o4YRigAHUnkewFB9x6nGW8B2zhjldUFId/+yqgF
         wWMKAhCZSCqpYHv+27jZZX7zo5XHXr4xqxfDBAEHGB/xF7dpFNnpgCFn83DvzjzIBZtq
         C5Fw==
X-Gm-Message-State: AOAM533R38/loaImHXiuzkI1iTCUPOUFyMqdlZMhuzoY9pOwi3Qk8vL0
        S9OLrqM/OlUy6kXB+CbTuqlmk6dT2BsAITFW6rw=
X-Google-Smtp-Source: ABdhPJxkbuNRGW8qDimLdoPzDT4q6WKLloCW78hMM32gIvpie9e8Bk5VF8VsPi+ErMe9BPWV7HHbX89FUomDg5lLeE0=
X-Received: by 2002:a17:906:1484:: with SMTP id x4mr15492776ejc.72.1631575938643;
 Mon, 13 Sep 2021 16:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com> <20210913181221.42635-2-chooglen@google.com>
 <YT+mlW851sRyt842@nand.local> <YT/bfZu5mnMMqq0z@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <YT/bfZu5mnMMqq0z@chooglen-macbookpro.roam.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Sep 2021 19:32:07 -0400
Message-ID: <CAPig+cS2E6c9YYKTThPSVpyBkouoL+nK2rgpsZxNODPmTr2hzQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] fsck: verify commit graph when implicitly enabled
To:     Glen Choo <chooglen@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 7:19 PM Glen Choo <chooglen@google.com> wrote:
> On Mon, Sep 13, 2021 at 03:29:25PM -0400, Taylor Blau wrote:
> > > +        git config --unset core.commitGraph &&
> >
> > But I'm not aware of a way to temporarily unset a configuration variable
> > for the duration of a test, so here I would probably write:
> >
> >     test_must_fail git -c core.commitGraph= fsck
> >
> > which Git interprets as "pretend this variable is unset in-core".
>
> From my testing, I suspect that git does not pretend the variable is
> unset, but rather, it pretends that the variable is set to the empty
> string. It seems that git behaves as if the variable is set to "false".
> This is called out in Documentation/git.txt:
>
>   Including the equals but with an empty value (like `git -c
>   foo.bar= ...`) sets `foo.bar` to the empty string which `git config
>   --type=bool` will convert to `false`.
>
> If the variable really is set to false, how might we proceed here? Shall
> we stick with test_when_finished?

That's probably reasonable, however, for robustness, you should
probably use test_unconfig() rather than raw `git config --unset` to
clear the variable.

Aside: This certainly makes one wonder if we should have a new
function in t/test-lib-functions.sh which unsets a variable for the
duration of a test only. However, that's outside the scope of this
submission.
