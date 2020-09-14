Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF224C433E2
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72ED3208DB
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KvYO0V1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgINUH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 16:07:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59330 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgINUHx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 16:07:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF5DA10485C;
        Mon, 14 Sep 2020 16:07:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=P68CxvWvwlo+NrXVREviflHF6V0=; b=KvYO0V1ZII9dqTlHgU7R
        8QIjg4iju46XgiCi7uko7xcI9vixEMK3/w5JpQcoPUdnRbdqVHKxpIghbhA2yJNj
        C/+tfbFWFQsFsnlidlM+WTz+FoBc6hny17UswfejMj0p75tZcoTqe7skpHI5KZDy
        Ih7/xOM/rjp8B4WnzZTgO14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=nYHz6TGSdrbbipA3Nql1ememxgcdWxf+0AarxE8HxzOc8R
        B1ES+o6hxZzPZh8dNwCzgbQyYA55sq2wRtTw9cmc/xtXKQQEWZcMA2KDNL7IxQo3
        XDoNXfNQtO3hyN/u/5fNt6KjNbIf2IbjWB977E1X/JZzjwaCcJjmnwPiHazYU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 882DE10485B;
        Mon, 14 Sep 2020 16:07:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F5FD104857;
        Mon, 14 Sep 2020 16:07:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
        <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet>
        <xmqqr1rcxdsu.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009090542430.54@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2009101220400.56@tvgsbejvaqbjf.bet>
        <xmqqsgbpr8oc.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009120016310.56@tvgsbejvaqbjf.bet>
Date:   Mon, 14 Sep 2020 13:07:39 -0700
Message-ID: <xmqqy2lcjf5g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1B09DEE-F6C5-11EA-B5D4-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Thu, 10 Sep 2020, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> >> In contrast, when you want to make sure that you _actually_ incorporated
>> >> the revision that is currently the remote tip, e.g. via `git pull
>> >> --rebase` with a possible additional rebase on top that makes this _not_ a
>> >> fast-forward, you totally have to force the push, otherwise it won't work.
>> >
>> > Maybe `--force-if-incorporated`? Originally, I had in mind to call it
>> > `--safe-force`, but that might be too vague.
>>
>> Yup.  "safe force" indeed feels like a misnomer.  The assumption of
>> safety relies heavily on the workflow.
>>
>> I might even say --force-if-merged even if the way the to-be-lost
>> changes have become part of what you are pushing out is not
>> technically a merge, but there may be shorter and sweeter way to
>> express it than 'merge' and 'incorporate'.
>
> You're right, `--force-if-merged` is a much better way to put it.

I am pretty happy that Srinidhi chose 'included', which is what
seems the best description without being a white-lie that is
technically incorrect.
