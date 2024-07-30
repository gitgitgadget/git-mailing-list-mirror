Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFE118A92F
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722353824; cv=none; b=i9+poHsf1O0D2cIGvwGkjkppQ6/BcR3vWbxxyMV3aqO8l9wWrnjDvAWyG7mmhOjKPkAmnNRfogV4IEuoa3oaOMtwQHq+7rD9Q4/vWeKzT9tdbWHBWcBsxRKSQ+909a31sSpzj76PsjdLulQZO5JGlEp+ucmLZ/HS4CpEm7nCLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722353824; c=relaxed/simple;
	bh=XaU7LK6WfhuU7MkArb8GYl/bu78FU0RUjzYiYBf92SI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fG6ozZoxlX7wgMWzfnChUhfJVKXGchYdcZjG1kq++A8/VNo9Tp1dVGxdmJuAbQdw4chh/h7W6mc7PtVEW6O4GJH7e8faKVfAguuBAeU3i72U/oAaJu/ykX0z4DTlXgZVaRsUurCWTKQ9OCfTX5vLUy0Ek2UMvv5KsjZSCFHM2FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RYKgEdDs; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RYKgEdDs"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 13B90380F6;
	Tue, 30 Jul 2024 11:37:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XaU7LK6WfhuU7MkArb8GYl/bu78FU0RUjzYiYB
	f92SI=; b=RYKgEdDsuQ11WdAkmgX/8Anay3GDgNiwpQ9q9aidU5V+JqK51eM+vu
	VA6yK/c+23lxGWSBhK4RcT+drDz7iavDQhEpNPX2nQnZa/wVxawSv32rgaoWHZeE
	m0Bba1G+aDEcvyDiJyCfi3URpoXnQGaatRVgEU+Qg4uVCiee4LkCs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0B5BC380F5;
	Tue, 30 Jul 2024 11:37:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9624A380F3;
	Tue, 30 Jul 2024 11:36:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/23] builtin/name-rev: fix various trivial memory leaks
In-Reply-To: <088f730572f0f5aaa8f9640ea35a4687be9094ba.1721995576.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 26 Jul 2024 14:14:55 +0200")
References: <cover.1721995576.git.ps@pks.im>
	<088f730572f0f5aaa8f9640ea35a4687be9094ba.1721995576.git.ps@pks.im>
Date: Tue, 30 Jul 2024 08:36:57 -0700
Message-ID: <xmqqikwmgacm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8EDFE6FA-4E89-11EF-9F2E-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> There are several structures that we don't release after
> `cmd_name_rev()` is done. Plug those leaks.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/name-rev.c                   | 6 ++++--
>  t/t6007-rev-list-cherry-pick-file.sh | 1 +
>  t/t6120-describe.sh                  | 1 +
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 70e9ec4e47..f62c0a36cb 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -677,7 +677,9 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>  				  always, allow_undefined, data.name_only);
>  	}
>  
> -	UNLEAK(string_pool);
> -	UNLEAK(revs);
> +	string_list_clear(&data.ref_filters, 0);
> +	string_list_clear(&data.exclude_filters, 0);
> +	mem_pool_discard(&string_pool, 0);
> +	object_array_clear(&revs);
>  	return 0;
>  }

You, originally these "we know we are at the very end of the
process, so _exit() will take care of releasing the resources" was a
very much deliberate, and in a sense, cmd_describe() calling to this
function as the last thing to do was still in the same spirit, but
it was not a hygiene thing to do.

In the longer term, we would want to make a major part of the body
of this "main" function into a reusable library-ish function, which
will be called the desribe and name-rev command implementations, and
when that happens, these fixes would move together to that
library-ish function.

Looking good.
