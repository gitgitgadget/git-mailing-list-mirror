Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8377C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 02:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiADCGp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 21:06:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57780 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiADCGo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 21:06:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 085E110FC74;
        Mon,  3 Jan 2022 21:06:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=5nxk4lpJeKCXsOiZK8FS6Fi5k+nn9jKSkVVMSEm67aM=; b=vZgj
        IM6PlM1HHCu8+0DdRA3ICX4SYtuCJjqwfPPwXqCmGOhVaRLkyhwlL83DLKvrapA1
        fmD/Lg5n3ZNJfxtMOrf9kAE8oLHcOuYPXD0eTq6/B4n/HQfSx5DsGNDIuJfH3l2q
        z6o4XoukzQvXknNkApFoIZXDP0J8YY4eQJgauFg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0048A10FC73;
        Mon,  3 Jan 2022 21:06:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6653910FC72;
        Mon,  3 Jan 2022 21:06:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 5/8] ls-tree: split up the "init" part of show_tree()
References: <cover.1641043500.git.dyroneteng@gmail.com>
        <d77c895a4b9d5cb86443279c0156196254895ef4.1641043500.git.dyroneteng@gmail.com>
Date:   Mon, 03 Jan 2022 18:06:42 -0800
Message-ID: <xmqqwnjgfe4t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F67D11AE-6D02-11EC-ACE9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:


> -static int show_tree(const struct object_id *oid, struct strbuf *base,
> -		const char *pathname, unsigned mode, void *context)
> +static int show_tree_init(enum object_type *type, struct strbuf *base,
> +			  const char *pathname, unsigned mode, int *retval)

Don't we need some comment that explains what the function does,
what its return value means, etc.?

>  {
> -	int retval = 0;
> -	size_t baselen;
> -	enum object_type type = OBJ_BLOB;
> -
>  	if (S_ISGITLINK(mode)) {
> -		type = OBJ_COMMIT;
> +		*type = OBJ_COMMIT;
>  	} else if (S_ISDIR(mode)) {
>  		if (show_recursive(base->buf, base->len, pathname)) {
> -			retval = READ_TREE_RECURSIVE;
> +			*retval = READ_TREE_RECURSIVE;
>  			if (!(ls_options & LS_SHOW_TREES))
> -				return retval;
> +				return 1;
>  		}
> -		type = OBJ_TREE;
> +		*type = OBJ_TREE;
>  	}
>  	else if (ls_options & LS_TREE_ONLY)
> -		return 0;
> +		return 1;
> +	return 0;
> +}

It seems that even from its returned value, the caller cannot tell
if *retval was set by the function or not.  Perhaps it makes a much
cleaner API to assign 0 to *retval at the beginning of this function,
just like the original did so anyway? ...

> +static int show_tree(const struct object_id *oid, struct strbuf *base,
> +		const char *pathname, unsigned mode, void *context)
> +{
> +	int retval = 0;

... It would mean we can lose this initialization.

> +	size_t baselen;
> +	enum object_type type = OBJ_BLOB;
> +
> +	if (show_tree_init(&type, base, pathname, mode, &retval))
> +		return retval;

>  
>  	if (!(ls_options & LS_NAME_ONLY)) {
>  		if (ls_options & LS_SHOW_SIZE) {
