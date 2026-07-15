Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354A0351C2D
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 05:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784093165; cv=none; b=g+3PQLQPe9U4WktLnPc2QSLWroup5SDqA82fBHsY8rPv2d2AV4bYVRsFn9rtRr5vihMeONWzQT+MaBlaempwb2WYcxI+VqsF8Vxo1EKGPeZacu0V4Y0Rn7+J27jCHgnlJVGeGaZX/qxoZooYnyIoMd0Z4MbjSWaYM/RU0ZWnlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784093165; c=relaxed/simple;
	bh=ImrQbxx6zl+a5wPQq0ncWsR7Ri76m+eWUbiMCJi6twA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BYoOSCkEAShNf/mvAdQS5r4bBJGlPPynpCNRAh98v/3A7mO3PzeRiYKUrrJzBX8MBzcJyx7qpGD/sHQsjeN4izMFOIpIldxDh2RZgYVD6eVc5TquDNdlsrig2Zjt3pV36sVmr5QRMgOezqBGf73KxcrThmw2hr7lcaDtphmKp90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=gj+WArXI; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="gj+WArXI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1784093158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dfzR3bdAkB1hAaxvToEoh4XszHHuBKdf81MdT3B2OIc=;
	b=gj+WArXITFYw1GO3dtXP2TUPJDcsIXWyTcbdyN3BGqgAlYStSNv39/dmSnJJhN3MCDJLyW
	Y76ojHoJ6gffZt+vYbGS0H1GItpATstf9v/RaE5BbVNZLXS9mQ1anCuJwjaObNIfbn9+Em
	V47BIV8ynXH0Do+nsxtftw1HWLQvBI4=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>
Subject: Re: [PATCH v3 7/9] pack-bitmap: introduce function to open bitmap
 for a single source
In-Reply-To: <20260713-pks-odb-for-each-object-filter-v3-7-b3c65c641073@pks.im>
References: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
 <20260713-pks-odb-for-each-object-filter-v3-7-b3c65c641073@pks.im>
Date: Wed, 15 Jul 2026 07:25:54 +0200
Message-ID: <875x2gn7rx.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The function `prepare_bitmap_git()` opens the first bitmap it can find
> in any of the object sources connected to the repository. In a
> subsequent commit, the "packed" object database backend will learn to
> use bitmaps to answer object filters when enumerating objects. That
> backend operates on a single object source though, so using a bitmap
> that potentially belongs to a different source would be wrong:
>
>   - The source would yield objects that are not part of the source
>     itself.
>
>   - The object source info would be attributed to the wrong source.
>
>   - With multiple sources, each source would enumerate the same bitmap
>     another time.
>
> Introduce a new function `prepare_source_bitmap_git()` that only opens
> bitmaps belonging to the given object source.

Tinies nit: this should be `prepare_bitmap_git_for_source()`

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  pack-bitmap.c | 12 ++++++++++++
>  pack-bitmap.h |  2 ++
>  2 files changed, 14 insertions(+)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 72c8ae3228..09ba15d26b 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -753,6 +753,18 @@ struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
>  	return NULL;
>  }
>  
> +struct bitmap_index *prepare_bitmap_git_for_source(struct odb_source_packed *source)
> +{
> +	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
> +
> +	if (!open_bitmap_for_source(source, bitmap_git) &&
> +	    !load_bitmap(source->base.odb->repo, bitmap_git, 0))
> +		return bitmap_git;
> +
> +	free_bitmap_index(bitmap_git);
> +	return NULL;
> +}
> +
>  int bitmap_index_contains_pack(struct bitmap_index *bitmap, struct packed_git *pack)
>  {
>  	for (; bitmap; bitmap = bitmap->base) {
> diff --git a/pack-bitmap.h b/pack-bitmap.h
> index ae8dc491ac..9f20fb6e56 100644
> --- a/pack-bitmap.h
> +++ b/pack-bitmap.h
> @@ -9,6 +9,7 @@
>  #include "string-list.h"
>  
>  struct commit;
> +struct odb_source_packed;
>  struct repository;
>  struct rev_info;
>  
> @@ -68,6 +69,7 @@ struct bitmapped_pack {
>  
>  struct bitmap_index *prepare_bitmap_git(struct repository *r);
>  struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx);
> +struct bitmap_index *prepare_bitmap_git_for_source(struct odb_source_packed *source);
>  
>  /*
>   * Given a bitmap index, determine whether it contains the pack either directly
>
> -- 
> 2.55.0.313.g8d093f411d.dirty
>
>

-- 
Cheers,
Toon
