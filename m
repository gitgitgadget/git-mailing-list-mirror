Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066C820100C
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743507973; cv=none; b=DpC1qxIpGggdebQ66NKMw6QVdFINA/EcxbAoKUOomUMw4nKiCQg5Y1vxVTrm9CxI0ulDm1dDQGwh2TZjuZhXM5wMnuwanghsV2MiXMXbDO6XRrR/AbhRjjivgwaMD+dwJLgsYYhfmFCdALelVHz36vl8C0nOTyADif5WBdNEJd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743507973; c=relaxed/simple;
	bh=IvjIK2oRNfce7LeVKwlWNsSnN0WHkuUkNAQ7Ou+YB6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X2AbWUJlNiEHmam5CdtYIDUSMVs5Gey/uZZudLcCeSBSZwzK3ksN6fbllWwWaa+I+aBkYue9K3osCBZ4TxSkXwoyywt63u7LxYLQdWAaBs+9e4yfUfJrPJZF3fZrMuR/o/2YFaT8pWmGBmfaumrFV3Htp5iqJ6Zd68yEhZOwKVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Ipki9RQV; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Ipki9RQV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1743507963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Er3nM1YXAr0fuiT/Mwh5+/jWrNy6Y3deLTS0KMpX4mQ=;
	b=Ipki9RQVuxp7D2VyI+NqnAbzRxTb1tAmUPSdGQfb8IIXQ2ak+jq2jFyy4c3HgwuYFjWWpm
	xGgDiquvtlUMmHvn5JbNGgzz5OhLwElDxLS2t43NJUuvXBsilJTGiIey7xvxqvSo209IlC
	eHyI1TK9RuvBMAi+v7a9NYx64epQc+8=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
 Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/10] builtin/cat-file: wire up an option to filter
 objects
In-Reply-To: <20250327-pks-cat-file-object-type-filter-v2-2-4bbc7085d7c5@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
 <20250327-pks-cat-file-object-type-filter-v2-2-4bbc7085d7c5@pks.im>
Date: Tue, 01 Apr 2025 13:45:46 +0200
Message-ID: <87r02cf6l1.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> In batch mode, git-cat-file(1) enumerates all objects and prints them
> by iterating through both loose and packed objects. This works without
> considering their reachability at all, and consequently most options to
> filter objects as they exist in e.g. git-rev-list(1) are not applicable.
> In some situations it may still be useful though to filter objects based
> on properties that are inherent to them. This includes the object size
> as well as its type.
>
> Such a filter already exists in git-rev-list(1) with the `--filter=`
> command line option. While this option supports a couple of filters that
> are not applicable to our usecase, some of them are quite a neat fit.
>
> Wire up the filter as an option for git-cat-file(1). This allows us to
> reuse the same syntax as in git-rev-list(1) so that we don't have to
> reinvent the wheel. For now, we die when any of the filter options has
> been passed by the user, but they will be wired up in subsequent
> commits.
>
> Further note that the filters that we are about to introduce don't
> significantly speed up the runtime of git-cat-file(1). While we can skip
> emitting a lot of objects in case they are uninteresting to us, the
> majority of time is spent reading the packfile, which is bottlenecked by
> I/O and not the processor. This will change though once we start to make
> use of bitmaps, which will allow us to skip reading the whole packfile.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-cat-file.adoc |  6 ++++++
>  builtin/cat-file.c              | 37 +++++++++++++++++++++++++++++++++----
>  t/t1006-cat-file.sh             | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
> index d5890ae3686..f7f57b7f538 100644
> --- a/Documentation/git-cat-file.adoc
> +++ b/Documentation/git-cat-file.adoc
> @@ -81,6 +81,12 @@ OPTIONS
>  	end-of-line conversion, etc). In this case, `<object>` has to be of
>  	the form `<tree-ish>:<path>`, or `:<path>`.
>  
> +--filter=<filter-spec>::
> +--no-filter::
> +	Omit objects from the list of printed objects. This can only be used in
> +	combination with one of the batched modes. The '<filter-spec>' may be
> +	one of the following:
> +
>  --path=<path>::
>  	For use with `--textconv` or `--filters`, to allow specifying an object
>  	name and a path separately, e.g. when it is difficult to figure out
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 8e40016dd24..940900d92ad 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -936,10 +946,13 @@ int cmd_cat_file(int argc,
>  	int opt_cw = 0;
>  	int opt_epts = 0;
>  	const char *exp_type = NULL, *obj_name = NULL;
> -	struct batch_options batch = {0};
> +	struct batch_options batch = {
> +		.objects_filter = LIST_OBJECTS_FILTER_INIT,
> +	};
>  	int unknown_type = 0;
>  	int input_nul_terminated = 0;
>  	int nul_terminated = 0;
> +	int ret;
>  
>  	const char * const builtin_catfile_usage[] = {
>  		N_("git cat-file <type> <object>"),
> @@ -1000,6 +1013,8 @@ int cmd_cat_file(int argc,
>  			    N_("run filters on object's content"), 'w'),
>  		OPT_STRING(0, "path", &force_path, N_("blob|tree"),
>  			   N_("use a <path> for (--textconv | --filters); Not with 'batch'")),
> +		OPT_CALLBACK(0, "filter", &batch.objects_filter, N_("args"),
> +			     N_("object filtering"), opt_parse_list_objects_filter),

Because we've decided on `--filter` we can use
`OPT_PARSE_LIST_OBJECTS_FILTER` here now.

--
Toon
