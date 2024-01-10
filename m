Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D4A4E1CA
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="byYeSNrq"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 16E9B30BE5;
	Wed, 10 Jan 2024 15:07:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=30dJClL9/BXW
	18/+KDtpoOIw/NrfecgY9JaVaQDApUA=; b=byYeSNrqlKtqeR3l+mhDH+nM9Y1x
	d+b3/TI8S4Xm9Wj4OhQkTwOlZ13hdwywD7OR5A6Csgzkjeb0oPjnleg4JSnJq/MI
	cTnkZOwrYqG3laom9JgDUvGu6OQP7q1p+O0RbwaC5VVaXQu/kgvn+1ixDtW6vBiA
	jWcI8P8Kg7cXotA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E7A330BE4;
	Wed, 10 Jan 2024 15:07:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 46E9930BE1;
	Wed, 10 Jan 2024 15:07:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 3/4] reftable/stack: use stat info to avoid re-reading
 stack list
In-Reply-To: <4fabdc3d8016dbc1e20fbe90058ee7320a5f770b.1704714575.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 8 Jan 2024 13:18:39 +0100")
References: <cover.1704714575.git.ps@pks.im>
	<4fabdc3d8016dbc1e20fbe90058ee7320a5f770b.1704714575.git.ps@pks.im>
Date: Wed, 10 Jan 2024 12:07:52 -0800
Message-ID: <xmqqo7dt9ckn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F0915224-AFF3-11EE-9AEE-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> We can do better and use the same stat(3P)-based mechanism that the
> "packed" backend uses. Instead of reading the file, we will only open
> the file descriptor, fstat(3P) it, and then compare the info against th=
e
> cached value from the last time we have updated the stack. This should
> always work alright because "tables.list" is updated atomically via a
> rename, so even if the ctime or mtime wasn't granular enough to identif=
y
> a change, at least the inode number should have changed.

Or the file size.  Let's keep in mind that many users get useless
inum from their filesystem X-<.

>   Summary
>     update-ref: create many refs (refcount =3D 1, revision =3D HEAD~) r=
an
>       1.01 =C2=B1 0.09 times faster than update-ref: create many refs (=
refcount =3D 1, revision =3D HEAD)
>       2.72 =C2=B1 0.11 times faster than update-ref: create many refs (=
refcount =3D 100, revision =3D HEAD)
>       3.42 =C2=B1 0.13 times faster than update-ref: create many refs (=
refcount =3D 100, revision =3D HEAD~)
>     163.59 =C2=B1 5.62 times faster than update-ref: create many refs (=
refcount =3D 10000, revision =3D HEAD)
>     233.91 =C2=B1 7.92 times faster than update-ref: create many refs (=
refcount =3D 10000, revision =3D HEAD~)
> ---

Nice.

> @@ -374,6 +375,8 @@ static int reftable_stack_reload_maybe_reuse(struct=
 reftable_stack *st,
>  		sleep_millisec(delay);
>  	}
> =20
> +	stat_validity_update(&st->list_validity, fd);
> +
>  out:
>  	if (fd >=3D 0)
>  		close(fd);

The stat_validity_update() does not happen in the error codepath.

Should we be clearing the validity of the list when somebody jumps
to "out:" due to an error?  Or by the time this function gets
called, the caller would already have cleared the validity and an
error that jumps to "out:" keeps the list invalid?

Other than the missing sign-off, the change looks very straight-forward.
