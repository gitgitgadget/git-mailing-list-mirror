Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449FAC433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 06:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06CB233EE
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 06:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbhAHGyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 01:54:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61130 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbhAHGyw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 01:54:52 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5243CAE4C1;
        Fri,  8 Jan 2021 01:54:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4DbiBHp6JpPASTpAx2M2F0vrk0g=; b=wCopvU
        m9uDKQTJviSNJ7UIgDdE7vUqfuUf0311eko1lQaIukBceyN/RnE32aq7iCZmJenB
        U1xQNi0bzL2gojb7u0Y17yoHPvP9lkiLF7DyhWXe4GDxuB6KoETFrMCWZiPgxGBC
        zkqpr4NnpTxIaqbvAGHzFL23SAvRkjkivsoUI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qfaa1yeY7bBUhUBcFntpmkhu4Lem0m8t
        9r5N6wuQ/WoTHGZc+eRXK7ywkSNsKwOM8TvC842arv5dz8wi3sEiOrCr1hjg4U6Y
        IDcWXCTu+dIuPoy9kn2sQ9x6NotqfBbbVw0310h8gIeBT4SrrKMrbZDDs+kgM0N8
        /1Ua6ENb6WY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4AD31AE4C0;
        Fri,  8 Jan 2021 01:54:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB6ECAE4BC;
        Fri,  8 Jan 2021 01:54:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 04/13] merge-one-file: rewrite in C
References: <20201116102158.8365-1-alban.gruin@gmail.com>
        <20201124115315.13311-1-alban.gruin@gmail.com>
        <20201124115315.13311-5-alban.gruin@gmail.com>
        <xmqq5z4th6ak.fsf@gitster.c.googlers.com>
        <30de2a29-a3fe-57f7-76b4-5d2bd3688635@gmail.com>
Date:   Thu, 07 Jan 2021 22:54:10 -0800
In-Reply-To: <30de2a29-a3fe-57f7-76b4-5d2bd3688635@gmail.com> (Alban Gruin's
        message of "Sun, 3 Jan 2021 23:41:06 +0100")
Message-ID: <xmqqwnwnj4vh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F9FC228-517E-11EB-9993-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

>> If we were to do that, then I do not mind the repetition of 0, 1, 1
>> too much.

Sorry, I think we will not need to see repetition of "0, 1, 1" if we
take the route I outlined above.

> Okay.  Are we sure we want add_merge_result_to_index() inside
> read-cache.c/cache.h?

I wouldn't be surprised if you can find a better place, so please
try to see if there is one.  If the only user ends up being the
merge-one-file itself and nobody else, then it may be a better
place.  Or perhaps merge-strategies.c turns out to be a better place
if other parts of the merge machinery can reuse it.

Thanks.
