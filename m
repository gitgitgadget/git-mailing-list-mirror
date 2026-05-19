Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03AA34A794
	for <git@vger.kernel.org>; Tue, 19 May 2026 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218267; cv=none; b=ZVJKtJ9nSvf5sBzcon9u4DDdB+qH3D33sjXsyxVTBWbBG/MTPzEBEZN2dvz0m7q7VeqS1s1WIXEqpbgWudaRxQH66VC7rxVX4E+FuZ9Y15pedTBnKBd3IGlIokm9r0hSVF0RzbYC6d/FOFaNSb0znJhn4jN1oT3I34/DxBfRMRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218267; c=relaxed/simple;
	bh=3AMP65HIiMmLvLWCSepNcrP2MbtMDwAgX0qwH28/yDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=En/2AvqvMRNgLbMi5/Wnw5WBfDFTh+d8uKTeUxCUFjY32s+p7PVWurUQXZWXqMhxyiPM+p2Eh+W0VnV5HPf5aW0vJbk28nN9ZTVADSI8HlgBdsMWsrSVjuebflTzZWAcRlfGee6whpFPq326B2lKGHfVV6iJzMYUOlF76dtU35s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U49FYjvt; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U49FYjvt"
Received: (qmail 23185 invoked by uid 106); 19 May 2026 19:17:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3AMP65HIiMmLvLWCSepNcrP2MbtMDwAgX0qwH28/yDI=; b=U49FYjvtA+4ZInFvjPOQuDBRn+cC2ei4GHrcgiSYrdkRPqfOITkDxlr7p3wmJVhbjr+kY1nVlrOnN8e4rD9Zy1KoBtmfmj5RQmuGhPKuQcgd5PsWYBs7FEjmZwaovlbJm221psgFRqAU66QSZSygmA0PNzt+3VblGeggdtPnpMvCGDqIaIm+GEubssagPGjWKrctwPsZcjqZD6q8sOURg19SOxk4HgRQe2nU+BoN0XoXz7b1CzJCoDhNedirkP2RLDYQVmVRfjoZncDdJZnd8zwDIqeWNOncliQHCX8Pqh4A9UkYY5kMjCFhZ4JZ0Ksi5iUOX3ityMK7TUZn0fqvAQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 May 2026 19:17:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 55102 invoked by uid 111); 19 May 2026 19:17:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 May 2026 15:17:45 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 May 2026 15:17:43 -0400
From: Jeff King <peff@peff.net>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	fox <fox.gbr@townlong-yak.com>
Subject: Re: [PATCH] http: fix memory leak in fetch_and_setup_pack_index()
Message-ID: <20260519191743.GA2269222@coredump.intra.peff.net>
References: <agx5tblaCZNsYEBq@lorenzo-VM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agx5tblaCZNsYEBq@lorenzo-VM>

On Tue, May 19, 2026 at 04:54:45PM +0200, LorenzoPegorari wrote:

> Inside the function `fetch_and_setup_pack_index()`, when the pack
> obtained using `fetch_pack_index()` fails to be verified by
> `parse_pack_index()`, the function returns without closing and freeing
> said pack.
> 
> Fix this by calling `close_pack_index()` to munmap the index file for
> the leaking pack (which might have been mmapped by `fetch_pack_index()`
> or `verify_pack_index()`), and then free it.

OK, I agree we are leaking here, but after reading the patch I'm left
with a few questions.

>  	ret = verify_pack_index(new_pack);
> -	if (!ret)
> -		close_pack_index(new_pack);
> +
> +	close_pack_index(new_pack);

This part was a little confusing at first, because it looked like we are
already closing the index. But we were doing so on _success_, not on
failure. Which is a little funny since the point is to be able to read
from it later, but OK.

At any rate, that is an existing oddity, and I agree that closing it
before freeing the struct is obviously the right thing to do.

>  	free(tmp_idx);
> -	if (ret)
> +	if (ret) {
> +		free(new_pack);
>  		return -1;
> +	}

And here we free the actual struct. Good.

But this existing free(tmp_idx) is what puzzles me. We do not need the
filename anymore regardless of success or failure, so freeing it makes
sense. But earlier in the function we have:

          new_pack = parse_pack_index(the_repository, sha1, tmp_idx);
          if (!new_pack) {
                  unlink(tmp_idx);
                  free(tmp_idx);
  
                  return -1; /* parse_pack_index() already issued error message */
          }

So on parse failure we actually unlink it, but not on verification
failure. Which seems like it would leave cruft after the process ends.
And I suspect we probably we did prior to 63aca3f7f1 (dumb-http: store
downloaded pack idx as tempfile, 2024-10-25), when we started
registering it as a tempfile to be deleted at process exit.

So I _think_ we could get away with dropping the existing unlink() call
and just let it get cleaned up at process exit. But if we are going to
keep it, do we want to also unlink() in this error path? At which point
it might make more sense to have an "out" label to consolidate all of
this cleanup.

If we are going to unlink() here it may also make sense to just return
the tempfile struct from fetch_pack_index(), and then we can call
delete_tempfile() on it. See the in-code comment in 63aca3f7f1 which
mentions this hackery.

So I dunno. I think your patch is doing the right thing as-is, but it
may be worth taking a moment to clean this up a bit further.

-Peff
