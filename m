Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A618DF8A
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859676; cv=none; b=RrAtrlQXKMgYHejsoHfBSXYom/v+oaG32qIPM67Q1EbRrDd2EMsXIqGmlWZbQSYJZDIt2epOw0i2yUKrVmXBeGQ2dLpJBazWzqUyrxAz8RDxDHjqzcYj4kDcUqk2w1NbDTKAQDKVjfgCEXldDgoZmK0bl5c2Jg6YJKMHmo6U2To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859676; c=relaxed/simple;
	bh=Ps3/abc/8+LC5eMKcExz3UJPmyAV9Y7/3vLMjLcX5zo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RyysPjRq+JstG5gukgkoRZHWfl9/oKe1rARwmHVCrVi8aCLF0Yjk20QHhXk3qO+o/WAUDXrTRhbdgDIFnjYM6frFKZZVGRErtBMxwYrUU84/aavPRDtQmPAXsG/C/Q5ojFEs0t232sDulzbc3r7WervfphPCvRc3JogsllxwZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pLEaT3qw; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pLEaT3qw"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3FFF53B3D5;
	Wed, 28 Aug 2024 11:41:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ps3/abc/8+LC5eMKcExz3UJPmyAV9Y7/3vLMjL
	cX5zo=; b=pLEaT3qwDfIov4NhS0Lsf8XEF0Zy9r3C8g0eIkk10jMnKKTjmfPJmm
	EIgVqo0qrExgWhJDol80hLWWvkjbvAy1xUhkeo5wyA/0DvmfDVKdrYzqmmXdg6K8
	TqYWvgmf6ioLc6BunfP18/FqFKUFOoUfndGkHvftbDDUEu0Ha2fQ4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 391F63B3D4;
	Wed, 28 Aug 2024 11:41:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A503B3B3D1;
	Wed, 28 Aug 2024 11:41:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v2 3/4] ref: add symbolic ref content check for files
 backend
In-Reply-To: <Zs8dAc0ss9KbwIDs@tanuki> (Patrick Steinhardt's message of "Wed,
	28 Aug 2024 14:50:09 +0200")
References: <Zs348uXMBdCuwF-2@ArchLinux> <Zs3558scHssaG_XS@ArchLinux>
	<Zs8dAc0ss9KbwIDs@tanuki>
Date: Wed, 28 Aug 2024 08:41:08 -0700
Message-ID: <xmqqbk1c3baj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F27F895A-6553-11EF-BDD9-BF444491E1BC-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Also, I think we don't typically call the value of a symbolic ref
> "pointee", but "target". Searching for "pointee" in our codebase only
> gives a single hit, and that one is not related to symbolic refs.

Yesterday while I was studying for reviewing this series, I saw some
existing code that call them "referent".  There may also be "target".

>> +	if (!newline_pos || *(newline_pos + 1)) {
>> +		ret = fsck_report_ref(o, report,
>> +				      FSCK_MSG_REF_MISSING_NEWLINE,
>> +				      "missing newline");
>> +	}
>
> The second condition `*(newline_pos + 1)` checks whether there is any
> data after the newline, doesn't it? That indicates a different kind of
> error than "missing newline", namely that there is trailing garbage. I
> guess we'd want to report a separate info-level message for this.
>
> Also, shouldn't we use `strchr` instead of `strrchr()`? Otherwise, we're
> only checking for trailing garbage after the _last_ newline, not after
> the first one.

None of the above.  It should strbuf_rtrim() and if we removed
anything but just a single terminating LF, we are looking at
something we wouldn't ahve written.  The next check_refname_format()
call would then find "trailing garbage".

 - "refs/heads/master \n " gets rtrimmed to "refs/heads/master",
   which is "valid but curious".

 - "refs/heads/main trash\n " becomes "refs/heads/main trash",
   which is outright bad.

