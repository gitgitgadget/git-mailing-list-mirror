Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4C8C6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB65061029
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhGUWPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:15:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53677 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhGUWPo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:15:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 405E9C279C;
        Wed, 21 Jul 2021 18:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ev0O/dmv91Lb
        ZDv/VmnpuPADktG391+XnGBt6VbDkw4=; b=JGStjWRkSDlHiYV0uicdVAVV1k/i
        skfZ4jG7mYkDq+THOwaaDtC87OpNbaGw5uAVXjt+65Bf8pyWe+nrGZpWmsdJgstg
        PwXrrTf11GsgFRn44IaNCdzECjk9ja6CfpsOQwSy8Ocd2SOiwRG9pR6ckN0dWb9e
        /x2tptUSMV8TyTM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36BDAC2798;
        Wed, 21 Jul 2021 18:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE5A5C2797;
        Wed, 21 Jul 2021 18:56:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/5] http: drop support for curl < 7.11.1
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
        <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
        <patch-1.5-dcbb6f95652-20210721T220402Z-avarab@gmail.com>
Date:   Wed, 21 Jul 2021 15:56:19 -0700
In-Reply-To: <patch-1.5-dcbb6f95652-20210721T220402Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 22 Jul
 2021 00:22:12 +0200")
Message-ID: <xmqqwnpjb7jg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DCDB3F5A-EA76-11EB-A641-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> From: Jeff King <peff@peff.net>
>
> Drop support for this ancient version of curl and simplify the code by
> allowing us get rid of some "#ifdef"'s.
>
> Git will not build with vanilla curl older than 7.11.1 due to (at
> least) two issues:
>
>   - our use of CURLOPT_POSTFIELDSIZE in 37ee680d9b
>     (http.postbuffer: allow full range of ssize_t values,
>     2017-04-11). This field was introduced in curl 7.11.1.
>
>   - our use of CURLPROTO_* outside any #ifdef in aeae4db174
>     (http: create function to get curl allowed protocols,
>     2016-12-14). These were introduced in curl 7.19.4.
>
> We could solve these compilation problems with more #ifdefs,
> but it's not worth the trouble. Version 7.11.1 came out in
> March of 2004, over 13 years ago. Let's declare that too old

13+4=3D17; in 2/5 you say 2006 is 15 years ago, and I think this
should be updated, too.  Is 21-4=3D17 close enough?

> and drop any existing ifdefs that go further back. One
> obvious benefit is that we'll have fewer conditional bits
> cluttering the code.
>
> This patch drops all #ifdefs that reference older versions
> (note that curl's preprocessor macros are in hex, so we're
> looking for 070b01, not 071101).

Yup.  I sense that we'd be dropping anything older than 7.19.4
because nobody complained about our dependency on CURLPROTO_* for
the past 5 years?
