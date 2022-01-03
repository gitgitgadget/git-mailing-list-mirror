Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCC4C433FE
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 23:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiACXVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 18:21:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53027 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiACXVi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 18:21:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9580016F6C1;
        Mon,  3 Jan 2022 18:21:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fD1VNGSILlxSG5eSK28C9nUv5qBXSC3gTdXtVB
        B4bS0=; b=AavuADu9XfygZCGDqqsNcjJNI9iHwS2iEmn4cE3yXaQDIC1SPOA6FI
        PcYmMgj3r46R8aOfVj8hiHSEPjuuJ1C8gQ7NFLnFE6jdOvKr1pKGmHfdMaeQi+Wz
        nKlyZUYVlukfJEfOUhwhFd0aG+Y4jw6hFnb+SdXOee24anRONH9FA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C3BD16F6BF;
        Mon,  3 Jan 2022 18:21:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 904F716F6BB;
        Mon,  3 Jan 2022 18:21:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 7/8] ls-tree.c: introduce struct "shown_data"
References: <cover.1641043500.git.dyroneteng@gmail.com>
        <296ebacafe4d40ffc5282aebb9fee972866c4ccc.1641043500.git.dyroneteng@gmail.com>
Date:   Mon, 03 Jan 2022 15:21:32 -0800
In-Reply-To: <296ebacafe4d40ffc5282aebb9fee972866c4ccc.1641043500.git.dyroneteng@gmail.com>
        (Teng Long's message of "Sat, 1 Jan 2022 21:50:30 +0800")
Message-ID: <xmqqilv0iewz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3C4B272-6CEB-11EC-B379-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> "show_data" is a struct that packages the necessary fields for

Is that shown_data?

> reusing. This commit is a front-loaded commit for support
> "--format" argument and does not affect any existing functionality.

What's a front-loaded commit?  Is that some joke around a washing
machine that I do not quite get, or something?

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  builtin/ls-tree.c | 47 +++++++++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 85ca7358ba..009ffeb15d 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -34,6 +34,14 @@ static unsigned int shown_bits;
>  #define SHOW_MODE (1 << 4)
>  #define SHOW_DEFAULT 29 /* 11101 size is not shown to output by default */
>  
> +struct shown_data {
> +	unsigned mode;
> +	enum object_type type;
> +	const struct object_id *oid;
> +	const char *pathname;
> +	struct strbuf *base;
> +};
> +
>  static const  char * const ls_tree_usage[] = {
>  	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
>  	NULL
> @@ -98,17 +106,15 @@ static int show_recursive(const char *base, size_t baselen,
>  	return 0;
>  }
>  
> -static int show_default(const struct object_id *oid, enum object_type type,
> -			const char *pathname, unsigned mode,
> -			struct strbuf *base)
> +static int show_default(struct shown_data *data)
>  {
> -	size_t baselen = base->len;
> +	size_t baselen = data->base->len;
>  
>  	if (shown_bits & SHOW_SIZE) {
>  		char size_text[24];
> -		if (type == OBJ_BLOB) {
> +		if (data->type == OBJ_BLOB) {
>  			unsigned long size;
> -			if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
> +			if (oid_object_info(the_repository, data->oid, &size) == OBJ_BAD)
>  				xsnprintf(size_text, sizeof(size_text), "BAD");
>  			else
>  				xsnprintf(size_text, sizeof(size_text),
> @@ -116,18 +122,18 @@ static int show_default(const struct object_id *oid, enum object_type type,
>  		} else {
>  			xsnprintf(size_text, sizeof(size_text), "-");
>  		}
> -		printf("%06o %s %s %7s\t", mode, type_name(type),
> -		find_unique_abbrev(oid, abbrev), size_text);
> +		printf("%06o %s %s %7s\t", data->mode, type_name(data->type),
> +		find_unique_abbrev(data->oid, abbrev), size_text);
>  	} else {
> -		printf("%06o %s %s\t", mode, type_name(type),
> -		find_unique_abbrev(oid, abbrev));
> +		printf("%06o %s %s\t", data->mode, type_name(data->type),
> +		find_unique_abbrev(data->oid, abbrev));
>  	}
> -	baselen = base->len;
> -	strbuf_addstr(base, pathname);
> -	write_name_quoted_relative(base->buf,
> +	baselen = data->base->len;
> +	strbuf_addstr(data->base, data->pathname);
> +	write_name_quoted_relative(data->base->buf,
>  				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
>  				   line_termination);
> -	strbuf_setlen(base, baselen);
> +	strbuf_setlen(data->base, baselen);
>  	return 1;
>  }
>  
> @@ -154,11 +160,16 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
>  {
>  	int retval = 0;
>  	size_t baselen;
> -	enum object_type type = OBJ_BLOB;
> +	struct shown_data data = {
> +		.mode = mode,
> +		.type = OBJ_BLOB,
> +		.oid = oid,
> +		.pathname = pathname,
> +		.base = base,
> +	};
>  
> -	if (show_tree_init(&type, base, pathname, mode, &retval))
> +	if (show_tree_init(&data.type, base, pathname, mode, &retval))
>  		return retval;
> -
>  	if (!(shown_bits ^ SHOW_OBJECT_NAME)) {
>  		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
>  		return retval;
> @@ -175,7 +186,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
>  
>  	if (!(shown_bits ^ SHOW_DEFAULT) ||
>  	    !(shown_bits ^ (SHOW_DEFAULT | SHOW_SIZE)))
> -		show_default(oid, type, pathname, mode, base);
> +		show_default(&data);
>  
>  	return retval;
>  }
