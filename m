Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7127F8
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 04:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721968940; cv=none; b=o45i0bBCRCYA+wNZ8KmS4/0ApMesmWGKpbjF1ozg8Yk2wbkL99uxesOOmxC4JTedXMe3NOPGCvE0fpT4eqEIPVN2m990nwF0ZaEX8szu0XFA7HT/iWuLLMjWvBBc4NUVxl9nNNcNniNxGxd6SADwo+bZcRJiWNQdOoK42SEGTAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721968940; c=relaxed/simple;
	bh=GDe7rHSE4ijpnVe3iKjHxg9UWQifn3FCeMxWrhu2+5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6Pv1tTgQK30giLWbOUYb79OBM5LUma3bJ2ZD81VG/vDSRJHntsqHpc/A1SrKqov8C41YQwmbpFhKJa9PHZE4g3sbecmGvQ0uvzm8qm5flZO1G7X2ydaOTuVGZnd6t0IgmH4x/xgQNM9ESAFTfQNVJrZOVjvCWgy9YfZgdvYzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15998 invoked by uid 109); 26 Jul 2024 04:42:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Jul 2024 04:42:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30608 invoked by uid 111); 26 Jul 2024 04:42:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Jul 2024 00:42:20 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 26 Jul 2024 00:42:16 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] csum-file: introduce discard_hashfile()
Message-ID: <20240726044216.GA642208@coredump.intra.peff.net>
References: <xmqqle1p1367.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqle1p1367.fsf@gitster.g>

On Thu, Jul 25, 2024 at 04:07:28PM -0700, Junio C Hamano wrote:

> Introduce discard_hashfile() API function to allow them to release
> the resources held by a hashfile structure the callers want to
> dispose of, and use that in read-cache.c:do_write_index(), which is
> a central place that writes the index file.

Nicely explained, and the patch looks good to me.

A few small comments (that probably do not need any changes):

> +void discard_hashfile(struct hashfile *f)
> +{
> +	if (0 <= f->check_fd)
> +		close(f->check_fd);
> +	if (0 <= f->fd)
> +		close(f->fd);
> +	free_hashfile(f);
> +}

I wondered if we could call this function to replace other spots that
close the descriptors. But I don't think so. There is only one such
spot, in finalize_hashfile(), and it does extra work to make sure that
the close succeeds. So it wouldn't make sense to convert, and nobody
else (until now) bothered to clean up a discarded hashfile.

> diff --git a/read-cache.c b/read-cache.c
> index 48bf24f87c..d96a2cb8cf 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2963,7 +2963,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>  
>  	if (err) {
>  		free(ieot);
> -		return err;
> +		goto discard_hashfile_and_return;
>  	}
>  
>  	offset = hashfile_total(f);
> @@ -2992,8 +2992,14 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>  		hashwrite(f, sb.buf, sb.len);
>  		strbuf_release(&sb);
>  		free(ieot);
> -		if (err)
> -			return -1;
> +		/*
> +		 * NEEDSWORK: write_index_ext_header() never returns a failure,
> +		 * and this part may want to be simplified.
> +		 */
> +		if (err) {
> +			err = -1;
> +			goto discard_hashfile_and_return;
> +		}
>  	}

There's other repeated cleanup happening here, like free(ieot) and
strbuf_release(), which made wonder if we could bump it down to the
cleanup label at the end of the function to simplify things. But
probably not, as we are often doing that cleanup even in the non-error
case. And of course the "sb" strbuf is local to a lot of blocks.

So even if we did want to do it, I think it would come as a separate
patch. But mostly I wondered whether the label should be a more generic
"cleanup" than "discard_hashfile". We could probably worry about that
later, though, if that separate patch ever materializes.

> @@ -3106,6 +3158,11 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>  			   istate->cache_nr);
>  
>  	return 0;
> +
> +discard_hashfile_and_return:
> +	if (f)
> +		discard_hashfile(f);
> +	return err;
>  }

OK, so here's our cleanup label. We check that "f" is valid. I notice we
don't initialize it to NULL, but assigning to it from hashfd() is the
very first thing we do, so it will never be uninitialized. Good.

That made me wonder when it would ever be NULL, and the answer is that
it becomes so after we finalize it:

> @@ -3085,13 +3134,16 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>  
>  	finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_INDEX,
>  			  CSUM_HASH_IN_STREAM | csum_fsync_flag);
> +	f = NULL;

which makes sense. Arguably finalize_hashfile() could take a
pointer-to-pointer and set it to NULL itself for safety/simplicity, but
it's probably OK to let the caller deal with it (we do that trick in the
tempfile API, but not elsewhere).

One thing I did notice. The full hunk above is:

> @@ -3085,13 +3134,16 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>  
>  	finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_INDEX,
>  			  CSUM_HASH_IN_STREAM | csum_fsync_flag);
> +	f = NULL;
>  
>  	if (close_tempfile_gently(tempfile)) {
> -		error(_("could not close '%s'"), get_tempfile_path(tempfile));
> -		return -1;
> +		err = error(_("could not close '%s'"), get_tempfile_path(tempfile));
> +		goto discard_hashfile_and_return;
> +	}
> +	if (stat(get_tempfile_path(tempfile), &st)) {
> +		err = error_errno(_("could not stat '%s'"), get_tempfile_path(tempfile));
> +		goto discard_hashfile_and_return;
>  	}
> -	if (stat(get_tempfile_path(tempfile), &st))
> -		return -1;

We know that "f" is always NULL at this point, so the new code at the
discard_hashfile_and_return label will never actually free anything.
We could continue to just "return -1" here and be fine. I am OK with it
to keep the general "jump to the cleanup label and return" pattern
consistent within the function, but it would make more sense if the
label had a less specific name. ;)

-Peff
