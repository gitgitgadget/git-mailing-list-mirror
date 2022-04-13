Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901E1C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 22:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbiDMW6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 18:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbiDMW6k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 18:58:40 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BB15A586
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 15:56:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0030919CFE7;
        Wed, 13 Apr 2022 18:56:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=anoXdy4bHvlI22acqyLvbzlHzImyjdQMRVzGMT
        b1hPU=; b=GGiyTn3g3usUuqU4e9LeiJJ+hHvOy08TWuoqk874oW9IoYgfcCmHjp
        rgPZ91zoNOzT/O2Zc5y+/5N9lnMAnkP7q/pnlEImGJ+YMMmNeiYF/wNFoOTYiwX1
        /QiXs9ER+Z1C92bDNOpTgEry1uzMQdwQTg/HBhhb7KzItO6JjT0xE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EDAC819CFE6;
        Wed, 13 Apr 2022 18:56:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5174B19CFE5;
        Wed, 13 Apr 2022 18:56:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Subject: Re: reference-transaction regression in 2.36.0-rc1
References: <CAGyf7-GYYA2DOnAVYW--=QEc2WjSHzUhp2OQyuyOr3EOtFDm6g@mail.gmail.com>
        <CAGyf7-GaoBarXD2xKG3KUXwGZgbhKgv-4Mz45achbr6G9ihTBQ@mail.gmail.com>
        <220413.86r161f3qp.gmgdl@evledraar.gmail.com>
        <xmqq4k2w92xo.fsf@gitster.g> <xmqqilrc61te.fsf@gitster.g>
Date:   Wed, 13 Apr 2022 15:56:14 -0700
In-Reply-To: <xmqqilrc61te.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        13 Apr 2022 15:44:29 -0700")
Message-ID: <xmqqbkx4619t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC1F4088-BB7C-11EC-96DD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Reverting the merge 991b4d47f0a as a whole is an option.  It might
> be the safest thing to do, if we do not to want to extend the cycle
> and add a few more -rc releases before the final.

It turns out that this involves nontrivial amount of work to get
right, as the bottom commit of Patrick's "fetch --atomic" series
wants to count how many transaction we make, instead of ensuring
that the updates to the references are all-or-none, so at least
2a0cafd4 (fetch: increase test coverage of fetches, 2022-02-17)
needs to be reverted as well.  This in turn is made unnecessarily
more cumbersome as the history in the t/ directory is littered with
unrelated "clean-up" patches since these topics were merged.

