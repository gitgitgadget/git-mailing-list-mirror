Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E380919D094
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245289; cv=none; b=Tb5hTOuXmkpnoIgtPOj6QPSqn0viO7P53BhpegjyJr3K7KNQxp+jiOOCrlj7qOLym2r4D/CHVvv3yiXpDYHKeJWLZmT29TyaVkpFyNjoKI4oRnE39eHDVzifpfkVMnn2DlO2BOKpWWmWuygROsbGiyYma1uSxLvLZ636o4tF4V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245289; c=relaxed/simple;
	bh=M7dZjpiH8okpT1FozoW2HqS8RLk5mWDOzsV+rcHzcLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d4a6yicOJvFSjtvcxgJZi6nIMilgd7/gF8n1Xnj5bgNnOqrkEPdMGb7H4hbpJpRgmyLt60FxSw5DxsGhtvQg3Shq2+Kq87XHPl0fO0mz7TGDd8mU3naBpSki05uxj7Boqv6qSfplGcyp9P4IbPz5nc5wMqrxIwbETtp4Hm3PUOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aaLcvcXi; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aaLcvcXi"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AF0682F505;
	Mon, 24 Jun 2024 12:08:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=M7dZjpiH8okpT1FozoW2HqS8RLk5mWDOzsV+rc
	HzcLg=; b=aaLcvcXiQWSmO6pxC3notNeisrXLoJoMpJfc1W/XWvY2B5h7tk63q1
	xVCmcQzs7oimtgdfvS9xEHm6LHWw9I3PlsW4ENuebtFpOCO4zUDDdaMnWqqJOHgE
	jRNj7NT65924kViaI3zsvKJT45sRPHwcqZ9+CyRzFP6pXIVN7SmXI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A77482F504;
	Mon, 24 Jun 2024 12:08:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C9B6F2F503;
	Mon, 24 Jun 2024 12:08:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Eric Wong <e@80x24.org>,  "Eric W. Biederman" <ebiederm@xmission.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] object-file: fix leak on conversion failure
In-Reply-To: <1f536f91-1dce-4156-98f2-4059cd5235ff@gmail.com> (Derrick
	Stolee's message of "Sun, 23 Jun 2024 12:34:51 -0400")
References: <20240622043648.M78681@dcvr>
	<1f536f91-1dce-4156-98f2-4059cd5235ff@gmail.com>
Date: Mon, 24 Jun 2024 09:08:03 -0700
Message-ID: <xmqq8qyue330.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F05A6570-3243-11EF-8988-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Derrick Stolee <stolee@gmail.com> writes:

> On 6/22/24 12:36 AM, Eric Wong wrote:
>> I'm not sure exactly how to trigger the leak, but it seems fairly
>> obvious that the `content' buffer should be freed even if
>> convert_object_file() fails.  Noticed while working in this area
>> on unrelated things.
>
> Definitely a good thing to include, even if it is unlikely to
> be hit frequently in common scenarios.
>
>>   			ret = convert_object_file(&outbuf,
>>   						  the_hash_algo, input_algo,
>>   						  content, size, type, !do_die);
>> +			free(content);
>>   			if (ret == -1)
>>   				return -1;
>> -			free(content);
>
> I looked at the context of this function to see that 'content'
> was local to the method, so was not "owned" by something outside
> of the method that might expect to reuse the buffer on failure.

Thanks, both.

Will queue.

