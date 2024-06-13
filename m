Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C54812DD83
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295376; cv=none; b=ee1KOpIpkbMq031zR3ATjXNlMkzhY+56bgRpeX6dZRIS39fmSz9YFRmrODeCi/MOlAr//NVWIfwrIgdwwSaasN9XZWKZcSEhuNiEI+xM4BVT9OYp/JlEr0OpKMfVQNyDjimM4+YNAndC99Om4yw5WDDoc8ISlhMq4m0CVAx1dmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295376; c=relaxed/simple;
	bh=I8/Cdv+Il2+P99sq3ZqpembmlQOBoOqyebX1aBOsGKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eO6yWmRBbSjgm869OnoEg70dwzdYVxJGhF/smMYwyHXrmQdbg78VlyJ57lOfTS3juy7pwA33J2K2h1G5Uh1pX4K32AB6BZMAgGquXMnzUNsgT8A/g4+pqE/iANXBQkhqjBOPVg+uuGqXhU9ArmPN9VoFdenOjSgrtiouPGT589c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=X9MUd7PF; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X9MUd7PF"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EF8A51A3D2;
	Thu, 13 Jun 2024 12:16:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=I8/Cdv+Il2+P99sq3ZqpembmlQOBoOqyebX1aB
	OsGKM=; b=X9MUd7PFHeIeQQV/vQmBspRNPaZz5xz2K69STQpTB+gKlEipldpz1N
	XlCGh0kzKTW2vx+zbBloQ2mifASQhQwJqUkPuAVsAKoeRBYjiAax8S6/6AApssQN
	0UWuE2iQLYIxAHIvzSaBAc7lFspiWa+MIlIt8GuS7abSf72kFVVMU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E6F0F1A3D1;
	Thu, 13 Jun 2024 12:16:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D7A81A3D0;
	Thu, 13 Jun 2024 12:16:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  darcy via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  darcy <acednes@gmail.com>
Subject: Re: [PATCH v3] date: detect underflow/overflow when parsing dates
 with timezone offset
In-Reply-To: <a03cd45e-e4e0-42c7-bb98-b25cac12e42f@gmail.com> (Phillip Wood's
	message of "Thu, 13 Jun 2024 14:31:06 +0100")
References: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
	<pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
	<CAOLa=ZTgP+OwVrT87=og4tVdhsqjErMUJzCuT9bdDatFS=J8hQ@mail.gmail.com>
	<a03cd45e-e4e0-42c7-bb98-b25cac12e42f@gmail.com>
Date: Thu, 13 Jun 2024 09:16:12 -0700
Message-ID: <xmqqle38n7hv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 40F97004-29A0-11EF-AC25-965B910A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> +/* timestamp of 2099-12-31T23:59:59Z, including 32 leap days */
>>> +static const time_t timestamp_max = ((2100L - 1970) * 365 + 32) * 24 * 60 * 60 - 1;
>>>
>> Nit: but since we're calculating the number of years here (2100L -
>> 1970), shouldn't we also be calculating the number of leap days instead
>> of hardcoding it?
>
> I'm happy with a hard coded constant for the number of leap days - I
> think it is probably easier to check that (which I have done) than it
> would be to check the calculation as I'm not sure off the top of my
> head if is it safe to do (2100-1970)/4 or whether we need something
> more complicated.

It's even OK to use a hard coded constant for the number of days
since the epoch to the git-end-of-time ;-)

The timestamp of the git-end-of-time would not fit in time_t on
32-bit systems, I would presume?  If our tests are trying to see if
timestamps around the beginning of year 2100 are handled
"correctly", the definition of the correctness needs to be
consitional on the platform.

On systems with TIME_T_IS_64BIT, we'd want to see such a timestamp
to be represented fine.  On systems without, we'd want to see the
"Timestamp too large for this system" error when we feed such a
timestamp to be parsed.

Thanks.
