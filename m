Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B2425A640
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 03:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738638121; cv=none; b=dtBB6RLsjVxIBzCd9Ww0Do7lktTRTaSb3jdWnRO0gFjQcoefrh0rZl5UIsiel7wqcQNeAfnWvuZ094zM+dWqDz364YiSNd9qvY984Api0YT1I0bZAcpNG6Fem+AeVINWVL2xium2VIZBUH9jNg9pLTvZWk0OVNAi5k6ZoVJB2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738638121; c=relaxed/simple;
	bh=kBMPzMawEfA+j5PXHT4cnrH8sbjcvAsdybKIx17qmz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fy4/DGhASdvI3c7g3QpbzEPN3+9AgkXsMmPOmjnkU1XQ0C565bn9cM2bNSncSaVsOz4vY61r9L/ZkEXWbEzuWSyTUGrrNZ04+3ebllSDBeDbPBRNsd/nECDqU3EwCq0FNFCSFXMkcz9KRPZVe285qNmirTrgZVjp1GEtGiIrO3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NmgThapL; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NmgThapL"
Received: (qmail 21876 invoked by uid 109); 4 Feb 2025 03:01:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kBMPzMawEfA+j5PXHT4cnrH8sbjcvAsdybKIx17qmz8=; b=NmgThapLIis7xOJwh4AoUqMljajtgBG+L8tWhU/8gIJyMge41e+FIdEE1regnNfsjKcOji5j4tlWfmt+KCtjoWNW3NhbiyG3WESzs7bF92fQFo1JMS6nUaHsggi1GUVtZk0VLe8gx78g9hC+C3K0EYWzHvcUrRxwdTCE68jTvriv/Awe4qRdzGasUnx9arRBLWXHxsvnYPuTob4o16tdzuIzi//on1wIbDwrwKP+DuTyJKFIn6NT+JU1/x8j3C+jcXfvFM/v0wBN4JkTh3SVn2iHeTbjfhLIhAV/ofrCpWs90bdEm0ZrSdtr4ow0moUwat6kE42eGw6zSk8Jddiz8Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Feb 2025 03:01:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30348 invoked by uid 111); 4 Feb 2025 03:02:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2025 22:02:01 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 3 Feb 2025 22:01:57 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/repack: fix `--keep-unreachable` when there
 are no packs
Message-ID: <20250204030157.GC23954@coredump.intra.peff.net>
References: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
 <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-2-7c4d69c5072c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-2-7c4d69c5072c@pks.im>

On Mon, Feb 03, 2025 at 02:06:55PM +0100, Patrick Steinhardt wrote:

> The "--keep-unreachable" flag is supposed to append any unreachable
> objects to the newly written pack. This flag is explicitly documented as
> appending both packed and loose unreachable objects to the new packfile.
> And while this works alright when repacking with preexisting packfiles,
> it stops working when the repository does not have any packfiles at all.

OK. I thought from the subject / cover letter this was going to be about
the fact that "git repack -adk" may sometimes say "Nothing new to pack".
And the issue there is that if there are no reachable objects, we don't
actually pack at al.

But this is a separate issue, where we actually do repack, but don't
correctly pass the options. Let's read on...

> The root cause are the conditions used to decide whether or not we want
> to append "--pack-loose-unreachable" to git-pack-objects(1). There are
> a couple of conditions here:
> 
>   - `has_existing_non_kept_packs()` checks whether there are existing
>     packfiles. This condition makes sense to guard "--keep-pack=",
>     "--unpack-unreachable" and "--keep-unreachable", because all of
>     these flags only make sense in combination with existing packfiles.
>     But it does not make sense to disable `--pack-loose-unreachable`
>     when there aren't any preexisting packfiles, as loose objects can be
>     packed into the new packfile regardless of that.

Yeah, this analysis makes sense, and is the root of the problem.

>   - `delete_redundant` checks whether we want to delete any objects or
>     packs that are about to become redundant. The documentation of
>     `--keep-unreachable` explicitly says that `git repack -ad` needs to
>     be executed for the flag to have an effect.
> 
>     It is not immediately obvious why such redundant objects need to be
>     deleted in order for "--pack-unreachable-objects" to be effective.
>     But as things are working as documented this is nothing we'll change
>     for now.

I don't think it's strictly necessary to require "-d" here. The original
concept of "-k" was to modify "-d" to keep objects instead of loosening
(so an alternative to --unpack-unreachable/-A). And then it expanded to
collecting the loose objects, too, for the reasons given in e26a8c4721
(repack: extend --keep-unreachable to loose objects, 2016-06-13).

I think you could conceive of "-k" as an alternative to "-d", rather
than an alternative to "-A". I.e., so that "repack -ak" did the same as
"repack -adk" does now.

And it would probably not even be a big code change, but it's possible
there would be some unexpected fallout (the logic in repack is quite
tortured and intricate from my recollection).

So I don't know that it's really worth it to change now. Especially
because I think "-k" has mostly outlived its usefulness. Cruft packs
solve the same problem but keep the extra objects in their own pack,
where they're less likely to interfere with normal operations. I'd
recommend anybody considering "-k" now to look into cruft packs instead.

>   - `pack_everything & PACK_CRUFT` checks that we're not creating a
>     cruft pack. This condition makes sense in the context of
>     "--pack-loose-unreachable", as unreachable objects would end up in
>     the cruft pack anyway.
> 
> So while the second and third condition are sensible, it does not make
> any sense to condition `--pack-loose-unreachable` on the existence of
> packfiles.

Yup, agreed.

> Fix the bug by splitting out the "--pack-loose-unreachable" and only
> making it depend on the second and third condition. Like this, loose
> unreachable objects will be packed regardless of any preexisting
> packfiles.

Makes sense. My only question would be whether there are any gotchas
inside pack-objects about using --pack-loose-unreachable without
--keep-unreachable (since the two were up until now always used
together).

It was added by e26a8c4721. And looking over that patch, I don't see
anything that would let the options be used independently. So this seems
like a good solution.

> diff --git a/builtin/repack.c b/builtin/repack.c
> index 81d13630ea..8194344b04 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -1370,9 +1370,12 @@ int cmd_repack(int argc,
>  					    "--unpack-unreachable");
>  			} else if (keep_unreachable) {
>  				strvec_push(&cmd.args, "--keep-unreachable");
> -				strvec_push(&cmd.args, "--pack-loose-unreachable");
>  			}
>  		}
> +
> +		if (keep_unreachable && delete_redundant &&
> +		    !(pack_everything & PACK_CRUFT))
> +			strvec_push(&cmd.args, "--pack-loose-unreachable");

One funny thing here is that previously unpack_unreachable took
precedence over keep_unreachable in the if-else chain. I wondered if we
could end up invoking pack-objects with both --unpack-unreachable and
--pack-loose-unreachable, which is nonsense.

But I think the answer is no, because we forbid --unpack-unreachable/-A
and --keep-unreachable from both being passed up front.

> -test_expect_failure '--keep-unreachable packs unreachable loose object without existing packs' '
> +test_expect_success '--keep-unreachable packs unreachable loose object without existing packs' '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&
>  	(

Your test from patch 1 looked reasonable to me. If you fold patch 1 into
the existing tests in t7701, you might want to adjust it to match the
techniques those tests use for checking the object (rather than the new
helpers you added).

-Peff
