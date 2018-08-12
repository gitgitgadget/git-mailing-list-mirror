Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E446C1F404
	for <e@80x24.org>; Sun, 12 Aug 2018 06:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeHLJVj (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 05:21:39 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36481 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbeHLJVj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 05:21:39 -0400
Received: by mail-yw1-f67.google.com with SMTP id v197-v6so11512395ywg.3
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 23:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7qLy47xtFag+aWgh5UQ0GrbnQpIYVZ3UOquE/+UsYMY=;
        b=LcjyrfnBk9+w3GukGOpC1ImS2VD3ZS8gDsYdBsJjIwSsBzOE0YdkMdb6ETyfY48flq
         XLopevRZp9lQRWidwpXsCkO/3huLifJVedFt0DZPwB6s5DcOLWxVYf39JL186x6W5hB7
         KzPrbsHyplw9YT4sIP8IfDa3ySjoONIg15+uGurxxilywC4S6DLrf32B9mgXzTExdoiL
         wgoB/de3VN3K4Arxl0wHUcoTPgtO5kXPc5dcf2p9bzpUd4/3f1IF5r8RLM/75xbk8pah
         ec9KHxwqGEnzJxZzLz22g/zS2Uuyfv2nvA/59j0iRVazarejjemfof4arsMv36e9U+n/
         L0VQ==
X-Gm-Message-State: AOUpUlH0PcGdkmoXfaqVkCrqtlYY5nXGrw+T1UhrUCBCyLAcq8+udnfD
        ADbJeTXlUO26HOcV5G0zfzdXCYPuyfP7RPJUQ/GJvEYq
X-Google-Smtp-Source: AA+uWPx5C/LV6sMnTX+GR/ce1wae3itpPy0djlmXWSCHpdLlpQ0Nt0uPwaiu3X7J2PomSXyvfhHtsnHOJO5wPXKZqY8=
X-Received: by 2002:a25:8806:: with SMTP id c6-v6mr4287180ybl.12.1534056281594;
 Sat, 11 Aug 2018 23:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAPig+cQK7JSosa0hNhgw7xoSui2f0m6yfRLWytsg_Zow3bN5bg@mail.gmail.com>
 <20180812040620.15298-1-wchargin@gmail.com> <CAPig+cTca5YsXeXYbEEuq8Y_GraUYWwzdKO7r+PR9=JRTR_xFA@mail.gmail.com>
 <CAFW+GMDu-FVFXZeB=fV5a+HyGXea-UoMpZS90T9b2G_=xd3iLw@mail.gmail.com>
In-Reply-To: <CAFW+GMDu-FVFXZeB=fV5a+HyGXea-UoMpZS90T9b2G_=xd3iLw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 12 Aug 2018 02:44:30 -0400
Message-ID: <CAPig+cQSg-t6KGj3s0LJi+FU7LSQMNTmSHhMJJH=PgMUU9GWOA@mail.gmail.com>
Subject: Re: [PATCH v3] test_dir_is_empty: properly detect files with newline
 in name
To:     William Chargin <wchargin@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 12, 2018 at 2:33 AM William Chargin <wchargin@gmail.com> wrote:
> > This is an abuse of test_must_fail() which is intended strictly for
> > testing 'git' invocations which might fail for reasons other than the
> > expected one (for instance, git might crash).
>
> Interesting. I didn't infer this from the docs on `test_must_fail` in
> `t/test-lib-functions.sh`. Sharness, which is supposed to be independent
> of Git, explicitly says to use `test_must_fail` instead of `!`.

This sort of knowledge is, perhaps unfortunately, spread around in too
many places. In this case, it's mentioned in t/README. The relevant
excerpt:

    Don't use '! git cmd' when you want to make sure the git command
    exits with failure in a controlled way by calling "die()".
    Instead, use 'test_must_fail git cmd'.  This will signal a failure
    if git dies in an unexpected way (e.g. segfault).

    On the other hand, don't use test_must_fail for running regular
    platform commands; just use '! cmd'.  We are not in the business
    of verifying that the world given to us sanely works.

It probably wouldn't hurt to update the comment block above
test_must_fail() in t/test-functions-lib.sh.

> I also see other uses of `test_must_fail` throughout the codebase: e.g.,
> with `kill`, `test`, `test_cmp`, `run_sub_test_lib_test`, etc. as the
> target command. Are these invocations in error?

Looks that way, even run_sub_test_lib_test().
