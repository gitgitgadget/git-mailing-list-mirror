Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA0FC4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 12:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJRMl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 08:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJRMl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 08:41:28 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ACEA87A7
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 05:41:27 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a26so31845569ejc.4
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 05:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtdMpJ2dEFP7a3akn78DcV6Q+K7fMtOzoynREjM9jIs=;
        b=ul873+J2pp7oPAk0p+Rn4/zxCCON4J5BV7+U7dpJL8EpMPIUXTi4jxlDT2b7uqxRuj
         MKUNg5MjgqJSQPrAj/AEldJBixFt/mt4QqEH5zEVqQYRxn6DFtTW6A9s2McR6h4KWOuT
         1QXxT9QDDQG0t+di+3aAL39KNb4VKXh3I2EjJvKsrMjZtV4Cs3N68bHDgnuD+KVdTjHf
         jLXE4vHk3NTtoL6UAMOLgX6pIEOVUz7yrhWkpok4uPUfB5/gDL4Um8kdHa/OgrNLp3Io
         HRmthgGjM4jpnqA22QBZHULOIZxI5v0RUl5Lf1qwcArGX3jK4VGkR9bcbXk6GnUyKnUH
         mzLw==
X-Gm-Message-State: ACrzQf1B0TTX5UXVsmeMVbSJUaN5+pILhTNa1NHDeVI+mQjpjHUbqguT
        uA4xi1lm5eLJl3Y94o7wySq2C1oZKgjxVF+SkSiS2/P0g6w=
X-Google-Smtp-Source: AMsMyM7TspjrXZR+qgqDGGLOCefEQ+B1gtGNI24HAMVIl4UFNuqZ0UXpGBTtj4ygsYrgbtLBbxVyF43AqF+Q+nDUKYs=
X-Received: by 2002:a17:906:5a4b:b0:78d:8790:d4a1 with SMTP id
 my11-20020a1709065a4b00b0078d8790d4a1mr2231121ejc.329.1666096885934; Tue, 18
 Oct 2022 05:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <CA+JQ7M-CN0UnHQDDDVz0kPcU1AcoL9+WFOeR8eiw_B=Yiyc-CA@mail.gmail.com>
 <221012.86mta1mmli.gmgdl@evledraar.gmail.com> <CA+JQ7M-y9d=c3GbpAs+Y4qtimtVs9oQ6BU1YL8nmFmF=rZxKag@mail.gmail.com>
 <221013.865ygomybw.gmgdl@evledraar.gmail.com> <xmqqlepjivv4.fsf@gitster.g>
In-Reply-To: <xmqqlepjivv4.fsf@gitster.g>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Tue, 18 Oct 2022 14:40:48 +0200
Message-ID: <CA+JQ7M_BoDbLM5_0Gvqfy0TTT_=4tvxG7mi+1ZYSNDTkSEoR6g@mail.gmail.com>
Subject: Re: [BUG] git fetch fetches tags matching negative refspec
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2022 at 5:31 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> It indeed is confusing and might warrant some clarification, if not
> updating.
>
>  * "--tags" is equivalent to giving "refs/tags*:refs/tags*", so it
>    might be natural to expect that you can say the same thing as
>    above with "fetch $URL --tags --no-tags", but it does not work
>    that way.  Command line parser treats "--tags" and "--no-tags" as
>    if they follow the "last one wins" semantics.
>
>  * As discussed in this thread, what "--no-tags" really means is "do
>    not follow tags"; there is no way to countermand a "--no-tags"
>    earlier on the command line to say "earlier we said do not
>    follow, but we changed our mind.  Please do follow tags".

Thank you for the clarification.

What follows is a small write-up of my problem for posterity and
in-case someone else finds it useful.

What I'm trying to achieve is by default excluding a set of tags auto
generated build tags from being fetched, unless I specifically fetch
them.

Something akin to this works
  [remote "origin"]
      url = git@github.com:git/git.git
      fetch = +refs/heads/*:refs/remotes/origin/*
      fetch = ^refs/tags/v2.9.*
      tagOpt = --no-tags

This lets me
  git fetch
  git fetch origin master
without fetching tags matching the negative refspec, as expected. As
well as override it through
  git fetch origin '+refs/tags/v2.9.0*:refs/tags/v2.9.0*'
which isn't super friendly to write but does the job


Earlier in the thread, I was under the impression --tags worked better
than --no-tags. It seemed it would avoid clobbering tags. I don't
think that's actually the case (they both clobber?) and it turned out
it wouldn't exclude refs if I was fetching a specific ref, ie
  git fetch origin master
would also fetch the tags I didn't want. So --no-tags it is
