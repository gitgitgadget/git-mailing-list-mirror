Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B35D5215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 22:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753902AbcJLWZV (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 18:25:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60574 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753866AbcJLWZT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 18:25:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DDEE459BA;
        Wed, 12 Oct 2016 17:50:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rPD66ylfNFFBqiERtJ2jdgaZh/A=; b=Kq1ZBq
        fmBmqjMNucDsnMoBc2X6QAc+/C1VlOH90Dar8p7rPHUAAlpWSP8/UYEXWd0xPhj7
        h5ZXbyVGJGLxqJg92C0pozo1iMNLuYykYIidC8tnO7Z2PFs++s9s72KPx8riq35N
        fD2+/nCwHvjQsMKe7ppBSbyyXJAfNCXdx89oI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sESZ5mCamRUsNZbZr600pX4SjH7LnkBq
        ttDgrAaU4/Cj5XH+cddHYVYkMVJxk+/+rUrUssHJE8piI9Bhq4tbCE4nEvSKQ8Nr
        Crb/JhhR7qtQj4dTrM7Rai80PGtuzNvSEfCouBeEavLaKAmT1/QhMqeKlGlFckiN
        Qf2lg8/9N7A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86877459B9;
        Wed, 12 Oct 2016 17:50:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06A9E459B8;
        Wed, 12 Oct 2016 17:50:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCHv2] attr: convert to new threadsafe API
References: <20161011235951.8358-1-sbeller@google.com>
        <44c554b8-7ac1-047d-59f0-b4d5331ed496@kdbg.org>
        <xmqq8ttt2qpp.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kb-xKDNG-LC56i8Y-FAaYZwr8zzXuC9snj1PavnQ6cdCA@mail.gmail.com>
Date:   Wed, 12 Oct 2016 14:50:43 -0700
In-Reply-To: <CAGZ79kb-xKDNG-LC56i8Y-FAaYZwr8zzXuC9snj1PavnQ6cdCA@mail.gmail.com>
        (Stefan Beller's message of "Wed, 12 Oct 2016 14:42:37 -0700")
Message-ID: <xmqqwphd1bkc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED96F128-90C5-11E6-A68A-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Oct 12, 2016 at 2:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> Sigh. DCLP, the Double Checked Locking Pattern. ...
>>> I suggest you go without it, then measure, and only *then* optimize if
>>> it is a bottleneck.
>>
>> That comes from me in earlier discussion before the patch, namely in
>> <xmqqeg3m8y6y.fsf@gitster.mtv.corp.google.com>, where I wondered if
>> a cheap check outside the lock may be a possible optimization
>> opportunity, as this is a classic singleton that will not be
>> deinitialized, and once the codepath gets exercised, we would be
>> taking the "nothing to do" route 100% of the time.
>
> Having followed that advice (and internally having a DCLP), I think
> we have Triple Checked Locking Pattern in this patch.  Nobody wrote
> a paper on how that would not work, yet. ;)
>
> In the reroll I plan to reduce it to a Single Checked (inside a mutex)
> Locking Pattern, though I would expect that performance (or lack thereof)
> will show then. But let's postpone measuring until we have a working patch.

Oh, that wasn't even an "advice" (read it again).  I fully agree
that starting simple would be the way to go.
