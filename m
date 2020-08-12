Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FC9C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 20:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F07520774
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 20:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BaHbKt0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHLUcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:32:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58467 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLUcC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 16:32:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BEDB66D510;
        Wed, 12 Aug 2020 16:31:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zSd00+0KTGbq
        4f5yZNeETnUoDck=; b=BaHbKt0SW3ZOfn1lMaskCGMOuy/iVOQin12lEsGcl22K
        O+iuEt/0ORzXiNvF/lFjlBxyA/Y9OMBYjb8kMn6FMnwtwuu00Wf2apAxgg5F3Uwj
        A03U2SudSD7lxbBLVHGRoNWQnWdREXnSDYI5WmwgNrdby9Rsrl3Qx1JgJrT/QPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hIDnY8
        1fjwPvvW8+c/30Tt0AeC3VWWaJGmKRGEhFsdywh4cuiCEQZLASmZHLgWdwzzt+JU
        m1KxErgcz+B5XDqHNNWKHWQwHLUvk7Pkx6QLfx4opUKFEPvzfHceCeEFGa9atHfU
        OfaVTLe8er2fuoBR/ecZCK2kv6B9JlUBAAd3c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B65CF6D50E;
        Wed, 12 Aug 2020 16:31:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A62B6D50D;
        Wed, 12 Aug 2020 16:31:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Chris Torek <chris.torek@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] midx: use buffered I/O to talk to pack-objects
References: <c5920e08-b7dd-e870-f99e-225d0aafc663@web.de>
        <9162c1cb-36fd-3203-ec58-4bd1501938d0@web.de>
        <xmqqh7t7623d.fsf@gitster.c.googlers.com>
Date:   Wed, 12 Aug 2020 13:31:58 -0700
In-Reply-To: <xmqqh7t7623d.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 12 Aug 2020 13:28:22 -0700")
Message-ID: <xmqqd03v61xd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DF1620F0-DCDA-11EA-B23B-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>  		nth_midxed_object_oid(&oid, m, i);
>> -		xwrite(cmd.in, oid_to_hex(&oid), the_hash_algo->hexsz);
>> -		xwrite(cmd.in, "\n", 1);
>> +		fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
>
> I do think it is silly to send an object name and terminating LF in
> two different system calls per object.
>
> The original uses xwrite() so that it does not have to worry about
> having to restart interrupted system calls and such.

Oops.  There is not much in "and such".  xwrite() only restarts but
the caller must deal with truncated write, which the original does
not do.

