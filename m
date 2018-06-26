Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BED081F516
	for <e@80x24.org>; Tue, 26 Jun 2018 19:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeFZTxG (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 15:53:06 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:43656 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbeFZTxG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 15:53:06 -0400
Received: by mail-yw0-f196.google.com with SMTP id r19-v6so6503718ywc.10
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 12:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AsqQmQB89ObgHnHBCNDZHfYNhT95Q/6XwCZvHgo9kQk=;
        b=P+TlukYHePSy1Yr499lkBiCnUAsI965djJaOhHoiTHnf7ciHHEmYxmxvLljk0i2Nc3
         VANqh9IRWifgxGiQbFoaRcLIZrbysSPdsi6AdiJ3Z6GnftTdyj+ofIthpDfM1mZCGgWx
         Z+UnHxQwUXgj4d9zYwP3qIEaoUObnV+Mq5ERKVSb62AaqaVJan963oYSpXwOnoqif100
         2vR/Esv583FpG9fD0ShZCQBHL2ef1szARvq6y9e0Vpn6Y+gvOz5uydcl0L10Tw46g9S0
         b8YjfDhTK4HIhxB2tDEGW5pZHMkzy8h34//zkFMKep6MZyBavxIgmlvbTyus2EANS0FX
         lBoA==
X-Gm-Message-State: APt69E1rs89IFMGamGON++N0EcyLTK2PDRlgZfkOmuftt2YTkLTSyMOH
        354fM8IPRqF1lEUpRbLahhSmdXk5E9e3HmiVtZ4=
X-Google-Smtp-Source: AAOMgpcDUKzKmMkhjv42zGjI/qAh+SwBTvIU6xXXRiRymujCTGP3GM/z/90bzbVbPBElZQXBh45/DDs6g5mfyNoj7uA=
X-Received: by 2002:a0d:c105:: with SMTP id c5-v6mr1460882ywd.131.1530042785430;
 Tue, 26 Jun 2018 12:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-30-sunshine@sunshineco.com> <xmqqwouljr5e.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwouljr5e.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Jun 2018 15:52:54 -0400
Message-ID: <CAPig+cSLyie8mr+u8Thv9cJ0J12nCA+RU6Mg3S5F8U68q1+nzQ@mail.gmail.com>
Subject: Re: [PATCH 29/29] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 3:15 PM Junio C Hamano <gitster@pobox.com> wrote:
> so, with --chain-lint, we would transform this
>
>         mkdir -p a/b/c &&
>         (
>                 cd a/b/c
>                 rm -fr ../../*
>         ) &&
>         statement 4
>
> into this sequence
>
>         (exit $sentinel) &&
>         mkdir -p a/b/c &&
>                 cd a/b/c
>                 rm -fr ../../* &&
>         statement 4
>
> and then rely on the non-zero exit to cancel all the remainder?
>
> We didn't create nor cd to the t/trash$num/a/b/c thanks to the &&
> chain, and end up running rm -fr ../../* from inside t/trash$num?

Yes, I did take that into account and, no, I don't have a good answer
to the issue.

The existing --chain-lint already suffers the same shortcoming. Older
(or even new poorly-written) tests, even without subshells, can fall
victim already:

    (exit $sentinel) &&
    mkdir -p a/b/c &&
    cd a/b/c
    rm -fr ../../* &&
    cd ../../.. &&
    statement4

As in your example, 'mkdir' and 'cd' are skipped, but 'rm -fr ../../*' is not.

This snippet from the commit message of bb79af9d09 (t/test-lib:
introduce --chain-lint option, 2015-03-20):

    When we encounter a failure of this check, we abort the test
    script entirely. For one thing, we have no clue which subset
    of the commands in the test snippet were actually run.

suggests that the issue was considered, in some form, even then
(though, it doesn't say explicitly that Peff had the 'rm -fr' case in
mind).

So, this isn't a new problem introduced by this series, though this
series may exacerbate it.

Thanks for thinking critically about it.
