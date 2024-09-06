Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2996C1E4BE
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634514; cv=none; b=KRD6/XerzFaXrDpw2DWQkieNHw8mQd9kWnbDNYdTFOhAAHLU91jGkH35vU6GVxTg+Jk1kkcARb1Ay2xLWObXxTjcBLUPo8AIzi2vA7qPvlVEdZxLGf6Q7X9YBbcQ/O+lSp+HzbU2Clj9APzKxXu7DkzjQF0gJ7q2j28xHfQ+JAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634514; c=relaxed/simple;
	bh=Cod7gNPD7fzaMsVtH5+dhTY3ojDTBA6LM7PlNMWePBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JUk8pv+MF5kQHTumjKteGWdNwVGzTHVDvfrUfcWfQ1hKEc/gkmX2LK4QL4y/yGXh+2GAN0R8QA4XL4GL8Ud8BWF7zTmZZdbl1Jz8+wiJKXebYAGjGBllqb8AL7SEmrAKAio2i2DSvr6N+3eKwcs7YqAnyBLpt1YSeUF8PHJhefo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hOG79K05; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hOG79K05"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F16141A71C;
	Fri,  6 Sep 2024 10:55:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Cod7gNPD7fzaMsVtH5+dhTY3ojDTBA6LM7PlNM
	WePBI=; b=hOG79K05KuJeBUZsOiAhFNtYcF2C8ST01yizdYQ294IGgHn7y5NyNl
	MsH0IHc4oKidaSC0vdSVwQxUBQ6HG3mlqj42ChwdJV7hvCWsUgUU6wLfuydpAggS
	lnlntoTbabGB2kCPQLCmY4bVYatT9TNHRTrWSGSFT5CoRFKDi1Dts=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E4CD31A71B;
	Fri,  6 Sep 2024 10:55:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3AA401A719;
	Fri,  6 Sep 2024 10:55:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] sparse-checkout: use fdopen_lock_file() instead of
 xfdopen()
In-Reply-To: <20240906011935.GA2616101@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 5 Sep 2024 21:19:35 -0400")
References: <20240905082749.GA88220@coredump.intra.peff.net>
	<ZtmN6sZCvDy1BGfn@pks.im> <xmqqr09xztqa.fsf@gitster.g>
	<xmqqmsklztkd.fsf@gitster.g>
	<20240906011935.GA2616101@coredump.intra.peff.net>
Date: Fri, 06 Sep 2024 07:55:09 -0700
Message-ID: <xmqq1q1wzvaq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 04111A54-6C60-11EF-BDF3-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

>>  	fp = fdopen_lock_file(&lk, "w");
>>  	if (!fp)
>> -		die_errno(_("unable to fdopen %s"), get_lock_file_path(&lk));
>> +		die_errno(_("unable to fdopen %s"), sparse_filename);
>>  
>>  	if (core_sparse_checkout_cone)
>>  		write_cone_to_file(fp, pl);
>> @@ -356,11 +355,13 @@ static int write_patterns_and_update(struct pattern_list *pl)
>>  		write_patterns_to_file(fp, pl);
>>  
>>  	if (commit_lock_file(&lk))
>> -		die_errno(_("unable to write %s"), get_locked_file_path(&lk));
>> +		die_errno(_("unable to write %s"), sparse_filename);
>
> Note the difference between "get_lock" and "get_locked" in these two.
> The first will mention the tempfile name, and the second the destination
> filename (and sparse_filename is the latter).

I did consider ... to write %s.%s", sparse_filename, LOCK_SUFFIX)
but then thought that the final name is what is more relevant to the
end user.  Yes, while correcting unrelated error, I shouldn't have
tried to improve unrelated end-user experience ;-).

> Will send v2 later tonight. Thanks, Patrick, for noticing the problem in
> the first place.

Yeah, thanks, both.
