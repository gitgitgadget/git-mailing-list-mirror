Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5405E20984
	for <e@80x24.org>; Tue, 13 Sep 2016 22:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759327AbcIMWoU (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 18:44:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54196 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758823AbcIMWoT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 18:44:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B8663EBA8;
        Tue, 13 Sep 2016 18:44:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KPdr61vHgUs8BefzuKeaOgHnzfI=; b=Q+qhyu
        xylU6ikww6vwVbDy0JlixmRO+4Zoi6wWsHrUwoxtJufOmIkJD+a/Obnn6uxwJNV3
        R/fgvIsrFytidR7EYap7nYYHKpiRTq/XmYfDqORpT6q8DQKyNZPikX49Lyz/KdxC
        VsAxRK2SSh64P1i+HuDiYnGQpH+6gx8neKDRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=laKYKA85CU5PPvvFbd9h1iFxN6c21bqB
        K4DRi80FbBIbEM0N6xdERGYXOLF4MP7sYBbM7CixdvicvOUEvh2+mLdospNA5KKz
        gAJEUDRyO9UmDoUbWmSuBs22ndmofJwWzn7j+dY5Oy+v+TVvlFf9oHsKEnWrRkfK
        Qn/p8IoZbI0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0235A3EBA7;
        Tue, 13 Sep 2016 18:44:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BC823EBA5;
        Tue, 13 Sep 2016 18:44:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, peff@peff.net,
        sbeller@google.com, Johannes.Schindelin@gmx.de, jnareb@gmail.com,
        mlbright@gmail.com, tboegi@web.de, jacob.keller@gmail.com
Subject: Re: [PATCH v7 04/10] pkt-line: add packet_flush_gently()
References: <20160908182132.50788-1-larsxschneider@gmail.com>
        <20160908182132.50788-5-larsxschneider@gmail.com>
        <xmqqinu0y9v1.fsf@gitster.mtv.corp.google.com>
        <B138B703-08A6-45C4-9D54-80F87C75356B@gmail.com>
Date:   Tue, 13 Sep 2016 15:44:15 -0700
In-Reply-To: <B138B703-08A6-45C4-9D54-80F87C75356B@gmail.com> (Lars
        Schneider's message of "Tue, 13 Sep 2016 23:12:33 +0100")
Message-ID: <xmqq37l3v2rk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A6F7E80-7A03-11E6-BA84-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 13 Sep 2016, at 00:30, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> larsxschneider@gmail.com writes:
>> 
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>> 
>>> packet_flush() would die in case of a write error even though for some
>>> callers an error would be acceptable. Add packet_flush_gently() which
>>> writes a pkt-line flush packet and returns `0` for success and `-1` for
>>> failure.
>>> ...
>>> +int packet_flush_gently(int fd)
>>> +{
>>> +	packet_trace("0000", 4, 1);
>>> +	if (write_in_full(fd, "0000", 4) == 4)
>>> +		return 0;
>>> +	error("flush packet write failed");
>>> +	return -1;
>> 
>> It is more idiomatic to do
>> 
>> 	return error(...);
>> 
>> but more importantly, does the caller even want an error message
>> unconditionally printed here?
>> 
>> I suspect that it is a strong sign that the caller wants to be in
>> control of when and what error message is produced; otherwise it
>> wouldn't be calling the _gently() variant, no?
>
> Agreed!

I am also OK with the current form, too.  Those who need to enhance
it to packet_flush_gently(int fd, int quiet) can come later.

