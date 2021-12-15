Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A55EC433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 19:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344243AbhLOTZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 14:25:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59697 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbhLOTZv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 14:25:51 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FE1910C6FC;
        Wed, 15 Dec 2021 14:25:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4BxKJl6qfp0DfXWMwO9+Hwe9h1B8217FPA7D8s
        pM9i8=; b=XSzYryHXpffntk+B3q6PrKPPAhr8e40Z7TFjzNg6PASryme59yr0A2
        cUZc5kWAtEtLuuLYNdx2owotUdLFa2xqHCDlZ9//igA7CMVuJoV9mIaiPsmeLT5U
        EE0b3Ff3Rs7UTU+D1pjlu+iNZCy7MDt7csnJfxH2YkILf/gt86Lgo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 856CC10C6FB;
        Wed, 15 Dec 2021 14:25:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E76F810C6FA;
        Wed, 15 Dec 2021 14:25:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, congdanhqx@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v5 1/1] ls-tree.c: support `--object-only` option for
 "git-ls-tree"
References: <cover.1638891420.git.dyroneteng@gmail.com>
        <38d55a878c51104f0a5337481fdcd5c8818660ac.1638891420.git.dyroneteng@gmail.com>
Date:   Wed, 15 Dec 2021 11:25:48 -0800
In-Reply-To: <38d55a878c51104f0a5337481fdcd5c8818660ac.1638891420.git.dyroneteng@gmail.com>
        (Teng Long's message of "Wed, 8 Dec 2021 10:08:31 +0800")
Message-ID: <xmqqk0g5656r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFA69F12-5DDC-11EC-9BC7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> We usually pipe the output from `git ls-trees` to tools like
> `sed` or `cut` when we only want to extract some fields.
>
> When we want only the pathname component, we can pass
> `--name-only` option to omit such a pipeline, but there are no
> options for extracting other fields.
>
> Teach the "--object-only" option to the command to only show the
> object name. This option cannot be used together with
> "--name-only" or "--long" (mutually exclusive).

I notice that this changed from --oid to --object and I agree that
it would probably be more friendly to end users.  In fact, this

    $ sed -ne '/^SYNOPSIS/,/^DESCRIPTION/p' Documentation/git-*.txt |
      grep -e -oid

did not find any hits.

> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 3a442631c7..beaa8bf13b 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -16,21 +16,38 @@
>  
>  static int line_termination = '\n';
>  #define LS_RECURSIVE 1
> -#define LS_TREE_ONLY 2
> -#define LS_SHOW_TREES 4
> -#define LS_NAME_ONLY 8
> -#define LS_SHOW_SIZE 16
> +#define LS_TREE_ONLY 1 << 1
> +#define LS_SHOW_TREES 1 << 2
> +#define LS_NAME_ONLY 1 << 3
> +#define LS_SHOW_SIZE 1 << 4
> +#define LS_OBJECT_ONLY 1 << 5

It usually is a good idea to enclose these in () so that they are
safe to use in any context in a statement.

Luckily, bitwise-or and bitwise-and, which are the most likely
candidates for these symbols to be used with, bind looser than
left-shift, so something like 

	if ((LS_TREE_ONLY | LS_SHOW_TREES) & opt)
		... do this ...

is safe either way, but (LS_TREE_ONLY + LS_SHOW_TREES) would have
different value with and without () around (1 << N).

> +static unsigned int shown_bits = 0;

Style: we do not initialize statics explicitly to zero.

> +#define SHOW_DEFAULT 29 /* 11101 size is not shown to output by default */
> +#define SHOW_MODE 1 << 4
> +#define SHOW_TYPE 1 << 3
> +#define SHOW_OBJECT_NAME 1 << 2
> +#define SHOW_SIZE 1 << 1
> +#define SHOW_FILE_NAME 1

Likewise.  It is a bit curious to see these listed in decreasing
order, though.

>  static const  char * const ls_tree_usage[] = {
>  	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
>  	NULL
>  };
>  
> +enum {
> +	MODE_UNSPECIFIED = 0,
> +	MODE_NAME_ONLY,
> +	MODE_OBJECT_ONLY,
> +	MODE_LONG

It is a good idea to leave a comma even after the last element,
_unless_ there is a strong reason why the element that currently is
at the last MUST stay to be last when new elements are added to the
enum.  That way, a future patch that adds a new element can add it
to the list with a patch noise with fewer lines.

> +};
> +
> +static int cmdmode = MODE_UNSPECIFIED;

This is also initializing a static variable to zero, and arguments
can be made either way: (A) unspecified is set to zero in enum
definition exactly so that we can use zero to signal the variable is
unspecified, so an explicit zero initialization here goes against
the spirit of choosing 0 as MODE_UNSPECIFIED; or (B) enum definition
can be scrambled in future changes to use something other than zero
for MODE_UNSPECIFIED, and explicitly writing it like this is more
future-proof.

I am OK with the way it is written (i.e. (B)).

> @@ -66,6 +83,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
>  {
>  	int retval = 0;
>  	int baselen;
> +	int follow = 0;

A better name, anybody?

This bit is to keep track of the fact that we made _some_ output
already so any further output needs an inter-field space before
writing what it wants to write out.

>  	const char *type = blob_type;
>  
>  	if (S_ISGITLINK(mode)) {
> @@ -74,8 +92,8 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
>  		 *
>  		 * Something similar to this incomplete example:
>  		 *
> -		if (show_subprojects(base, baselen, pathname))
> -			retval = READ_TREE_RECURSIVE;
> +		 * if (show_subprojects(base, baselen, pathname))
> +		 *	retval = READ_TREE_RECURSIVE;
>  		 *
>  		 */

Nice ;-)

>  		type = commit_type;
> @@ -90,35 +108,67 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
>  	else if (ls_options & LS_TREE_ONLY)
>  		return 0;
>  
> -	if (!(ls_options & LS_NAME_ONLY)) {
> -		if (ls_options & LS_SHOW_SIZE) {
> -			char size_text[24];
> -			if (!strcmp(type, blob_type)) {
> -				unsigned long size;
> -				if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
> -					xsnprintf(size_text, sizeof(size_text),
> -						  "BAD");
> -				else
> -					xsnprintf(size_text, sizeof(size_text),
> -						  "%"PRIuMAX, (uintmax_t)size);
> -			} else
> -				xsnprintf(size_text, sizeof(size_text), "-");
> -			printf("%06o %s %s %7s\t", mode, type,
> -			       find_unique_abbrev(oid, abbrev),
> -			       size_text);
> +	if (shown_bits & SHOW_MODE) {
> +		printf("%06o",mode);

SP before ','.

> +		follow = 1;
> +	}
> +	if (shown_bits & SHOW_TYPE) {
> +		printf("%s%s", follow == 1 ? " " : "", type);
> +		follow = 1;
> +	}
> +	if (shown_bits & SHOW_OBJECT_NAME) {
> +		printf("%s%s", follow == 1 ? " " : "",
> +		       find_unique_abbrev(oid, abbrev));
> +		if (!(shown_bits ^ SHOW_OBJECT_NAME))
> +			printf("%c", line_termination);

Curious.  I wonder if we can get rid of these two lines (and the
line_termination bit in the SHOW_FILE_NAME part), and have an
unconditional 

	putchar(line_termination);

at the end of the function.

That way, we could in the future choose to introduce a feature to
show only <mode, type, size> and nothing else, which may be useful
for taking per-type stats.

We need to stop using write_name_quoted_relative() in SHOW_FILE_NAME
part, because the helper insists that the name written by it must be
at the end of the entry, if we go that route, but it may be a good
change in the longer term.

> +		follow = 1;
> +	}
> +	if (shown_bits & SHOW_SIZE) {
> +		char size_text[24];
> +		if (!strcmp(type, blob_type)) {
> +			unsigned long size;
> +			if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
> +				xsnprintf(size_text, sizeof(size_text), "BAD");
> +			else
> +				xsnprintf(size_text, sizeof(size_text),
> +					  "%"PRIuMAX, (uintmax_t)size);
>  		} else
> -			printf("%06o %s %s\t", mode, type,
> -			       find_unique_abbrev(oid, abbrev));
> +			xsnprintf(size_text, sizeof(size_text), "-");
> +		printf("%s%7s", follow == 1 ? " " : "", size_text);
> +		follow = 1;
> +	}
> +	if (shown_bits & SHOW_FILE_NAME) {
> +		if (follow)
> +			printf("\t");
> +		baselen = base->len;
> +		strbuf_addstr(base, pathname);
> +		write_name_quoted_relative(base->buf,
> +					   chomp_prefix ? ls_tree_prefix : NULL,
> +					   stdout, line_termination);
> +		strbuf_setlen(base, baselen);
>  	}

But the above nits aside, the updated organization of this function
looks much cleaner than the original.  Nicely reorganized.

> -	baselen = base->len;
> -	strbuf_addstr(base, pathname);
> -	write_name_quoted_relative(base->buf,
> -				   chomp_prefix ? ls_tree_prefix : NULL,
> -				   stdout, line_termination);
> -	strbuf_setlen(base, baselen);
>  	return retval;
>  }

Thanks.
