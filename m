Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A633F9E5
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707761152; cv=none; b=nWN4erGd0DbxvALvRDkY43U8c/YbaZhDx6Dx70bWQPN43BF0zEVqmQLq/Ofoo0EPrx+AmGlNz0Alqz5BBumI2wSdQPEt1UhkujAbwf4sNzG3itDtiw24ISTMbSQY+tfDh/cYKwL7dtAxNkA0ugnvv2TEXjZ9UR2FoF8YNnKxYnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707761152; c=relaxed/simple;
	bh=GV606oMwIoRCVaEu6nk4vLVmzdvDrVnnA+uqEkS/ZY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XMmO3I94aSxT9fk8yQXUqtphukSxv7EaGER4DZJaMlIocErCq6cAElwAePGP7nr7PLD2Tf3vwK2MqyCHLyj2tMuZeY/hqi3S908ZLcMCVxX+/FAr3Yk6fn4M05bN4fIYrZm2GKZIBhRUQ0hb4RKg7t+Vv04Z+4gcF4HqkMHohig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iffQ3pN8; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iffQ3pN8"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C75FB2C81B;
	Mon, 12 Feb 2024 13:05:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GV606oMwIoRCVaEu6nk4vLVmzdvDrVnnA+uqEk
	S/ZY8=; b=iffQ3pN8AJBtrbPi9hLT6pdbbMPOx4t2wL02uzLbLntMNvGdvE1mcr
	bVgTmPUMjT+zDnLc7056j1/VYUfDwBZmV9LnqQoI5rrQi/GMzs+49OYImixOmitb
	/GWHWDYGBhzfnFgKPtH5n9uqDsFT3eH4qF1f83o6REK9Z1NswDvHU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BFCDA2C81A;
	Mon, 12 Feb 2024 13:05:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 621522C817;
	Mon, 12 Feb 2024 13:05:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood123@gmail.com,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v4 1/5] refs: introduce `is_pseudoref()` and `is_headref()`
In-Reply-To: <20240211183923.131278-2-karthik.188@gmail.com> (Karthik Nayak's
	message of "Sun, 11 Feb 2024 19:39:19 +0100")
References: <20240119142705.139374-1-karthik.188@gmail.com>
	<20240211183923.131278-1-karthik.188@gmail.com>
	<20240211183923.131278-2-karthik.188@gmail.com>
Date: Mon, 12 Feb 2024 10:05:43 -0800
Message-ID: <xmqqwmr95zig.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 57D8121E-C9D1-11EE-AA5E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> +	if (ends_with(refname, "_HEAD")) {
> +		refs_resolve_ref_unsafe(refs, refname,
> +   					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> +   					&oid, NULL);
> +   		return !is_null_oid(&oid);
> +	}

FYI. I see

.git/rebase-apply/patch:31: space before tab in indent.
   					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
.git/rebase-apply/patch:32: space before tab in indent.
   					&oid, NULL);
.git/rebase-apply/patch:33: space before tab in indent.
   		return !is_null_oid(&oid);

around here.
