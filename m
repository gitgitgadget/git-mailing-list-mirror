Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DECD51F461
	for <e@80x24.org>; Wed, 21 Aug 2019 15:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfHUPkx (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 11:40:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60679 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfHUPkx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 11:40:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61B4E16C486;
        Wed, 21 Aug 2019 11:40:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5LkjP/sD2tu5+TJl7ZLJj23ltmE=; b=b4ekzQ
        j0Y/Ib6yQOw8idY/ei8N7iTYKA1acUfgt6VSHD/rFPP5725jtsD6JIZvl3i0WgTw
        PqwN6AANZTsN3Xujs9YnLvHQ2TlL6LxGJ8C0bgxyiVkSfRBOh2VPQ1+zHOY6ebYI
        YNC3IniqTqILC23evAX6Nk9fjoT7UcOOyKzyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M2DNQYw64ZMXZ2dwWBnP4GbwBTEfCrxQ
        1MeNkfOLONbaBhkP3UXjaNGPga17ey4LDpjzxowefMcQsNWxIVG9CCRzJDLzOT54
        AyhTZTOum+EkyANF9RIizglQ6z1/J/vbZG4W3vSFodahrlGvsL4WI37lsCabSsuC
        /Qkhef17lSU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59B0716C484;
        Wed, 21 Aug 2019 11:40:51 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4B6616C482;
        Wed, 21 Aug 2019 11:40:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        johannes.schindelin@gmx.de, larsxschneider@gmail.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH] t0021: make sure clean filter runs
References: <20190820065625.128130-1-t.gummerer@gmail.com>
        <xmqqlfvnvhpl.fsf@gitster-ct.c.googlers.com>
        <20190821145215.GA2679@cat>
Date:   Wed, 21 Aug 2019 08:40:49 -0700
In-Reply-To: <20190821145215.GA2679@cat> (Thomas Gummerer's message of "Wed,
        21 Aug 2019 15:52:15 +0100")
Message-ID: <xmqq36huttku.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D9D3050-C42A-11E9-86EA-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> It will also check the contents if the mtime is greater than the
> timestamp of the index, so the 'touch' here would also cover that.
>
> So the changes here do solve the race completely.

OK, the explanation makes sense.

Either test.r has been correctly checked out and has an older
timestamp or a more recent timestamp. In the former case, the index
knows that we did not touch it, so the next "checkout" knows it does
not have to ask the clean filter to work on it.  In the latter case,
the index is unsure if we touched it (or, suspects that it has
updated contents in it), so the clean filter needs to read from the
working tree to see if we did change it (and we find it is not
modified).  The outcome at the higher level, the answer to the
question "checkout" wanted to ask, is the same: test.r has no local
modificaiton and we can switch branches safely.

And that is already validated by seeing what exit status "checkout"
gives us, so it sort-of feels to be testing a bit too low level
implementation detail to see on which paths the filters are or are
not called, but that is not a problem with this fix.  If we want to
check at that level, we should do so correctly, and making sure that
the test.r file has recent timestamp to convince "checkout" that it
needs to verify contents is the right thing to do.

Thanks.
