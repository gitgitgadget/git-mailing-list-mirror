Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5490207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 22:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935371AbcJFWxk (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 18:53:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56796 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934752AbcJFWxj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 18:53:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD47B43C2E;
        Thu,  6 Oct 2016 18:53:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4aiVpWhw4tI3
        KETDnJQ2DRg3EK4=; b=TWscQ8tJA/cmSgE9wWHHyxFVbMl4Bo6gy2fYWBwDP43p
        SRzSqi+hpolMi6JtnlvLkEk3WkoBeYUc58t9TwyVOIJq1LP3KOzBRBLp1XDXQmtq
        XSrsYcVFoFpvS0cvSH2Dm/yZllfHIK1mBhAw0wllGDZNc5cXQ3QJJhGZj+YZU1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=chyMwR
        638K1OyUfVsTZdMBy/EBkOdTZkYcHbQXrvE2cjyd5A5LWCg2MbqnPrPPS/cEr3/Z
        OIstHvK4cvtM500V6azEpMUjV0AGFw7VnYUtweiGwyCZhH4x545mKvZGoB7Zln5S
        Us8KObOs1lkoZXkknum+xXo49k+LbDkzbU278=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4D5843C2D;
        Thu,  6 Oct 2016 18:53:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 44EE943C2C;
        Thu,  6 Oct 2016 18:53:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 05/25] sequencer: allow the sequencer to take custody of malloc()ed data
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <942aa559a0af9b52e079c5c78fa313f49b87d50d.1473590966.git.johannes.schindelin@gmx.de>
        <xmqqzinc295y.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610051338530.35196@virtualbox>
        <xmqqeg3tjn7n.fsf@gitster.mtv.corp.google.com>
        <28935e27-5ba8-c261-ba44-424f7b91cdda@gmail.com>
Date:   Thu, 06 Oct 2016 15:53:35 -0700
In-Reply-To: <28935e27-5ba8-c261-ba44-424f7b91cdda@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Fri, 7 Oct 2016 00:40:59 +0200")
Message-ID: <xmqq8tu1hyxc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B79647B6-8C17-11E6-AAA8-F99D12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>> We manage lifetime of a field in a structure in one of three ways in
>> our codebase [*1*].
>>=20
>>  ...
>>  * A field can sometimes own and sometimes borrow the memory, and it
>>    is accompanied by another field to tell which case it is, so that
>>    cleaning-up can tell when it needs to be free(3)d.  This is a
>>    minority case, and we generally avoid it especially in modern
>>    code for small allocation, as it makes the lifetime rule more
>>    complex than it is worth.
> ...
> On the other hand the _entrust() mechanism might be a good solution
> if the amount of memory was large, for example order of magnitude more
> than what would be needed to keep ownership info *and* borrowing would
> not be possible for some reason.

We have approach #3 exactly for that usage pattern.
