Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177DC16C440
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722353288; cv=none; b=lEguMqObgbpBPmyvaClezAMnzbDbC+4GaAi71Aoq3M060DqtuORDm89aQXqmWsvyth1MdDPnNDfh6PmjSK6Qh5QN1jHFooJbuFXTbDDJFqpAfjirJKGCVVGWBTyFCxM7NtpHZlI49500VhLYQbAKPAZTxxAli2ueuBsYQw3Sb4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722353288; c=relaxed/simple;
	bh=cRIwEsnKJajz+sipAoGUZ/6S5j/Gjfi5fG0ZGxXL6fg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=knaFkseWwYF/dEjAZcd+mnGig8rxC9jjYfACrURwzUHI9T2b8EcRZTvTA9DQo5wkiIX/BY8LUUrle3OZ90ZnAQV4CRZLpgzYuohCHCaZncqPL9mCv5gkKScxg1WsXtMBJBuZSPXlvwchy6AulI8bnG2tOE1BmH8fZAOdIMb2YIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=afy8IAKm; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="afy8IAKm"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 43E3537EAC;
	Tue, 30 Jul 2024 11:28:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cRIwEsnKJajz+sipAoGUZ/6S5j/Gjfi5fG0ZGx
	XL6fg=; b=afy8IAKmGh7vWiGUr8aZD352ZaTpf/J9GxqlteDlejwXWFfFMoW7Cw
	wTT7u+0WCTtSIzmyp++HA05hNa4UC4GbQc6X8LfTYQGqCdsA9fnYNhpousHnl3gD
	Ayqv9QGx8sLAN5kd51xIRmfg92E7qCGmkjcNjj9LacsOWwv2Q1SC8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D35337EAB;
	Tue, 30 Jul 2024 11:28:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1363C37EA9;
	Tue, 30 Jul 2024 11:28:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/23] builtin/describe: fix memory leak with `--contains=`
In-Reply-To: <08a12be13c2fed247d6086967e7a3f03fa6519e1.1721995576.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 26 Jul 2024 14:14:18 +0200")
References: <cover.1721995576.git.ps@pks.im>
	<08a12be13c2fed247d6086967e7a3f03fa6519e1.1721995576.git.ps@pks.im>
Date: Tue, 30 Jul 2024 08:27:59 -0700
Message-ID: <xmqqr0bagark.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4E7A402A-4E88-11EF-A725-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When calling `git describe --contains=`, we end up invoking
> `cmd_name_rev()` with some munged argv array. This array may contain
> allocated strings and furthermore will likely be modified by the called
> function. This results in two memory leaks:
>
>   - First, we leak the array that we use to assemble the arguments.
>
>   - Second, we leak the allocated strings that we may have put into the
>     array.
>
> Fix those leaks by creating a separate copy of the array that we can
> hand over to `cmd_name_rev()`. This allows us to free all strings
> contained in the `strvec`, as the original vector will not be modified
> anymore.

OK, the separate copy has to be a shallow copy, as its purpose is
not to lose pointers to the contained strings.

> Furthermore, free both the `strvec` and the copied array to fix the
> first memory leak.
> ...
> +		strvec_clear(&args);
> +		free(argv_copy);

So, calling cmd_name_rev() may shuffle the argv_copy[] array but at
least it will not free any element in it (as expected---it is
typically the (argc, argv[]) the process receives from getting
exec'ed) [*].  Freeing the argv_copy shell itself is sufficient to
discard what we used to call cmd_name_rev().  And we discard args
both its content strings and the array.  OK.

> +		return ret;
>  	}
>  
>  	hashmap_init(&names, commit_name_neq, NULL, 0);


[Footnote]

 * The fact that cmd_foo() is called is not a hygiene thing to do in
   the first place, and in the longer term #leftoverbits we may need
   to refactor the thing further, into a proper library-ish reusable
   helper function that can be used to compute name_rev() any number
   of times, plus cmd_name_rev() and this caller that call it.
