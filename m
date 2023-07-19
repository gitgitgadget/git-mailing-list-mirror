Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D4BC0015E
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 22:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjGSW5R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 18:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGSW5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 18:57:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE342101
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 15:56:49 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A72BF3239E;
        Wed, 19 Jul 2023 18:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3ZEoojbVEjwrk+w4XLKKnjl3tnsLABryhSD8HA
        u/Vzg=; b=jVqYlyeVHQdWsAFUEXwkg+MQ2cJ0viUsr0wk7qIQ33zrqvr5ckAXwe
        o0cnzCzpDRsdjKKVefXbkICUrwUDO5pC5vNQpXF+r9veV3CcJSVp96M/zk/bVzPb
        UkH0wW7uBAmZASDPO7VaTDQLUgFoG+3M1owEghRUCy6IUe+SHVLV0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EA3C3239D;
        Wed, 19 Jul 2023 18:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 20AE93239C;
        Wed, 19 Jul 2023 18:56:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3 2/2] ref-filter: add new "describe" atom
References: <20230714194249.66862-1-five231003@gmail.com>
        <20230719162424.70781-1-five231003@gmail.com>
        <20230719162424.70781-3-five231003@gmail.com>
Date:   Wed, 19 Jul 2023 15:56:15 -0700
In-Reply-To: <20230719162424.70781-3-five231003@gmail.com> (Kousik
        Sanagavarapu's message of "Wed, 19 Jul 2023 21:45:06 +0530")
Message-ID: <xmqqy1jb7bow.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 780A4AAE-2687-11EE-BA81-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> Duplicate the logic of %(describe) and friends from pretty to
> ref-filter. In the future, this change helps in unifying both the
> formats as ref-filter will be able to do everything that pretty is doing
> and we can have a single interface.
>
> The new atom "describe" and its friends are equivalent to the existing
> pretty formats with the same name.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Hariom Verma <hariom18599@gmail.com>
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  23 +++++
>  ref-filter.c                       | 130 +++++++++++++++++++++++++++++
>  t/t6300-for-each-ref.sh            | 114 +++++++++++++++++++++++++
>  3 files changed, 267 insertions(+)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 2e0318770b..395daf1b22 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -258,6 +258,29 @@ ahead-behind:<committish>::
>  	commits ahead and behind, respectively, when comparing the output
>  	ref to the `<committish>` specified in the format.
>  
> +describe[:options]:: Human-readable name, like
> +		     link-git:git-describe[1]; empty string for
> +		     undescribable commits. The `describe` string may be
> +		     followed by a colon and zero or more comma-separated
> +		     options.

Why do these new items formatted so differently from the previous
ones?  By indenting the lines so deeply you are forcing yourself to
wrap these lines many times.  How about imitating the previous entry
for ahead-behind and writing this like so:

        describe[:<options>]::
                A human-readable name, like linkgit:git-describe[1];
                empty string is given for an undescribable commit.
		...

By the way, there is a typo "link-git" above that needs to be
corrected.

It is curious that we support "describe:" (i.e. having no options,
but colon is still present).  It may not be wrong per se, but it
looks strange.  "may be followed by a colon and one or more
comma-separated options" would be more intuitive (I haven't seen the
implementation yet, so if we go that route, the implementation may
also need to be updated).

>               .... Descriptions can be inconsistent when tags
> +		     are added or removed at the same time.

"at the same time" meaning "while the description are being
computed"?  I think this was copied from 273c9901 (pretty: document
multiple %(describe) being inconsistent, 2021-02-28) where the
pretty placeholder for "git log" and friends are described, and the
implementation used there go one formatting element at a time,
unlike for-each-ref that can compute a description for a given ref
just once in populate_value() and reuse the same atom number of
times in the format, each instance giving exactly the same value.
So I am not sure if the "can be inconsistent" disclaimer applies
to the %(describe) on this side the same way.  Are you sure?

