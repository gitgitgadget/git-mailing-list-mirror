Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103682863
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725487687; cv=none; b=ZYtJas7Z7m9ee+ToldzIlovClVcBSWc5yyiJtTRQboRV/eFQ2FJeStXNdmS+k+4VUb/Qo7RHUul1c685hNqRK2MzsXzBXY7v0MXUUBZ+maMdkPVW1h/R/s4vhefO0Q4YwoAWPvjsrDg7TscwS6nslEgpGOmK5sVjVrtLDpiRblw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725487687; c=relaxed/simple;
	bh=Au+9bzEixGPvBySLRWJJsC8u5ZeOvb7WIJe+beeNjnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CUtVMlvWEQPW3YeSARV87o847932NgpjzKY90oXTjwhl9+4zO1tXbtDXDUBRmWb+HvRu0RJO1EX1crzjNJUUJvSFlbuNwCCC4JY4aEQqX+eZLlfarelSN9opsvZoU4jG2deDPKfV81J+qW3l9gYMQu3NRs9fe+99Ozu+CzRIQ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=l/UeZCK5; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l/UeZCK5"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A892E1A1A7;
	Wed,  4 Sep 2024 18:08:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Au+9bzEixGPvBySLRWJJsC8u5ZeOvb7WIJe+be
	eNjnA=; b=l/UeZCK58OHI8CcTiqn+dZKWWw12NdL4Ol65wJuSI6DoshDF/wjlxv
	G+T1Oj9YJ6NZqAZKcPKQsMfDjWQlmKzeulxZR1V+tterCH8vLhIt1qEZAbSp8hMY
	YhID1q3q08F0gvcpoWxinOSonGK9sTdMoPSH/iK+yyrqOixYoWXO4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71C1C1A1A6;
	Wed,  4 Sep 2024 18:08:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 40CDA1A1A5;
	Wed,  4 Sep 2024 18:08:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/22] send-pack: fix leaking push cert nonce
In-Reply-To: <138a5ded35a43d3aeaa5058ba316a45b7b50b9ef.1724656120.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 26 Aug 2024 09:22:04 +0200")
References: <cover.1724656120.git.ps@pks.im>
	<138a5ded35a43d3aeaa5058ba316a45b7b50b9ef.1724656120.git.ps@pks.im>
Date: Wed, 04 Sep 2024 15:08:00 -0700
Message-ID: <xmqqr09z6pj3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 27C4C3E4-6B0A-11EF-99A5-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When retrieving the push cert nonce from the server, we first store the
> constant returned by `server_feature_value()` and then, if the nonce is
> valid, we duplicate the nonce memory to extend its lifetime. We never
> free the latter and thus cause a memory leak.

"to extend its lifetime" -> "to a NUL-terminated string, so that we
can pass it to generate_push_cert()".

What is going on in this code path is this.

The other side may send a nonce in the server capability.  We die if
that nonce is bogus.  Otherwise we make a xmemdupz() copy because we
need to pass the nonce to generate_push_cert() that expects nonce to
be a NUL terminated string (the original server capability is a long
concatenation of capabilities and we learn the <ptr, len> for the
nonce).  The function cryptographically signs the ref update request
we have, together with the nonce we got from the server, so that the
other side can validate that it is signed by us, and the nonce serves
as a protection against replay attacks.

> diff --git a/send-pack.c b/send-pack.c
> index b224ef9fc5e..c37f6ab3c07 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -501,7 +501,7 @@ int send_pack(struct send_pack_args *args,
>  	unsigned cmds_sent = 0;
>  	int ret;
>  	struct async demux;
> -	const char *push_cert_nonce = NULL;
> +	char *push_cert_nonce = NULL;
>  	struct packet_reader reader;
>  	int use_bitmaps;

This is a change necessary to avoid having to cast the parameter to
free().

> @@ -550,10 +550,11 @@ int send_pack(struct send_pack_args *args,
>  
>  	if (args->push_cert != SEND_PACK_PUSH_CERT_NEVER) {
>  		size_t len;
> -		push_cert_nonce = server_feature_value("push-cert", &len);
> -		if (push_cert_nonce) {
> -			reject_invalid_nonce(push_cert_nonce, len);
> -			push_cert_nonce = xmemdupz(push_cert_nonce, len);
> +		const char *nonce = server_feature_value("push-cert", &len);
> +
> +		if (nonce) {
> +			reject_invalid_nonce(nonce, len);
> +			push_cert_nonce = xmemdupz(nonce, len);

And this hunk become needed because push_cert_nonce cannot receive
the return value from server_feature_value() without stripping
constness.

>  		} else if (args->push_cert == SEND_PACK_PUSH_CERT_ALWAYS) {
>  			die(_("the receiving end does not support --signed push"));
>  		} else if (args->push_cert == SEND_PACK_PUSH_CERT_IF_ASKED) {
> @@ -771,5 +772,6 @@ int send_pack(struct send_pack_args *args,
>  	oid_array_clear(&commons);
>  	strbuf_release(&req_buf);
>  	strbuf_release(&cap_buf);
> +	free(push_cert_nonce);

And this is my fault to forget freeing.  Thanks for spotting and fixing.

>  	return ret;
>  }
