Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3171FE44C
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749066899; cv=none; b=LNHBsSo/RnDkNYlQmQKJAfWtJWkAlQGcdwLiNbJvgkYQXKYNeeHYhvJxzRLBU143ENVNTHGc8yrbqJ5SlUXtLX0wXrs9cjV7NfRgNWGpOgaLTFPDgZV6SlD0yU8PnBDOgN9BkFNGImzeaXQi6xr/11JbArnIgpr0GyEOcEee0s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749066899; c=relaxed/simple;
	bh=mCuZZl/ttzoaSBN3NNJ1DfDs+Hm5KNheCacPZQ2Equ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joxrlx8zuZmiIDde52b0SyRUcPGvIuzlbmnlwB0h4xuomKdqNCDnrJF5A6srCTRHRpbScQG0chaIAt4RymA6uTSqgu8ryXqKVx4+zIqQGHMnUpP2m+yvEDNUDH1OycXQO4E5QwV3DS72RYmG7ekRJDMA1G8MtPlxlC/pD+F3kU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ebMPFUmn; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ebMPFUmn"
Received: (qmail 13932 invoked by uid 109); 4 Jun 2025 19:54:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mCuZZl/ttzoaSBN3NNJ1DfDs+Hm5KNheCacPZQ2Equ0=; b=ebMPFUmnwUwBj0jTwWkNUG4HyIcSITGs3Thu3J+LjEu+eoHjLpyydVbT/sNheV0H0nrw+GMcVX81qGHJXpQxgS0PuJBFydI+LPUTMuv5b4aXQOLbF832WPoQSS92pAxemgjrwjYtRGWfHw/r56k1qZW+lQkocPvOi2rhldzNNQzfX0yCdPH4aoysZS7oz0FVBmK6G8kdKOVZTNMqfxw1+E5TpmgIKXbHbTE37j0rXD/ZaBl/jtbwC8cghW4rVgbg1x6ZCcCsXK02jT6/byfV1Nu99NPzcLVUnc4ZYX44+u+MwkOpLHpnFqoM+n72qsnSu6t8cFf0srs/ubelnnm9Fg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Jun 2025 19:54:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13098 invoked by uid 111); 4 Jun 2025 19:54:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Jun 2025 15:54:57 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Jun 2025 15:54:55 -0400
From: Jeff King <peff@peff.net>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 3/3] cat-file.c: add batch handling for submodules
Message-ID: <20250604195455.GB1500045@coredump.intra.peff.net>
References: <pull.1929.git.1748890555.gitgitgadget@gmail.com>
 <980ab7f7ef56944df78530dcc9c79b54d1450806.1748890555.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <980ab7f7ef56944df78530dcc9c79b54d1450806.1748890555.git.gitgitgadget@gmail.com>

On Mon, Jun 02, 2025 at 06:55:55PM +0000, Victoria Dye via GitGitGadget wrote:

> To disambiguate without needing to invoke a separate Git process (e.g.
> 'ls-tree'), print the message "<oid> submodule" for such objects instead of
> "<object> missing". In addition to the change from "missing" to "submodule",
> the new message differs from the old in that it always prints the resolved
> tree entry's OID, rather than the input object specification.

OK. I read over the discussion from last year, which I think mostly
centered around this patch. I do still think in the long run it would be
nice for cat-file to produce what output it _can_ for a missing object
(e.g., the oid and mode).

But I think it is OK to punt on that for now. Because "<oid> missing"
lines already exist, we'd probably need to put such behavior behind a
new command-line option. So while "<oid> submodule" lines would be
unnecessary in that hypothetical future world, we are not digging the
hole any deeper, from a backwards-compatibility standpoint.

Although speaking of backwards compatibility, I guess older readers may
be surprised that the old "missing" message becomes a "submodule" one.
They may need to be updated if they were written carefully to bail on
unknown input (and were happy seeing "missing" messages for submodules).
So there may be some fallout, but it's not like the existing messages
were particularly useful in the first place.

> Note that this implementation maintains a distinction between submodules
> where the commit OID is not present in the repo, and submodules where the
> commit OID *is* present; the former will now print "<object> submodule", but
> the latter will still print the full object content.

Hmm, that is an interesting point. It feels kind of arbitrary, but I'm
having trouble making a strong argument for one direction or the other.
The way you've written it means that readers need to be prepared to
parse _both_ the mode and "<oid> submodule" lines to find submodules.
But maybe there's some value in finding out more information about
submodule commits you do have in-repo.

The implementations are similar. Replacing this hunk:

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index b11576756bcc..4b23fcecbd8e 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -496,7 +496,10 @@ static void batch_object_write(const char *obj_name,
>  						       &data->oid, &data->info,
>  						       OBJECT_INFO_LOOKUP_REPLACE);
>  		if (ret < 0) {
> -			report_object_status(opt, obj_name, &data->oid, "missing");
> +			if (data->mode == S_IFGITLINK)
> +				report_object_status(opt, oid_to_hex(&data->oid), &data->oid, "submodule");
> +			else
> +				report_object_status(opt, obj_name, &data->oid, "missing");
>  			return;
>  		}
>  

with:

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4b23fcecbd..1b200e1607 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -488,6 +488,11 @@ static void batch_object_write(const char *obj_name,
 		if (opt->objects_filter.choice == LOFC_BLOB_LIMIT)
 			data->info.sizep = &data->size;
 
+		if (data->mode == S_IFGITLINK) {
+			report_object_status(opt, oid_to_hex(&data->oid), &data->oid, "submodule");
+			return;
+		}
+
 		if (pack)
 			ret = packed_object_info(the_repository, pack, offset,
 						 &data->info);

so I think the decision is really about what people will find most
useful. So I dunno. It is mostly a coin-flip, leading me to say that
what you picked just came up "heads" and is good enough. ;)

-Peff
