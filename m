Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7621DC83007
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510C5206F0
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xgEcuUB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgD1VCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:02:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59850 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgD1VCh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 17:02:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA5ED65B3D;
        Tue, 28 Apr 2020 17:02:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tpHx3LKlKs9KCzO+KbTdhtwkxPw=; b=xgEcuU
        B3bcXsVY+gEP9uNmKzNaZCblMDTMk6H22xJeazRic7X/nKc1iyXt1nB+I9uk50FQ
        n9ymqgmz9MDQMGx5od/XVSTz4zBNq2gfj2FhInaCEpXx4T1cYBwJz4aD/vJ/aTpz
        HGER1qRzjG/tgpYSR7m4C5W/RXFK9NcFq8D3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f9o3iIZ0QEzAfprBTCWDF3TBmhEOXrTb
        +KtJBpEILUafp8/H7r74Z5IMg1jijuTbrqt9EJZc4NporE8LfzCUBwDuHgZ5uPNY
        pKIq0tEhMUniMUOM6WO2GnH+pV0po8Fru+drxQZcvpGGDvPfLy71Pd5Hbsj4lXdm
        u5wBOiOReBo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B253A65B3C;
        Tue, 28 Apr 2020 17:02:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 41A7D65B3B;
        Tue, 28 Apr 2020 17:02:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] fetch-pack: try harder to read an ERR packet
References: <20200428074442.29830-1-chriscool@tuxfamily.org>
        <xmqqzhav1kix.fsf@gitster.c.googlers.com>
        <20200428204908.GA4000@coredump.intra.peff.net>
Date:   Tue, 28 Apr 2020 14:02:33 -0700
In-Reply-To: <20200428204908.GA4000@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Apr 2020 16:49:08 -0400")
Message-ID: <xmqqh7x31fyu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9519730C-8993-11EA-B8A4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Hmm, if the connection gets severed just before the ERR packet the
>> other side has written, we will see "Broken pipe" if we write
>> "done", and no amount of "try to read to collect as much what they
>> said as possible" would help.  If you are lucky and the connection
>> is broken after the ERR reaches on this side, such an "extra effort"
>> may help, but is it really worth the effort?  It is not clear to me
>> if the extra complexity, one more API function people need to learn,
>> and the need to think which one to use every time they want to say
>> write_in_full(), are justifiable.
>
> I think the "lucky" case happens pretty routinely. The situation we're
> trying to catch here is that server does:
>
>    packet_write("ERR I don't like your request for some reason");
>    die("exiting");

OK, if we assume that the communication route is never flaky and
everything writtten will go through before TCP shutdown that would
happen when die() kills the process (or like test environment that
most communication goes locally between two processes), sure, it may
look common enough to be worth "fixing".  I simply did not realize
that was the shared assumption behind this patch before I went back
to the original discussion that was about a racy test.

As long as an extra read on the side that just got a write error
won't throw us into a deadlock, I think I am OK, but I am still not
sure if the code complexity to have two write_in_full() is worth it.

If the mechanism to do this were limited to the packet IO layer, it
may be more palatable, though.

