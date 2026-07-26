Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355CE1F0991
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785057630; cv=none; b=Y5+z3Yu7Bz1zrjlIMwuKrApmuFsx8wQp6LHFGJVswpTBo0gNNJTKe7kCxmhRCEWuNNtfnMBEcgyVpZLixF45kMH8nCBRScIA7JUTI/icscaXSEsCuVOpzJzdu8JRbQXBmWPUuT7AuhTC09yofTX00GCHGY/gBuZS5uPSdcv7V0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785057630; c=relaxed/simple;
	bh=WcAYx+9+ZDzPMsxL0NMk85F2FAZNJLP5DOl5+xvh13A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOgeD903A6kpCed7P1nmhOcCkvj0jSLXr/H2uOQUztfDW/RXr+0wT80MuXow149rj31IasK2lvtlGEMmQR5SQfoQq6ywJk/1ACCUQsiYlL6ELAda/2TifAHrxhI21jYL1TRPJWGhTPJSNLmFTGdKoaQL1D2di4fqC2AsfW48R8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=N/gq13t2; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="N/gq13t2"
Received: (qmail 57155 invoked by uid 106); 26 Jul 2026 09:20:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WcAYx+9+ZDzPMsxL0NMk85F2FAZNJLP5DOl5+xvh13A=; b=N/gq13t2Vr3j1uRw/+r4lIvqNAZeYTaiJ1/WEkBnE8vRLrgO8GXnP47Axr0yksYyodxl2rosiY4WlXAgUhtgjSU3RtbUA1VM/9/pEBX16C9Y+xmBIqGyiY9Mak/JNXqOOmv4AB1qYYnEAX3Bx2nmf6BW3by/xmm7D9dEm6er/wLxVlIu5g7fKShRneinrogTTSxc+Z1pcaotbh+osTFb/lJNkjxPKiC3bZMNa6esacOUtEr/JVW9B8BApIlMQcygjFYvlP3UAoQJgN1HxernDB2UezO59u4TBljzsKlUV/LehqdmO2dbjH192ngGZqIS3AEpmuFs1i+OtLaqj2Qdhw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Jul 2026 09:20:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 58269 invoked by uid 111); 26 Jul 2026 09:20:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Jul 2026 05:20:32 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Jul 2026 05:20:27 -0400
From: Jeff King <peff@peff.net>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com, ps@pks.im,
	karthik.188@gmail.com, sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: Re: [PATCH v5 2/3] http: avoid concurrent appends to partial packs
Message-ID: <20260726092027.GA3529827@coredump.intra.peff.net>
References: <cover.1784874850.git.tnyman@openai.com>
 <cover.1785047139.git.tnyman@openai.com>
 <d9667c93b03d1a71df55a33f90538b31afd08677.1785047139.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9667c93b03d1a71df55a33f90538b31afd08677.1785047139.git.tnyman@openai.com>

On Sat, Jul 25, 2026 at 11:44:47PM -0700, Ted Nyman wrote:

> Pack requests stage downloads in a predictable partial-pack file so an
> interrupted transfer can be resumed. Both packfile URI and ordinary dumb
> HTTP requests use this staging path. Opening it in append mode forces
> each write to the current end of the file, so concurrent responses can
> append duplicate data and corrupt the pack.
> 
> Open the partial pack read-write without O_APPEND and seek once to its
> current end. Each downloader then retains the offset matching the Range
> it requested. Because the staging key must uniquely identify immutable
> pack contents, overlapping responses write the same bytes at the same
> offsets instead of extending the file with duplicate data.

OK. I still think this is kind of horrible and gross, but I can't think
of a reason it won't work (at least on POSIX-ish systems) and it solves
the problem with minimal changes and risk of regression.

I wondered about racing with another concurrent writer on the seek, but
I think it is OK. We seek immediately, and then use that offset (which
we get from another seek, replacing ftell()) as the value for our range
request. So even if somebody else advances the file, we have _some_
atomic value that we'll start writing to ourselves, and the worst case
is redundantly requesting a few bytes.

> MinGW's non-append O_RDWR open grants FILE_SHARE_DELETE only for an
> existing file. Create a missing partial pack exclusively, close it, and
> reopen it without O_CREAT so every retained descriptor permits another
> downloader to unlink the staging path. Duplicate that descriptor for
> index-pack instead of reopening the path after closing the stream;
> index-pack installs its own pack and the shared staging file is only
> unlinked, never renamed.

