Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431C61805E
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516242; cv=none; b=UBWtxOnxwwR0ndGe0rY1xB+jqB5vFVHN5YtGA8SUutWcQhLr8stFtxz+KEi2wdekwn+aknJyNbvscHriN3RQ944NhPecWIrqHwS0siG7omRmjqk7EDi2+6pJ+fHNrKzpiiQ5+KheOtdiiJcQBtn3uJMEKR/r156Pt0taIR3IlMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516242; c=relaxed/simple;
	bh=BJ4qQWg7pCFaS70Ue45vHCs3iIwXrauDT4/kmeglN8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WhWrUFRyhl9M6YrabEQlIRGBCshVvzPB9nScaU9eyDiX9VvE4PJFhlwuskLjMizI4nyFTBz+8dYGdMTKHcPUkdui6JgGoGrenMLAWZd5yVqbjcv1ty1A7XcWfV19L0Gbrip1UOXLO9bs0JLAc+swecu8Znks6VXKsYnxlQ5joJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WefNTgGo; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WefNTgGo"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 65FDB1BF52;
	Tue,  4 Jun 2024 11:50:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BJ4qQWg7pCFa
	S70Ue45vHCs3iIwXrauDT4/kmeglN8E=; b=WefNTgGogSZuxj6PeZCycx3PmOO4
	eDbP5dOYxHbv+dDlbfqVNiYLC3CMEjgklLX6Sc0Ek5cOdFfdEky9eYdQJiMBSafy
	4Z5cPJ2PkIcb/bVGexIpyAgFWahPp4dqD1Z8z2CgfFEdZJKPBWQ/vZzzDDdsl80p
	2oHqpRiP0MBzPHQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E93C1BF51;
	Tue,  4 Jun 2024 11:50:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7CC1E1BF50;
	Tue,  4 Jun 2024 11:50:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Dragan Simic <dsimic@manjaro.org>,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 2/6] pager: do not close fd 2 unnecessarily
In-Reply-To: <e98dc7b1-3c93-41d2-a2ef-7f9f69789886@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 3 Jun 2024 22:38:12 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
	<1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
	<e98dc7b1-3c93-41d2-a2ef-7f9f69789886@gmail.com>
Date: Tue, 04 Jun 2024 08:50:36 -0700
Message-ID: <xmqqcyow1zcj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 2FD703B2-228A-11EF-9CE2-8F8B087618E4-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> We send errors to the pager since 61b80509e3 (sending errors to stdout
> under $PAGER, 2008-02-16).
>
> In a8335024c2 (pager: do not dup2 stderr if it is already redirected,
> 2008-12-15) an exception was introduced to avoid redirecting stderr if
> it is not connected to a terminal.
>
> In such exceptional cases, the close(STDERR_FILENO) we're doing in
> close_pager_fds, is unnecessary.

I was wondering how we can test this.

> diff --git a/pager.c b/pager.c
> index b8822a9381..b786601074 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -14,6 +14,7 @@ int pager_use_color =3D 1;
> =20
>  static struct child_process pager_process;
>  static const char *pager_program;
> +static int close_fd2;
> =20
>  /* Is the value coming back from term_columns() just a guess? */
>  static int term_columns_guessed;
> @@ -23,7 +24,8 @@ static void close_pager_fds(void)
>  {
>  	/* signal EOF to pager */
>  	close(1);
> -	close(2);
> +	if (close_fd2)
> +		close(2);
>  }
> =20
>  static void wait_for_pager_atexit(void)
> @@ -141,8 +143,10 @@ void setup_pager(void)
> =20
>  	/* original process continues, but writes to the pipe */
>  	dup2(pager_process.in, 1);
> -	if (isatty(2))
> +	if (isatty(2)) {
> +		close_fd2 =3D 1;
>  		dup2(pager_process.in, 2);
> +	}
>  	close(pager_process.in);

At this step, we are assuming that we would start the pager only
once during the whole process, so relying on the 0-initialization of
close_fd2 in the BSS and setting it to 1 as needed when we dup2() is
sufficient, but presumably we would want to explicitly set close_fd2
to 0 when we are not calling dup2() here for completeness, with an
eye to the future where we run the pager multiple time.

Other than that, this looks reasonable to me.

Perhaps we should be checking the return value of our close() system
calls?  We would be getting scolded for closing an invalid file
descriptor, if we are closing something we shouldn't be closing,
right?

Thanks.

