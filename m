Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DAC3126B0
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 05:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810266; cv=none; b=OiPvFsTvxOCJkEpZGnIlGMuCtQibyo3mjO+xdPCUMf6fj6HgWeYeeyczfWbX/Uym0lWkmUE5a+ZKrR7vdk2OhLVM4TGu25VoS3WNCrtEWIi5HnEKTsebEaR6ex3Den/fmQjbWHWB2h51zF2aqUhQHTJ35nUUkJwLePLH8I5QRtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810266; c=relaxed/simple;
	bh=NOq1ZXVP3V0C6hGFWb3J/qnpsyE9PjgqCjZ7W24mi18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mm3RyklNMugEDEXoWmbWYKQsg3/Jm2r7pIO9sK57inGqkqGZmI39trl29CEo60QTZVqSv1csSF+Sd3MwM22itlNONr+sPprVDsmggMbGTw6YMDRjqcqg+KcqKHFOmBiSucuBQ+L34h627O8ho3jb5U5Wvj3gZE6KN1tZvZVrMh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=W0js71aN; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="W0js71aN"
Received: (qmail 7545 invoked by uid 106); 27 Aug 2026 05:57:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NOq1ZXVP3V0C6hGFWb3J/qnpsyE9PjgqCjZ7W24mi18=; b=W0js71aNPG5a6ec29MJcXo1iIpb7yRjhdnPRgszk4vli2xevjwu75BbJNRNGtWlMFyx1BhuYfJWmMnJ+k5H77DJhVbSzKTLiYCzyfILhrN2p7/REAXUyEj0fu3rh/cAn2mJlfOZ2wADkTRIJXVPW6PVBRpMP0biDrFSuiQS7zwiJ0gEHEmTmyne6XHsQjFwlZarnmBLo8fbAKfJOYllazwr5D/dTn5gpbylIy1FteuMfAvSP28vjgZCz5vERm3FODnSZ6wWFTy7enN+Ycz52m1vaYW9DV6gXLNzR4LGKRv47N9scSjtXAfQwhMVJiR2BqY90/NTLMZDZ2PUlE8zcxQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Aug 2026 05:57:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 38098 invoked by uid 111); 27 Aug 2026 05:57:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Aug 2026 01:57:47 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 27 Aug 2026 01:57:43 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/4] packfile: recover object lookups racing a
 concurrent repack
Message-ID: <20260827055743.GB189659@coredump.intra.peff.net>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <pull.2207.v2.git.1787684429.gitgitgadget@gmail.com>
 <fc98f48ddb4d46cad66a40ecdd96c139e1397784.1787684429.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc98f48ddb4d46cad66a40ecdd96c139e1397784.1787684429.git.gitgitgadget@gmail.com>

On Tue, Aug 25, 2026 at 07:00:28PM +0000, Elijah Newren via GitGitGadget wrote:

>   1. open_pack_index() fails, so we print
> 
>         error: packfile <path> index unavailable
> 
>      and report the pack as unusable, even though the object still lives
>      in the replacement pack.
> 
>   2. A normal lookup recovers: odb_read_object_info_extended() issues a
>      second read that reloads the on-disk pack state and finds the object
>      in its new home, making the message above mere noise.  But an
>      OBJECT_INFO_QUICK lookup deliberately skips that second read to stay
>      fast on a genuine miss, so it does *not* recover: it reports the
>      object as absent even though it still lives in the replacement pack.
>      A resident reader that resolves objects with a QUICK lookup -- such
>      as the `git mktree --batch` process the tests below drive -- then
>      produces wrong results.  Even where a spurious miss is not fatal it
>      is not harmless: `git upload-pack` checks a client's "have" lines
>      with a QUICK lookup, and a dropped "have" removes a common object
>      from the negotiation, so the client is sent more than it needs.

Maybe I am still being dense, but this description does not make any
sense to me at all.

The _point_ of QUICK is to accept those false negatives. It is the right
thing for upload-pack to do, to avoid re-scans for objects which we
simply don't have (and don't necessarily expect to have).

It sounds like mktree is wrong to be using QUICK at all. It comes from
817b0f6027 (mktree: do not check type of remote objects, 2022-06-21)
which rewrote a call to vanilla oid_object_info(). From the description
there it probably should be using SKIP_FETCH_OBJECT but not QUICK. Or
possibly it should use neither unless --missing is given.

So I don't see QUICK itself here violating any contract (even if it
_could_ find the object in some cases with just a little more work, as
in the case that we were discussing for v1).

The much more interesting case is the non-QUICK one that Patrick
outlined earlier in the thread. Where we say "nope, we don't have that
object" even though we could find it with a little more work. But that
doesn't seem to be described here either. But I think that is not even
what this patch is about; that's in patch 4.

If the "error:" message is scary and gross (especially because we may
retry and correct it anyway) and happens due to routine races, we might
consider suppressing it.

> +	/*
> +	 * Set when a lookup finds that a pack we already know about has
> +	 * vanished -- its ".idx" or ".pack" removed out from under us, the
> +	 * signature of a concurrent "git repack".  It tells
> +	 * odb_read_object_info_extended() to reprepare and retry even for an
> +	 * OBJECT_INFO_QUICK lookup, which normally skips that rescan to stay
> +	 * fast on a genuine miss.  Reset when the packfiles are reprepared
> +	 * (see odb_source_packed_prepare()).
> +	 */
> +	unsigned stale_packs_detected : 1;

So this is a way of hackily triggering SECOND_READ for QUICK queries,
even though the point of QUICK is to suppress that second read! Again,
maybe I'm just being dense, but I don't get it.

> @@ -535,8 +550,20 @@ static int open_packed_git_1(struct packed_git *p)
>  	ssize_t read_result;
>  	const unsigned hashsz = p->repo->hash_algo->rawsz;
>  
> -	if (open_pack_index(p))
> +	if (open_pack_index(p)) {
> +		/*
> +		 * A concurrent repack may have removed this pack, deleting its
> +		 * ".idx" before its ".pack" (see unlink_pack_path()).  If the
> +		 * index simply vanished, note the stale pack set and stay
> +		 * quiet; the pack is still reported unusable.  Only a
> +		 * still-present but unreadable index is worth an error.
> +		 */
> +		if (pack_index_is_missing(p)) {
> +			p->repo->objects->stale_packs_detected = 1;
> +			return -1;
> +		}
>  		return error("packfile %s index unavailable", p->pack_name);
> +	}

And this seems racy. We might catch the .idx but miss the .pack file.
That would cause a failed read, but not trigger sale_packs_detected.

-Peff
