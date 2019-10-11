Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A0BD1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 01:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfJKBkc (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 21:40:32 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57656 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbfJKBkc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 21:40:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1BD0298ED1;
        Thu, 10 Oct 2019 21:40:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T+bgK4TgUSGS2FFpV90MMhNdwBk=; b=RzDsMD
        MLejoR6urYhjHo01VMWt/leg8Cqnbrd6P3Jw8ceWHPkSgrCL+wgmGwI2DseJu+Zy
        cBz2a9ffKDKW39A8qQLYph/+OLMll61iyGSUyyWM9zaziBZFo1uyUhnbpEwv4r0v
        NN5nGeiPz4kGddfEOLzYMOp9E6UVKIgZKS8Dw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=palfoESXnTt+CpUI2D0HDe4DIHoK/Gys
        qzhWNvVT/tDDtCBHYWRA+xTCZm2fLjOPSmMQ4vBaINXEis8fEpc8ERu859JWS4gR
        X8BH59wiRU/4MleMtA4Ui/ELeTEd2BsGScw9OpsSG9bqvWu6v/nn9vm4KSSEJOf6
        BlSUlahmWJg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 13DDB98ED0;
        Thu, 10 Oct 2019 21:40:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 40EAF98ECF;
        Thu, 10 Oct 2019 21:40:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, James Coglan <jcoglan@gmail.com>
Subject: Re: [PATCH 01/11] graph: automatically track visible width of `strbuf`
References: <pull.383.git.gitgitgadget@gmail.com>
        <4bc0a0596164212aa9d29d6dd0d7a0d8ab1b9dd0.1570724021.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1910102303330.46@tvgsbejvaqbjf.bet>
Date:   Fri, 11 Oct 2019 10:40:24 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910102303330.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 10 Oct 2019 23:07:35 +0200 (CEST)")
Message-ID: <xmqqbluojbzr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19F25018-EBC8-11E9-ACC1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This is a big heavy-handed: adding a `width` field to `struct strbuf`
> and maintaining it _just_ for the purpose of `graph.c` puts an
> unnecssary load on every other `strbuf` user (of which there are a
> _lot_).
>
> So my obvious question is: what makes `width` different from `len`?
> Since we exclusively use ASCII characters for the graph part, we should
> be able to use the already-existing `len`, for free, no?

A red-colored piece on the line consumes <RED><RESET> bytes more
than the payload.  Which is counted as part of "len".  These bytes
do not consume any display width.

When the payload is a basic CJK char in UTF-8 it may typically use 3
byte, while consuming only two display columns.

So I can understand that this application may want to keep track of
<byte sequence, byte sequence length, display width> tuple.

I also understand that a programmer inexperienced/unfamiliar with
our codebase may find it an easy way to satisfiy the need to add an
extra field to strbuf.  But as you pointed out, that is a hack
unacceptable in the larger picture.  Use of strbuf as "auto resizing
byte array, represented as a <byte sequence, byte sequence length>
tuple" is everywhere and we do not want to bloat it.

Thanks for spotting and raising this unfortunate show-stopper issue.
The problem being solved is worth solving, but it needs to be done
without butchering a basic data structure used elsewhere.







