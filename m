Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CD53C0D
	for <git@vger.kernel.org>; Sun, 14 Jan 2024 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2135 invoked by uid 109); 14 Jan 2024 10:14:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 14 Jan 2024 10:14:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3625 invoked by uid 111); 14 Jan 2024 10:14:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 14 Jan 2024 05:14:27 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 14 Jan 2024 05:14:24 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] reftable/stack: refactor reloading to use file
 descriptor
Message-ID: <20240114101424.GA1196682@coredump.intra.peff.net>
References: <cover.1704714575.git.ps@pks.im>
 <cover.1704966670.git.ps@pks.im>
 <36b9f6b6240686cc5b0a761b889614fc31f01d34.1704966670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36b9f6b6240686cc5b0a761b889614fc31f01d34.1704966670.git.ps@pks.im>

On Thu, Jan 11, 2024 at 11:06:43AM +0100, Patrick Steinhardt wrote:

> We're about to introduce a stat(3P)-based caching mechanism to reload
> the list of stacks only when it has changed. In order to avoid race
> conditions this requires us to have a file descriptor available that we
> can use to call fstat(3P) on.
> 
> Prepare for this by converting the code to use `fd_read_lines()` so that
> we have the file descriptor readily available.

Coverity noted a case with this series where we might feed a negative
value to fstat(). I'm not sure if it's a bug or not.

The issue is that here:

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

...we might end up with fd as "-1" after calling open() on the list
file. For most errors we'll jump to "out", which makes sense. But if we
get ENOENT, we keep going with an empty file-list, which makes sense.

But we then do other stuff with "fd". I think this case is OK:

> @@ -356,12 +367,16 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
>  		names = NULL;
>  		free_names(names_after);
>  		names_after = NULL;
> +		close(fd);
> +		fd = -1;

We only get here if reftable_stack_reload_once() returned an error,
which it won't do since we feed it a blank set of names (and anyway,
close(-1) is a harmless noop).

But if we actually get to the end of the function, it's more
questionable. As of this patch, it's OK:

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

But in the next patch we have this hunk:

> @@ -374,7 +375,11 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
>                 sleep_millisec(delay);
>         }
> 
> +       stat_validity_update(&st->list_validity, fd);
> +
>  out:
> +       if (err)
> +               stat_validity_clear(&st->list_validity);
>         if (fd >= 0)
>                 close(fd);
>         free_names(names);

which means we'll feed a negative value to stat_validity_update(). I
think this may be OK, because I'd imagine the only sensible thing to do
is call stat_validity_clear() instead. And using a negative fd means
fstat() will fail, which will cause stat_validity_update() to clear the
validity struct anyway. But I thought it was worth double-checking.

-Peff
