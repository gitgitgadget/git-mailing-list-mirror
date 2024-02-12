Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4FB45BE8
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762465; cv=none; b=JuxAXn8kx754YiLJgRuj8Ntz9YEwas2FrPGIl3jvnwBIRIhF2d9LR5mLYsMt8SLUZFi4e3JaSxaG5H07siMhzmGB4S//vjTN9D6Jkw6iEkNsGvgqXOGZpTdYggsrfFc3ESdfGQaYpo0zFt2J5LLCFFT9BnSNJuUmsEEPzk8FZ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762465; c=relaxed/simple;
	bh=uHlv7jTFAXmTRi3ojNnyTb4eB07FAmPcXF3jOHoWWp4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NhAfwQNyRPMD3G8y8oke0O2e5HBDhDyDJ7S2XpRy0oYvFHCU55eML1GYZC+0ebBZd/ShQbyZF2BRvXi+LyVMcS5ctXH394ZvLTLPCU4zobgAPJyXYMWA8+kKq08VCtIHxhd/qWM0F+ln4UoysjSEGR3AAJYLAFDxO4F1MQaqFTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wdkrLLl5; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wdkrLLl5"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 80A5A1DF02F;
	Mon, 12 Feb 2024 13:27:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uHlv7jTFAXmT
	Ri3ojNnyTb4eB07FAmPcXF3jOHoWWp4=; b=wdkrLLl5LZtp42+AK90PK5eZTWm6
	EAORO+9EZPKSWWntPnnkoxyd7ueDY1K5yJLBjfe4LF2fWgJo/Ufji4mKDDTSBzvv
	1KOKh5Ql4DOewAj9CSqUBEJPhj0xfqRGFD9o/Ib4GDGoH1u9PFf7cm2VKUZbpPAR
	VmK0vtdzq1a08fc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7753B1DF02E;
	Mon, 12 Feb 2024 13:27:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D30181DF02D;
	Mon, 12 Feb 2024 13:27:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>, Johannes Sixt
 <j6t@kdbg.org>
Cc:  Elijah Newren <newren@gmail.com>,  Michael Lohmann
 <mial.lohmann@gmail.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Patrick Steinhardt <ps@pks.im>,  Michael Lohmann
 <mi.al.lohmann@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4 2/2] revision: implement `git log --merge` also for
 rebase/cherry-pick/revert
In-Reply-To: <529c7b42-c606-408e-b6a3-fe189c28db9b@kdbg.org> (Johannes Sixt's
	message of "Sun, 11 Feb 2024 18:59:09 +0100")
References: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
	<20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-2-3bc9e62808f4@gmail.com>
	<2cf557e9-bf48-4bf3-be24-c1eeaa887418@kdbg.org>
	<1c258037-cb08-5fbc-d473-743a60cd8eab@gmail.com>
	<529c7b42-c606-408e-b6a3-fe189c28db9b@kdbg.org>
Date: Mon, 12 Feb 2024 10:27:40 -0800
Message-ID: <xmqqmss55yhv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 6884778A-C9D4-11EE-B634-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Johannes Sixt <j6t@kdbg.org> writes:

> Am 11.02.24 um 17:43 schrieb Philippe Blain:
>> Hi Johannes,
>>=20
>> Le 2024-02-11 =C3=A0 03:34, Johannes Sixt a =C3=A9crit=C2=A0:
>>=20
>>>> Adjust the documentation of this option accordingly.
>>>>
>>>> Co-authored-by: Philippe Blain <levraiphilippeblain@gmail.com>
>>>> Co-authored-by: Johannes Sixt <j6t@kdbg.org>
>>>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>>>> Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
>>>> [jc: tweaked in j6t's precedence fix that tries REBASE_HEAD last]
>>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>>
>>> Signed-off-by trailers should occur in temporal order. Therefore, whe=
n
>>> you pick up a commit and resend it, you should keep existing
>>> Signed-off-by and add yours last.
>>=20
>> Thank you, I did not know that. I guess Junio should be kept last thou=
gh ?
>> Or maybe  I should remove Junio's sign-off if I send a new version of =
the=20
>> patch ?
>
> You should *not* remove Junio's Signed-off-by, because the patch went
> through his hands before you picked it up. Then you add your own
> sign-off below. Later, Junio will sign it off again.

In the meantime, this is how I tweaked while queuing.

    Co-authored-by: Johannes Sixt <j6t@kdbg.org>
    Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
    [jc: tweaked in j6t's precedence fix that tries REBASE_HEAD last]
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    [pb: greatly enhanced the log message]
    Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
