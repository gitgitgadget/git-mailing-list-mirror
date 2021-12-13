Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1B5C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 21:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbhLMViG convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 13 Dec 2021 16:38:06 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:43595 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbhLMViG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 16:38:06 -0500
Received: by mail-pl1-f181.google.com with SMTP id m24so12102413pls.10
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 13:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kxnAcG2p0FFKD3H1OxcTRr8ZzMc7/sa/QIzsE6LHOLA=;
        b=M+i7nyTvyVGbll0qQspLL64vEvRWsBHyB02CPAYezJw5p46hgy7o4bi7PS9lvVq8FA
         UnHmCWOZlrHkuaGMyxDfARCC3f4Rc9mxKHd+Nryj/691G8uF6RP3H0EwIjcF6Cue+o02
         bVPYV3cGC7UzJi9gWZbltyteDaF47ObiWuB9Br/mWXlay2/QJODzFRUZBS72xtIMKkj5
         vc65FYVMOqbsU0/Uq06skYPDx7YL5QoVhd5Xzz0Z2ZFdvWUNMD1gc3FnUj5yjIZHT63u
         NQ4U4ybv8OKUXzQb7zWZ5Ii4TB8SYdLENRzAKdqab27wFTYYE23pCU+urF3vZX4G6arH
         ISAA==
X-Gm-Message-State: AOAM532NNdc4PbcbrM+zv6o6sEVNDSDla/9C9ZF/QmXO89cePoC1+DdZ
        3BJRSiqH1i3z52BVpSKPgxevynugNpVdksHOeXw=
X-Google-Smtp-Source: ABdhPJx5T7Lgeqwvj8ETcnoC6YnABF4ltljHtNuDLymQfqOw4vOpI+eM4v3SmwXGHRQn/l7aFmjL5Dq4VCm/SMS9rKU=
X-Received: by 2002:a17:90a:b107:: with SMTP id z7mr897566pjq.104.1639431485896;
 Mon, 13 Dec 2021 13:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20211213063059.19424-1-sunshine@sunshineco.com>
 <20211213063059.19424-6-sunshine@sunshineco.com> <20211213102224.y5psbojmivlxe5px@fs>
 <CAPig+cSKn6wdPKc=b8Xjqy5D=bVdu6FQtYKJuwN2VoV7pEEgHw@mail.gmail.com>
 <20211213154327.pmhopjbdlkz7dgjh@fs> <CAPig+cSXHBMgOUycL0cXuVCb_PJ2=x2w4wUkc7eQQueyk=0Uzw@mail.gmail.com>
 <211213.86tufc8oop.gmgdl@evledraar.gmail.com> <CAPig+cR5Q2q=wdXuVBeP52=pAfvh6_4z__g-0JUGWq_7uor_Hg@mail.gmail.com>
 <CAPig+cRkC=-dV_i1LJg3kZVVpR778YNyhpO6maHnH5zFH9zS6w@mail.gmail.com> <211213.86zgp470wa.gmgdl@evledraar.gmail.com>
In-Reply-To: <211213.86zgp470wa.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Dec 2021 16:37:55 -0500
Message-ID: <CAPig+cRrX396RRGGhjMDB6ybNa0WxcAOY-BfW4FTE84R+ucLkQ@mail.gmail.com>
Subject: Re: [PATCH 05/15] t/Makefile: optimize chainlint self-test
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 2:36 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Dec 13 2021, Eric Sunshine wrote:
> > Another less sledge-hammer approach would be to make t/Makefile
> > respect GIT_TEST_CHAIN_LINT so that it doesn't run `check-chainlint`
> > for `test` and `prove` when that variable is `0`. That would allow
> > your `git rebase -i --exec` case to avoid the wasted extra overhead of
> > `check-chainlint` (and chainlint in general).
>
> Yes, but I just don't see why it's needed.
>
> We need to build e.g. t/helpers/ to run the tests, and doing that is
> probably always going to take eons of compilation times compared to
> these assertions.
>
> But it's a one-off eon because we declare the dependency DAG and don't
> recompile them unless the sources or their dependencies change. Likewise
> for these chainlint tests we can (and maybe should) make them optional,
> but as long as we're not needlessly running them when no changes have
> happened...

That's a good point, and the same observation applies to
t/check-non-portable-shell.pl which is run unconditionally, as well,
whenever `test` and `prove` are run.
