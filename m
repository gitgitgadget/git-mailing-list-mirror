Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9955F20196
	for <e@80x24.org>; Thu, 14 Jul 2016 17:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbcGNRIj (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 13:08:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751402AbcGNRIi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 13:08:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 78D462ADBF;
	Thu, 14 Jul 2016 13:08:37 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nF/E7Xrfuna4XXduHTCUtFzYekA=; b=dO56Pt
	UlQOevAWb5NOz8w/bxRGxq+clE1IwR2AI8xMySRKBJeTf3FdaqT8CyqZV7DnPYqO
	kkxGEQQTilqhD5lwqCye/frBbZB9a7sfHE52lWBMQWm+NiE+Iy4QjjFdiDhglNJx
	lO54nktDYip2vlep+IPF7zWQIl41bCxJEJ0ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xUb1eR7f+6T7e1L1MKlsOEaqT4gelvmH
	AqB3YlufDYBHdwpNZ6hVsyOWiI/Ev/ToaVatbhyCoztbBQ8QnofUKl46tFY1Loq0
	ZPGI+yYVb/FeAjwjwZwj+NPvN+SC34o6DOGMLw4NE3MF9KaPdjXq2yAA2GQ1ybPK
	MchwPeC2Mt0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71AFD2ADBE;
	Thu, 14 Jul 2016 13:08:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9D4C2ADBD;
	Thu, 14 Jul 2016 13:08:36 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
References: <20160630090614.GA16725@sigill.intra.peff.net>
	<20160630090857.GB17463@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607141745420.6426@virtualbox>
	<19a2d02e-3918-3bc9-db34-66e12ab950e4@kdbg.org>
Date:	Thu, 14 Jul 2016 10:08:34 -0700
In-Reply-To: <19a2d02e-3918-3bc9-db34-66e12ab950e4@kdbg.org> (Johannes Sixt's
	message of "Thu, 14 Jul 2016 18:45:47 +0200")
Message-ID: <xmqqa8hkrvu5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A7E9E04-49E5-11E6-8CF2-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 14.07.2016 um 17:47 schrieb Johannes Schindelin:
>> On Thu, 30 Jun 2016, Jeff King wrote:
>>> The ustar format only has room for 11 (or 12, depending on
>>> some implementations) octal digits for the size and mtime of
>>> each file. For values larger than this, we have to add pax
>>> extended headers to specify the real data, and git does not
>>> yet know how to do so.
>>>
>>> [...]
>>>  t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a | Bin 0 -> 2048 bytes
>>
>> It appears that this blob cannot be read when sizeof(unsigned long) == 4.
>> This happens to break the t5000 test on Windows, where that comparison
>> holds true.
>
> The problem occurs in parse_sha1_header_extended(), where the
> calculation of the size in the object header overflows our 32-bit
> unsigned long.

OK, then we'd want something that measures how big "unsigned long"
is, and use it as a lazy prerequisite 64BIT_LONG, tweaking the other
patch to t0006 the other Johannes sent yesterday.

Dscho?  I'll revert the merge of 'js/t0006-for-v2.9.2' out of
'next' so that we can replace it with your newer version, but it
needs to be massaged to lose the strong linkage with "time", as
it is no longer "is our time big enough", I would think.

Thanks.
