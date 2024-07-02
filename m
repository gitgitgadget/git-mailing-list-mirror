Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AD11BD512
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957124; cv=none; b=FmR4Qyc9c78ofY+cI4hvs/XT6APtxNiNnhvwkr4X4mTrSrcr8ab7LMqCCTvH78Oy+RxfwJ86GuHZUQnH/6CV95XVku+j6P0KGTYmnMzibjCU0mRyuGmVc4ouugb5uehX95b8kEoyDgNhXcqAOXptwKrLQN1lC13qrKzo+iFYEnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957124; c=relaxed/simple;
	bh=D7i5oVzfKApCDFKElooB4lcpCcWQ111H5uo5JYL65Nw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DJFcVZVv/OB/bKTRA7eztbBbfzQ8JP9sh5LFYi6KUpsVc09h6RY2VUJ35CuAwqnOyqKQP5AxTrN6EuB4AXJzYUSt+V793xHKloyPAA3i0jKrBT3zOozLfBPNeGrK/tV0PE5Omm0/W+Lp/uWGzyhBaW8rE3VARrK/ll4Hk1SsNsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mvxTFqvQ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mvxTFqvQ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5068333C3D;
	Tue,  2 Jul 2024 17:52:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=D7i5oVzfKApCDFKElooB4lcpCcWQ111H5uo5JY
	L65Nw=; b=mvxTFqvQnBnGu885JiLwfGppxTmuy+7xT0cJUTS7rK4RXqAI+1qeHN
	tDPShGoOx5jsNPbLDLtu5pfJdZpHkXwV1HWBrb9+W8HARH5sNV+Ly2spoAiHOn8k
	1llCL6uOC8g9SPRx/YT1WuddDwkHUjvINTAL6y3Wxce6dLaSUwjIc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A75033C3C;
	Tue,  2 Jul 2024 17:52:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D61F433C39;
	Tue,  2 Jul 2024 17:51:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: avoid showing false negotiation errors
In-Reply-To: <20240702211151.GA120950@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 2 Jul 2024 17:11:51 -0400")
References: <xmqqo77fr2h0.fsf@gitster.g>
	<20240702211151.GA120950@coredump.intra.peff.net>
Date: Tue, 02 Jul 2024 14:51:56 -0700
Message-ID: <xmqqcynvqx6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4E82AE62-38BD-11EF-88AB-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

>> diff --git c/t/t5516-fetch-push.sh w/t/t5516-fetch-push.sh
>> index 2e7c0e1648..a3f18404d9 100755
>> --- c/t/t5516-fetch-push.sh
>> +++ w/t/t5516-fetch-push.sh
>> @@ -230,6 +230,17 @@ test_expect_success 'push with negotiation proceeds anyway even if negotiation f
>>  	test_grep "push negotiation failed" err
>>  '
>>  
>> +test_expect_success 'push deletion with negotiation' '
>> +	mk_empty testrepo &&
>> +	git push testrepo $the_first_commit:refs/heads/master &&
>> +	git ls-remote testrepo >ls-remote &&
>> +	git -c push.negotiate=1 push testrepo \
>> +		:master $the_first_commit:refs/heads/next 2>errors-2 &&
>> +	test_grep ! "negotiate-only needs one or " errors-2 &&
>> +	git -c push.negotiate=1 push testrepo :next 2>errors-1 &&
>> +	test_grep ! "negotiate-only needs one or " errors-1
>> +'
>
> The test mostly makes sense, though is the ls-remote bit leftover
> debugging cruft?

The ls-remote is more of "forward-looking" (as opposed to
"leftover") debugging cruft to help future debugging when somebody
breaks the tests.  I can remove it, of course, as it is not required
for the tests to work correctly.

Thanks.

