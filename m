Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF28172BD8
	for <git@vger.kernel.org>; Tue, 28 May 2024 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912974; cv=none; b=sgckSAj1hRJUBj+spPUrS8w36vOxRw8ydsChKGgW9cg4voWtvewiEsLjBIizBkXAIZWIbi8K+LY8BnTx+MVoghi21lgP+EbH9URxPikJ7rqnElyKGH+euzZOLNqJYeMK6sr7SJOleaWxYcRv6/ipdVfH81P7ol6GwflHZsvrxu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912974; c=relaxed/simple;
	bh=R+hDJxyyqSfyz64m6UOpak5F4FQ9t+TmSefcpDl2C7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cfOryn7wDIrSaqXhzWwM3Sj0LwFZCjuDMEBMfWqQ23LNIclBX23KKUYhWZwHBl5Pf2PBx1+yh1CC9vxwtJmBtd5f86lHn8E+rTn36knEWWK3azh1K2Aks9arXFsmc6g9PAMKjtV6PHFtjpjmi/gTrsEs/winow3x+od/QZbvWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pgMqnw2C; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pgMqnw2C"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DF191A9DD;
	Tue, 28 May 2024 12:16:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=R+hDJxyyqSfyz64m6UOpak5F4FQ9t+TmSefcpD
	l2C7g=; b=pgMqnw2CMG6ivHbzGPQYBG3je7d4Hcwt0SsFVfDPF/f5MQ7VGiNH0V
	SySeh4zZq43uFUJqk+1hCCugLD1UvSCCUB55Xc+KYLzFtpwfKyVXuK2w4h5zoSpS
	3oFivD7W8wznqPFFyqqXSf4AsKwyEODj8+OP35FRobLglivgXVLhI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0708D1A9DC;
	Tue, 28 May 2024 12:16:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7ADFC1A9D8;
	Tue, 28 May 2024 12:16:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/9] refs: ref storage format migrations
In-Reply-To: <ZlVoCnojAiShmtRg@tanuki> (Patrick Steinhardt's message of "Tue,
	28 May 2024 07:13:46 +0200")
References: <cover.1716451672.git.ps@pks.im> <xmqqwmnkv7ay.fsf@gitster.g>
	<ZlBC5O4CHqrx1di7@tanuki> <xmqqv833maxu.fsf@gitster.g>
	<ZlVoCnojAiShmtRg@tanuki>
Date: Tue, 28 May 2024 09:16:10 -0700
Message-ID: <xmqqmso97vzp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9947C110-1D0D-11EF-B0E6-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> It is documented as part of the new git-refs(1) man page, in the "Known
> limitations" section:
>
>     * There is no way to block concurrent writes to the repository during an
>       ongoing migration. Concurrent writes can lead to an inconsistent migrated
>       state. Users are expected to block writes on a higher level. If your
>       repository is registered for scheduled maintenance, it is recommended to
>       unregister it first with git-maintenance(1).

Good.  Thanks.
