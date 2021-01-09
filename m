Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049B4C433E0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE04D23B00
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbhAIWDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 17:03:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55386 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbhAIWDj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 17:03:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A429F11404E;
        Sat,  9 Jan 2021 17:02:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4kIIoGjTWiN9U1Ki/Xu1LhMf+cQ=; b=pjbmaw
        KvqC7QXAkKUiroNVLYLB0Awo2xHBJn5hT2H3PIg/IIa8hbesqhpZ+pHmHIE0dA3o
        8XgXwd6FJozkENhuIy8VtYi/RmwBZh27ldzYfVm+oCJG7TDmNpwXn7ueflSs7SiD
        r93fz2rz4G9LmincZEIUNrGO9kgtSgj6APoj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SuOLoP61E87w1EuEpEqCEs/kXHbu8ltm
        bEyPTCCFkHXDDe3kSUKstpGmwTns59dtNuStefOt8qLtYdXM2Sr4laKPpKNNNGhh
        DPAoTj0CzRIvWylbzyBJi5OgXN/Ps73eeLgqdVe4pXMjMBEEm6avJ/jGnb6iHHwX
        GQfwvWHMvSc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9CA4211404D;
        Sat,  9 Jan 2021 17:02:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0B34711404C;
        Sat,  9 Jan 2021 17:02:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 1/2] bundle: lost objects when removing duplicate
 pendings
References: <X/cqrTgilKAW9P9G@danh.dev>
        <20210108144514.24805-2-worldhello.net@gmail.com>
        <xmqqv9c6g8r4.fsf@gitster.c.googlers.com>
        <CANYiYbGR0ByQ4p9oqPvZCq=GFRpbFsHZETz-UwGc_amf1QmXYw@mail.gmail.com>
Date:   Sat, 09 Jan 2021 14:02:52 -0800
In-Reply-To: <CANYiYbGR0ByQ4p9oqPvZCq=GFRpbFsHZETz-UwGc_amf1QmXYw@mail.gmail.com>
        (Jiang Xin's message of "Sat, 9 Jan 2021 23:09:38 +0800")
Message-ID: <xmqq7dolg44z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C66E82A-52C6-11EB-8C89-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> 1. For those scripts which use  these shared functions include this helper like:
>
>         . ./test-lib.sh
>         # current directory changed, so add path prefix
>         .  "$TEST_DIRECTORY"/test-bundle-functions.sh

This one.  But without double spaces after the dot.
