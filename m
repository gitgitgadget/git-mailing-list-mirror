Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E8BC4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 21:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiLNVQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 16:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLNVQj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 16:16:39 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E82332BB6
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 13:16:37 -0800 (PST)
Received: (qmail 28442 invoked by uid 109); 14 Dec 2022 21:16:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Dec 2022 21:16:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22891 invoked by uid 111); 14 Dec 2022 21:16:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Dec 2022 16:16:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Dec 2022 16:16:36 -0500
From:   Jeff King <peff@peff.net>
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] git: remove unneeded casts
Message-ID: <Y5o9NNVx7dFLhIMd@coredump.intra.peff.net>
References: <pull.1396.git.git.1671032126602.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1396.git.git.1671032126602.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2022 at 03:35:26PM +0000, Rose via GitGitGadget wrote:

> From: Seija Kijin <doremylover123@gmail.com>
> 
> Many of these casts remain,
> even though the target variable is the type it is being casted to.
> We can safely remove said casts.

Funny line-breaking. Re-wrapping with vim yields:

  Many of these casts remain, even though the target variable
  is the type it is being cast to.  We can safely remove
  said casts.

I also fixed a minor grammatical issue with "casted".

I'm curious how you found all of these. With coccinelle or
similar? If there's an analysis tool that can find them,
that would make review much simpler if we can trust that it
did the leg-work of checking the types.

Either way, I think it's still useful to see how we ended up
in this state for each case (so we know that cleaning up the
cast is the right thing, and it is not a symptom of some
other bug).

> diff --git a/builtin/credential-store.c b/builtin/credential-store.c
> index 62a4f3c2653..93e521af395 100644
> --- a/builtin/credential-store.c
> +++ b/builtin/credential-store.c
> @@ -165,7 +165,7 @@ int cmd_credential_store(int argc, const char **argv, const char *prefix)
>  
>  	umask(077);
>  
> -	argc = parse_options(argc, (const char **)argv, prefix, options, usage, 0);
> +	argc = parse_options(argc, argv, prefix, options, usage, 0);
>  	if (argc != 1)
>  		usage_with_options(usage, options);
>  	op = argv[0];

Our argv used to be "char **" due to 84d32bf767 (sparse: Fix
mingw_main() argument number/type errors, 2013-04-27), but
later regained its const when it became cmd_main() in
3f2e2297b9 (add an extra level of indirection to main(),
2016-07-01). Makes sense.

> diff --git a/diff.c b/diff.c
> index 1054a4b7329..2e58c9372b4 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1776,8 +1776,8 @@ static void emit_rewrite_diff(const char *name_a,
>  	ecbdata.opt = o;
>  	if (ecbdata.ws_rule & WS_BLANK_AT_EOF) {
>  		mmfile_t mf1, mf2;
> -		mf1.ptr = (char *)data_one;
> -		mf2.ptr = (char *)data_two;
> +		mf1.ptr = data_one;
> +		mf2.ptr = data_two;
>  		mf1.size = size_one;
>  		mf2.size = size_two;
>  		check_blank_at_eof(&mf1, &mf2, &ecbdata);
> @@ -1809,9 +1809,9 @@ static void emit_rewrite_diff(const char *name_a,
>  	if (lc_b)
>  		emit_rewrite_lines(&ecbdata, '+', data_two, size_two);
>  	if (textconv_one)
> -		free((char *)data_one);
> +		free(data_one);
>  	if (textconv_two)
> -		free((char *)data_two);
> +		free(data_two);
>  }

These variables lost their const in 840383b2c2 (textconv:
refactor calls to run_textconv, 2010-04-01). OK, makes
sense.

> diff --git a/http.c b/http.c
> index 8a5ba3f4776..32db5d76a7c 100644
> --- a/http.c
> +++ b/http.c
> @@ -2319,8 +2319,8 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
>  	}
>  
>  	do {
> -		ssize_t retval = xwrite(freq->localfile,
> -					(char *) ptr + posn, size - posn);
> +		ssize_t retval =
> +			xwrite(freq->localfile, ptr + posn, size - posn);
>  		if (retval < 0)
>  			return posn / eltsize;
>  		posn += retval;

This one went from a void pointer to a char pointer in
a04ff3ec32 (http: make curl callbacks match contracts from
curl header, 2011-05-03). Good.

> diff --git a/imap-send.c b/imap-send.c
> index a50af56b827..e67dbfc5567 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -779,7 +779,7 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
>  			if (cmdp->cb.data) {
>  				n = socket_write(&imap->buf.sock, cmdp->cb.data, cmdp->cb.dlen);
>  				FREE_AND_NULL(cmdp->cb.data);
> -				if (n != (int)cmdp->cb.dlen)
> +				if (n != cmdp->cb.dlen)
>  					return RESP_BAD;
>  			} else if (cmdp->cb.cont) {
>  				if (cmdp->cb.cont(ctx, cmdp, cmd))

This one dates back to f2561fda36 (Add git-imap-send,
derived from isync 1.0.1., 2006-03-10), so no clue how it
came about. It's clearly pointless, though, as "dlen" is
already an int.

> @@ -1526,7 +1526,8 @@ int cmd_main(int argc, const char **argv)
>  	setup_git_directory_gently(&nongit_ok);
>  	git_config(git_imap_config, NULL);
>  
> -	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
> +	argc = parse_options(argc, argv, "", imap_send_options, imap_send_usage,
> +			     0);

This is another one that picked up a const when switching to
cmd_main().

> diff --git a/merge-ort.c b/merge-ort.c
> index d1611ca400a..a2aefd609ad 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -2574,7 +2574,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
>  
>  	/* Find parent directories missing from opt->priv->paths */
>  	cur_path = mem_pool_strdup(&opt->priv->pool, new_path);
> -	free((char*)new_path);
> +	free(new_path);
>  	new_path = (char *)cur_path;

This one was always a "char *", going back to fa5e06d690
(merge-ort: modify collect_renames() for directory rename
handling, 2021-01-19).

There's another variable in there, parent_name, which
probably _should_ be non-const, since we allocate and free
it. That's out of scope for your patch, though.

> diff --git a/oidmap.h b/oidmap.h
> index c66a83ab1d6..9cefbba550d 100644
> --- a/oidmap.h
> +++ b/oidmap.h
> @@ -87,7 +87,7 @@ static inline void *oidmap_iter_first(struct oidmap *map,
>  {
>  	oidmap_iter_init(map, iter);
>  	/* TODO: this API could be reworked to do compile-time type checks */
> -	return (void *)oidmap_iter_next(iter);
> +	return oidmap_iter_next(iter);
>  }

This comes from 87571c3f71 (hashmap: use *_entry APIs for
iteration, 2019-10-06), whose only change to this line is
adding the cast. Maybe the intent was to flag the area to be
handled later according to the comment? I'd think the
comment itself suffices, there. But if not, then we're
undoing it.

There's an identical case (from the same commit) a few lines
above. If we are changing this one, we should do both.

I'll stop here for now. It's a fair bit of leg-work digging
these up (though again, I do think there's value in
understanding why the cast was there, even if we know it
isn't _currently_ doing anything).

-Peff