This part I have no real knowledge or opinion on the Windows bits (or if
there's an easier way to do it).

> Accept HTTP 416 when a partial pack is already
> complete and let index-pack validate its contents.

I wonder if we still need this or not. AIUI the original 416 responses
came because we were asking for nonsense outside of the range (because
the corrupted writes advanced the file too far). The worst case now is
that we'd ask for bytes "N-" when the file is only N bytes long, and the
server should say "OK, here are your 0 bytes". But maybe there's a
server who complains about that.

> diff --git a/http.c b/http.c
> index caccf2108e..a0d399b274 100644
> --- a/http.c
> +++ b/http.c
> @@ -2688,10 +2688,13 @@ int finish_http_pack_request(struct http_pack_request *preq)
>  	int tmpfile_fd;
>  	int ret = 0;
>  
> +	/* Another downloader may unlink the staging path while we index it. */
> +	tmpfile_fd = xdup(fileno(preq->packfile));
>  	fclose(preq->packfile);
>  	preq->packfile = NULL;
> -
> -	tmpfile_fd = xopen(preq->tmpfile.buf, O_RDONLY);
> +	if (lseek(tmpfile_fd, 0, SEEK_SET) < 0)
> +		die_errno("unable to seek local file %s for pack",
> +			  preq->tmpfile.buf);

OK, here we are avoiding the race that it gets unlinked by dup-ing the
existing descriptor and seeking back to the start. Makes sense. But
then...

> @@ -2704,13 +2707,8 @@ int finish_http_pack_request(struct http_pack_request *preq)
>  	else
>  		ip.no_stdout = 1;
>  
> -	if (run_command(&ip)) {
> +	if (run_command(&ip))
>  		ret = -1;
> -		goto cleanup;
> -	}
> -
> -cleanup:
> -	close(tmpfile_fd);
>  	unlink(preq->tmpfile.buf);
>  	return ret;

What is going on with this hunk? We don't really need to jump to cleanup
here because we get there directly anyway, and there are no other users
of the cleanup label. So that part doesn't seem wrong, but rather
unrelated.

More importantly, why don't we need to close tmpfile_fd anymore? We hand
it off to run_command(), which will always close it. So I _think_ it was
always wrong to close it ourselves here. If so, then could this hunk
become a preparatory commit on its own?

This commit is already confusing enough that the more extraneous stuff
we can take out of it the better.

> @@ -2738,22 +2736,45 @@ struct http_pack_request *new_http_pack_request(
> [...]
> +	/*
> +	 * MinGW's non-append O_RDWR open grants FILE_SHARE_DELETE only for an
> +	 * existing file; reopen a newly created file so others may unlink it.
> +	 */
> +	for (;;) {
> +		fd = open(preq->tmpfile.buf, O_RDWR);
> +		if (fd >= 0 || errno != ENOENT)
> +			break;
> +		fd = open(preq->tmpfile.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
> +		if (fd >= 0) {
> +			close(fd);
> +			continue;
> +		}
> +		if (errno != EEXIST)
> +			break;
> +	}

OK, and this is the opening magic. What's going on with the O_EXCL here,
though? We try to open once, and if that fails with ENOENT then we open
again. But isn't that racy? Two processes simultaneously try to open(),
find the file is not there, and then both try O_EXCL. Only one of them
will win, and the other will barf.

I guess that is the reason for the loop, where we will try again over
and over until we either pick up somebody else's copy or get our own.
And if we get our own, we still close it and try again. And that's the
Windows magic described in the commit message.

That is...subtle as hell. I really wonder if it would be worth
introducing the basic form of this (just opening once with O_RDWR) and
then doing the Windows hackery on top as a separate commit. That would
leave the intermediate state subject to racy problems on Windows. But
when balancing bisectability versus having a clear human-readable patch,
I think I'd rather see it broken up.

> +	if (fd < 0) {
> +		error_errno("unable to open local file %s for pack",
> +			    preq->tmpfile.buf);
>  		goto abort;
>  	}

OK, and then we get here if we broke out of the loop due to an error
besides ENOENT/EEXIST.

> +	prev_posn = lseek(fd, 0, SEEK_END);
> +	if (prev_posn < 0) {
> +		error_errno("unable to seek local file %s for pack",
> +			    preq->tmpfile.buf);
> +		close(fd);
> +		goto abort;
> +	}
> +	preq->packfile = xfdopen(fd, "w");

And then this is the positioning magic to replace O_APPEND. Good.

> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh

For the record, I don't love that we are using a custom perl script here
instead of going through apache (like all of our other tests). But I
suspect the apache version would be sufficiently horrific (possibly even
worse) that it's not really worth pursuing. Hopefully this perl script
(and the accompanying fifo monstrosities) can sit here for eternity
un-looked-at by human eyes, just quietly doing their job until the heat
death of the universe.

-Peff
