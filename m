Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AAC1B2ED8
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263142; cv=none; b=OcJZwKptBxc7w9mPZVnc1V02XZuVEdwtZ2faRAgkLom9UBR3euwzDKYl+KBUU6zM62ZzvK6wlyEXYZCkHB3hiYVzO0sZHhhtvYUNHI2O2xYVMw2dl4TmdxK6oDPck9hTzuVG13hv+wuDdi/QxrhASVDh9DKtPcVOeHpIeWJEIzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263142; c=relaxed/simple;
	bh=muKckglp+wLnaR+Cspiz7KeZZCizoSKkaMtlQZ09rkY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uturBp2bRTPqh7B7TkeJNTn/gEGtb0p2DLO3rYtdA8Cfh716jf/S7jt1FMY/JiIS64dR7vtDy3naiYyfw3PEQ1mQWUT6dCiDGu9QXGe2T7MQMJbpQZ45EegjibuZGP3a/2TWb5cuI5m4AXNPdbQPhNc6zW8PYRLB3RDVFY81xJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=T9vRdrG5; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="T9vRdrG5"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 437273663F;
	Wed, 21 Aug 2024 13:59:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=muKckglp+wLnaR+Cspiz7KeZZCizoSKkaMtlQZ
	09rkY=; b=T9vRdrG5+4QQM+kkhAn4b7t/24QRVHTlvcYzqZ7Q6N7Rm8otdaoMYX
	lJtJxatIK5q0v8U1CNKKqIqVb224uec/Qb+gNH2Ol9sY19uXhF7ywP8m8YM7YVmP
	Fgw1Oz8axh/nv7uwLFRrHUlO/70F0NnazWVaAimBMmTdfX5cWaMwI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C81D3663E;
	Wed, 21 Aug 2024 13:59:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C046736608;
	Wed, 21 Aug 2024 13:58:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 15/20] remote: fix leaking config strings
In-Reply-To: <97346d6f944e3587a08d96a5e1b4ead8df8a0bc0.1724159575.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 20 Aug 2024 16:05:46 +0200")
References: <cover.1724159575.git.ps@pks.im>
	<97346d6f944e3587a08d96a5e1b4ead8df8a0bc0.1724159575.git.ps@pks.im>
Date: Wed, 21 Aug 2024 10:58:55 -0700
Message-ID: <xmqqy14pycyo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0930868A-5FE7-11EF-8302-BF444491E1BC-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> @@ -2802,6 +2809,7 @@ void remote_state_clear(struct remote_state *remote_state)
>  	for (i = 0; i < remote_state->remotes_nr; i++)
>  		remote_clear(remote_state->remotes[i]);
>  	FREE_AND_NULL(remote_state->remotes);
> +	FREE_AND_NULL(remote_state->pushremote_name);
>  	remote_state->remotes_alloc = 0;
>  	remote_state->remotes_nr = 0;

As remote_state has two extra structures embedded in it, I wonder if
we should be clearing them in this function, but possibly it is
cleared elsewhere or perhaps in a later series?

As the focus of this step is about strings that we obtained from the
config API, it is totally outside the scope of this topic, even if
it turns out to be needed to clear them.

Looking good.  Thanks.
