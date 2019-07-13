Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B76B1F461
	for <e@80x24.org>; Sat, 13 Jul 2019 21:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfGMV3M (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jul 2019 17:29:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54408 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfGMV3M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jul 2019 17:29:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4CE577ACAB;
        Sat, 13 Jul 2019 17:29:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KlBK2CisfkpESkJnTQ23/AU4qBM=; b=nA3Uuk
        R5NEto4e1Cv/Zd9k5FHuzlsarjyBmnseYb8MQFHjFk9krTDEDvafepzrLBgew2Zv
        kXFGIRUrvSWwt11EgclPCX5jW5yE+ev88+L8AGKM5ZuUokbmUTaV9jIfZtaHmmOf
        eB0UqawyfAn8YCVV46BDfHmRmCxfq2Iw5bPHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s/pzFQbGtuskhrlzTqJQafGpNj4wjE4D
        7U6JKR1W2RPurwFzngxpCm6D2FE6b95C1J/rZBoikGjae7KYboSVS4+etjHjX74m
        eGOctfI+55/DGRKPSyUOwP/YPhAweJBS6y4FMS1NL14mNIuqoi0FTXoVgEiLYV+/
        GOzI9nCGZuw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 44D557ACAA;
        Sat, 13 Jul 2019 17:29:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 768217ACA8;
        Sat, 13 Jul 2019 17:29:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
References: <e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com>
        <41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org>
        <xmqqy313p5hn.fsf@gitster-ct.c.googlers.com>
        <ec635d0d-00ca-2419-3c1a-9b0343b46daa@kdbg.org>
Date:   Sat, 13 Jul 2019 14:29:05 -0700
In-Reply-To: <ec635d0d-00ca-2419-3c1a-9b0343b46daa@kdbg.org> (Johannes Sixt's
        message of "Sat, 13 Jul 2019 12:44:20 +0200")
Message-ID: <xmqq1rytpqse.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EEE8502-A5B5-11E9-80B0-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> Hmm, care to elaborate a bit?  Certainly, we have a clear preference
>> between these two:
>> 
>> 	struct patch patch;
>> 	patch.new_name = 0;
>> 	patch.new_name = NULL;
>> 
>> where the "char *new_name" field is the first one in the structure.
>> We always try to write the latter, even though we know they ought to
>> be equivalent to the language lawyers.
>
> I'm not questioning this case; the latter form is clearly preferable.
>
> Using only = { 0 } for zero-initialization makes the code immune to
> rearrangements of the struct members. That is not the case with = { NULL
> } because it requires that the first member is a pointer; if
> rearrangement makes the first member a non-pointer, the initializations
> must be adjusted.

I do not think this position is maintainable, especially if you
agree with me (and everybody else, including sparse) that this is a
bad idea:

>   struct string_list dup_it = { 0, 0, 0, 1, 0 };

The way I read "6.7.8 Initialization" (sorry, I only have committee
draft wg14/n1124 of 2005 handy) is that

	struct patch patch = { 0 };

has an initializer for a structure with an automatic storage
duration, and for each of the subsequent fields of the structure
(i.e. we ran out the initializer after dealing with that single zero
that talks about the first field), due to "all subobjects that are
not initialized explicitly shall be initialized implicitly the same
as objects that have static storage duration." rule, "if it has a
pointer type, it is initialized to a null pointer", which is exactly
in line with your (and our) position that the first example I left
in the above (new_name gets assigned NULL).  So we are fine with the
fields that are not speled out.

But then what about the explicitly spelled out 0 for the first
field?  It is like an assignment, so by arguing that we should have
0 over there and not NULL, you are essentially arguing for

	patch.new_name = 0; /* not NULL */

aren't you?

As already pointed out downthread, sparse will catch an
initialization for an arithmetic type that is left to be NULL, but
which should have been spelled 0, when fields are reordered anyway,
so I do not think your "only when initializing the first field of
the structure with a zero value while leaving the initializer for
the remainder unspelled, we should say 0 not NULL even when the
field has pointer type" stance is not maintainable.

And I agree with you that the calloc()/memset() that fills it with
0-bit pattern is "evil-doing" as you say.  Compared to that, the
initialization rule for objects with static storage duration is
quite sane---a pointer field gets a NULL pointer and arithmetic
field gets a (positive or unsigned) zero.

I wish if we could say

	struct patch patch = {};

so that we an leave all fields to have their natural zero value like
fields in a static variable without explicit initialization do ;-)
but according to "6.7.8 Initialization / Syntax #1", the
initializer-list inside the braces must have at least one
initializer, so that won't be possible X-<.

