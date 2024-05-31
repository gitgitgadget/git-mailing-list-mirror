Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B818C22
	for <git@vger.kernel.org>; Fri, 31 May 2024 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165420; cv=none; b=e5XXXh2pqeHO5rRg2D1VSTJDjx7ZwZQYku5n4FP97JmTRZfOoeUmE1+gLbP5w3VUuxinWMwwu9rlFLMKlvgb5cQo5oUQAWmNjr5lZIj1oSZ93oe/WdVNU+dCFnV01+vev3to9y4fDx6CatvMpF6GKu8CGtA5r2QeCioKsWegZ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165420; c=relaxed/simple;
	bh=jCUBjHTCD7OThheSPJmywAYO1x4Dr/hfABzC735Oko4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqcQK5uxLWBNx8SK61EG32XpsCGR8+hxtKlFb7Q7d2PRne44oGp/jf5hqwC0KLJIIbWhm38qwZzD2p3SJBc4DuP0JjIoIOf/g6ZRQjN8SFEwKuhARTcdQaV0iv2nzylvY9nLVPCC06gGHOvVTbzws5xWZkiWsXDABc7kS1Isk5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BWrWgoQj; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BWrWgoQj"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EF95B1A1F2;
	Fri, 31 May 2024 10:23:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jCUBjHTCD7OThheSPJmywAYO1x4Dr/hfABzC73
	5Oko4=; b=BWrWgoQjt4M/iaEjVjqUnDEa3bjNgqbU2bzQKUclL6ikhCc3Ieg4m1
	D5yCsH9qhWwa8yFbrMimWiwfh+WBfCwFWuensOM0aBSBdy54qRQzTOTtjniA7ZTJ
	u/YyHAa6SPFgzhPUwOBzgtqGY+VTML6S3zffsQtu49xDUnOcGlITE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E78A91A1F1;
	Fri, 31 May 2024 10:23:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0FFF91A1EF;
	Fri, 31 May 2024 10:23:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [GSoC][PATCH 1/2] refs: setup ref consistency check infrastructure
In-Reply-To: <20240530122753.1114818-2-shejialuo@gmail.com>
	(shejialuo@gmail.com's message of "Thu, 30 May 2024 20:27:52 +0800")
References: <20240530122753.1114818-1-shejialuo@gmail.com>
	<20240530122753.1114818-2-shejialuo@gmail.com>
Date: Fri, 31 May 2024 07:23:27 -0700
Message-ID: <xmqqfrtyjc0w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 59CAB3E6-1F59-11EF-AB7C-8F8B087618E4-77302942!pb-smtp21.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 5f3089d947..b6147c588b 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3299,6 +3299,11 @@ static int files_init_db(struct ref_store *ref_store,
>  	return 0;
>  }
>  
> +static int files_fsck(struct ref_store *ref_store)
> +{
> +	return 0;
> +}
> +
>  struct ref_storage_be refs_be_files = {
>  	.name = "files",
>  	.init = files_ref_store_create,
> @@ -3322,5 +3327,7 @@ struct ref_storage_be refs_be_files = {
>  	.reflog_exists = files_reflog_exists,
>  	.create_reflog = files_create_reflog,
>  	.delete_reflog = files_delete_reflog,
> -	.reflog_expire = files_reflog_expire
> +	.reflog_expire = files_reflog_expire,
> +
> +	.fsck = files_fsck,

What is the extra blank line doing there?  It makes reader wonder
why the .fsck member is somehow very special and different from
others.  Is there a valid reason to single it out (and no, "yes this
is special because I invented it" does not count as a valid reason)?

The same comment applies to a few other places in this patch.
