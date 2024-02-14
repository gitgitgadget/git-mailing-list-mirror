Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3C311CBB
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 01:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707874484; cv=none; b=HdbM0mu06nK7UeVtHPzrZnHwHxFBABmZ9m59kIjHhGwdZVaw286q3xQTo7cUVD68XGuiX4aDZTxVzMYDM6yuNtv2THwF0JS6eXRoUoHPqzTaDQ6iDmP0h01dRIoUT8215ITkcHnx3LoxhTO5UL1EFrE50zf2pfQD54pQL6zedpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707874484; c=relaxed/simple;
	bh=mQpmODrTIKydW+O8sZm3WIBeY4PIYnlJhejSB+1wob0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a7290r9kV47clrrC9ZyA2CCT3U16CZfeSUjUfwpMUWVGBhUmt8qN7qJsRECZ7Z7KLtKq0Exz9WTaE2lqtV4aM6llelHq+uPS/8e7sr5e9O191eQIrSueO8OO9LO0+NIM5Z95DROYjwaQ0IKLE+d8fd86LQmTjYX1RfM+UuIBZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xIDiN0cH; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xIDiN0cH"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E5581C09B;
	Tue, 13 Feb 2024 20:34:41 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mQpmODrTIKydW+O8sZm3WIBeY4PIYnlJhejSB+
	1wob0=; b=xIDiN0cHuV2jlsjy7jg4twlIdwju0ms7vdpxxsH3i9usR3a+JXj96R
	dpeELoCbGMPi0ana9ysGqhSMywfWF/VTNGUxpldxzU6tmdwLyy7ktp/wQ8qrOgze
	/2UmoL1zUjcDJL4zivMLWAqE5lxHc04Xh3vMqrc0uww6VSSDRGn1Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2642B1C09A;
	Tue, 13 Feb 2024 20:34:41 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C9D9E1C099;
	Tue, 13 Feb 2024 20:34:37 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 05/12] fsmonitor: refactor refresh callback for
 non-directory events
In-Reply-To: <0896d4af907d71df29b0c4f5a27d24ea80b3c0e1.1707857541.git.gitgitgadget@gmail.com>
	(Jeff Hostetler via GitGitGadget's message of "Tue, 13 Feb 2024
	20:52:14 +0000")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<0896d4af907d71df29b0c4f5a27d24ea80b3c0e1.1707857541.git.gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 17:34:36 -0800
Message-ID: <xmqq5xyr25hv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 373B4464-CAD9-11EE-B9EC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 66 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 28 deletions(-)

Up to this point, I found it a very pleasant read.  Nothing
surprising or unexpected.  Just a simple series of nice clean-ups.

Thanks.
