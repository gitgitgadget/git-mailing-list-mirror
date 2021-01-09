Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7092DC433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 09:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E36223A3A
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 09:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbhAIJMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 04:12:02 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:36788 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbhAIJMB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 04:12:01 -0500
Received: by mail-ed1-f41.google.com with SMTP id b2so13661600edm.3
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 01:11:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2Bu+XLV2teRItaFyO4zuyjy60OZuzSbTf3JmrL/59I=;
        b=V7Xi5em8d0y2i+ZqhDWDl6OWftjXp7+WWM5gPDcr9MwKX660mxXDrokvYokwX40mDj
         Tcq/C9XXIps6AdZ1OBJhRUYh6FCpPGljLeF9Tn4xYt4v/nohgyqkQm82OlyB6iGbZlqo
         5hzb4ItGuRHt2/kRxSyaM7S+pICu9z+9lljHv1lMYVrAIuoUO9E2C5vTEmzo9hz3on2G
         +PJklIFtOkTOsnqGhnei7gXHwDSE9h6T8cdqN3Wc+UD7IvjIgJXUXGuyZpXRsO3/wBuN
         b8upG9+/iy01jye0YuDx7Kvodkiv4z63gzLntalI2bwllq2+W/MSPI63FzJGDVyVDXgD
         WAKQ==
X-Gm-Message-State: AOAM532KYyCLkNxTzMW/HE/Zt9ZcAnptrGB+zFw0GADeRLc7JLjouxXx
        fuCqzLgmSLFEwMkI2Dg7CIhYKyvVGLDbp9HnM0hzI3InkTaq+A==
X-Google-Smtp-Source: ABdhPJymRiGlOZ2BOBjhP8lNXJX8z0v4oi/8PuprHsHXngkc5ah1aqw8/ZY+J4Vy1Vpf2BXyN+dvuQLcz7Uo+87KHFw=
X-Received: by 2002:a50:9310:: with SMTP id m16mr8076624eda.94.1610183479917;
 Sat, 09 Jan 2021 01:11:19 -0800 (PST)
MIME-Version: 1.0
References: <xmqq35zbgd2a.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq35zbgd2a.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 9 Jan 2021 04:11:09 -0500
Message-ID: <CAPig+cQ3U4s0qmzoLL=ZBeSyCZm=QqjWz2P36ZUxMzNAyYn-WQ@mail.gmail.com>
Subject: Re: Is t5516 somehow flakey only on macOS?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 8, 2021 at 7:39 PM Junio C Hamano <gitster@pobox.com> wrote:
> I've seen this breakage only on "regular (osx-clang, clang,
> macos-latest)" so far, but that does not necessarily mean clang on
> macOS is miscompiling or anything like that.
>
>  https://github.com/git/git/runs/1671504998?check_suite_focus=true
>
> Any interest in helping to find out what's going on from folks in
> the macOS land?

Something seems to be dying prematurely. The code in question from
test #86 "deny fetch unreachable SHA1, allowtipsha1inwant=false" is:

    test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 \
        git fetch ../testrepo/.git $SHA1_3 2>err &&
    test_i18ngrep "remote error:.*not our ref.*$SHA1_3\$" err

In a successful run, the content of `err` is:

    fatal: git upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886
    fatal: remote error: upload-pack: not our ref
64ea4c133d59fa98e86a771eda009872d6ab2886

However, in the unsuccessful run from CI, it is:

    fatal: git upload-pack: not our ref 64ea4c133d59fa98e86a771eda009872d6ab2886
    fatal: unable to write to remote: Broken pipe

Perhaps this means something to someone familiar with this area of the code.
