Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1469134409
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720034932; cv=none; b=T3UQtF2tcIk3psgXa+e8U+b9lt49Zl06fpxmuLeXgz4Go8pxbtBVmGbive0pfqUwsUj9m4x9/v3h6YFChqDeFWFUVGcKi0oz3nD6BMuAnbsjo6gdOKkum4TIQkXblN6CFDP0cvqNZeRLKPWBdC9YiHHCJZCqRZhEwT+nZMpoqd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720034932; c=relaxed/simple;
	bh=4h2k6wJGw/YtlcHmwALdISiQaaDmRNVR+qc9aZbEHsE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ARgnwkhd5E7JEGwsnWsEENKYihoUnlXUU/q0Ep7/bMKPW3+iKW+46Z1GBQdqKre/LMLl1FBFHKYLfOk18ttmzcOtiMhMJc3EJH4ckv+A74erQ7qtPu9PmkaMegdXnnFON6hTTeJXZK+38hSDpXqekWl27mxZcogDVUsKv7nblrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 463JSj9f2263377
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 19:28:46 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Derrick Stolee'" <stolee@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Derrick Stolee via GitGitGadget'" <gitgitgadget@gmail.com>
Cc: <git@vger.kernel.org>, <newren@gmail.com>, <vdye@github.com>
References: <pull.1756.git.1720019679517.gitgitgadget@gmail.com> <xmqq8qyicpdd.fsf@gitster.g> <068752a3-4140-4b30-803a-1c409afb01e1@gmail.com>
In-Reply-To: <068752a3-4140-4b30-803a-1c409afb01e1@gmail.com>
Subject: RE: [PATCH] advice: warn when sparse index expands
Date: Wed, 3 Jul 2024 15:28:39 -0400
Organization: Nexbridge Inc.
Message-ID: <084501dacd7f$38ac7d60$aa057820$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK7y3ijQe9zOYaDw2JpTM/wfjKqxQFTDLN1AUejssGwDpGrIA==
Content-Language: en-ca

On Wednesday, July 3, 2024 3:18 PM, Derrick Stolee wrote:
>On 7/3/24 2:16 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Derrick Stolee <stolee@gmail.com>
>>>
>>> Typically, forcing a sparse index to expand to a full index means
>>> that Git could not determine the status of a file outside of the
>>> sparse-checkout and needed to expand sparse trees into the full list
>>> of sparse blobs. This operation can be very slow when the
>>> sparse-checkout is much smaller than the full tree at HEAD.
>>>
>>> When users are in this state, it is common that 'git status' will
>>> report the problem. Usually there is a modified or untracked file
>>> outside of the sparse-checkout mentioned by the 'git status' output.
>>> There are a number of reasons why this is insufficient:
>>
>> Nicely written to explain why giving an advice message is a good idea
>> to cover this situation.
>>
>> Making it possible to squelch comes with no cost (once the code to do
>> so is written), so I do not have a huge problem with the use of
>> advise_if_enabled(), but I offhand do not know if the users would =
ever
>> want to squelch it.  Is this something that users would choose to say
>> "yes, I know what I am doing is making my sparse working tree
>> unusuably slow and I've heard how to whip my sparse working tree into
>> a better shape already---please do not tell it to me ever again;
>> because I need to leave these crufts outside the sparse cone anyway, =
I
>> am willing to accept the unusually slow response, overhead, and =
wasted
>> cycles and power" to?
>
>I currently can't imagine a case where a user would want to disable =
this advice, but I
>defaulted to allowing it. I suppose it is more difficult to remove that =
option later, so I
>should have defaulted to not having it removable via config.
>
>I can send a v2 without the config option present. (I'll wait a day or =
two to see if
>others have strong opinions.)

One possible use case is during a CI test of user code where they need =
to do something that causes the advice, but don't want to see the =
message in their logs.
--Randall

