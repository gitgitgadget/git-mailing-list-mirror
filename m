Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74F64D5AF
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A6gJyROU"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4351B1D38CB;
	Wed, 10 Jan 2024 14:57:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rYLiO2mckn/SRPZ1RXgxWNrgA+E0h1w/usDwPP
	zbNH0=; b=A6gJyROUpsDG8meuN7/IZVihccjPusJEbNZiNtoGa6q9im3GJuakHn
	qigf6OJ3EJ5FuXVrAoTnblwOSiNVCsQi0GUjGzScwOMMF2JeqDXXW5wGMuSjV66T
	vc2D2Z4ALSlpcPZv6L6KGnWqYT/2EcyhWPUe7w66swgKDK1ihhZcU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 39F621D38CA;
	Wed, 10 Jan 2024 14:57:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F1851D38C9;
	Wed, 10 Jan 2024 14:57:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 2/4] reftable/stack: refactor reloading to use file
 descriptor
In-Reply-To: <726d302d7b21a5b948575492c717cfdb701de5cd.1704714575.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 8 Jan 2024 13:18:35 +0100")
References: <cover.1704714575.git.ps@pks.im>
	<726d302d7b21a5b948575492c717cfdb701de5cd.1704714575.git.ps@pks.im>
Date: Wed, 10 Jan 2024 11:57:25 -0800
Message-ID: <xmqqsf359d22.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7A7804DA-AFF2-11EE-851D-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We're about to introduce a stat(3P)-based caching mechanism to reload
> the list of stacks only when it has changed. In order to avoid race
> conditions this requires us to have a file descriptor available that we
> can use to call fstat(3P) on.
>
> Prepare for this by converting the code to use `fd_read_lines()` so that
> we have the file descriptor readily available.
> ---

Missing sign-off.

Other than that, the change is a refactoring that is very faithful
to the original.  Instead of doing the "open - pretend we opened an
empty file if it does not exist - read - close" dance all inside the
read_lines() call, this sort-of open codes the helper in this caller,
so that later steps of this series can look at the file descriptor
open to it.

Looking good.

>  reftable/stack.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/reftable/stack.c b/reftable/stack.c
> index bf869a6772..b1ee247601 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -308,6 +308,7 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
>  	struct timeval deadline;
>  	int64_t delay = 0;
>  	int tries = 0, err;
> +	int fd = -1;
>  
>  	err = gettimeofday(&deadline, NULL);
>  	if (err < 0)
> @@ -329,9 +330,19 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
>  		if (tries > 3 && tv_cmp(&now, &deadline) >= 0)
>  			goto out;
>  
> -		err = read_lines(st->list_file, &names);
> -		if (err < 0)
> -			goto out;
> +		fd = open(st->list_file, O_RDONLY);
> +		if (fd < 0) {
> +			if (errno != ENOENT) {
> +				err = REFTABLE_IO_ERROR;
> +				goto out;
> +			}
> +
> +			names = reftable_calloc(sizeof(char *));
> +		} else {
> +			err = fd_read_lines(fd, &names);
> +			if (err < 0)
> +				goto out;
> +		}
>  
>  		err = reftable_stack_reload_once(st, names, reuse_open);
>  		if (!err)
> @@ -356,12 +367,16 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
>  		names = NULL;
>  		free_names(names_after);
>  		names_after = NULL;
> +		close(fd);
> +		fd = -1;
>  
>  		delay = delay + (delay * rand()) / RAND_MAX + 1;
>  		sleep_millisec(delay);
>  	}
>  
>  out:
> +	if (fd >= 0)
> +		close(fd);
>  	free_names(names);
>  	free_names(names_after);
>  	return err;
