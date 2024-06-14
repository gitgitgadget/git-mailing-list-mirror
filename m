Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED6B1EB25
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718399033; cv=none; b=nSucLbwHuMqWiDL6yPe6PV+9IidK6JhUYpkoBEIfjnXnF/PVyTGJq+qLeT7QjSWUJZ0jooSbqEYSP9HKId20h4i3rfbDzS5R8TwHDBZfRH3BPaihaAt6SVhl3G/R1rmyGwMJHVFLJxOJSH3hlsVxo3lhoY4NVhMMTG4LuyQWU20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718399033; c=relaxed/simple;
	bh=ZMJFF8evWa9Sh6FUCBpW7NaNYSEtHPDAzyChUp5KQI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CXVDJo2OWWLylK41oYa3c0pvWMBgmPtrfrcQsEprg4LPLaPCR0U4bmlcJtanxoj5In4+eOA5/P3f8yN+itbRtmbu9TSRJ7Gaw4cxxdcLsACj4tOzBZhS1RuYev7Rimc+H4Bd1yoDh2DUMYe4LRqaell8FTtkKeiwOWH+f7FVmcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Od2wPJkO; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Od2wPJkO"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E66852107F;
	Fri, 14 Jun 2024 17:02:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZMJFF8evWa9Sh6FUCBpW7NaNYSEtHPDAzyChUp
	5KQI8=; b=Od2wPJkOUBmDYAiVE5OPM0f9Ai83ohh0Qchznm0O/OlVgx9xsfUQEW
	PtCpUNEXcfr8Y++7UfWBiu0Jsazs1KA3dY35oQGqcNMmb/WdCH6EtUpU2q23OO9u
	p4RNG50uUJfMSIcGG4bDa9mWSKCLh9S0M6aDi3cldgID4vPfOcl7Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DEC162107E;
	Fri, 14 Jun 2024 17:02:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1D0B22107C;
	Fri, 14 Jun 2024 17:02:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  darcy via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  darcy <acednes@gmail.com>
Subject: Re: [PATCH v3] date: detect underflow/overflow when parsing dates
 with timezone offset
In-Reply-To: <CAOLa=ZT2goTBD6WBtjYOYqa6vEsp=P=UzUBzs-5Om3d9HLZYbw@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 14 Jun 2024 13:09:08 -0700")
References: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
	<pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
	<CAOLa=ZTgP+OwVrT87=og4tVdhsqjErMUJzCuT9bdDatFS=J8hQ@mail.gmail.com>
	<a03cd45e-e4e0-42c7-bb98-b25cac12e42f@gmail.com>
	<xmqqle38n7hv.fsf@gitster.g>
	<CAOLa=ZT2goTBD6WBtjYOYqa6vEsp=P=UzUBzs-5Om3d9HLZYbw@mail.gmail.com>
Date: Fri, 14 Jun 2024 14:02:25 -0700
Message-ID: <xmqqjzirdyqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 67C4C96C-2A91-11EF-B647-C38742FD603B-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

>> It's even OK to use a hard coded constant for the number of days
>> since the epoch to the git-end-of-time ;-)
>
> That's why I noted it as a _Nit_, mostly because it wasn't anything big.
> But I found that part of it being dynamic and part of it being static
> was inconsistent.

Sure, but it is so tiny thing, we shouldn't waste more time than we
spend getting the tests right even on 32-bit systems.  We seem to be
doing the opposite by talking about this part even more, which is a
bit sad.  Any comments on the actual patch I sent as a follow-up?

>> The timestamp of the git-end-of-time would not fit in time_t on
>> 32-bit systems, I would presume?  If our tests are trying to see if
>> timestamps around the beginning of year 2100 are handled
>> "correctly", the definition of the correctness needs to be
>> consitional on the platform.
>>
>> On systems with TIME_T_IS_64BIT, we'd want to see such a timestamp
>> to be represented fine.  On systems without, we'd want to see the
>> "Timestamp too large for this system" error when we feed such a
>> timestamp to be parsed.
>>
>> Thanks.
