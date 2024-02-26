Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F5135A5C
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991436; cv=none; b=pCDHyN652fcpFQOpJUQr1PphxsOb6MatAlc8R7kPJEwv36zJH6ZMmG76RRFie71FxQmcwqknkADT8D1PYqKHZmpRqCLFGfeyUOT4xVBDbWDXbz2SajbGVRiJFCQZwjyRAdswcTNKlUU0QaIuFh/GkYWMJ16J4g91VjdHNomQDtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991436; c=relaxed/simple;
	bh=dHGoboSlDqrq6mag8LM+LeuoPHwzkA4BvRY6uclRzhs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pxiaYYObZlRYyx4a4tzEmc0HbhDY7vuscw39iLiJYmRCLjNOrrQsYO2vEL0FAMoBK6VB1Ge+ZYLCnaaylNRR37gfFrvjZL8wRqlroHNUfZweytpX9oKyWkBoaUn5S6ibzUd5O4vgUbYUSHBOAbDqCbLkRjPhDjMG+Cg2Isot80g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dmERpxZw; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dmERpxZw"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 92B021C9DF7;
	Mon, 26 Feb 2024 18:50:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dHGoboSlDqrq6mag8LM+LeuoPHwzkA4BvRY6uc
	lRzhs=; b=dmERpxZwf8ihQ2RUfexOp52dqkXCBFOULq7i87D5m1ol6LBXDNNooW
	P/4X4TvtFF928h+ToNZxGMscbtna3Z3z/jekZZhvL2bpkVoNr4WVoG5AhUsE0fdw
	NX5nDppGMB/AhYDpRxcS9OmHcH26NlomafT/VSSMGySpodvFs+kZk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A8A61C9DF6;
	Mon, 26 Feb 2024 18:50:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E93E41C9DF5;
	Mon, 26 Feb 2024 18:50:32 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Randall S. Becker" <the.n.e.key@gmail.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v1 2/4] builtin/receive-pack.c: change xwrite to
 write_in_full to allow large sizes.
In-Reply-To: <20240226220539.3494-3-randall.becker@nexbridge.ca> (Randall
	S. Becker's message of "Mon, 26 Feb 2024 17:05:36 -0500")
References: <20240226220539.3494-1-randall.becker@nexbridge.ca>
	<20240226220539.3494-3-randall.becker@nexbridge.ca>
Date: Mon, 26 Feb 2024 15:50:31 -0800
Message-ID: <xmqq34tekcoo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D45EB7BC-D501-11EE-B0D1-25B3960A682E-77302942!pb-smtp2.pobox.com

"Randall S. Becker" <the.n.e.key@gmail.com> writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> This change is required because some platforms do not support file writes of
> arbitrary sizes (e.g, NonStop). xwrite ends up truncating the output to the
> maximum single I/O size possible for the destination device.

As msg[] here is 4k on-stack buffer, if the I/O size is small
enough, the above may happen, and I think write-in-full is warranted
here.  If your I/O must be done in 1k chunks, it would be very slow
to run things like writing a pack stream to clone any non-toy
projects, though X-<.

> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  builtin/receive-pack.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index db65607485..5064f3d300 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -455,8 +455,9 @@ static void report_message(const char *prefix, const char *err, va_list params)
>  
>  	if (use_sideband)
>  		send_sideband(1, 2, msg, sz, use_sideband);
> -	else
> -		xwrite(2, msg, sz);
> +	else {
> +		write_in_full(2, msg, sz);
> +	}
>  }
>  
>  __attribute__((format (printf, 1, 2)))
