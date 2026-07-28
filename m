Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1719441600
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245806; cv=none; b=oNIzSO3J5l0uFiv0GnOsMcxo3ySunwzagaOob56xI+qBLNpUDTCMpPXlJ4OaP3M82SCdg8NWyflaJRuPZq5XA84mBslYIvmDLsUANjaW5hhE848I7UNHdli6h+0xcmvt9cykEr2Iv73eKRUZYCWVM4k5QVBXmU8C6qn1A9BVLXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245806; c=relaxed/simple;
	bh=kx1PYcRYoL67jmXsZXC87cISEBb2qQb4yfxlsu5lh+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ay4k/TiBLGV213/CY6RhdnR5PP2uDRV3gdU+7Otlw0Fc8EI7oN+ywqvbdPWPwq/XqLIrWR2rLkGRvkzn0pNrxXeB2rB3hCGxjwrbG2GnkUaYzqpqNkI1r0xHQcGP71NFuRytOl3xeyWCKCUMqdMjfa3+wHKFD9t4VFQGKDMYuuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=blho625f; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="blho625f"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1785245798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dn8jGGJ9SnUNzqCA3x0/D0wtcq612fk9jJGaBb2W7Sw=;
	b=blho625fD7MtsAKHtCCGSj8EJDmnRKq2k2qI+yJgEBYoN6P8cVpSFxove3rOopV7lBkldz
	sM1N8pUE/KkFNHQ9t739eTI3L0ZCQRHImSvQM0p8rxGCvArv0VwV9QtU48HISBsyWh/+EM
	MnPUnDVWW3yIsTrM2L2INRdjy2v83Uo=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, stsp <stsp2@yandex.ru>, Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] branch: report active bisect run when rejecting delete
In-Reply-To: <xmqqbjbtyd80.fsf@gitster.g>
References: <9865fc6b-e3fe-4614-9ffe-71af776e1796@web.de>
 <590382fb-731b-4e14-911e-ff68356d1082@web.de> <xmqqbjbtyd80.fsf@gitster.g>
Date: Tue, 28 Jul 2026 15:36:22 +0200
Message-ID: <871pcndynd.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> git branch refuses to delete branches that are currently checked out
>> with a message like this: "error: cannot delete branch 'foo' used by
>> worktree at '/path/of/worktree'".  This can be confusing if it's an
>> internal checkout for git bisect.  Report a more specific error in
>> that case to help users that might have forgotten their bisect run.
>>
>> Suggested-by: stsp <stsp2@yandex.ru>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> Changes since v2:
>> - Only report bisect runs as specific rejection reason for now.

Works for me.

>> - Leave rebasing unaddressed because I don't see how to formulate
>>   clear and readable messages for those scenarios, yet.
>> - Collect all checkout reasons of all branches in a simple array for
>>   easy use, e.g. to eventually address rebases or for git status.

That's handy for future use.

>> - Rebased onto the landed test_grep conversion.
>
> The scope of this patch has shrunk a bit.  While the 'in use by a
> rebase' state is still recognized internally, unlike in the previous
> round, we guard users only against the 'in use by a bisect' state and
> the 'in use by being checked out' state.
>
> This is probably a good single step, so unless there are objections,
> let's mark the topic for 'next'.

Yeah, I agree it's a step in the right direction.

I've reviewed the patch and looks good to me.

To answer your other question:

> This reminds me of another recent discussion on rewriting a branch
> that is checked out elsewhere, where the "git history" command
> forgot to apply the same safety check:
>=20
> https://lore.kernel.org/git/e7dbcede-4486-459c-aa64-e44690e01fe0@gmail.co=
m/
>=20
> We definitely need an easy-to-use API to determine consistently
> which branches are in use, and to teach all commands that repoint
> branch tips to use it to offer the same safety to users.  The
> framework that this patch introduces might be a good starting point
> for that effort.

Yeah, there is definetly some overlap here. As far as I can tell this is
a good step in the direction of an API the git-history(1) can use.

--=20
Cheers,
Toon
