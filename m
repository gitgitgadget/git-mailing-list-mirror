Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9257F1E878
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 23:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991776; cv=none; b=PsZ4PFZuIb8JX/88rfa0al4QNCF8qYyapmTZiv6Apdt7U1zvll8tyZmylzeshwnbU54gWprtmQOqtneaQdN6nUjfZ0zqe3vyKj+ntmVrWzDyhgp1OnchhRqaRa8L1cGwefDtb4ZzaJSGHTDNTg+cy89Qtfp3wm1ZzHsJ3xYcadI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991776; c=relaxed/simple;
	bh=sRp7G8KhlOcXsnYZSAVbdi6c7Q8fTlJojrrYdyTaIZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gqj2mYe6MRP8k13+XtdSKDus7GIjVXjjkvTHcv9JrEFAY/PpeHxaelo80+RDEmnua3PQUWEXgJryVeOsLOdKo3zoKEAJg1Wmox5kyDE8AQILeLqhJY4gwqBn+bF2rmONpg4wXxiXZGVAAa0B+lvfSCbrDdJIsTuTTjU+jFAm4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tTXoj0tX; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tTXoj0tX"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 114D01DABC;
	Mon, 26 Feb 2024 18:56:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sRp7G8KhlOcXsnYZSAVbdi6c7Q8fTlJojrrYdy
	TaIZk=; b=tTXoj0tXd6FfrEb6xF9AdFZBq83noqcBimlaqIQjtQY4kFuUbA5fOH
	C7VuRUV+fAgt9SHnpOKoAEQFoTfLBoT2WmizV6Ap1Z/cUp4bjNyBYFxCy1mAvwoy
	EsYlH/Gy6wuRMQL0Wq2xa4Pu2GWRdF3F8vq6aHENysQbUE27gNjFU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 09D421DABB;
	Mon, 26 Feb 2024 18:56:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 18B3E1DABA;
	Mon, 26 Feb 2024 18:56:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Randall S. Becker" <the.n.e.key@gmail.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v1 4/4] builtin/unpack-objects.c: change xwrite to
 write_in_full to allow large sizes.
In-Reply-To: <20240226220539.3494-5-randall.becker@nexbridge.ca> (Randall
	S. Becker's message of "Mon, 26 Feb 2024 17:05:38 -0500")
References: <20240226220539.3494-1-randall.becker@nexbridge.ca>
	<20240226220539.3494-5-randall.becker@nexbridge.ca>
Date: Mon, 26 Feb 2024 15:56:09 -0800
Message-ID: <xmqqr0gyixuu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9DEAE2FE-D502-11EE-867B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Randall S. Becker" <the.n.e.key@gmail.com> writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> This change is required because some platforms do not support file writes of
> arbitrary sizes (e.g, NonStop). xwrite ends up truncating the output to the
> maximum single I/O size possible for the destination device.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  builtin/unpack-objects.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The same comment as [1/4].  Perhaps your MAX_IO_SIZE should be tuned
downwards, so that xwrite() works as it was designed to work.

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
