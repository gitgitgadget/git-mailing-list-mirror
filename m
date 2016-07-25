Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04671203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 18:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbcGYSDH (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 14:03:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752108AbcGYSDF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 14:03:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E9B730269;
	Mon, 25 Jul 2016 14:03:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IDCECqP26KATH1GI7s1+zuKUDF8=; b=hhfAAc
	JgFNsXdgOimy3PIq1FXg149qU1GCIzwDDkNzXDYyvMPpuVdkbvQNu1u/9eOkEgE8
	7XfcAgJj4e6fCPPWaUosFkNz9D5osFEL35eMsVD3D/G/OyaYjq3tQEN9sKkQKt8R
	12uxGpkV4JG79gwO1tiJSb8oqGiX9y7HXK4uo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oAvxYSuYxNmW3oigy+43mtdOYPUExF0z
	0M3iAAW18uPXB9fdksCYzoLcymjK4LvcO2oix+NAAZcctzNKj5+9gtt7a56sP4R/
	NQLYBM7BFws/GBgw3MdObRAYcB0y16ZfV4fEcHYBuJtPWLWdBJSuDY8jsd7Vfw8S
	QOco9zfk408=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6579230268;
	Mon, 25 Jul 2016 14:03:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CDBDA30267;
	Mon, 25 Jul 2016 14:03:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Andreas Schwab <schwab@linux-m68k.org>
Cc:	Eric Wong <e@80x24.org>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] mailinfo: extract is_from_line from mailsplit
References: <20160722224739.GA22961@whir>
	<alpine.DEB.2.20.1607231056150.14111@virtualbox>
	<20160724031409.GA32480@starla> <20160724031518.GB32480@starla>
	<m2poq3zdu3.fsf@linux-m68k.org>
Date:	Mon, 25 Jul 2016 11:03:00 -0700
In-Reply-To: <m2poq3zdu3.fsf@linux-m68k.org> (Andreas Schwab's message of
	"Sun, 24 Jul 2016 09:37:24 +0200")
Message-ID: <xmqqmvl561ez.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 07B44C44-5292-11E6-ADD7-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

>> +	colon = line + len - 2;
>> +	line += 5;
>> +	for (;;) {
>> +		if (colon < line)
>> +			return 0;
>> +		if (*--colon == ':')
>> +			break;
>> +	}
>> +
>> +	if (!isdigit(colon[-4]) ||
>> +	    !isdigit(colon[-2]) ||
>> +	    !isdigit(colon[-1]) ||
>> +	    !isdigit(colon[ 1]) ||
>> +	    !isdigit(colon[ 2]))
>> +		return 0;
>> +
>> +	/* year */
>> +	if (strtol(colon+3, NULL, 10) <= 90)
>> +		return 0;
>> +
>> +	/* Ok, close enough */
>> +	return 1;
>> +}
>
> Should this be made more strict, like by checking for a space before the
> year?

The function seems to judge the line to be "close enough" by
checking these places (please view with fixed-width font ;-):

    From me Mon Jul 25 01:23:45 2016
    xxxxx               x xxxxx ....

We only see if the year part is more than 90 but we do not even
ensure that it is at the end of the line without any further
garbage, which I think is probably OK for the purpose of "close
enough".

We also do not bother rejecting a single-digit hour, or there is a
colon between the hour and minute part.

I would say requiring SP between the year and the second, and
requiring colon between hour and minute, would probably be a good
change, i.e. something like this:

	if (!isdigit(colon[-4]) ||
	    colon[-3] != ':' ||
	    !isdigit(colon[-2]) ||
	    !isdigit(colon[-1]) ||
	    !isdigit(colon[ 1]) ||
	    !isdigit(colon[ 2]) ||
	    colon[3] != ' ')

would be safe enough without increasing the false negatives too
much.
