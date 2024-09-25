Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1096614600F
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295983; cv=none; b=kF/X1Rzc1qgL29AlnY3zRxlvyY/oirUMf4kk7kTiQ2CDs7sTK63etBpWu60iAYQKE0rUfMmxH3FT7vaGL6VlfTafjh8DBNc9+yMOL05o5KoHvBO00sYi4IEpasNrMorMkefYeMw2H8v3CljrVf4+0fhmZgx6exm9ZQ/YFYEbM3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295983; c=relaxed/simple;
	bh=tDyXJNU9KOvXH0ihtNv74VAzJOzlXHFxa3FnhBok6gg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CqLGWtyk38fXu9BfJGU48K0sdCQbejWiMd1bUtT+jgpnuMtUSiBIz7N0nACWQw+rX3YMMu+bnHBhrtJ/w7p+wkW1Q+tYVq8XgcYYs07qeoo67cmxvzxVQO+AEL7j8fWabyfw9o4wHH+/o5ddBZXptFcwGQys72ouvAAhb28DwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rsMlkE2P; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rsMlkE2P"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D4DB22CFD6;
	Wed, 25 Sep 2024 16:26:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tDyXJNU9KOvXH0ihtNv74VAzJOzlXHFxa3FnhB
	ok6gg=; b=rsMlkE2PGbVdbBDCc7Te+4NkyUK29obVkcyqMaKaVzxrOFB5Ck7IZ8
	q+TOwzkcFjWolPRqRdhQB8LtYu5yytepjRdE4s6T/kYETnw7CZ0wGEo58+uHE6Ma
	YlzOu11iYZ/QrnmDkh+auZT28ePf7anydrZsFH7rmyXrKXI8zk6DM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CBDFA2CFD5;
	Wed, 25 Sep 2024 16:26:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 376D42CFD4;
	Wed, 25 Sep 2024 16:26:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 08/23] builtin/submodule--helper: fix leaking remote ref
 on errors
In-Reply-To: <ZulXjXSozNrXgMUM@pks.im> (Patrick Steinhardt's message of "Tue,
	17 Sep 2024 12:19:05 +0200")
References: <cover.1726484308.git.ps@pks.im>
	<d088703d317a8598e1cc4eb068234c105cdeffe6.1726484308.git.ps@pks.im>
	<l5aljv4zlvkfpjsizofsypgfaxdzkihwghd3voxin5oxibuixz@fesroo5tihzi>
	<ZulXjXSozNrXgMUM@pks.im>
Date: Wed, 25 Sep 2024 13:26:17 -0700
Message-ID: <xmqqbk0bo4ye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6C27255E-7B7C-11EF-B03C-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Sep 16, 2024 at 01:51:21PM -0500, Justin Tobler wrote:
>> On 24/09/16 01:45PM, Patrick Steinhardt wrote:
>> > When `update_submodule()` fails we return with `die_message()`.
>> > Curiously enough, this causes a memory leak because we use the
>> > `run_process_parallel()` interfaces here, which swap out the die
>> > routine.
>> 
>> Naive question, is `update_submodule()` itself being run in parallel
>> here? Is that why the die routine gets swapped out so a child process
>> dying is handled differently? Also is it correct to say leaks are not
>> considered when we "die" normally? 
>
> Hm. Revisiting this patch: my analysis was wrong. It's not the parallel
> subsystem that swaps out `die()`, but it's the fact that we call
> `die_message()`, which actually doesn't die. It really only prints the
> message you would see when we call `die()`, nothing more.
>
> I'll amend the commit message and send out the amended version once
> there is more feedback to address.

So it has been a week and half since the series was posted and it
seems that this is the only thing you might want to touch up.

What's next?  Just have an updated patch [08/23] and nothing else
and be done with it?  A v2 round of 23-patch series hopefully will
see somebody other than Justin and I lend an extra set of eyes to
double check before we merge it to 'next'?

Thanks.


