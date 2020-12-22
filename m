Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E913CC433E9
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 20:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADCB422ADC
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 20:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgLVUzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 15:55:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59719 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgLVUzI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 15:55:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C2EDA2357;
        Tue, 22 Dec 2020 15:54:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PTa5QgBmADTvQf01tFw/jsGq408=; b=LpdvQm
        KBjN4jXD+4N8/IMovYuSHGuHKpV+8+9VETW4ZwOF69IsQx2j+YS3wOt1ModAHn0b
        fPRlYiJ1pM9/Rrn3f4IJXtWatgHwGjPiG7QxaZ8O1w/d8lOAVc32IlQ/1YActTfL
        j7TVFnB9rCFQDLQpXY0PWAAi+B9DYM11PaqY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Akeux9Q1pfCpeGf6nHnJmcphXJ+yQIPT
        nLzOnRCPuXMUddRAsF04Op14xbUzkiSO3at8Z5jX0nJhyIcNNN9hky3VrWcnNak9
        BrwQ3rcVk3yboZ7tGQ0vXI+O/KytZdMv2QriL5/C/L3DkNrPMKZ7Vl0ixBwmkPyu
        cLL9gxQzdhQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 220B6A2356;
        Tue, 22 Dec 2020 15:54:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9CDBEA2355;
        Tue, 22 Dec 2020 15:54:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 03/13] update-index: move add_cacheinfo() to
 read-cache.c
References: <20201116102158.8365-1-alban.gruin@gmail.com>
        <20201124115315.13311-1-alban.gruin@gmail.com>
        <20201124115315.13311-4-alban.gruin@gmail.com>
Date:   Tue, 22 Dec 2020 12:54:24 -0800
In-Reply-To: <20201124115315.13311-4-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 24 Nov 2020 12:53:05 +0100")
Message-ID: <xmqqczz1h88v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E02ACB2E-4497-11EB-AC98-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This moves the function add_cacheinfo() that already exists in
> update-index.c to update-index.c, renames it add_to_index_cacheinfo(),
> and adds an `istate' parameter.  The new cache entry is returned through
> a pointer passed in the parameters.  The return value is either 0
> (success), -1 (invalid path), or -2 (failed to add the file in the
> index).
>
> This will become useful in the next commit, when the three-way merge
> will need to call this function.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  builtin/update-index.c | 25 +++++++------------------
>  cache.h                |  5 +++++
>  read-cache.c           | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 79087bccea..44862f5e1d 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -404,27 +404,16 @@ static int process_path(const char *path, struct stat *st, int stat_errno)
>  static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
>  			 const char *path, int stage)
>  {
> -	int len, option;
> -	struct cache_entry *ce;
> +	int res;
>  
> -	if (!verify_path(path, mode))
> -		return error("Invalid path '%s'", path);
> -
> -	len = strlen(path);
> -	ce = make_empty_cache_entry(&the_index, len);
> -
> -	oidcpy(&ce->oid, oid);
> -	memcpy(ce->name, path, len);
> -	ce->ce_flags = create_ce_flags(stage);
> -	ce->ce_namelen = len;
> -	ce->ce_mode = create_ce_mode(mode);
> -	if (assume_unchanged)
> -		ce->ce_flags |= CE_VALID;
> -	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
> -	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
> -	if (add_cache_entry(ce, option))
> +	res = add_to_index_cacheinfo(&the_index, mode, oid, path, stage,
> +				     allow_add, allow_replace, NULL);
> +	if (res == -1)
> +		return res;
> +	if (res == -2)
>  		return error("%s: cannot add to the index - missing --add option?",
>  			     path);

Introduce a symbolic constant (C preprocessor macros) so that the
above becomes

	if (res == ADD_TO_INDEX_CACHEINFO_UNABLE_TO_ADD)
		return error("%s: cannot add to the index - missing --add option?",
			     path);
	if (res < 0)
		return res;

or something like that.

Stepping back a bit.

It feels _really_ odd that add_to_index_cacheinfo() became silent
only for one error-return case while the other error case emits an
error message on its own, without any way to squelch it.  Isn't this
adapting too much the need of a single (future) caller?

It may make more sense to do

	#define ADD_TO_INDEX_CACHEINFO_INVALID_PATH	(-1)
	#define ADD_TO_INDEX_CACHEINFO_UNABLE_TO_ADD	(-2)

and make both silent.  At least that would be more consistent.

> +
>  	report("add '%s'", path);
>  	return 0;
>  }
> diff --git a/cache.h b/cache.h
> index c0072d43b1..be16ab3215 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -830,6 +830,11 @@ int remove_file_from_index(struct index_state *, const char *path);
>  int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
>  int add_file_to_index(struct index_state *, const char *path, int flags);

As a public function with mysterious 0/-1/-2 return values, a reader
deserves to see a comment to understand how to call this function,
how to treat its return value, etc.

You already have enough material to fill in such a comment in your
proposed log message, it seems, which is good.

> +int add_to_index_cacheinfo(struct index_state *, unsigned int mode,
> +			   const struct object_id *oid, const char *path,
> +			   int stage, int allow_add, int allow_replace,
> +			   struct cache_entry **pce);
> +
>  int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
>  int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
>  void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
> diff --git a/read-cache.c b/read-cache.c
> index ecf6f68994..c25f951db4 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1350,6 +1350,41 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
>  	return 0;
>  }
>  
> +int add_to_index_cacheinfo(struct index_state *istate, unsigned int mode,
> +			   const struct object_id *oid, const char *path,
> +			   int stage, int allow_add, int allow_replace,
> +			   struct cache_entry **pce)
> +{

I see two behaviour differences from the original, which may be
worth noting in the proposed log message as difference.

 - callers of add_cacheinfo() never learned of the new cache entry;
   this allows the caller to optionally obtain a pointer to it.

 - we used to leak a new cache entry when add_cache_entry() refused
   to add it to the index; the leak got plugged.

> +	int len, option;
> +	struct cache_entry *ce = NULL;

Why initialize it to NULL?  It is quite clear in the code that the
variable is never used until it is assigned to.

> +	if (!verify_path(path, mode))
> +		return error(_("Invalid path '%s'"), path);
> +
> +	len = strlen(path);
> +	ce = make_empty_cache_entry(istate, len);
> +
> +	oidcpy(&ce->oid, oid);
> +	memcpy(ce->name, path, len);
> +	ce->ce_flags = create_ce_flags(stage);
> +	ce->ce_namelen = len;
> +	ce->ce_mode = create_ce_mode(mode);
> +	if (assume_unchanged)
> +		ce->ce_flags |= CE_VALID;
> +	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
> +	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
> +
> +	if (add_index_entry(istate, ce, option)) {
> +		discard_cache_entry(ce);

This behaviour is new.  We were leaking the ce.

> +		return -2;
> +	}
> +
> +	if (pce)
> +		*pce = ce;

I think you mean by 'p' a "pointer", but that is a horrible way to
name things.  We know from the type that it is a pointer to a
pointer already; what reader needs to learn from either its name or
a comment associated with it is what purpose it serves.

Perhaps call it with a name that hints it is used as the return
parameter, e.g. ce_ret?

> +	return 0;
> +}
> +
>  /*
>   * "refresh" does not calculate a new sha1 file or bring the
>   * cache up-to-date for mode/content changes. But what it
