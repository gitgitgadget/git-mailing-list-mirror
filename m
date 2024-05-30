Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB8A18757C
	for <git@vger.kernel.org>; Thu, 30 May 2024 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717084869; cv=none; b=qFfpClLXvu3tWX49KoEw3o6rfSP/C1T3NocsFyz0exZKSb9GzPqHmzghp2lwfpSD7SGBITXBMKMQRuK/kjFdjEvnBTkiDDjw5D6grKlb6pgTuLZf8YZ6nfZEqWX5kV65Fldj90tfjIqt1WO3/NoZ+1Tzx34corn/U7kOHPfi3yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717084869; c=relaxed/simple;
	bh=nYCI98i7s4cClMObQ6PU6AEgOV4FPA2aYsGKfb3qTsg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZNaPnBd2tJkAgqMAxK13wQdUnIFlFBGcUnBPV7NT5CMW/UhEhLlT1HojUUExScljqqL0PnpT7S5oPNbXDwYKNQvYv9/8cVIAoxGx3hVZkpqj8MmyLVo2yxy9fchoJTWrWKX5W44ZdpcnU2F6dnMwyQifka3Xqy0fUy4dMTOVpmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FfaVZERF; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FfaVZERF"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C72543A43D;
	Thu, 30 May 2024 12:01:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nYCI98i7s4cClMObQ6PU6AEgOV4FPA2aYsGKfb
	3qTsg=; b=FfaVZERFiUdbbCED/7c7wkwpZNMvJqcA8RqYSi6n20lyM4zZdfMdXk
	pyHui07AKZncD3QXshws8SI+mGJ5exzHTlXxPc2ppYxHrcYAId32tU3urNl4lTwf
	hZbhfiLE65e+c43f7ZkJkOchqBDTu1qofuVJ9AGL9H5ZyZUKATXAk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B516C3A43C;
	Thu, 30 May 2024 12:01:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F05803A434;
	Thu, 30 May 2024 12:00:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/19] global: convert intentionally-leaking config
 strings to consts
In-Reply-To: <ZlhjRtRwxlnchOaV@tanuki> (Patrick Steinhardt's message of "Thu,
	30 May 2024 13:30:14 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<8f3decbb762916a536ec7a8d319c5903bd8f30c1.1716983704.git.ps@pks.im>
	<xmqqle3sy1cq.fsf@gitster.g> <ZlhjRtRwxlnchOaV@tanuki>
Date: Thu, 30 May 2024 09:00:58 -0700
Message-ID: <xmqqfrtzqog5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CECC6084-1E9D-11EF-8EFA-8F8B087618E4-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, May 29, 2024 at 10:28:05AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > There are multiple cases where we intentionally leak config strings:
>> >
>> >   - `struct gpg_format` is used to track programs that can be used for
>> >     signing commits, either via gpg(1), gpgsm(1) or ssh-keygen(1). The
>> >     user can override the commands via several config variables. As the
>> >     array is populated once, only, and will never be free'd, it is fine
>> >     to treat the program as a quasi-constant.
>> >
>> >   - `struct ll_merge_driver` is used to track merge drivers. Same as
>> >     with the GPG format, these drivers are populated once and then
>> >     reused. Its data is never free'd, either.
>> >
>> >   - `struct userdiff_funcname` and `struct userdiff_driver` can be
>> >     configured via `diff.<driver>.*` to add additional drivers. Again,
>> >     these have a global lifetime and are never free'd.
>> >
>> > All of these are intentionally kept alive and never free'd. Let's mark
>> > the respective fields as `const char *` and cast away the constness when
>> > assigning those values.
>> 
>> It is not unclear where the linkage between "not freed" and "must be
>> const" comes from.  What am I missing?
>
> It comes from `-Wwrite-strings`, which will mark string constants as
> `const char *`. This will cause warnings in all of the above cases
> because the fields are being assigned constants, but those fields are
> currently `char *`. Will clarify.

In short, these warnings have nothing to do with the pointee by
these variables or struct members are eventually freed or not, no?

