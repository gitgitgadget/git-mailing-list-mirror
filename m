Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BE6B1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 06:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfA2Gpa (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 01:45:30 -0500
Received: from 0x63.nu ([109.74.10.199]:48006 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfA2Gpa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 01:45:30 -0500
Received: from ip6-localhost ([::1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1goN9B-0004E4-1h; Tue, 29 Jan 2019 07:45:25 +0100
References: <20181028125025.30952-1-anders@0x63.nu> <20190128213337.24752-1-anders@0x63.nu> <20190128213337.24752-3-anders@0x63.nu> <xmqq8sz49zm1.fsf@gitster-ct.c.googlers.com>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Anders Waldenborg <anders@0x63.nu>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/7] pretty: Allow %(trailers) options with explicit value
Message-ID: <87tvhsklpb.fsf@0x63.nu>
In-reply-to: <xmqq8sz49zm1.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 29 Jan 2019 07:45:06 +0100
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano writes:

>> ...
>> +static int match_placeholder_bool_arg(const char *to_parse, const char *candidate,
>> +				      const char **end, int *val)
>> +{
>> +	char buf[8];
>> +	const char *strval;
>> +	size_t len;
>> +	int v;
>> +
>> +	if (!match_placeholder_arg_value(to_parse, candidate, end, &strval, &len))
>> +		return 0;
>> +
>> +	if (!strval) {
>> +		*val = 1;
>> +		return 1;
>> +	}
>> +
>> +	strlcpy(buf, strval, sizeof(buf));
>> +	if (len < sizeof(buf))
>> +		buf[len] = 0;
>
> Doesn't strlcpy() terminate buf[len] if len is short enough?
> Even if the strval is longer than buf[], strlcpy() would truncate
> and make sure buf[] is NUL terminated, no?

Yes, but no. strval is not NUL-terminated at len. E.g strval would point
to "false,something=true". `buf[len] = 0` makes sure it becomes "false".

> Instead of using "char buf[8]", just using a strbuf and avoidng
> strlcpy() would make the code much better, I would think.

Yes, taking the heap allocation hit would most likely make the intent
clearer.
