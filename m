Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E553419AD87
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 22:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709759; cv=none; b=Mu86bVZat/XCfjc1gjScP0vt4MhOiInsvW1BgTk+q3h42kjGPDCWj2nnvIW+M3lQCRk6g5tLrpGTlSGZFWuVE6x4RvmsCIXvG+5d1sf7yn6FCB321PGpKMPaE8StKDw14M7u4PA4UjaXhf2z05Qc6yrbdt+QTSZ5z5XmpTOuHYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709759; c=relaxed/simple;
	bh=HiO6GN3IVDmrF0VUFjGVuhcjyjwzVGIW5wu9aHeJMo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ikx5dtzWJAIagbqhlx3UQ1Idq1ltgRfyr+vRbotrBobBzdOa2X4uACGXgWZW6dApCh6dH1MADwxrE8z4psiwYHVMZVbTSD6aBbdKCeNCgStEb2vSA6agSNVvPDCrGshPvXaMM5tfcL4py1SADhCMwZbOmbW7v4BqHxV079ddZYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=f/RWD0G5; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f/RWD0G5"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A67DA3B3AF;
	Mon, 26 Aug 2024 18:02:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HiO6GN3IVDmrF0VUFjGVuhcjyjwzVGIW5wu9aH
	eJMo8=; b=f/RWD0G5ZW/FREKKZvGBsS0ocbMOcXLXfpuNkQccxTDvj7yWFQhS2x
	YOdn4F5nTUCWfXbCiIsxvRy77eWiYHOvj2X48WhzT6Nry0mBEoHp7+iIjKPQPgsI
	ywSlzrjY1h1YBbYmGrWLnzqgVcNkcvJMru91oV4GkLISY6JgWxb5I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EA6B3B3AE;
	Mon, 26 Aug 2024 18:02:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06BCF3B3AD;
	Mon, 26 Aug 2024 18:02:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 07/10] object_info: content_limit only applies to blobs
In-Reply-To: <20240823224630.1180772-8-e@80x24.org> (Eric Wong's message of
	"Fri, 23 Aug 2024 22:46:27 +0000")
References: <20240823224630.1180772-1-e@80x24.org>
	<20240823224630.1180772-8-e@80x24.org>
Date: Mon, 26 Aug 2024 15:02:34 -0700
Message-ID: <xmqqwmk3eydh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E70136AE-63F6-11EF-897A-9B0F950A682E-77302942!pb-smtp2.pobox.com

Eric Wong <e@80x24.org> writes:

> Streaming is only supported for blobs, so we'd end up having to
> slurp all the other object types into memory regardless.  So
> slurp all the non-blob types up front when requesting content
> since we always handle them in-core, anyways.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  builtin/cat-file.c  | 21 +++++++++++++++++++--
>  object-file.c       |  3 ++-
>  packfile.c          |  8 +++++---
>  t/t1006-cat-file.sh | 19 ++++++++++++++++---
>  4 files changed, 42 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 8debcdca3e..2aedd62324 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -385,7 +385,24 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>  	assert(data->info.typep);
>  
>  	if (data->content) {
> -		batch_write(opt, data->content, data->size);
> +		void *content = data->content;
> +		unsigned long size = data->size;
> +
> +		data->content = NULL;
> +		if (use_mailmap && (data->type == OBJ_COMMIT ||
> +					data->type == OBJ_TAG)) {

Line-wrap at higher level in the parse tree, i.e.

		if (use_mailmap &&
		    (data->type == OBJ_COMMIT || data->type == OBJ_TAG)) {

> +			size_t s = size;
> +
> +			if (data->info.whence == OI_DBCACHED) {
> +				content = xmemdupz(content, s);
> +				data->info.whence = OI_PACKED;
> +			}
> +
> +			content = replace_idents_using_mailmap(content, &s);
> +			size = cast_size_t_to_ulong(s);

This piece of code does look good, but it makes me wonder where the
need to duplicate the code comes from.  Before this patch, if
somebody asked use_mailmap, we must have been making the
replace_idents_using_mailmap() call and showing the result elsewhere
in the existing code, and it is curious why that code path is not
removed, or if we can share more common code with that code paths
here.

> +		}
> +
> +		batch_write(opt, content, size);
>  		switch (data->info.whence) {
>  		case OI_CACHED:
>  			/*
> @@ -395,7 +412,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>  			BUG("TODO OI_CACHED support not done");
>  		case OI_LOOSE:
>  		case OI_PACKED:
> -			FREE_AND_NULL(data->content);
> +			free(content);

data->content has been nuked earlier, and content that holds the new
copy with replaced one is freed (and the original data->content was
freed by replace_idents_using_mailmap(), so there is no leak or
double-free here.  Good.

> diff --git a/object-file.c b/object-file.c
> index 19100e823d..59842cfe1b 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1492,7 +1492,8 @@ static int loose_object_info(struct repository *r,
>  
>  		if (!oi->contentp)
>  			break;
> -		if (oi->content_limit && *oi->sizep > oi->content_limit) {
> +		if (oi->content_limit && *oi->typep == OBJ_BLOB &&
> +				*oi->sizep > oi->content_limit) {
>  			git_inflate_end(&stream);
>  			oi->contentp = NULL;
>  			goto cleanup;

OK, so non-BLOB objects we would fall through this if/else cascade
and inflate them fully.

