Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FB81350E0
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706134435; cv=none; b=bwUgdYxyCj5O/Zmard30fQeHc6eV9ud5s3+RgJMFjFIhUfsCUuLl7O96iiLg9iTWjp0MElU2qnTgFYYVcPb68/fairA439gzzuPQa0CWNrNlsP2YqSnpFBZK1iCuZeUZ5j9k5UmKhtup+x8K5nXVi3YODr4FgDD6z4JA6uQ39EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706134435; c=relaxed/simple;
	bh=H53aGB2g6nzxtk4WrGhcuEjjVKcQLovE8CO0JSYbgY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gD4StMpg32qWD5hqOpYOhK/CDvQIoEAkVzQQPD8+d7U62pRQMi/tPInooe3eE02EcMJfxV8+CKX44L72VhbZAHUquJAocvVv1rpgl2zP9qS6t55NaaFpvTE3KJQweCvVLVodGTHRCwomsg6oYX2Z4AhfdSvovgTli3gYrfRnpAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nPhGMfgF; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nPhGMfgF"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4BAD425D12;
	Wed, 24 Jan 2024 17:13:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H53aGB2g6nzxtk4WrGhcuEjjVKcQLovE8CO0JS
	YbgY8=; b=nPhGMfgFG8xRz0lGUsTWR0WaIgImbn980XGI6HJOTTyqmUyha3wiIs
	qCAGpCkyk3gwExpluuPDMkp+0UYdhrDUSJc3DjcRcSkOZ2awwScsbqT/2y2Txpvq
	HtfKSXthq+zrpy1WUawl6Qr1/L0JT/Sd9oysmGSOexWuh59Fc5aic=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4460425D11;
	Wed, 24 Jan 2024 17:13:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9A17D25D10;
	Wed, 24 Jan 2024 17:13:42 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Elijah Newren <newren@gmail.com>,  Michael Lohmann
 <mi.al.lohmann@gmail.com>,  git@vger.kernel.org,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 2/2] revision: Implement `git log --merge` also for
 rebase/cherry_pick/revert
In-Reply-To: <0a061bee-9b78-419f-9f1a-ced69ca96002@kdbg.org> (Johannes Sixt's
	message of "Wed, 24 Jan 2024 23:06:49 +0100")
References: <xmqqzfxa9usx.fsf@gitster.g>
	<20240117081405.14012-1-mi.al.lohmann@gmail.com>
	<20240117081405.14012-2-mi.al.lohmann@gmail.com>
	<CABPp-BE4zqRX=wd5EBj96hzCS8V73QpdN-2pCpv7qMdkpkX93w@mail.gmail.com>
	<dfb582cf-b1e4-414d-bfe1-0f93d910ec54@kdbg.org>
	<xmqq1qa6ecqr.fsf@gitster.g>
	<0a061bee-9b78-419f-9f1a-ced69ca96002@kdbg.org>
Date: Wed, 24 Jan 2024 14:13:41 -0800
Message-ID: <xmqqbk9abcru.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D583DF84-BB05-11EE-8D07-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

> Am 24.01.24 um 20:46 schrieb Junio C Hamano:
>> Johannes Sixt <j6t@kdbg.org> writes:
>> 
>>> Good point! IMO, REBASE_HEAD should have lower precedence than all the
>>> other *_HEADs. It would mean to reorder the entries:
>>>
>>> 	static const char *const other_head[] = {
>>> 		"MERGE_HEAD", "CHERRY_PICK_HEAD", "REVERT_HEAD", "REBASE_HEAD"
>>> 	};
>>>
>>> (and perhaps adjust the error message, too).
>> 
>> And probably give a warning saying that we noticed you are rebasing
>> and cherry-picking and we chose to show the --merge based on the
>> relationship between cherry-pick-head and head, ignoring your rebase
>> status, or something.
>
> I don't think that's necessary. When rebase stopped with a merge
> conflict, neither of the other commands can begin their work until the
> conflicted state is removed. That should be a concious act, just like
> when thereafter one of these other commands is used and leads to a
> conflict. At least I would certainly not need a reminder.

OK.
