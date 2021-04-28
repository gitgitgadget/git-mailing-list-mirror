Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25429C433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 04:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E48C3613C5
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 04:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhD1EDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 00:03:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52083 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhD1EDs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 00:03:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B205C888B;
        Wed, 28 Apr 2021 00:02:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5wlSyg80Gp8FFjf+Lz2WRTxuTmMAh/xzjN5rK6
        Nkt6k=; b=C1UMJtDIz3YT5n+pb8kZU61Zk+ZJjuNhp5kn9QIBuKFDVIJDQ8I3SF
        /cTEWobU8FnpUSBrMn3nYOa20dq9kW+OmwNtkXhSxMFPgQElZoFy4lbPeeV+MWo7
        +hW0QdFzs+/YAixRVbSomibfV9mqyfRMTPD8rTdnjPQVkUUbWH+LY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 315A1C888A;
        Wed, 28 Apr 2021 00:02:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7EDBC8889;
        Wed, 28 Apr 2021 00:02:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH v3 3/3] fast-export, fast-import: implement signed-commits
References: <20210422002749.2413359-1-lukeshu@lukeshu.com>
        <20210423164118.693197-1-lukeshu@lukeshu.com>
        <20210423164118.693197-4-lukeshu@lukeshu.com>
Date:   Wed, 28 Apr 2021 13:02:47 +0900
In-Reply-To: <20210423164118.693197-4-lukeshu@lukeshu.com> (Luke Shumaker's
        message of "Fri, 23 Apr 2021 10:41:18 -0600")
Message-ID: <xmqqfszbcazc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97D4882C-A7D6-11EB-8B50-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Shumaker <lukeshu@lukeshu.com> writes:

> From: Luke Shumaker <lukeshu@datawire.io>
>
> fast-export has an existing --signed-tags= flag that controls how to

Don't call a command line option "a flag", especially when it is not
a boolean.

"has an existing" feels redundantly repeticious.

> handle tag signatures.  However, there is no equivalent for commit
> signatures; it just silently strips the signature out of the commit
> (analogously to --signed-tags=strip).
>
> While signatures are generally problematic for fast-export/fast-import
> (because hashes are likely to change), if they're going to support tag
> signatures, there's no reason to not also support commit signatures.
>
> So, implement signed-commits.

That's misleading.  You are not inventing "git commit --signed"
here.

    So implement `--signed-commits=<disposition>` that mirrors the
    `--signed-tags=<disposition>` option.

> +--signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
> +	Specify how to handle signed commits.  Behaves exactly as
> +	--signed-tags (but for commits), except that the default is
> +	'warn-strip' rather than 'abort'.

Why deliberate inconsistency?  I am not sure "historically we did a
wrong thing" is a good reason (if we view that silently stripping
was a disservice to the users, aborting would be a bugfix).

> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index 458af0a2d6..4955c94305 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index d121dd2ee6..2b1101d104 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -30,8 +30,11 @@ static const char *fast_export_usage[] = {
>  	NULL
>  };
>  
> +enum sign_mode { SIGN_ABORT, SIGN_VERBATIM, SIGN_STRIP, SIGN_VERBATIM_WARN, SIGN_STRIP_WARN };
> +
>  static int progress;
> -static enum { SIGNED_TAG_ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;

Giving the enum values consistent prefix "SIGN_" is a great
improvement.  On the other hand, swapping the word order,
e.g. WARN_STRIP to SIGN_STRIP_WARN, is unwarranted.

> +static enum sign_mode signed_tag_mode = SIGN_ABORT;
> +static enum sign_mode signed_commit_mode = SIGN_STRIP_WARN;

I think it is safer to abort for both and sell it as a bugfix
("silently stripping commit signatures was wrong. we should abort
the same way by default when encountering a signed tag").

> -static int parse_opt_signed_tag_mode(const struct option *opt,
> +static int parse_opt_sign_mode(const struct option *opt,
>  				     const char *arg, int unset)
>  {
> -	if (unset || !strcmp(arg, "abort"))
> -		signed_tag_mode = SIGNED_TAG_ABORT;
> +	enum sign_mode *valptr = opt->value;
> +	if (unset)
> +		return 0;
> +	else if (!strcmp(arg, "abort"))
> +		*valptr = SIGN_ABORT;
>  	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
> -		signed_tag_mode = VERBATIM;
> +		*valptr = SIGN_VERBATIM;

Interesting and not a new issue at all, but "ignore" is a confusing
symonym to "verbatim"---I would have expected "ignore", if accepted
as a choice, would strip the signature.  Not documenting it is
probably good, but perhaps we would eventually remove it?

> @@ -499,6 +505,60 @@ static void show_filemodify(struct diff_queue_struct *q,
>  	}
>  }
>  
> +static const char *find_signature(const char *begin, const char *end, const char *key)

This is only for in-header signature used in commit objects, and not
for the traditional "attached to the end" signature used in tag
objects, right?

The name of this function should be designed to answer the above
question, but find_signature() that does not say either commit or
tag implies it can accept both (which would be a horrible interface,
though).  If this is only for in-header signature, rename it to make
sure that the fact is readable out of its name?

> +{
> +	static struct strbuf needle = STRBUF_INIT;
> +	char *bod, *eod, *eol;
> +
> +	strbuf_reset(&needle);
> +	strbuf_addch(&needle, '\n');
> +	strbuf_addstr(&needle, key);
> +	strbuf_addch(&needle, ' ');

strbuf_addf(), perhaps?

> +	bod = memmem(begin, end ? end - begin : strlen(begin),
> +		     needle.buf, needle.len);
> +	if (!bod)
> +		return NULL;
> +	bod += needle.len;
> +
> +	/*
> +	 * In the commit object, multi-line header values are stored
> +	 * by prefixing continuation lines begin with a space.  So

"by prefixig continuation lines with a space"

> +	 * within the commit object, it looks like
> +	 *
> +	 *     "gpgsig -----BEGIN PGP SIGNATURE-----\n"
> +	 *     " Version: GnuPG v1.4.5 (GNU/Linux)\n"
> +	 *     " \n"
> +	 *     " base64_pem_here\n"
> +	 *     " -----END PGP SIGNATURE-----\n"
> +	 *
> +	 * So we need to look for the first '\n' that *isn't* followed
> +	 * by a ' ' (or the first '\0', if no such '\n' exists).
> +	 */

> +	eod = strchrnul(bod, '\n');
> +	while (eod[0] == '\n' && eod[1] == ' ') {
> +		eod = strchrnul(eod+1, '\n');
> +	}

SP on both sides of '+'; no {} around a block that consists of a
single statement.

> +	*eod = '\0';

The begin and end pointers pointed to a piece of memory that is
supposed to be read-only, but this pointer points into that region
of memory and then updates a byte?  The function signature is
misleading---if you intend to muck with the string, accept them as
mutable pointers.

Better yet, don't butcher the region of memory pointed by the
"message" variable the caller uses to keep reading from the
remainder of the commit object buffer with this and memmove()
below.  Perhaps have the caller pass a strbuf to fill in the
signature found by this helper as another parameter, and then return
a bool "Yes, I found a sig" as its return value?

> +
> +	/*
> +	 * We now have the value as it's stored in the commit object.
> +	 * However, we want the raw value; we want to return
> +	 *
> +	 *     "-----BEGIN PGP SIGNATURE-----\n"
> +	 *     "Version: GnuPG v1.4.5 (GNU/Linux)\n"
> +	 *     "\n"
> +	 *     "base64_pem_here\n"
> +	 *     "-----END PGP SIGNATURE-----\n"
> +	 *
> +	 * So now we need to strip out all of those extra spaces.
> +	 */
> +	while ((eol = strstr(bod, "\n ")))
> +		memmove(eol+1, eol+2, strlen(eol+1));

Besides, this is O(n^2), isn't it, as it always starts scanning at
bod while there are lines in the signature block to be processed, it
needs to skip over the lines that the loop already has processed.

I'd stop here for now, as there should be enough to polish.

Thanks.
