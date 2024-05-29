Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD7618E06
	for <git@vger.kernel.org>; Wed, 29 May 2024 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014119; cv=none; b=WW2vWxquA2OpZ9ITAw2rOVjjotAMhaDFRFcseMqzWNeSO6d4H+qUduPRRnT7V1j5Lmm7IWyzVcHuj2XTdi46XbW/3Lz16qRawW8VtE2ZuCR9VFrc+Tc6dKsUSXbY8cJ2jExWJaspShGAFnaElcDtre8VHrcLODWoXxUIu4Q5xLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014119; c=relaxed/simple;
	bh=JC0F9T9MZ73GNgXTxWdTiUMMr1KstiEJyI6OybCM3gs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rJIo5BtktbYqifhIHaUqvQO2dZYis+DsXj3MrUCasu1xlpi++gX5slmq662kYyEK8VtJqPNiQ1rzL5CW7Wy5VkM7SFf640M193IFyZhGNU/uBowxo5+NvLbg67ajBixjXiOzdM3CTYAXqWpYPZjvXWUHfW4+M2bwjuiMLZmzI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iP+ZOySJ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iP+ZOySJ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4520D33323;
	Wed, 29 May 2024 16:21:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JC0F9T9MZ73GNgXTxWdTiUMMr1KstiEJyI6Oyb
	CM3gs=; b=iP+ZOySJKiZWasDiruRG+Zhd1GFserEPohSdiLJvwdBx6usgCSN+2W
	mR3LlHSWVbl3VRg7APJ+oRy6j5iP78Bu9empGdD2oaPhMElda7lzIhxgHciv7FnL
	XqDEPzq9Fqr6mLB7fHNfgshHWeLFAX/rfxqKOX9raZvdQBRWwEAGE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D6A833322;
	Wed, 29 May 2024 16:21:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 457113331E;
	Wed, 29 May 2024 16:21:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/19] remote-curl: avoid assigning string constant to
 non-const variable
In-Reply-To: <00b4a7dbbcdfd8a0f7b4beb4ecaf272257838460.1716983704.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 29 May 2024 14:44:59 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<00b4a7dbbcdfd8a0f7b4beb4ecaf272257838460.1716983704.git.ps@pks.im>
Date: Wed, 29 May 2024 13:21:47 -0700
Message-ID: <xmqq5xuwweqs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 14189252-1DF9-11EF-B083-8F8B087618E4-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>  		} else if (skip_prefix(buf.buf, "option ", &arg)) {
> +			const char *value = strchr(arg, ' ');
> +			size_t arglen;
>  			int result;
>  
> +			if (value) {
> +				arglen = value - arg;
> +				value++;
> +			} else {
> +				arglen = strlen(arg);
>  				value = "true";
> +			}

There is a micro optimization opportunity here.

	const char *value = strchrnul(arg, ' ');
	size_t arglen = value - arg;

	if (*value)
		value++; /* skip over SP */
	else
		value = "true";

But other than that, very cleanly done.
