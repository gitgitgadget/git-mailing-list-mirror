Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FC518E04F
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134693; cv=none; b=tIxbR7UhhARzP2d2581vAgFXmxXBHJU+/lzpTBVaPoYvfUxKz+tXjRmLNunyyt455JD/XqG0+ViAwQRsC4J8K6kwVK1B88MvhK7aq1o0SJljvlvMEJiCt9keeOHxeGayD/3On35eyjQDV3w4F+MPGD0QUoDB1XScR+HSdBnEEZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134693; c=relaxed/simple;
	bh=3u1dmjqv6QwBcONmLmzNnHMOcvjTIj4E0EP8P7S5ETI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IOrEH+aUyssxXfGXJHy/kxxZWZcnUDqKVYpZwmRhW9dkL24Y+ejZW44eDaa39vu7woPalcKTUQAWq8z60Tz+Dp0vyWXIwf78I5fWEfOR1aKG2aPpzJslvJ5xSsZ/afxLGK9gU3d3Di5b6QhstRrLmL5brJ2SbjuxxCW9ES9xStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YkUoajKz; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YkUoajKz"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A2F622AC1;
	Thu,  8 Aug 2024 12:31:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3u1dmjqv6QwBcONmLmzNnHMOcvjTIj4E0EP8P7
	S5ETI=; b=YkUoajKzaNaQLWLgraq9RFTpL8KLP2dbmGA+EBxuAk/0cJ178ZusZB
	G4vZtzAGnvdSJBddnxpn6R65z95b7lgYw18u58TZyTe4y+poHr+1fyApDRhLL5Dr
	z4ah1cZK6mHgeB0j5mD0GnZ48G1iUIITgecyFnmbRr07pjQfT9VOA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4212C22AC0;
	Thu,  8 Aug 2024 12:31:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A716C22ABF;
	Thu,  8 Aug 2024 12:31:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 15/22] sequencer: release todo list on error paths
In-Reply-To: <e0685657-369f-4211-8518-cc41aa28dcb9@gmail.com> (Phillip Wood's
	message of "Thu, 8 Aug 2024 11:08:23 +0100")
References: <cover.1722933642.git.ps@pks.im>
	<df4c21b49f86d6e1e9d2b28375ab6465ffa4339a.1722933642.git.ps@pks.im>
	<e0685657-369f-4211-8518-cc41aa28dcb9@gmail.com>
Date: Thu, 08 Aug 2024 09:31:23 -0700
Message-ID: <xmqqmslnht7o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A752D8FC-55A3-11EF-A882-9B0F950A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Patrick
>
> On 06/08/2024 10:00, Patrick Steinhardt wrote:
>> We're not releasing the `todo_list` in `sequencer_pick_revisions()` when
>> hitting an error path. Restructure the function to have a common exit
>> path such that we can easily clean up the list and thus plug this memory
>> leak.
>
> This looks good, I've left a couple of small formatting comments below
> if you do end up re-rolling.

Oh, formatting nitpicks, my favourite ;-)

>> @@ -5506,11 +5508,14 @@ int sequencer_pick_revisions(struct repository *r,
>>   				enum object_type type = oid_object_info(r,
>>   									&oid,
>>   									NULL);

Also, if we say

				enum object_type type;

				type = oid_object_info(r, &oid, NULL);

the result is much easier on the eyes usign the same three lines.
Yes, initializing while declaring may look nicer and in some cases
it may even be necessary, but not this one.

>> -				return error(_("%s: can't cherry-pick a %s"),
>> +				res = error(_("%s: can't cherry-pick a %s"),
>>   					name, type_name(type));
>
> This line needs re-indenting to match the changes above.

Thanks.
