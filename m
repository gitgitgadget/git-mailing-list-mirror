Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB023328FE
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780809; cv=none; b=Bsx65VE6SwZRu66JOOWIH/i8k47y2hbbFrfjM3y8QA/FaZVCQRNvBg6UYFTN970sDPpreqRk0Lt6b5E3RS+oHXTUVqmKJ0n5VVq9pwxUTcE5SXA5F96B8T4xMsnowAYEQRg4wLm86lNJljzozh0vBwNc7zS1JLTbIP3blp2sPaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780809; c=relaxed/simple;
	bh=aEp57+xtw6/L2MSqAhKON1AReK4NvbAQDKg6pHBIV3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uD5zjnqAoMYSIBycWLWfMZyE9svUpTr3AfrZ1zyR5VBtYfx03ePr7TdFTCG2rgjvu5NUDl0+IirqRt4cWmBK4C3I5fCt2hpltt+/2ecR82SjM32u3Mn7/YZ6dnDxNmMdyDRHhurf4JyvdOZJ4SJQB9S05LKC0uHYCUYDP76kLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=VR9R9ds4; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="VR9R9ds4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1767780801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rU4p97ILG1FhZg0ldAo+s4f2YyNaXGCQCraV2wQQLtg=;
	b=VR9R9ds4COLU5ZjmWPRXWqP2ii1qU40Dzg3OfMd3z76YkHvn9SDmOns3Iz8CjfiWw/vtSK
	UX7OQ8YbeB3YUtPG2N6qJoBa1qenktYP8NpXez+2aP3QYqbg866bRhqkPdBzg8dTXQlyVX
	j4XH09+ahu20WfjInSzKfi5IZ0394s0=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 04/10] packfile: refactor misleading code when
 unusing pack windows
In-Reply-To: <20251218-b4-pks-pack-store-via-source-v2-4-62849007ce21@pks.im>
References: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
 <20251218-b4-pks-pack-store-via-source-v2-4-62849007ce21@pks.im>
Date: Wed, 07 Jan 2026 11:13:11 +0100
Message-ID: <87fr8hpw7c.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The function `unuse_one_window()` is responsible for unmapping one of
> the packfile windows, which is done when we have exceeded the allowed
> number of window.
>
> The function receives a `struct packed_git` as input, which serves as an
> additional packfile that should be considered to be closed. If not
> given, we seemingly skip that and instead go through all of the
> repository's packfiles. The conditional that checks whether we have a
> packfile though does not make much sense anymore, as we dereference the
> packfile regardless of whether or not it is a `NULL` pointer to derive
> the repository's packfile store.
>
> The function was originally introduced via f0e17e86e1 (pack: move
> release_pack_memory(), 2017-08-18), and here we indeed had a caller that
> passed a `NULL` pointer. That caller was later removed via 9827d4c185
> (packfile: drop release_pack_memory(), 2019-08-12), so starting with
> that commit we always pass a `struct packed_git`. In 9c5ce06d74
> (packfile: use `repository` from `packed_git` directly, 2024-12-03) we
> then inadvertently started to rely on the fact that the pointer is never
> `NULL` because we use it now to identify the repository.
>
> Arguably, it didn't really make sense in the first place that the caller
> provides a packfile, as the selected window would have been overridden
> anyway by the subsequent loop over all packfiles if there was an older
> window. So the overall logic is quite misleading overall. The only case
> where it _could_ make a difference is when there were two packfiles with
> the same `last_used` value, but that case doesn't ever happen because
> the `pack_used_ctr` is strictly increasing.

I didn't even think about this edge case, so thanks for clarifying.

> Refactor the code so that we instead pass in the object database to
> help make the code less misleading.

Nice improvement.

-- 
Cheers,
Toon



