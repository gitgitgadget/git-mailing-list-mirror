Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAD6B20899
	for <e@80x24.org>; Wed,  2 Aug 2017 22:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbdHBW3w (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 18:29:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64644 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751161AbdHBW3v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 18:29:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74690A0F66;
        Wed,  2 Aug 2017 18:29:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1lI0rYLLZasMC361pXNMpVrg34M=; b=FyV/qs
        //rYhY+mQP3lDscCZ3MZHKEEk2TzgvKn/NhcD+XDEt5xQKnNdzcrZ5NKfXEWThJZ
        JVhu9HCuT/Zoh7Bw2I1mWBGxcERwOJ3aENBTlyzB2rsYhyf8dz1epq6+YwUdx+tU
        8DusUvwyX5MVAejyCJ+LjHSnrumjSBqEumAGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vgdoDPOzwiDunqZcaV10ukcXTe9aUXWX
        pokm8It8+pEglmZzROjhQSX70ShGVc87Yu34chfR3SV86HAQ8VvA/DLzjOtgKf/p
        euedIk7Fw5U+TcEl3AC0e3LsFI9PYxEbflARR9zGcZTzfzRIW437lKYWrFXCtaDG
        sALMc2m2GNs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D1AAA0F65;
        Wed,  2 Aug 2017 18:29:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD128A0F64;
        Wed,  2 Aug 2017 18:29:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 6/6] cherry-pick/revert: reject --rerere-autoupdate when continuing
References: <20170802104420.12809-1-phillip.wood@talktalk.net>
        <20170802104420.12809-7-phillip.wood@talktalk.net>
        <xmqqpocdr5tu.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 02 Aug 2017 15:29:41 -0700
In-Reply-To: <xmqqpocdr5tu.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 02 Aug 2017 14:57:17 -0700")
Message-ID: <xmqqlgn1r4bu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 147AE60C-77D2-11E7-9DA5-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood@talktalk.net> writes:
>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> cherry-pick and revert should not accept --[no-]rerere-autoupdate once
>> they have started.
>
> Hmph, why shouldn't they?  In other words, shouldn't the usual "try
> to carry forward from the original invocation (saved in the state
> file), but allow overriding from the command line" rule apply?

Actually, I do not care _too_ deeply between

 * You can only give "--[no-]rerere-autoupdate" at the beginning and
   cannot change your mind later.

and

 * The "--[no-]rerere-autoupdate" you give at the beginning is used
   throughout your multi-commit cherry-pick session, but you can
   give an opposite one from the command line when you say
   "--continue", and in that case it takes effect only for a single
   commit.

If I understand correctly, the former is what 5-6/6 implements.  The
latter makes it more in line with how "am -3" followed by "am --no-3
--continue" behaves.

Thanks.
