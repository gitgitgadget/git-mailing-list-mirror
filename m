Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE0C3D988
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060342; cv=none; b=S4LLRiQA1g5jPXttcF22eP4VphznbTSzs3psjRRp1qbdXxPXTyf9I2Dfe61nQjsNCsSIn0Kld67j2BFkzFh2TCYrvaPGpYS0GiXXSAX+rx8js6M/2cQ/v1jfnP3FCyRVVn6ERaE0D9KFGLSbVl3n+dP9vnJFhilfznnVT/TAnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060342; c=relaxed/simple;
	bh=Z4fEepsyeeGwTn4BYKtRq8vApLKTCHwM+PKISpM9oYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AFggjksH2aLZhfEJySsUHVhoFaXZY8VapqGUYEa5wj2E+USgJ+SVYKePY1waUw0r4rRpc4WRE2Nf7zxZ1NVSjiD7d2c8fwcY75k+aZ/Ww2AZQl4RpVibUoKYopm9dM6zKMJt07n+He2CsJm4K2DMlK/UOwzHFlD6jgtf8O9PsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=M1QCwCcy; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M1QCwCcy"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AF0F324590;
	Tue, 27 Feb 2024 13:58:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Z4fEepsyeeGwTn4BYKtRq8vApLKTCHwM+PKISp
	M9oYk=; b=M1QCwCcyanElaR2DHUml3g3EtLmNVBUUPp1SA7NFtABRrUUGmlYqCY
	BwcIEzTEEo3F8QVjDqLXrROzMUlSdVaJLxakWGGMUreJQxWTPm8Es/RLo+RaSXxq
	/HBc4w8a2oMMhvL72QVKBwmL4Mj0iRUDcgeSIkOmlco6oPCfLIMiU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A765D2458F;
	Tue, 27 Feb 2024 13:58:59 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D36BB2458C;
	Tue, 27 Feb 2024 13:58:55 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Randall S. Becker" <the.n.e.key@gmail.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 3/3] builtin/unpack-objects.c: change xwrite to
 write_in_full avoid truncation.
In-Reply-To: <20240227150934.7950-4-randall.becker@nexbridge.ca> (Randall
	S. Becker's message of "Tue, 27 Feb 2024 10:09:34 -0500")
References: <20240227150934.7950-1-randall.becker@nexbridge.ca>
	<20240227150934.7950-4-randall.becker@nexbridge.ca>
Date: Tue, 27 Feb 2024 10:58:54 -0800
Message-ID: <xmqq1q8xspht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 41B46F00-D5A2-11EE-A4D6-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Randall S. Becker" <the.n.e.key@gmail.com> writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> This change is required because some platforms do not support file writes of
> arbitrary sizes (e.g, NonStop). xwrite ends up truncating the output to the
> maximum single I/O size possible for the destination device if the supplied
> len value exceeds the supported value. Replacing xwrite with write_in_full
> corrects this problem. Future optimisations could remove the loop in favour
> of just calling write_in_full.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  builtin/unpack-objects.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index e0a701f2b3..6935c4574e 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -680,7 +680,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
>  
>  	/* Write the last part of the buffer to stdout */
>  	while (len) {
> -		int ret = xwrite(1, buffer + offset, len);
> +		int ret = write_in_full(1, buffer + offset, len);
>  		if (ret <= 0)
>  			break;
>  		len -= ret;

Why do we need this with a retry loop that is prepared for short
write(2) specifically like this?

If xwrite() calls underlying write(2) with too large a value, then
your MAX_IO_SIZE is misconfigured, and the fix should go there, not
here in a loop that expects a working xwrite() that is allowed to
return on short write(2), I would think.

