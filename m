Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 026152021F
	for <e@80x24.org>; Tue,  2 Aug 2016 21:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933AbcHBVO2 (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 17:14:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51764 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754138AbcHBVO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 17:14:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1472033BCA;
	Tue,  2 Aug 2016 17:14:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OogKyjeFiA0baJs9RyIDtbnvFo0=; b=hA3La0
	y31M/crcek5EHR9kFZEGr8l0sVWMInCzEr+PghJ7o7wc80MipWbNZJbYfE2KoaZA
	xHgswkv0ayEQmzPu2wQOG090EqgkR/Z80T1brGFUusdrpOk2krH9baT0cUhYb8u5
	ddFoOHabCrEZT42C2otmhwqK5Uv9LFJSKIjag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QQHkdYuZHaCjy515efjiCv5sisCljHXl
	fcBtNawp4c5RAXbdKLu/woMg7W+WJjqktlnB29gW+5pGMM0WFDIWbhu1aBw9ZTrm
	xujPKuIvUykIJNkE+sMrA/vxqgh7KUO8+aXDawcqIcyPlGWATmTFm60Kd3ROn4DO
	OPITExPiAK0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09B4433BC9;
	Tue,  2 Aug 2016 17:14:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7ED3033BC6;
	Tue,  2 Aug 2016 17:14:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Eric Wong <e@80x24.org>, "Kyle J. McKay" <mackyle@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 1/1 v2] pager: move pager-specific setup into the build
References: <20160801214937.4752-1-e@80x24.org>
	<20160801214937.4752-2-e@80x24.org>
	<xmqq1t28gkhf.fsf@gitster.mtv.corp.google.com>
	<20160801234608.rsrrsnzywt5k7uzl@sigill.intra.peff.net>
Date:	Tue, 02 Aug 2016 14:14:22 -0700
In-Reply-To: <20160801234608.rsrrsnzywt5k7uzl@sigill.intra.peff.net> (Jeff
	King's message of "Mon, 1 Aug 2016 19:46:08 -0400")
Message-ID: <xmqqeg66dgb5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 169D3E54-58F6-11E6-B0BC-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 01, 2016 at 04:03:40PM -0700, Junio C Hamano wrote:
>
>> Eric Wong <e@80x24.org> writes:
>> 
>> > From: Junio C Hamano <gitster@pobox.com>
>> >
>> > Allowing PAGER_ENV to be set at build-time allows us to move
>> > pager-specific knowledge out of our build.  Currently, this
>> > allows us to set a better default for FreeBSD where more(1)
>> > is the same binary as less(1).
>> 
>> Thanks for resurrecting, but I am not sure what "a better default"
>> is from the above description and with the patch.  Even though a
>> naive reading of the above (i.e. "less" and "more" are the same)
>> makes me expect that the patch will give the same set of default
>> environment settings to those on FreeBSD, you give LESS=FRX and
>> MORE=-R, i.e. they are configured differently.
>
> I wondered about this, too. They are the same binary, but calling less
> as "more" (or setting LESS_IS_MORE) causes less to behave "like more".

I guessed that, but if that is the case, "more is the same binary"
is irrelevant.  "more" behaves differently from "less" might be, but
what "less" does is much less important than "more needs this default
setting to work pleasantly", which is what is missing.

So I'd say

    Allowing PAGER_ENV to be set at build-time allows us to move
    pager-specific knowledge out of our build.  This allows us to
    set a better default for FreeBSD more(1), which misbehaves if
    MORE environment variable is left empty $in_such_and_such_way,
    by defaulting it to -R.

without even mentioning anything about "less" may be a more
understandable justification for a patch that sets MORE only on
FreeBSD.


