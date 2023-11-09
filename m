Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD19F374E0
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CZSk7A1H"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAF34239
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 15:02:35 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 95F951CCBA3;
	Thu,  9 Nov 2023 18:02:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/U7TGnbYBg2/tnW96I6B+sNcRWRcsTJenF2Nv/
	YPlqU=; b=CZSk7A1HMoxEzmr2ABWgBwSsv+msXnZCQZLLtu06nIoABtGuEPgfTl
	EsVBXE9s4Eg8ZqZ3DWT1XzJ1DWLkWc/p9avfi7nj8C8sBxalQbB3ZTf/BOPBTSm8
	wTPC4KR9du6Eh7/xWMLLtob+49lyZQTAh3UmoUhiiKruSOyUnzyIw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D2101CCBA2;
	Thu,  9 Nov 2023 18:02:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB6641CCB9F;
	Thu,  9 Nov 2023 18:02:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 2/4] contrib/subtree: stop using `-o` to test for number
 of args
In-Reply-To: <20231109185515.GD2711684@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 9 Nov 2023 13:55:15 -0500")
References: <cover.1699526999.git.ps@pks.im>
	<b1ea45b8a8884d09ab070bb0f099834447d28938.1699526999.git.ps@pks.im>
	<20231109185515.GD2711684@coredump.intra.peff.net>
Date: Fri, 10 Nov 2023 08:02:32 +0900
Message-ID: <xmqq8r76zg1j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 114B7ED4-7F54-11EE-9ED7-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

>>  # Usage: process_subtree_split_trailer SPLIT_HASH MAIN_HASH [REPOSITORY]
>>  process_subtree_split_trailer () {
>> -	assert test $# = 2 -o $# = 3
>> +	assert test $# -ge 2
>> +	assert test $# -le 3
>
> It took me a minute to figure out why we were swapping "=" for "-ge". It
> is because we want to logical-OR the two conditions, but "assert"
> requires that we test one at a time. I think that is probably worth
> explaining in the commit message.

I wish we could write something like

	assert test $# -ge 2 && test $# -le 3

(and I'd allow double quoting the whole thing after assert if
needed) but we cannot do so without tweaking the implementation of
assert.

>
>> @@ -916,7 +919,7 @@ cmd_split () {
>>  	if test $# -eq 0
>>  	then
>>  		rev=$(git rev-parse HEAD)
>> -	elif test $# -eq 1 -o $# -eq 2
>> +	elif test $# -eq 1 || test $# -eq 2
>
> OK, this one is a straight-forward use of "||".

Yes, but why not consistently use the range notation like the
earlier one here, or below?

	elif test $# -ge 1 && test $# -le 2

>>  cmd_merge () {
>> -	test $# -eq 1 -o $# -eq 2 ||
>> +	if test $# -lt 1 || test $# -gt 2
>> ...
> (I am OK with either, it just took me a minute to verify that your
> conversion was correct. But that is a one-time issue now while
> reviewing, and I think the code is readable going forward).

Yeah, the end result looks good.

Thanks, both.