As %(describe) is fairly expensive to compute, if the format string
wants two, e.g. --format="%(refname) %(describe) %(describe)", there
should be some effort to make these two share the same used_atom(),
so that there will be only one "git describe" invocation from
populate_value() that lets get_ref_atom_value() reuse that result
of a single invocation to fill the two placeholder.


> @@ -219,6 +222,7 @@ static struct used_atom {
>  			enum { S_BARE, S_GRADE, S_SIGNER, S_KEY,
>  			       S_FINGERPRINT, S_PRI_KEY_FP, S_TRUST_LEVEL } option;
>  		} signature;
> +		const char **describe_args;
>  		struct refname_atom refname;
>  		char *head;
>  	} u;

Nice and simple ;-).

> +static int describe_atom_option_parser(struct strvec *args, const char **arg,
> +				       struct strbuf *err)
> +{
> +	const char *argval;
> +	size_t arglen = 0;
> +	int optval = 0;
> +
> +	if (match_atom_bool_arg(*arg, "tags", arg, &optval)) {
> +		if (!optval)
> +			strvec_push(args, "--no-tags");
> +		else
> +			strvec_push(args, "--tags");
> +		return 1;
> +	}

OK.  One thing that I hate about the split of this series into two
steps is that [1/2] has to be read without knowing what the expected
use of those two helper functions are.  It was especially bad as the
functions lacked any documentation on how they are supposed to be
called.

Now, if we go back to the implementation of match_atom_bool_arg(),
it first called match_atom_arg_value(), which stripped the given key
("tags" in this case) from the argument being parsed, and allowed
'=' (i.e. followed by a val), ',' (i.e. no val, but more "key[=val]"
to follow), or '\0' (i.e. end of the argument string).  Anything
else after the matched key meant that the key did not match
(e.g. the arg had "tagsabcd", which should not match "tag").  And it
stored the byte position after '=' if the key was terminated with
'=', or NULL otherwise, to signal where the optional value starts.
match_atom_bool_arg() uses this and correctly translates a key
without the optional [=val] part into "true".  So the above is
given, after the caller skips "%(describe:", things like "tags,...",
"tags=no,...", "tags=yes,..." (or replace ",..." with a NUL for the
final option), and chooses between --no-tags and --tags.  Sounds
good.

> + ...
> +	if (match_atom_arg_value(*arg, "exclude", arg, &argval, &arglen)) {
> +		if (!arglen)
> +			return strbuf_addf_ret(err, -1,
> +					       _("value expected %s="),
> +					       "describe:exclude");
> +
> +		strvec_pushf(args, "--exclude=%.*s", (int)arglen, argval);
> +		return 1;
> +	}

I would have expected that these become if/else if/.../else cascade,
i.e.

	if (is that "tags"?) {
	} else if (is that "abbrev"?) {
		...
	} else
		return 0; /* nothing matched */
	return 1;

but I do not mind the above.  Each "block" that matches and handles
one key looks more indenendent the way the patch was written, which
may be a good thing.

> +	return 0;
> +}
> +
> +static int describe_atom_parser(struct ref_format *format UNUSED,
> +				struct used_atom *atom,
> +				const char *arg, struct strbuf *err)
> +{
> +	struct strvec args = STRVEC_INIT;

OK, parse_ref_fitler_atom() saw "%(describe", possibly followed by a
colon and zero or more comma-separated key[=val], and the location
after ':' (or NULL) is given to arg.  Specifically, %(describe) and
%(describe:) both pass NULL in arg.

> +	for (;;) {
> +		int found = 0;
> +		const char *bad_arg = NULL;
> +
> +		if (!arg || !*arg)
> +			break;

And we stop when there is no more key[=val].

> +		bad_arg = arg;
> +		found = describe_atom_option_parser(&args, &arg, err);

This one moves arg forward and arranges the next key[=val] to be seen
in the next iteration of this loop.  Makes sense.

In the remainder of the code changes, I saw nothing strange.
Quite well made.
