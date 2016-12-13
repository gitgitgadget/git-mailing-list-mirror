Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A609B209B5
	for <e@80x24.org>; Tue, 13 Dec 2016 21:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933593AbcLMVyW (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 16:54:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56158 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932767AbcLMVyV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 16:54:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 257C7572F3;
        Tue, 13 Dec 2016 16:54:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cMFOkuNQcxCNu6KArnXeRgWCWI0=; b=Xbrk2B
        VoxGxaBdvImZPahYzBmYTf0Xjr+b6gACbcqiQRttGLoJbihZIDuI7X3Iwtmmyr6P
        VAIG3L/gC6wNOi8uRnb8AzcV+yFrU5WrzozNd2nUAGz/tTgDMAetWk3DS5FaJOir
        126ysZ4GiJ3lFnsXHYQdTehZ9jt4853Lw6Rl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gLtSPT3b3hfJLakn4Rw6oZI+QAhWZmiT
        HdOwGOQsSpr8zF6lXBcljhjAgJPGhtuJ1iuTCiWysTfa2QaNsfI4TUNZVtbLtrGQ
        ktBNueYlpVXHbgZuPgI55CZgOtK9fgOlAeFYl7RlCHJBITXTu6rvVGWOISjeFvqt
        VdnosmFf8rw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DB11572F1;
        Tue, 13 Dec 2016 16:54:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8A3DF572EF;
        Tue, 13 Dec 2016 16:54:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 02/34] sequencer (rebase -i): implement the 'noop' command
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <934c8e420cc4a75b1f3e4489fa4a4135c48f78ae.1481642927.git.johannes.schindelin@gmx.de>
        <xmqqfulr1s5z.fsf@gitster.mtv.corp.google.com>
        <CA+55aFzxFFNY+dL6s7dLZeVXBsBKD0aeof5Bj2wcD1CpefVSAA@mail.gmail.com>
Date:   Tue, 13 Dec 2016 13:54:17 -0800
In-Reply-To: <CA+55aFzxFFNY+dL6s7dLZeVXBsBKD0aeof5Bj2wcD1CpefVSAA@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 13 Dec 2016 12:48:31 -0800")
Message-ID: <xmqqtwa7ze9i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B27B1FC6-C17E-11E6-A9F5-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Dec 13, 2016 at 12:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>>> +/*
>>> + * Note that ordering matters in this enum. Not only must it match the mapping
>>> + * below, it is also divided into several sections that matter.  When adding
>>> + * new commands, make sure you add it in the right section.
>>> + */
>>
>> Good thinking.  Makes me wish C were a better language, though ;-)
>
> Do this:
>
>   static const char *todo_command_strings[] = {
>       [TODO_PICK] = "pick",
>       [TODO_REVERT] = "revert",
>       [TODO_NOOP] = "noop:,
>   };
>
> which makes the array be order-independent. You still need to make
> sure you fill in all the entries, of course, but it tends to avoid at
> least one gotcha, and it makes it more obvious how the two are tied
> together.
>
>               Linus

Yes, I know.  But I do not think the variant of C we stick to is not
new enough to have that.
