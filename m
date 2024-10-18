Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CEFD530
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729253074; cv=none; b=RoFuvw2CTKA2+CxuKIXUpKzGrUcUYhcJn5ZkcAD6sMXhmMmo+xwYK1v3rKkjWuJm0lVjfoJUg3Ixkc9aP1Pr2VTUMyJTTsw3+2NgVgpHmJnNR9nSgb98YSZ83qqMHWaR5cU6z2E28DvKg0BmczXbeeSIW9Y6bcBsQkq8dqGkca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729253074; c=relaxed/simple;
	bh=tejBQ6ZwRJnsKrz/lGgLJjRPhS1mERStDvobybOcepc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yuh2tvWQ40v9YHHZCqjZf7wvY8KfxhKBcjceZqzMi/H9i3aPpwQJnxjeVqPvDqGsPk1bSyNLB3bHdEj39yJVqZxTdseNIM2/sTlvH76SUZ3jZXBtKFgHkDyA2VHmLZYovizJnne4unneShRph93RN2mCMKzEiWlrxAgikBJJISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=aq8PkQsl; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="aq8PkQsl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1729253070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lWwy+bF/egUaQKD6JmL4j/1hJ8QzAMsdGOJc1Ei0NaE=;
	b=aq8PkQsl8yK2Ba6CFX/REKbOXNkP9gtYnxl6HzM6v5NyeHp0S+7/p5BwOxoZuX+xWZ927J
	ftHH1JaFVCMBlf05uR7gfSZ4pNyKcbYMR20AhkHaTrZI/GdlaYJqUCBnAki42kbRFcxxV0
	UqcNsPao7xr+TPly/uvRLPg1tckcOjQ=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 21/21] list-objects-filter-options: work around reported
 leak on error
In-Reply-To: <6a2baf0d3e538e5f450c45c22248fbc3fefd77af.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <6a2baf0d3e538e5f450c45c22248fbc3fefd77af.1728624670.git.ps@pks.im>
Date: Fri, 18 Oct 2024 14:04:18 +0200
Message-ID: <875xppd3ct.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> This one is a little bit more curious. In t6112, we have a test that
> exercises the `git rev-list --filter` option with invalid filters. We
> execute git-rev-list(1) via `test_must_fail`, which means that we check
> for leaks even though Git exits with an error code. This causes the
> following leak:
>
>     Direct leak of 27 byte(s) in 1 object(s) allocated from:
>         #0 0x5555555e6946 in realloc.part.0 lsan_interceptors.cpp.o
>         #1 0x5555558fb4b6 in xrealloc wrapper.c:137:8
>         #2 0x5555558b6e06 in strbuf_grow strbuf.c:112:2
>         #3 0x5555558b7550 in strbuf_add strbuf.c:311:2
>         #4 0x5555557c1a88 in strbuf_addstr strbuf.h:310:2
>         #5 0x5555557c1d4c in parse_list_objects_filter list-objects-filter-options.c:261:3
>         #6 0x555555885ead in handle_revision_pseudo_opt revision.c:2899:3
>         #7 0x555555884e20 in setup_revisions revision.c:3014:11
>         #8 0x5555556c4b42 in cmd_rev_list builtin/rev-list.c:588:9
>         #9 0x5555555ec5e3 in run_builtin git.c:483:11
>         #10 0x5555555eb1e4 in handle_builtin git.c:749:13
>         #11 0x5555555ec001 in run_argv git.c:819:4
>         #12 0x5555555eaf94 in cmd_main git.c:954:19
>         #13 0x5555556fd569 in main common-main.c:64:11
>         #14 0x7ffff7ca714d in __libc_start_call_main (.../lib/libc.so.6+0x2a14d)
>         #15 0x7ffff7ca7208 in __libc_start_main@GLIBC_2.2.5 (.../libc.so.6+0x2a208)
>         #16 0x5555555ad064 in _start (git+0x59064)
>
> This leak is valid, as we call `die()` and do not clean up the memory at
> all. But what's curious is that this is the only leak reported, because
> we don't clean up any other allocated memory, either, and I have no idea
> why the leak sanitizer treats this buffer specially.
>
> In any case, we can work around the leak by shuffling things around a
> bit. Instead of calling `gently_parse_list_objects_filter()` and dying
> after we have modified the filter spec, we simply do so beforehand. Like
> this we don't allocate the buffer in the error case, which makes the
> reported leak go away.
>
> It's not pretty, but it manages to make t6112 leak free.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  list-objects-filter-options.c       | 17 +++++++----------
>  t/t6112-rev-list-filters-objects.sh |  1 +
>  2 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index 00611107d20..fa72e81e4ad 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -252,16 +252,14 @@ void parse_list_objects_filter(
>  	const char *arg)
>  {
>  	struct strbuf errbuf = STRBUF_INIT;
> -	int parse_error;
>  
>  	if (!filter_options->filter_spec.buf)
>  		BUG("filter_options not properly initialized");
>  
>  	if (!filter_options->choice) {
> +		if (gently_parse_list_objects_filter(filter_options, arg, &errbuf))
> +			die("%s", errbuf.buf);
>  		strbuf_addstr(&filter_options->filter_spec, arg);
> -
> -		parse_error = gently_parse_list_objects_filter(
> -			filter_options, arg, &errbuf);
>  	} else {
>  		struct list_objects_filter_options *sub;
>  
> @@ -271,18 +269,17 @@ void parse_list_objects_filter(
>  		 */
>  		transform_to_combine_type(filter_options);
>  
> -		strbuf_addch(&filter_options->filter_spec, '+');
> -		filter_spec_append_urlencode(filter_options, arg);
>  		ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
>  			      filter_options->sub_alloc);
>  		sub = &filter_options->sub[filter_options->sub_nr - 1];
>  
>  		list_objects_filter_init(sub);
> -		parse_error = gently_parse_list_objects_filter(sub, arg,
> -							       &errbuf);
> +		if (gently_parse_list_objects_filter(sub, arg, &errbuf))
> +			die("%s", errbuf.buf);

Do we actually have a test hitting this code path? I wanted to figure
out why `filter_options->sub` wasn't leaky (I assume that's what you're
talking about in your commit message), but I wasn't able to reproduce a
scenario where we should die here.

--
Toon
