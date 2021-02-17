Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C45C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 23:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC4A64E2F
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 23:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhBQXXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 18:23:18 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:36682 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhBQXXO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 18:23:14 -0500
Received: by mail-ej1-f42.google.com with SMTP id do6so115991ejc.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 15:22:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3GbWbFhp3LuHzdellIdEfXWjUpxPyCjJPIhKKpssi0=;
        b=VuZ2ELkv9xUVcNe2av5hJddv1zjrrttYMXkjk7huxUfkclgEcOovhD4f8nR4W9i1ay
         xQyqyCwhjGUsuvxOba3NjwtncffvG6wOkBmpHPxWXkIW/UNjfPvsKSYd/M3RCVT6p7K8
         s2F0Zn5Lo3yZC4CtxHNPehTXjOcvcm8VvrUa2EFuSO7am+crYwnUVhIrxzZdsTtPA0I+
         g36SNhKc4O5/vAHoeYyS0BT2Jf9RDx/Xkzm0Y6DrUOJ03ea64ugSmUOEVmIu/OAzGpPe
         pRcCe+7RGug/p4cfPmk0LUFi/NLdsnv16Vz13vHjSegkV9KAhFhS1Y14fH6Mbzlwuuvn
         ayeA==
X-Gm-Message-State: AOAM533Xb+Su1xsEakpfv8wRdCSfIEsQHoGPePijRAS48BAsoLXjI4HV
        1opDbsbqzF8h4s1yWYpGSWVo3lL7ZcU8UHcKOvzybwITbxA=
X-Google-Smtp-Source: ABdhPJweHs4bZmOs7YxX9CdovyJ+qK1EZ1jncHKoDOlBzwbX4tEirpzh2dmOnhdKC/vT0W1dOueDfKuc1DiXGSefrVA=
X-Received: by 2002:a17:906:3105:: with SMTP id 5mr1295660ejx.168.1613604152935;
 Wed, 17 Feb 2021 15:22:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613593946.git.matheus.bernardino@usp.br>
 <6e30f133e234ff1d3a29f36423cd3fdca58d8095.1613593946.git.matheus.bernardino@usp.br>
 <xmqqpn0yi9ii.fsf@gitster.g>
In-Reply-To: <xmqqpn0yi9ii.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 17 Feb 2021 18:22:17 -0500
Message-ID: <CAPig+cT_ASSSe0jzEWiW_EPEa5FfHigfM+6fGQyG_kwj57XPfQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] t3705: add tests for `git add` in sparse checkouts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 6:04 PM Junio C Hamano <gitster@pobox.com> wrote:
> Matheus Tavares <matheus.bernardino@usp.br> writes:
> > +for opt in "" -f -u --ignore-removal
> > +do
> > +     if test -n "$opt"
> > +     then
> > +             opt=" $opt"
> > +     fi
> > +     test_expect_success "git add$opt does not update SKIP_WORKTREE entries" '
>
> The above is cumulative, and as a consequence, "git add -u <path>"
> is not tested, but "git add -f -u <path>" is.  Intended?  How was
> the order of the options listed in "for opt in ..." chosen?

I may be misreading, but I don't think this is cumulative (though it's
easy to mistake it as such due to the way it inserts a space before
$opt). My interpretation is that `opt` gets overwritten with a new
value on each iteration, and it is inserting the space merely to make
the test title print nicely. A more idiomatic way to do this would
have been:

    for opt in "" -f -u --ignore-removal
    do
        test_expect_success " git add${opt:+ $opt} does ..." '
