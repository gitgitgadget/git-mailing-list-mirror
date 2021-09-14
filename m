Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F94C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7DC610F9
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhINRyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:54:44 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:35625 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhINRyl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 13:54:41 -0400
Received: by mail-ej1-f46.google.com with SMTP id i21so240013ejd.2
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 10:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bf+2ZuEzCfPvPD0JDtppisrziPiiLjv2hwhDberEXiM=;
        b=i104NJsWrpizIOETtkDVt1LtYfnfPh5sftWEqre0TaJrAZ5Nxyv6REM5iM/jN68gm6
         BbMFycqb5xmB7QKpVBmHUHIb1jTeGAmp/cqTIpY0U/7CZuJtID1QXBZG5ciMvz2f4668
         SU1t4L16qeWPgStGPcOgJUefiOrTGw32hetvu8UuJl4npvpusOS0qBaA8+Vqo71hvGf/
         yCoHKV2HMDlH+Ko/tVpZIv8MVuGs8hNzAoyTLjxlG7prcKZQwJYOKO1Vk37Ki9ppKO8j
         +S1LtlhNI2zDO7Hi3TJCDLKyVs8tP0AyYOFfSbxOmYkXwOtoxxJXYBUhD2fY65orbFtX
         GGzQ==
X-Gm-Message-State: AOAM530hbfM65EvABrr124kYN/KPU2+GawUVpHl2LdO7UgQUUjyAI3SR
        /dXet3HQlwD+WZseRtizOs61ghiezq73YA2IRXU=
X-Google-Smtp-Source: ABdhPJwSYQsyrodVF3TF3QWAVQoTLG4yTIT2QZSIRRGSQlJxU0Sxr9lWG8gydhA1Tae9uVA85URxlZfBeLNfQpqVFzQ=
X-Received: by 2002:a17:906:1484:: with SMTP id x4mr20038836ejc.72.1631642002701;
 Tue, 14 Sep 2021 10:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210913185941.6247-1-alban.gruin@gmail.com> <CAPig+cR=HUDgFctXzcigZ062c=QWYfGWUPuT7scc-xU_w3NT1w@mail.gmail.com>
 <26422bc7-f1d4-4959-ce30-b26d8fe61888@gmail.com> <CAPig+cRGzmN6tH-5DmtnbW2cMHSSQ2RS_6d=B0xJ7QWKtG6yug@mail.gmail.com>
 <d02c7f3b-221d-fbab-827a-a950bf28856c@gmail.com> <xmqqbl4v2gpu.fsf@gitster.g>
In-Reply-To: <xmqqbl4v2gpu.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Sep 2021 13:53:11 -0400
Message-ID: <CAPig+cTQNkwWgpgu-Mw=Qd++cUVnFrrdnaQnaSZ79RexnNQFHg@mail.gmail.com>
Subject: Re: [PATCH v1] git-clone.txt: add the --recursive option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 1:46 PM Junio C Hamano <gitster@pobox.com> wrote:
> I am wondering if it is just a matter of either
>
>  * removing the "recursive" alias from the options table.  Because
>    we accept unique prefix, --recurse=<arg> the user types will be
>    taken as --recurse-submodules=<arg> anyway (until "git clone"
>    learns another option --recurse-xyzzy=<arg>, at which time it
>    will become ambiguous and error out, that is).

With this option, we risk breaking existing tooling which happens to
use the deprecated --recursive.

> or
>
>  * adding the PARSE_OPT_HIDDEN bit to the OPT_ALIAS() element for
>    the deprecated "recurse" option.

I was going to suggest this as a possible way forward to address
Alban's most recent response to my response. The lack of
PARSE_OPT_HIDDEN on OPT_ALIAS() almost seems like an oversight.

> Between adding "--recursive" to the manual and describing it as a
> deprecated synonym for "--recurse-submodules", and not doing so, I
> do not have a strong preference.

I don't have a strong preference either, especially considering how
long ago --recursive was removed from the manual, however, adding it
would help someone who runs across --recursive in existing tooling or
old blog post and wants to know what it does.
