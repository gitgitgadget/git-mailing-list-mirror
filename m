Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D402C6A33A
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717842305; cv=none; b=oI301sEfee6KDwjNPc4SF75DB3L97Wp0haxzgLoKpKXVFV5F4Lmk4cftAlwYVFGvc0x3mbgnEiUyS0PulFDCU4ZMQh7J2A16L1xsTC5agcN8jmrTsCvrgolldB3X3Wp1YXB9GmgwLlm3KbVfWKtnaAqcLTlGfJZ1EZTJ+pJ7IR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717842305; c=relaxed/simple;
	bh=SoMHy32L/0VLJHmWK5GO3KTjH3u5n1COli7/aW3P0PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlGfmZeIFteNntCpmHwpDmrLq2OdNPo7iEoE5yGDHAHEghj3SyF1Qh4WFK/IImXM2Kiu/zdWQp4njkvfjcpGx3tlRbjCTrg3pTy0q4G5k8nbu1CBqr2bam6WD2+QlFOs0erqDH+iydj3WSHhIhqP9siAa4bscyvl9mHoaInoArk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7907 invoked by uid 109); 8 Jun 2024 10:25:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Jun 2024 10:25:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29241 invoked by uid 111); 8 Jun 2024 10:25:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Jun 2024 06:25:00 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Jun 2024 06:25:02 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] server-info.c: remove temporary info files on exit
Message-ID: <20240608102502.GC2659849@coredump.intra.peff.net>
References: <cover.1717712358.git.me@ttaylorr.com>
 <2d5a0536af1a6d45835622e2c020266079fa0873.1717712358.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d5a0536af1a6d45835622e2c020266079fa0873.1717712358.git.me@ttaylorr.com>

On Thu, Jun 06, 2024 at 06:19:31PM -0400, Taylor Blau wrote:

> The update_info_file() function within server-info.c is responsible for
> moving the info/refs and info/packs files around when updating server
> info.
> 
> These updates are staged into a temporary file and then moved into place
> atomically to avoid race conditions when reading those files. However,
> the temporary file used to stage these changes is managed outside of the
> tempfile.h API, and thus survives process death.
> 
> Manage these files instead with the tempfile.h API so that they are
> automatically cleaned up upon abnormal process death.

Makes sense. I was going to suggest that these could even be lockfiles,
but it is intentional to let two simultaneous processes race (with an
atomic last-one-wins result). See d38379ece9 (make update-server-info
more robust, 2014-09-13).

> Unfortunately, and unlike in the previous step, there isn't a
> straightforward way to inject a failure into the update-server-info step
> that causes us to die() rather than take the cleanup path in label
> 'out', hence the lack of a test here.

That sounds like a challenge. ;)

  $ echo garbage >.git/packed-refs
  $ git update-server-info
  fatal: unexpected line in .git/packed-refs: garbage
  $ ls .git/info/
  exclude  refs  refs_QYvQGb

I don't know if it's worth adding such a test. It seems rather brittle
to assume that we'd die() here (let alone that we are using the files
backend at all).

> @@ -86,13 +86,12 @@ static int update_info_file(char *path,
>  	};
>  
>  	safe_create_leading_directories(path);
> -	fd = git_mkstemp_mode(tmp, 0666);
> -	if (fd < 0)
> +	f = mks_tempfile_m(tmp, 0666);
> +	if (!f)
>  		goto out;
> -	to_close = uic.cur_fp = fdopen(fd, "w");
> +	uic.cur_fp = fdopen_tempfile(f, "w");

OK, good, fdopen_tempfile() means that the FILE handle is owned by the
tempfile, too.

> @@ -121,27 +120,22 @@ static int update_info_file(char *path,
>  	}
>  
>  	uic.cur_fp = NULL;
> -	if (fclose(to_close))
> -		goto out;

And we don't need to fclose() anymore since the tempfile code handles
that for us. Nice.

>  	if (uic_is_stale(&uic)) {
> -		if (adjust_shared_perm(tmp) < 0)
> +		if (adjust_shared_perm(get_tempfile_path(f)) < 0)
>  			goto out;
> -		if (rename(tmp, path) < 0)
> +		if (rename_tempfile(&f, path) < 0)
>  			goto out;
>  	} else {
> -		unlink(tmp);
> +		delete_tempfile(&f);
>  	}
>  	ret = 0;

OK, so we always rename or delete here, unless we jumped to the error
path...

>  out:
>  	if (ret) {
>  		error_errno("unable to update %s", path);
> -		if (uic.cur_fp)
> -			fclose(uic.cur_fp);
> -		else if (fd >= 0)
> -			close(fd);
> -		unlink(tmp);
> +		if (f)
> +			delete_tempfile(&f);
>  	}

And here we do an explicit delete, which is good for a lib-ified world
where the process doesn't just exit immediately.

I think you could actually call delete_tempfile() unconditionally, even
outside the "if (ret)" block. It is a noop for a NULL tempfile (so OK
even if we jump to "out" before opening it). And a renamed tempfile goes
back to NULL as well.

I.e., one of the advantages to using the tempfile interface is that it's
always in a consistent state, and you just use delete() on exit, like we
do strbuf_release().

That said, it's a pretty minor style question, and I don't think is
worth a re-roll.

-Peff
