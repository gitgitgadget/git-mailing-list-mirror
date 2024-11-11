Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEBF1D9A57
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358501; cv=none; b=e7z+h5XU8eKXlX63n7MhbhxEELOOXS4wEAfxKZ+ZB5ahC64jCfrybUwKjwnS6WDpctRlI4DQcAP+eYpUyqTaCz/efoD5ec0iexBt+fbkvLlx8EcL3GYtQ1aqQN8N96QovjbYuQNWdYTmOZDAgcn11AJybwd3ra5FqQUj8mzbh4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358501; c=relaxed/simple;
	bh=aQUWSvApFBBKbOH94D+4QqCptAhz5xonIoirhVRxO9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK3dSWYoolKrcivrVxhE8YqpHxjrZjgAlpS8+FoTncKWwOXoOJpVNdfyA6fkepoVLcjczqsyfLpltyRa68fv9pqpCQAID932jHTfpDtA40b1d5G20t1skjcCfz0UB96nngGTD7obglEb9s8FR8GWrgLPgjtGWUGJb92tu30PA6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cWrcGQL8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cWrcGQL8"
Received: (qmail 20639 invoked by uid 109); 11 Nov 2024 20:54:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=aQUWSvApFBBKbOH94D+4QqCptAhz5xonIoirhVRxO9g=; b=cWrcGQL8wRBgvup/9gfM11iyFLdNyZYZxc8D4DmWrO/iPLE10pQmHf0wBWOK/H9EV7FssIVWJHzLt9D9JjNXp5YoFWnWzliA/uLJU6XomNo8eJoWt6eTS3+A10zz+Lrcq0DlvmwC9w7VLZEsQNC/pJphcZVTa4HY5Z8K93XO91EP/NrwE5ik7NZZ0pXjpEaun89HYEZNp2RH6EOexRVXps0uWO0fSsMWJj9+x6xJYj55x2lAeRdw/B6N3ubikQcjhd5SXBSu8mJHx98++0ghnPo5+9wwt/qqGWhW5GDeHYtClcs57Kr83FTvDkWiHHJgym5ie8cPhbxchdDoEwGaWQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Nov 2024 20:54:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19562 invoked by uid 111); 11 Nov 2024 20:54:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2024 15:54:56 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 11 Nov 2024 15:54:53 -0500
From: Jeff King <peff@peff.net>
To: Simon Marchi <simon.marchi@efficios.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] builtin/difftool: intialize some hashmap variables
Message-ID: <20241111205453.GA5019@coredump.intra.peff.net>
References: <20241111162148.337375-1-simon.marchi@efficios.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241111162148.337375-1-simon.marchi@efficios.com>

On Mon, Nov 11, 2024 at 11:21:44AM -0500, Simon Marchi wrote:

> When running a dir-diff command that produces no diff, variables
> `wt_modified` and `tmp_modified` are used while uninitialized, causing:
> 
>     $ /home/smarchi/src/git/git-difftool --dir-diff master
>     free(): invalid pointer
>     [1]    334004 IOT instruction (core dumped)  /home/smarchi/src/git/git-difftool --dir-diff master
>     $ valgrind --track-origins=yes /home/smarchi/src/git/git-difftool --dir-diff master
>     ...
>     Invalid free() / delete / delete[] / realloc()
>        at 0x48478EF: free (vg_replace_malloc.c:989)
>        by 0x422CAC: hashmap_clear_ (hashmap.c:208)
>        by 0x283830: run_dir_diff (difftool.c:667)
>        by 0x284103: cmd_difftool (difftool.c:801)
>        by 0x238E0F: run_builtin (git.c:484)
>        by 0x2392B9: handle_builtin (git.c:750)
>        by 0x2399BC: cmd_main (git.c:921)
>        by 0x356FEF: main (common-main.c:64)
>      Address 0x1ffefff180 is on thread 1's stack
>      in frame #2, created by run_dir_diff (difftool.c:358)
>     ...
> 
> If taking any `goto finish` path before these variables are initialized,
> `hashmap_clear_and_free()` operates on uninitialized data, sometimes
> causing a crash.
> 
> Fix it by zero-initializing these variables, making
> `hashmap_clear_and_free()` a no-op in that case.

The fix makes sense. I wondered if this had been broken for a long time,
and if so, how we managed not to notice it. But it looks like it is a
recent problem, via 7f795a1715 (builtin/difftool: plug several trivial
memory leaks, 2024-09-26).

> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index ca1b0890659b..b902f5d2ae17 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -376,7 +376,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  	struct checkout lstate, rstate;
>  	int err = 0;
>  	struct child_process cmd = CHILD_PROCESS_INIT;
> -	struct hashmap wt_modified, tmp_modified;
> +	struct hashmap wt_modified = {0};
> +	struct hashmap tmp_modified = {0};
>  	int indices_loaded = 0;

That commit likewise frees some other local variables, but they are all
properly initialized. So touching these two are sufficient.

I'm not sure if zero-initialization is being a little too familiar with
the hashmap internals, though. The other variables use HASHMAP_INIT().
Should we do the same here, like this:

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 1a68ab6699..86995390c7 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -374,7 +374,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	struct checkout lstate, rstate;
 	int err = 0;
 	struct child_process cmd = CHILD_PROCESS_INIT;
-	struct hashmap wt_modified, tmp_modified;
+	struct hashmap wt_modified = HASHMAP_INIT(path_entry_cmp, NULL);
+	struct hashmap tmp_modified = HASHMAP_INIT(path_entry_cmp, NULL);
 	int indices_loaded = 0;
 
 	workdir = get_git_work_tree();
@@ -594,14 +595,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	 * should be copied back to the working tree.
 	 * Do not copy back files when symlinks are used and the
 	 * external tool did not replace the original link with a file.
-	 *
-	 * These hashes are loaded lazily since they aren't needed
-	 * in the common case of --symlinks and the difftool updating
-	 * files through the symlink.
 	 */
-	hashmap_init(&wt_modified, path_entry_cmp, NULL, wtindex.cache_nr);
-	hashmap_init(&tmp_modified, path_entry_cmp, NULL, wtindex.cache_nr);
-
 	for (i = 0; i < wtindex.cache_nr; i++) {
 		struct hashmap_entry dummy;
 		const char *name = wtindex.cache[i]->name;

That loses the initial table growth that the original had, but I think
letting it grow in the usual way is fine here.

-Peff
