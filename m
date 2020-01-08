Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F20AC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 17:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0119220705
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 17:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R1bsi5dL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgAHRan (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:30:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55395 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbgAHRan (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 12:30:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F5A9A0F4B;
        Wed,  8 Jan 2020 12:30:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DXsn8dSQK6tFM9czMc7kQdp5T1Y=; b=R1bsi5
        dLudQRMK52T/LKBTWeBWFEB6pbQeq2buXpH1fJXqmDehrKLUMXbWAHB7veJ1beps
        P8TOW+fjTcuFwYB13RRC12XuO8F15AHINWNt0gd4Ti8Z2Y7eSUBqj5hijVOeROV+
        jJfJs47wavRm8/MlRJE5aOkCPnSzgmOakvpZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ksCg5YYGfT1z5Ze1ycy5tpnandCu1wnP
        Tt4ZET8gVOh27WKN3YmF8iLQmQEyUmSLnVWn73loWbCny/FomnklZF8gP4vQTDIB
        URVG6BK65zzxPMMdKOesT/ivSHnuRTMoABme/eCDcvv3VWehC5EffOH11q0dKhH8
        ImFBAPqPY8k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 76CC0A0F4A;
        Wed,  8 Jan 2020 12:30:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 940AAA0F49;
        Wed,  8 Jan 2020 12:30:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] unpack-trees: watch for out-of-range index position
References: <20200108023127.219429-1-emilyshaffer@google.com>
        <20200108071525.GB1675456@coredump.intra.peff.net>
Date:   Wed, 08 Jan 2020 09:30:36 -0800
In-Reply-To: <20200108071525.GB1675456@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 8 Jan 2020 02:15:25 -0500")
Message-ID: <xmqqeew93lfn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 961E79E0-323C-11EA-9434-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jan 07, 2020 at 06:31:27PM -0800, Emily Shaffer wrote:
>
>> This issue came in via a bugreport from a user who had done some nasty
>> things like deleting various files in .git/ (and then couldn't remember
>> how they had done it). The concern was primarily that a segfault is ugly
>> and scary, and possibly dangerous; I didn't see much problem with
>> checking for index-out-of-range if the result is a fatal error
>> regardless.
>>
>> [...]
>>  	if (pos >= 0)
>>  		BUG("This is a directory and should not exist in index");
>>  	pos = -pos - 1;
>> -	if (!starts_with(o->src_index->cache[pos]->name, name.buf) ||
>> +	if (pos >= o->src_index->cache_nr ||
>> +	    !starts_with(o->src_index->cache[pos]->name, name.buf) ||
>>  	    (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name.buf)))
>> -		BUG("pos must point at the first entry in this directory");
>> +		BUG("pos %d doesn't point to the first entry of %s in index",
>> +		    pos, name.buf);
>
> The new condition you added looks correct to me. I suspect this BUG()
> should not be a BUG() at all, though. It's not necessarily a logic error
> inside Git, but as you showed it could indicate corrupt data we read
> from disk. The true is probably same of the "pos >= 0" condition checked
> above.

It does not sound like a BUG to me, either, but the new condition
does look correct to me, too.  We can turn it into die() later if
somebody truly cares ;-)

Thanks, both.  Will queue.


> It's mostly an academic distinction, though, as I think it would be
> pretty reasonable for now to just die() here (eventually, though, we
> might want to turn it into an error return).
>
> -Peff
