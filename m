Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F36DE552
	for <git@vger.kernel.org>; Mon, 20 May 2024 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232449; cv=none; b=NT63Wye3qg4LG9mD/fXfbRGHIaT5W4q/gWXQ0lP2WuJr/NrLjRERexdlI1bhw/4rGdT9O3v8HeoSn5R0TYGwojOszC+VepRl4T+HYjrAByZdVAwNnnWWwLlg36YspmfRNZ7qcScgRV+RdLOso4kNlgvUCliSDxzzi3Q4ljh0QVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232449; c=relaxed/simple;
	bh=NPtaeUbcg/FoWfkrkEVcayYMKYOnPuoDrRf3GVRaBkQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IoTVWeQ14ENI0qGOE1MwdWmf311JvvYdiv4WXUt6Um21HbE4c/zcwnvbjkyujPE/aqPtHN1QYk1D4ToomD/Xooar1WZ8yx9JFFxElsE1Eu4MVSyRm0c/GWQTSeZA9OA9PP9QDe8e5XhHfusZFlVpJmEmk62m2kjqzXLACKPY5+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=S6rxOU3n; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S6rxOU3n"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E95A19682;
	Mon, 20 May 2024 15:14:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NPtaeUbcg/Fo
	WfkrkEVcayYMKYOnPuoDrRf3GVRaBkQ=; b=S6rxOU3nHIExmdWVd2uNW3W+fALa
	s0APIf2zkO92OYbO6+1C9KPliXM5tCwCeUjGs049njeuSDyd+P2nc2c3cIfbWPCI
	s4yFLQhy4fqMB4yDyNKzDAQ8zXq1x47uLYUy9KTJGb1b9lvcgouIhmDZB0XvXVOI
	W/m7N/pbobSiBcc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0527719681;
	Mon, 20 May 2024 15:14:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C82B19680;
	Mon, 20 May 2024 15:14:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] pager: do not close fd 2 unnecessarily
In-Reply-To: <80f15223-246e-4cfb-a139-e47af829c938@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 19 May 2024 09:12:31 +0200")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<80f15223-246e-4cfb-a139-e47af829c938@gmail.com>
Date: Mon, 20 May 2024 12:14:04 -0700
Message-ID: <xmqqo790fg8z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 209F3E18-16DD-11EF-8F96-25B3960A682E-77302942!pb-smtp2.pobox.com
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


> Furthermore, in a subsequent commit we're going to introduce changes
> that might call close_pager_fds multiple times.  With this in mind,
> unconditionally closing stderr will become undesirable.

In a new world with such a change, what does it mean to call
close_pager_fds()?  It used to mean "we are really done with the
pager and we no longer need them, ever".

And we still call the helper for that purpose after this change,
from wait_for_pager_atexit() and wait_for_pager_signal().

So no matter what "a subsequent commit" does, it feels conceptually
wrong to call it more than once in the first place.  In other words,
what is wrong is that this function closes stderr, but "a subsequent
commit" calls this function multiple times, no?

>  static struct child_process pager_process;
>  static const char *pager_program;
> +static int old_fd2 =3D -1;

What does the magic number "-1" mean?  We often use it to signal
"uninitialized", but then what are concrete "initialized" values
mean?  "We dup2()'ed something else to stderr/fd #2 but before doing
so we saved the original fd #2 away to this variable, so that we can
restore fd #2 by another dup2() of the value of this variable when
we declare that we are done with the standard error stream"?

But that does not look like what is happening here.

>  /* Is the value coming back from term_columns() just a guess? */
>  static int term_columns_guessed;
> @@ -23,7 +24,8 @@ static void close_pager_fds(void)
>  {
>  	/* signal EOF to pager */
>  	close(1);
> -	close(2);
> +	if (old_fd2 !=3D -1)
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
> +		old_fd2 =3D 1;

Equally unclear magic number "1" is used here.

This value is different from pager_process.in, and my earlier "we
are saving away" does not apply, either.

>  		dup2(pager_process.in, 2);
> +	}
>  	close(pager_process.in);

Puzzled...
