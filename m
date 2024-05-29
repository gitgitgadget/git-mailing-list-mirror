Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517FE16937B
	for <git@vger.kernel.org>; Wed, 29 May 2024 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717016472; cv=none; b=mYY1/iI+lSnlMY5pVEZjoiDh1hwOilEFYdsrvw4ZXDTDGPLC1xzyhXF4gpr2DTGEyRJ4NHbtRUXieUYF0XK5lK+XkPKtWktdtUN/n+Ydudp3I5SJqUR/Je5Sn9A+8udClVDiAQI83kKKV0RYA0EygLFwtY3iiDLAc+LTt2EDA4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717016472; c=relaxed/simple;
	bh=zJHG8w4KqFNmbf8TdOlNbFS7DpGbfjpRVoPZ7oKyT4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JB8sWVtHfQBXJ62RFfa2SREMahMJejpKA/jJse1L3TqRURrdgloM95b2BPouy1j5GaWdJ9NzIYM2YT/zUklklBoUNbAN1WuzKg0ER5uzntMzGoH5+MyhQCD2FA/hN1IWyR9t1V5Ldduu2UMJKfDsnyyJSH5JC71zFUeNIFxmnwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aLi6hLja; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aLi6hLja"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C3D7349E1;
	Wed, 29 May 2024 17:01:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zJHG8w4KqFNmbf8TdOlNbFS7DpGbfjpRVoPZ7o
	KyT4Q=; b=aLi6hLjaVeCZuscwiY1z5DxKfxZb4iy2D+S+udjlGapj+BeT+I+Mni
	h9ZRDMAdctveFPbEf19UR62oi9bYT1EEaj5W+S9VMZQ82KLzrtiuLfW+/yErZCZQ
	xuJFQHf6nkMcMKObefjluXtcDI3pBNiHo0ahyZ5zPxpUx/JRoT/ZA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 449A7349E0;
	Wed, 29 May 2024 17:01:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A366349DF;
	Wed, 29 May 2024 17:01:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 17/19] builtin/rebase: adapt code to not assign string
 constants to non-const
In-Reply-To: <16d3d28243a0480c929ae3740db92ade238dd325.1716983704.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 29 May 2024 14:45:23 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<16d3d28243a0480c929ae3740db92ade238dd325.1716983704.git.ps@pks.im>
Date: Wed, 29 May 2024 14:01:08 -0700
Message-ID: <xmqqh6eguycr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 92F95D5E-1DFE-11EF-AABA-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When computing the rebase strategy we temporarily assign a string
> constant to `options.strategy` before we call `xstrdup()` on it.
> Furthermore, the default backend is being assigned a string constant via
> `REBASE_OPTIONS_INIT`. Both of these will cause warnings once we enable
> `-Wwrite-strings`.
>
> Adapt the code such that we only store allocated strings in those
> variables.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/rebase.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

One gripe I have in this change is that it used to be crystal clear
what the hardcoded default was (i.e. written in the initialization
data), but now you have to follow the program flow to see what the
hardcoded default is.

>  	if (options.type == REBASE_UNSPECIFIED) {
> -		if (!strcmp(options.default_backend, "merge"))
> +		if (!options.default_backend)
> +			options.type = REBASE_MERGE;
> +		else if (!strcmp(options.default_backend, "merge"))
>  			options.type = REBASE_MERGE;
>  		else if (!strcmp(options.default_backend, "apply"))
>  			options.type = REBASE_APPLY;
