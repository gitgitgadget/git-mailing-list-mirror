Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAA3C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 20:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243929AbiAFUoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 15:44:54 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57099 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiAFUoy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 15:44:54 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BEC97164044;
        Thu,  6 Jan 2022 15:44:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gUpUlPXEmwe+t7VlPWYygW3UHDq/zp09opOE6y
        W6y/Y=; b=OpIvWclroDoqG/hB5v4d5k7eJgboNGVaGBTDMxQluTOIclM9qjEyHg
        dYU2C4Zlefi1XD7955xgxs6LUvQgu/N8/3cwzgiG/ejNgCCCOoQ00aJeB3eTQRhK
        c+WApPsBZnYy9JjMQX9L2OMFFD8jqqPVVmArgxw2AdRIfORzsGC1Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6EB3164043;
        Thu,  6 Jan 2022 15:44:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 27E02164042;
        Thu,  6 Jan 2022 15:44:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        peff@peff.net, tenglong.tl@alibaba-inc.com,
        Johannes.Schindelin@gmx.de, Teng Long <dyronetengb@gmail.com>
Subject: Re: [PATCH v9 5/9] ls-tree: optimize naming and handling of
 "return" in show_tree()
References: <cover.1641440700.git.dyroneteng@gmail.com>
        <75503c41a7e2f3fdbb59ce3568853049b55a2d3b.1641440700.git.dyroneteng@gmail.com>
Date:   Thu, 06 Jan 2022 12:44:49 -0800
In-Reply-To: <75503c41a7e2f3fdbb59ce3568853049b55a2d3b.1641440700.git.dyroneteng@gmail.com>
        (Teng Long's message of "Thu, 6 Jan 2022 12:31:28 +0800")
Message-ID: <xmqq5yqwd266.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7EB962EA-6F31-11EC-AC9A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> +static void init_type(unsigned mode, enum object_type *type)
> +{
> +	if (S_ISGITLINK(mode))
> +		*type = OBJ_COMMIT;
> +	else if (S_ISDIR(mode))
> +		*type = OBJ_TREE;
> +}
> +
> +static void init_recursive(struct strbuf *base, const char *pathname,
> +				int *recursive)
> +{
> +	if (show_recursive(base->buf, base->len, pathname))
> +		*recursive = READ_TREE_RECURSIVE;
> +}
> +
>  static int show_tree(const struct object_id *oid, struct strbuf *base,
>  		const char *pathname, unsigned mode, void *context)
>  {
> -	int retval = 0;
> +	int recursive = 0;
>  	size_t baselen;
>  	enum object_type type = OBJ_BLOB;
>  
> -	if (S_ISGITLINK(mode)) {
> -		type = OBJ_COMMIT;
> -	} else if (S_ISDIR(mode)) {
> -		if (show_recursive(base->buf, base->len, pathname)) {
> -			retval = READ_TREE_RECURSIVE;
> -			if (!(ls_options & LS_SHOW_TREES))
> -				return retval;
> -		}
> -		type = OBJ_TREE;
> -	}
> -	else if (ls_options & LS_TREE_ONLY)
> -		return 0;
> +	init_type(mode, &type);

What this one is doing sounds more like setting the type variable
based on the mode bits, and doing only half a job at it.  The name
"init" does not sound like a good match to what it does.

If we make it a separate function, we probably should add the "else"
clause to set *type to OBJ_BLOB there, so that the caller does not
say "we'd assume it is BLOB initially, but tweak it based on mode
bits".

I.e.

	type = get_type(mode);

where

	static enum object_type get_type(unsigned int mode)
	{
		return (S_ISGITLINK(mode) 
		        ? OBJ_COMMIT
			: S_ISDIR(mode)
			? OBJ_TREE
			: OBJ_BLOB);
	}

or something like that, perhaps?  But I think open-coding the whole
thing, after losing the "We assume BLOB" initialization, would be
much easier to follow, i.e.

	if (S_ISGITLINK(mode))
		type = OBJ_COMMIT;
	else if (S_ISDIR(mode))
		type = OBJ_TREE;
	else
		type = OBJ_BLOB;

without adding init_type() helper function.

> +	init_recursive(base, pathname, &recursive);

This is even less readable.  In the original, it was clear that we
only call show_recursive() on a path that is a true directory; we
now seem to unconditionally make a call to it.  Is that intended?

	Side note.  show_recursive() has a confusing name; it does
	not show anything---it only decides if we want to go
	recursive.

At least, losing the "we assume recursive is 0" upfront in the
variable declaration and writing

	if (type == OBJ_TREE && show_recursive(...))
		recursive = READ_TREE_RECURSIVE;
	else
		recursive = 0;

here, without introducing init_recursive(), would make it easier to
follow.  If we really want to add a new function, perhaps

	recursive = get_recursive(type, base, pathname);
 
where

	static int get_recursive(enum object_type type,
				 struct strbuf *base, const char *pathname)
	{
		if (type == OBJ_TREE && show_recursive(...))
			return READ_TREE_RECURSIVE;
		else
			return 0;
	}

but I fail to see the point of doing so; open-coded 4 lines here
would make the flow of thought much better to me.

In any case, I think your splitting the original into "this is about
type" and "this is about the recursive bit" is a good idea to help
making the resulting code easier to follow.

> +	if (type == OBJ_TREE && recursive && !(ls_options & LS_SHOW_TREES))
> +		return recursive;

We are looking at an entry that is a directory.  We are running in
recursive mode.  And we are not told to show the directory itself in
the output.  We skip the rest of the function, which is about to
show this single entry.  Makes sense.


> +	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
> +		return !READ_TREE_RECURSIVE;

Negation of a non-zero integer constant is 0, so it is the same as
the original that returned 0, but I am not sure if it is enhancing
or hurting readability of the code.  The user of the value, in
tree.c::read_tree_at(), knows that the possible and valid values are
0 and READ_TREE_RECURSIVE, so returning 0 would probably be a better
idea.  After all, the initializer in the original for the variable
definition of "retval" used "0", not "!READ_TREE_RECURSIVE".

The name "recursive" is much more specific than the overly generic
"retval".  Its value is to be consumed by read_tree_at(), i.e. our
caller, to decide if we want it to recurse into the contents of the
directory.  I would have called it "recurse" (or even "to_recurse"),
if I were doing this change, though.
