Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 956AC1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 21:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeGBVNB (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 17:13:01 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:40214 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbeGBVNA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 17:13:00 -0400
Received: by mail-yb0-f193.google.com with SMTP id y11-v6so2113139ybm.7
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 14:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zUfaU9fO7Ww4IFHS1NRMCGl8PkWIeEfCDT8I/9vVecQ=;
        b=omlB7I6p44ZlN5AlqKAsUmU4ETeCO49S7iT2QF7QVmXnSNV7qCEH5h8X7taxFbn4UA
         UE/34Y74//f4DoednnmAALW3DMdZZ6AXKcM0EFhoikgXvhThhreKiMRl8xQqTfZVT0ej
         dIl4Ow5sJdEoMmi5Wy9gynf+W6t8f1FB/z8hY4Fg5eQimJyRf46BYSRxZpHdtoF+1WS8
         gOdNcc/u4xoVY63YhLDN2b95Gvw92u0c1e623IeUN/DXE4r+cetQqS1DPVoNrP4vnEWJ
         VRib+Ciy6O3wHvY3ZUvDTCapdGoJSDzlDK/fW4suGmTmPViKxNF+suabbdMTsWAcm5gs
         y9Iw==
X-Gm-Message-State: APt69E1u8LInBdcuJhV30IidhqxUjI4utCRMOWtL3TE38AC4s9ofXl3Z
        vJagus66lSlwzy2hqp3RRAk9UZwN9vMqxBkD1U4=
X-Google-Smtp-Source: AAOMgpdX9MpAwHX4H+OBz3XtIPG8mKsK/iPK9o2dsQL1Mj1c0KvMKtCduuB1wH4oJ73d/ipEuFZyEb0hsniJhZrW6oc=
X-Received: by 2002:a25:ac44:: with SMTP id r4-v6mr3235639ybd.497.1530565980327;
 Mon, 02 Jul 2018 14:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180702002405.3042-1-sunshine@sunshineco.com>
 <20180702002405.3042-13-sunshine@sunshineco.com> <CAGZ79kZFSAe1NL3EVKtbSm6E9PvhajWdrrbwDNMm2K5FRH7m-Q@mail.gmail.com>
In-Reply-To: <CAGZ79kZFSAe1NL3EVKtbSm6E9PvhajWdrrbwDNMm2K5FRH7m-Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 2 Jul 2018 17:12:49 -0400
Message-ID: <CAPig+cTr_nCYkGn6DVtODOa+ufsr4V006FmdvqL63PzvpARvUA@mail.gmail.com>
Subject: Re: [PATCH 12/25] t7810: use test_expect_code() instead of
 hand-rolled comparison
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 2, 2018 at 2:14 PM Stefan Beller <sbeller@google.com> wrote:
> On Sun, Jul 1, 2018 at 5:25 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> >  test_expect_success 'grep from a subdirectory to search wider area (2)' '
> >         mkdir -p s &&
> >         (
> > -               cd s || exit 1
> > -               ( git grep xxyyzz .. >out ; echo $? >status )
> > -               ! test -s out &&
> > -               test 1 = $(cat status)
> > +               cd s &&
> > +               test_expect_code 1 git grep xxyyzz .. >out &&
> > +               ! test -s out
> >         )
>
> Further optimisation would be possible if I understand the code correctly:
>
>     test_expect_code git -C s grep xxyyzz .. >../out
>     test_must_be_empty out
>
> (dropping the subshell entirely)

I did consider dropping the subshell in favor of -C, however, decided
to keep it since the subshell has value by making it very explicit to
the reader that this git-grep command is running in a subdirectory
(which is what this test is all about). Contrast that with -C which is
easy to overlook and might not fully convince the reader that the
command's entire execution is within the subdirectory, whereas there
is no question that the entire execution of git-diff in "(cd s &&
git-diff ...)" occurs in the subdirectory.

I can make the test_must_be_empty() change if I re-roll.
