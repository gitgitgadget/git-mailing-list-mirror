Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2373D2070D
	for <e@80x24.org>; Fri,  8 Jul 2016 17:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbcGHR0E (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 13:26:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932185AbcGHR0B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2016 13:26:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F18F92A706;
	Fri,  8 Jul 2016 13:25:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=x97Qxft6MLDE
	3VVSzmnKDkjUc2o=; b=j2X4K/fwt/i+VqVK7tkluQx7eeASLfuml4mquGYySCAc
	Yp386QhHIegxkbr+umbnU6l6WaYm6DqEVkwE7HADVBi2o26ZGCheKW1b28FIW9gr
	vU9XRvY9fYO5M+SvOEan3aPxahwXO8xiFY2a2xktPACuWiE8l4hM5Sx+dTT4k6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=afPCbN
	JLnFn4p50sxJILKUUXYhiCn0MXmtr/dZ0OatbBp4DfLEmOo+Y9QXq5r9zp44xsYC
	EdYk5TvIMxyrqSfDGP46iXv+4Q9+xTYggnwVXOFTpCxWa6r5t9FlaLWNTnR6XEJ/
	U/8/90l3duAZP8J5WPD4rnbzPBxTGrEz/sGtE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E7E452A705;
	Fri,  8 Jul 2016 13:25:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7074E2A704;
	Fri,  8 Jul 2016 13:25:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] correct ce_compare_data() in a middle of a merge
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
	<1467100876-2803-1-git-send-email-tboegi@web.de>
	<xmqqh9cc55wm.fsf@gitster.mtv.corp.google.com>
	<62eb3d75-126e-427b-8701-d490e80e3501@web.de>
	<xmqq8txlvwip.fsf@gitster.mtv.corp.google.com>
	<574692d1-c8ae-9c2f-6b99-a01545b15051@telia.com>
	<xmqqa8huvmpv.fsf@gitster.mtv.corp.google.com>
	<c36fe487-b8dc-9767-7fae-bee513dac0b2@web.de>
	<xmqqr3b5p9v0.fsf@gitster.mtv.corp.google.com>
	<2cbf12a6-2dca-8180-323b-f79638aa03bd@web.de>
	<xmqqmvlsm6hu.fsf@gitster.mtv.corp.google.com>
	<f78fa94d-abd2-05a2-c411-15e2ffdb7dae@web.de>
Date:	Fri, 08 Jul 2016 10:25:52 -0700
In-Reply-To: <f78fa94d-abd2-05a2-c411-15e2ffdb7dae@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Fri, 8 Jul 2016 19:13:40
 +0200")
Message-ID: <xmqq1t34m47z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 066A6BE8-4531-11E6-B0BD-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

>> And then with this further on top:
>>
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index b880ae5..628c8ed 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -202,6 +202,9 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
>>  		const char *path, int stage, int refresh, int options)
>>  {
>>  	struct cache_entry *ce;
>> +
>> +	if (!stage)
>> +		remove_file_from_cache(path);
>>  	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage,
>>  			      (refresh ? (CE_MATCH_REFRESH |
>>  					  CE_MATCH_IGNORE_MISSING) : 0 ));
>>
> Thanks :-)
> Did that experiment made it to a branch somewhere ?

Not yet.  As I called it "experiment", it was merely to demonstrate
that there are less intrusive ways to kill the "safer crlf" we may
want to consider first before passing an extra blob object name
around.
