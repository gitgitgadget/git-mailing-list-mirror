Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20948C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 18:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA6A611B0
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 18:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242621AbhIWSGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:06:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59469 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238811AbhIWSGx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 14:06:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3458E15F71F;
        Thu, 23 Sep 2021 14:05:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=mlWeSc8RGCs8Rv2lSGsQnShCD
        eKCyzydBLGG479QcXY=; b=VteU1RIuS9HuzlVi8khZuRBIWnWwS8hGwSXtDLwIC
        MrXReQWnSYVPu0P9iuBp3gA0cz3PQpccy7LIvo4drcBQTyYkiG16poJBh2mTlBbu
        GcZutyXtUm1FzIqe5zhYjADB0R0vKPDrKfFIXJAuEnxXmayi3K314ufdRhpyTr4H
        lk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D2CD15F71E;
        Thu, 23 Sep 2021 14:05:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8CFB915F71D;
        Thu, 23 Sep 2021 14:05:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 6/9] help: simplify by moving to OPT_CMDMODE()
References: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
        <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
        <patch-v3-6.9-b52269eeab9-20210921T223223Z-avarab@gmail.com>
Date:   Thu, 23 Sep 2021 11:05:17 -0700
Message-ID: <xmqq4kab182q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CFA4A494-1C98-11EC-B813-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> As preceding commits have incrementally established all of the --all,
> --guides, --config and hidden --config-for-completion options are
> mutually exclusive. So let's use OPT_CMDMODE() to parse the
> command-line instead, and take advantage of its conflicting options
> detection.

Sounds quite logical.

> I think this makes the usage information that we emit slightly worse,
> e.g. before we'd emit:
>
>     $ git help --all --config
>     fatal: --config and --all cannot be combined
>
>     usage: git help [-a|--all] [--[no-]verbose]]
>              [[-i|--info] [-m|--man] [-w|--web]] [<command>]
>        or: git help [-g|--guides]
>        or: git help [-c|--config]
>     [...]
>     $
>
> And now:
>
>     $ git help --all --config
>     error: option `config' is incompatible with --all
>     $

We often hear that our error messages for command line options are
unhelpful by being too broad, don't we?  I think the new one would
be much better by not scrolling away the most important part.  Those
who want to know about options other than --all and --config can
issue "git help -h" after seeing that single line error, but not
everybody has to do so.

> But improving that is a general topic for parse-options.c improvement,
> i.e. we should probably emit the full usage in that case.

Yes, absolutely.
