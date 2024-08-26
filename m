Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3265B677
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710407; cv=none; b=t5DPYpsBE1hByVW/b9bS9I16Rg7Jj7beM4i4KMrOlDgMI/6H3U3DC5Wgjkup5/go+Y4/PtwPt7Pf3I5+iS1WlfryQ7rfsFP8jBbJRG1GuiE6z8lrNFhtRi1l1maDN6ABqClOiPBA4R2VgInOQJqvOS3wmiGLge28aP00+azyko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710407; c=relaxed/simple;
	bh=rLWrBgUwJ3rcgjMW6I24/gUM2BerRuadtwAUeRBeaJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ldY/klNfo4Ubgv7pHzspmmFYFe0ulX07XFdJIHcG45YQ8u2Zbx1o4AOHICStIOAWjS7SPquXMiDqklj73qh7XhKNeSZ4SjxQn0U6szA7FEYYvE2wvPiaB2GtPlnkrR62nwtjmNS3wzcPKq3R87Z3MEKw1zhz1e6c+2mckghmZrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AqdvxDja; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AqdvxDja"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 025741DD5B;
	Mon, 26 Aug 2024 18:13:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rLWrBgUwJ3rcgjMW6I24/gUM2BerRuadtwAUeR
	BeaJc=; b=AqdvxDjaGQcGsWzJLHPHoP1hoQpCE7bQQTRKHZaod4uWlB2DwWra/f
	eJf/JIRNMLPoptabD1jNaUtNKbNJugdKBSU32MgcCtLLgfo8XTivVlPWOxh2QXz1
	hLw/j+UzxAzM7uQiT9l7YJkoqpHJtAl3qfevyXq1FRbGtRO4zHHEc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EF1081DD5A;
	Mon, 26 Aug 2024 18:13:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DA6431DD59;
	Mon, 26 Aug 2024 18:13:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 08/10] cat-file: batch-command uses content_limit
In-Reply-To: <20240823224630.1180772-9-e@80x24.org> (Eric Wong's message of
	"Fri, 23 Aug 2024 22:46:28 +0000")
References: <20240823224630.1180772-1-e@80x24.org>
	<20240823224630.1180772-9-e@80x24.org>
Date: Mon, 26 Aug 2024 15:13:18 -0700
Message-ID: <xmqqo75fexvl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 66C664C6-63F8-11EF-BBE1-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Eric Wong <e@80x24.org> writes:

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 2aedd62324..067cdbdbf9 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -417,7 +417,8 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>  		case OI_DBCACHED:
>  			unlock_delta_base_cache();
>  		}
> -	} else if (data->type == OBJ_BLOB) {
> +	} else {
> +		assert(data->type == OBJ_BLOB);
>  		if (opt->buffer_output)
>  			fflush(stdout);
>  		if (opt->transform_mode) {

Hmph, because until this step, the control could reach this function
with data->content NULL for a non-BLOB type, even though we
eliminated that with the previous step for "--batch" command user.
This step covers "--batch-command" user to also force the
data->content to be populated, so we no longer will see anything but
BLOB when data->content is NULL.

That sounds correct with the current code, but it somehow feels a
bit too subtle to my taste.  In addition to an assert(), future
readers of this code would deserve a comment describing why we can
safely assume that blobs are the only types we will see here.  That
way, they can tell when they add another command that ends up calling
this function that they too will need to do the contentp thing.

> @@ -452,30 +453,6 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>  			stream_blob(oid);
>  		}
>  	}
> -	else {
> -		enum object_type type;
> -		unsigned long size;
> -		void *contents;
> -
> -		contents = repo_read_object_file(the_repository, oid, &type,
> -						 &size);
> -		if (!contents)
> -			die("object %s disappeared", oid_to_hex(oid));
> -
> -		if (use_mailmap) {
> -			size_t s = size;
> -			contents = replace_idents_using_mailmap(contents, &s);
> -			size = cast_size_t_to_ulong(s);
> -		}
> -
> -		if (type != data->type)
> -			die("object %s changed type!?", oid_to_hex(oid));
> -		if (data->info.sizep && size != data->size && !use_mailmap)
> -			die("object %s changed size!?", oid_to_hex(oid));
> -
> -		batch_write(opt, contents, size);
> -		free(contents);
> -	}

And it certainly is nice that we can get rid of this fallback code.

By the way, the previous step sshould rename the .content_limit
member to make it clear that (1) it is about the size limit, and (2)
it only applies to blobs.  Ideally (1) should be done much earlier
in the series, and (2) must be done when the code starts to ignore
the member for non-blob types.

Thanks.
