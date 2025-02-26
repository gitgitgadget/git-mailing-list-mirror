Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A722157A
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583405; cv=none; b=otvrMzElHVhE2+qStJw4yj1PUS9RejYx4slxUT8jTXYamvXnClNH07JossPkfQeE7to+smKxeebndoo4Y6qNSF/UbhYggWhdietxkzoh/wmUMfPFraCdzUxVDoYBRuvU6wwUgebv8zrIjlCWBYMPI0GdXXx3yF/ccOvgMYMV71k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583405; c=relaxed/simple;
	bh=3Am+LKylMtvt1ZRh+s/m6cl322POkD0gsm/vztb3t1c=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uXZP2UREfmmYPPKPmfwXfEaeVJkbjvpp9maEPsJ/xUNfsnJTbWY18a0ZmgWezWOaElIDeaKhwN66AE6jS3uVI6qOe+kDivdMRPFLebmwIbY54EGhqeSOfrX4/BqQVS5V8ydayUa2fR/HgdRHNxv39BGPPn95dAxPTFKFRVW9y+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=rWUu9yA6; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="rWUu9yA6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1740583401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UzhIg5qidMv5mlk4wvaCv9xjQZ8HtvAtU5rP7CC39Ow=;
	b=rWUu9yA6OYG6uCDbtmcjVoxt4grEAa4QLah0lqFDFKNxJdFCrXnG9SVLr+g2H3oJWbt56G
	Fkx/X7XEqmHJ5K1jMM5gLb3iNkCxjj18a718VCaQU/RvKC0tWUdscJJNbekm1AURTGW/SK
	uGYoup1ZE5rJLbh0TXLL710s0FPNHeE=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 5/9] builtin/cat-file: support "object:type=" objects
 filter
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-5-0852530888e2@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
 <20250221-pks-cat-file-object-type-filter-v1-5-0852530888e2@pks.im>
Date: Wed, 26 Feb 2025 16:23:12 +0100
Message-ID: <871pvkraqn.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Implement support for the "object:type=" filter in git-cat-file(1),
> which causes us to omit all objects that don't match the provided object
> type.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-cat-file.adoc | 3 +++
>  builtin/cat-file.c              | 8 +++++++-
>  t/t1006-cat-file.sh             | 6 +++++-
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
> index 8c474418b52..540d9dffdf9 100644
> --- a/Documentation/git-cat-file.adoc
> +++ b/Documentation/git-cat-file.adoc
> @@ -93,6 +93,9 @@ The form '--filter=blob:limit=<n>[kmg]' omits blobs of size at least n
>  bytes or units.  n may be zero.  The suffixes k, m, and g can be used
>  to name units in KiB, MiB, or GiB.  For example, 'blob:limit=1k'
>  is the same as 'blob:limit=1024'.
> ++
> +The form '--filter=object:type=(tag|commit|tree|blob)' omits all objects
> +which are not of the requested type.
>  
>  --path=<path>::
>  	For use with `--textconv` or `--filters`, to allow specifying an object
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index f57bf65cb03..b374c2bb104 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -474,7 +474,8 @@ static void batch_object_write(const char *obj_name,
>  
>  		if (use_mailmap ||
>  		    opt->objects_filter.choice == LOFC_BLOB_NONE ||
> -		    opt->objects_filter.choice == LOFC_BLOB_LIMIT)
> +		    opt->objects_filter.choice == LOFC_BLOB_LIMIT ||
> +		    opt->objects_filter.choice == LOFC_OBJECT_TYPE)
>  			data->info.typep = &data->type;
>  		if (opt->objects_filter.choice == LOFC_BLOB_LIMIT)
>  			data->info.sizep = &data->size;
> @@ -505,6 +506,10 @@ static void batch_object_write(const char *obj_name,
>  			    data->size >= opt->objects_filter.blob_limit_value)
>  				return;
>  			break;
> +		case LOFC_OBJECT_TYPE:
> +			if (data->type != opt->objects_filter.object_type)
> +				return;
> +			break;
>  		default:
>  			BUG("unsupported objects filter");

I see we don't support LOFC_COMBINE, so we won't be supporting repeating
the --filter= option, is this intentional? Should we support that too? I
feel it would make sense from the start, unless there are good reasons
not to?

-- 
Toon
