Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0697A1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 20:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbeG3WC1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 18:02:27 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:36974 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeG3WC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 18:02:27 -0400
Received: by mail-yw0-f170.google.com with SMTP id w76-v6so4884627ywg.4
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 13:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNvZ7IeKpkzbzzmAWKBVPiRq4UX48s8JU339QqgHJFk=;
        b=jPD05u5zcCqfHr71lIAB/U4zZAbTMqRGaA6eGbm4+Jud/jdbl7kUlHPoanmbagVaZj
         B1v9GuF+saqIvI6Bk3bJMvWaSfR8Seabmm6hOwRjPOxxHS3QuduSqWQ5arokzM8imevC
         iDQGKXEB2Ty4q4QrSLk27G3kwev/k6SieLNXVA6slxWQeA96gPwFXDzMZWp3HxUGrfEX
         Dve4uD3CwDqMLrfG3NDH6NU9T79aQawlAhqCG3xK7osisQijgQR386GiuOVwplZxS7jQ
         kEQgo6RkB566T0K8jGMvSsYMI99+AehkfEHzpJWg7NhEscnn8L4Yhw+62tOEcslnZNfI
         pu5A==
X-Gm-Message-State: AOUpUlFc5Xbnh926MhKv+3Go0avaf4AdNdySBzcdtF6Ercy4GP+dwrbU
        X8l7Oje7Zj5fA0zT1l64HUmQHapyRxy7Yfa8D6U=
X-Google-Smtp-Source: AAOMgpf0/gGBAqkaLNWMngeA1F2KVnCtd/2ACuL0koS4A47NAu4OSb/kgtRE3dW6PL7IF8EwpjZPnghZLV0vIs7GSvs=
X-Received: by 2002:a81:4153:: with SMTP id f19-v6mr9748720ywk.418.1532982346320;
 Mon, 30 Jul 2018 13:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com> <20180711064642.6933-2-sunshine@sunshineco.com>
 <20180730181356.GA156463@aiede.svl.corp.google.com>
In-Reply-To: <20180730181356.GA156463@aiede.svl.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Jul 2018 16:25:34 -0400
Message-ID: <CAPig+cRFMKBQVVYjhS6-Yyy-aQCYXGiqG6XoqucJoedCvAzheQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 2:14 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> Eric Sunshine wrote:
> > Address this shortcoming by feeding the body of the test to a
> > lightweight "linter" which can peer inside subshells and identify broken
> > &&-chains by pure textual inspection.
>
> This is causing contrib/subtree tests to fail for me: running "make -C
> contrib/subtree test" produces

Thanks, I forgot that some of 'contrib' had bundled tests. (In fact, I
just checked the other 'contrib' tests and found that a MediaWiki test
has a broken top-level &&-chain.)

> The problematic test code looks like this:
>
>         (
>                 chks_sub=$(cat <<TXT | sed '\''s,^,sub dir/,'\''
> $chks
> TXT
> ) &&
>
> Ugly quoting, useless use of "cat", etc, aside, I don't think it's
> missing any &&.  Hints?

Yes, it's a false positive.

The subshell linter would normally fold out the here-doc content, but
'sed' isn't a proper programming language, so the linter can't
recognize arbitrary here-doc tags. Instead it has hard-coded knowledge
of the tags commonly used in the Git tests, specifically EOF, EOT, and
INPUT_END.

The linter also deals with multi-line $(...) expressions, however, it
currently only recognizes them when the $( is on its own line.

Had this test used one of the common here-doc tags _or_ had it
formatted the $(...) as described, then it wouldn't have misfired.

I could try to update the linter to not trip over this sort of input,
however, this test code is indeed ugly and difficult to understand,
and your rewrite[1] of it makes it far easier to grok, so I'm not sure
the effort would be worthwhile. What do you think?

[1]: https://public-inbox.org/git/20180730190738.GD156463@aiede.svl.corp.google.com/
