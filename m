Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F101974E7
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688945; cv=none; b=F4vxEgB6l7YepncUzkmAJ8CgecDgHCm8llLOBsaOiRs42IrskDLeHQt0bjcPvpmqDnQiLo297fSTz4zEu/j6lF7Obn3IUHT/dO2tFy0o+fP2Ilq9pbYpKLSTcjzy+WFlqJeJyTPG53u3KGsBq8iFu1cUVI40EBtEKqB/r1pVegA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688945; c=relaxed/simple;
	bh=2pDLjTkQXRnmEX369JK2JzaXF3wU/eGJ3A8tUtpRgBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B0tYv9s8biXMUWIYfHWjLdcYLH2xg3SNWWN80XR5dpbi6jzNKyfulre+XMs9Qfh5NOYrXNpJY5nqiyoDS0F5GaLLkYtVP4s3oyOGAJy+L+CzOVJwHnkg/cySFrIAVZwwydku0QvBo4ll8TQfagkamrZG426WZrqYWYBDvDXQk9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cBuSZEX0; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cBuSZEX0"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AAB2D2E4B7;
	Thu,  6 Jun 2024 11:49:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2pDLjTkQXRnm
	EX369JK2JzaXF3wU/eGJ3A8tUtpRgBc=; b=cBuSZEX0jZRyeGuR1edYYp3vkSLp
	x3UnEDTJfCx0G0qnF3W0E+Zy8N3DjnhAdZ1kKro5MRrdQnxSNTwoO1SxbLv9uC+J
	uR3Ex/E/Dn8wHP4GV6eQoGQQE+vSRFjL2j5O2oijgMEDflTY5y/IEdWYxLlqrp8L
	7Px6rt8PC+rAh1s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A5452E4B5;
	Thu,  6 Jun 2024 11:49:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C4BB2E4B4;
	Thu,  6 Jun 2024 11:49:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Johannes Sixt <j6t@kdbg.org>,  German Lashevich
 <german.lashevich@gmail.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] diff: let external diffs report that changes are
 uninteresting
In-Reply-To: <55389f35-5762-4b86-81bf-b9fe956815d2@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Thu, 6 Jun 2024 10:28:24 +0200")
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
	<82561c70-ec33-41bf-b036-52310ffc1926@web.de>
	<e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
	<6fa51a62-5dc1-4865-9f79-eaf7d65189ab@web.de>
	<99a99e5c-4fe4-413a-9281-363e280716b8@web.de>
	<1c055e96-76b0-4174-a8e2-cb6df041fabf@kdbg.org>
	<55389f35-5762-4b86-81bf-b9fe956815d2@web.de>
Date: Thu, 06 Jun 2024 08:49:00 -0700
Message-ID: <xmqqsexqnkb7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 4BC4D200-241C-11EF-A5EC-B84BEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>> +diff.trustExitCode::
>>> +	If this boolean value is set to true then the `diff.external`
>>> +	command is expected to return exit code 1 if it finds
>>> +	significant changes and 0 if it doesn't, like diff(1).  If it's
>>> +	false then the `diff.external` command is expected to always
>>> +	return exit code 0.  Defaults to false.
>>
>> I find this somewhat unclear. What are the consequences when this valu=
e
>> is set to false, but the command exits with code other than 0? Is it
>>
>>     If it's false then any exit code other than 0 of the `diff.externa=
l`
>>     command is treated as an error.
>
> Yes, unexpected exit codes are reported as errors.
>
> If trustExitCode is false and --quiet is given then the execution of
> external diffs is skipped, so in that situation there is no exit code t=
o
> expect, though.  Not sure how to express it concisely, though.  This
> attempt looks a bit bloated:
>
> --quiet::
>         Disable all output of the program. Implies `--exit-code`.
>         Disables execution of external diff helpers whose exit code
>         is not trusted, i.e. their respective configuration option
> 	`diff.trustExitCode` or `diff.<driver>.trustExitCode` or
> 	environment variable `GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE` is
> 	false.
>
> Might be worth documenting this original behavior somehow, anyway.  It
> makes sense in hindsight, but surprised me a bit when I wrote the tests=
.

Yes.  The explanation of trustExitCode makes sense as an explanation
of what the variable means (i.e. if set, we pay attention to the
exit code of the external diff driver, otherwise a non-zero exit is
an error), but I suspect that readers are _more_ interested in how
the external diff driver contributes to the answer to the "has this
path been changed?" question when the variable is on and off.  And
the above description of "--quiet" does help answer that question
somewhat.

