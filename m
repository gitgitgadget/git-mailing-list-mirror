Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0DB1B4C3C
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947672; cv=none; b=bo1Qkp+DdHondHBb+hg/6lr/yzhTF3R0R0mGIuWLaxg2WwgptC36V9fQHBXXzcNYlzz9UE2wA5Gm7vJWIQ2eNfgWSR7y4nb8jkoBWoyEcIuUIxUWojZwCyFiznVA8mAat1qRn6XvD+0IsybCn0Knwrjec/8Fb3SqWBx7q162EFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947672; c=relaxed/simple;
	bh=wOVvSa6enEpFI7fcimVulZsJ+zQk4C7MZkq91se/mh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uiLaF6uWpeS4/1AdTLFj21LTgAm5+vWXWErHkcYEjQ9tpRrwrK6onQyKbq3D92Ca/AgAMttcrpg/ZzEaYUfgczGol9KsAmeZcssxsY5ZAjc/SZavdjPu5L6QseQ/6+wzTbh/GYvJLKiJ2xTyB8yY6F10xx+h5q/P8JgyMelaE+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tC/PV9iK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tC/PV9iK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B4C4A323DA;
	Thu, 29 Aug 2024 12:07:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wOVvSa6enEpFI7fcimVulZsJ+zQk4C7MZkq91s
	e/mh8=; b=tC/PV9iKV+Nn5BAj582OYx2rlLfN4rF/u575xOVnYTVxF3Iq07Su8n
	qvKLpAwacZQrb/hc+4oXcb/tpDaJCbVTYhX8ZGYrEaQcpGO4eWiGzJMLCVz46avQ
	EmFYrGvofIxcRl4+ab1In6CpNWvcDrPMBGiHoXTZyg0VsCCyTQ58M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ABFED323D9;
	Thu, 29 Aug 2024 12:07:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 208A0323D7;
	Thu, 29 Aug 2024 12:07:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Toon claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 14/22] shallow: fix leaking members of `struct
 shallow_info`
In-Reply-To: <87ed67jtxy.fsf@iotcl.com> (Toon claes's message of "Thu, 29 Aug
	2024 16:16:09 +0200")
References: <cover.1724656120.git.ps@pks.im>
	<2a63030ff09f938d705c117406b501ecf81f67de.1724656120.git.ps@pks.im>
	<87ed67jtxy.fsf@iotcl.com>
Date: Thu, 29 Aug 2024 09:07:47 -0700
Message-ID: <xmqqr0a7wbvw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D6435596-6620-11EF-83DA-9B0F950A682E-77302942!pb-smtp2.pobox.com

Toon claes <toon@iotcl.com> writes:

>>  void clear_shallow_info(struct shallow_info *info)
>>  {
>> +	if (info->used_shallow) {
>> +		for (size_t i = 0; i < info->shallow->nr; i++)
>> +			free(info->used_shallow[i]);
>> +		free(info->used_shallow);
>> +	}
>> +
>> +	free(info->need_reachability_test);
>> +	free(info->reachable);
>> +	free(info->shallow_ref);
>>  	free(info->ours);
>>  	free(info->theirs);
>>  }
>
> `prepare_shallow_info()`, which allocates new memory. So would it be
> worth to rename this function to `release_shallow_info()`?

In the longer term in a separate "renaming everything" effort, yes.
In the context of "plug many resource leaks" series, probably no.

Thanks.
