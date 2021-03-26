Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DBCC433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 01:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5326A61A42
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 01:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhCZBcg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 21:32:36 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:37492 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCZBcO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 21:32:14 -0400
Received: by mail-ed1-f41.google.com with SMTP id x21so4531516eds.4
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 18:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=75zNxjkmfWesrwczU6tYKV/WUhR74KpD8q3yyrXIS3Q=;
        b=hWugKmQnLbg8/QUAwvYtgc1FcyeOkZ/PeWA+kcR84v9LYkTGS8QE8nTbOARXyLlyLf
         iZM12yQANqAW7R07/8w58ahjhJmbELHduiVUHJ1XMBQBVwl5HZRhMIrrnybG5WM3GWQY
         74YtRXbZ7VGt1fqyCA4VLW+z0ZsOyUf9CJZ5tNHNG/l1pSbik3RD2Py51qg9PMiTeDMN
         uy3WUQnCkgVV3UOGNJjWH/ZhNJ4k8QMWgvxXmWJkgBfKnfIwtp32/RekdOXGrS5hBLRF
         QiIgFK0G14tiF1krEtByRL2aC38MfMgAXc2x7PpqwjOGVWskry9OXFsaBZ7nSkOk1kuK
         RqGg==
X-Gm-Message-State: AOAM532/NJPT2igs5rR62mLuc6HE5y8JN8B/WKNRe1Gh39FZBJaYsyK5
        GES16VrlF3QoqfMoNesSDVDxi2aKnDBPGfZF7xI=
X-Google-Smtp-Source: ABdhPJzjJgF3k6a5FxoGHgtNWY1V8PEKFvJ/dh/nuGaiZQ8tuYQbmR6Ri1EZj0UHTDg6lpgPav/bhuYzKGUOvoOHnx4=
X-Received: by 2002:a05:6402:447:: with SMTP id p7mr12240410edw.89.1616722333188;
 Thu, 25 Mar 2021 18:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqft1iquka.fsf@gitster.g> <20210325233648.31162-2-stdedos+git@gmail.com>
 <xmqq35wiu4om.fsf@gitster.g>
In-Reply-To: <xmqq35wiu4om.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 25 Mar 2021 21:32:02 -0400
Message-ID: <CAPig+cT3xprHLxDkvfgHpHY7t5_5_A2xyGKB5S2KiqW=3Lk-TQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pathspec: warn for a no-glob entry that contains `**`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>, git <git@vger.kernel.org>,
        =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos+git@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 25, 2021 at 8:43 PM Junio C Hamano <gitster@pobox.com> wrote:
> So, perhaps taking the first two paragraphs together and rewriting:
>
>         When '/**/' appears in the pathspec, the user may be
>         expecting that it would be matched using the "wildmatch"
>         semantics, matching 0 or more directories.  But that is
>         not what happens without ":(glob)" magic.
>
>         Teach the pathspec parser to emit an advice message when a
>         substring "/**/" appears in a pathspec element that does not
>         have a ":(glob)" magic.  Make sure we don't disturb users
>         who use ":(literal)" magic with such a substring, as it is
>         clear they want to find these strings literally.

I haven't been following the discussion, but is there a reason we need
to penalize the user with a warning rather than helping, for instance
by inferring ":(glob)" in the presence of `/**/` if not otherwise
countermanded by ":(literal)" or whatnot?
