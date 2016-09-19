Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4BA62070F
	for <e@80x24.org>; Mon, 19 Sep 2016 23:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbcISXWL (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 19:22:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50483 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750730AbcISXWL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 19:22:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA6094000A;
        Mon, 19 Sep 2016 19:21:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G/BCpchCybBvQfIhptTCJZH4ISE=; b=lMnsHx
        MXKhez1ehYWPqRWipktuVyi7NZQJ4CeOAT5B7YOIoc7OzAcbsxaN7oWBldP7h0xP
        sYVR5Tn0ou+6I8NfnMPhVhy9EcGMcmWe5Fpc84JCzRsXYdlwVLN+3ci/VZgLwNoQ
        wYpyMcc1kxKj7HX1IzH+qb9JJQrOka9Lc9HOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qdES4uUFyncRvgeAEVgHbMI9qBiJxHou
        rmGhlMvUJxRJBYZRW7lps0UCUSppE4biFjfx/HvAMMAcy6rPQKbSVSbxDHQ9Gf6u
        FNoaG7ifX03+wfq6HKvJ4Ym41q8d61apf2gy/HjIsEPf9hRhyGqkDJBLjYOA5bn1
        cSiKyLGSl5Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D034B40009;
        Mon, 19 Sep 2016 19:21:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 45C3C40008;
        Mon, 19 Sep 2016 19:21:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] ls-files: add pathspec matching for submodules
References: <CAKoko1qrAuLhn6qQax-BSZFhEqbFdiBbVrip8TD3NVjD8Xzy0g@mail.gmail.com>
        <1474311151-117883-1-git-send-email-bmwill@google.com>
Date:   Mon, 19 Sep 2016 16:21:53 -0700
In-Reply-To: <1474311151-117883-1-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Mon, 19 Sep 2016 11:52:31 -0700")
Message-ID: <xmqqh99bcw6m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA9DBCD6-7EBF-11E6-81AA-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index a623ebf..09e4449 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -19,7 +19,7 @@ SYNOPSIS
> -		[--output-path-prefix=<path>]
> +		[--submodule-prefix=<path>]
> ...
> ---output-path-prefix=<path>::
> +--submodule-prefix=<path>::
> ...
> -static const char *output_path_prefix;
> +static const char *submodule_prefix;
> ...
> -	if (output_path_prefix && *output_path_prefix) {
> +	if (submodule_prefix && *submodule_prefix) {
>  		strbuf_reset(&full_name);
> -		strbuf_addstr(&full_name, output_path_prefix);
> +		strbuf_addstr(&full_name, submodule_prefix);
> ...
> -	argv_array_pushf(&cp.args, "--output-path-prefix=%s%s/",
> -			 output_path_prefix ? output_path_prefix : "",
> +	argv_array_pushf(&cp.args, "--submodule-prefix=%s%s/",
> +			 submodule_prefix ? submodule_prefix : "",
>  			 ce->name);

As the previous one that used a wrong (sorry) argument is not even
in 'next' yet, let's pretend that it never happened.  It is OK to
still keep it and this patch as two separate steps, i.e. a topic
with two patches in it.

That means that this patch will become 2/2 of a series, and 1/2 is
rerolled to use submodule_prefix from the get-go, without ever
introducing output_path_prefix variable, so that many of the above
lines we won't have to review in 2/2.

> +	/*
> +	 * Pass in the original pathspec args.  The submodule will be
> +	 * responsible for prepending the 'submodule_prefix' prior to comparing
> +	 * against the pathspec for matches.
> +	 */

Good.

> +	argv_array_push(&cp.args, "--");
> +	for (i = 0; i < pathspec.nr; ++i)
> +		argv_array_push(&cp.args, pathspec.items[i].original);
> +

Please prefer post-increment i++ over pre-increment ++i when writing
a for(;;) loop, unless there is a strong reason not to (familiarlity
in C++ is not a good reason).

> diff --git a/dir.c b/dir.c
> index 0ea235f..1afc3ff 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -63,6 +63,35 @@ int fspathncmp(const char *a, const char *b, size_t count)
>  	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
>  }
>  
> +/**
> + * Used to perform prefix matching against a pathspec_item for determining if we
> + * should decend into a submodule.  This function can result in false positives
> + * since we are only trying to match the 'string' to a prefix of the 'pattern'
> + */

Perhaps s/can/is allowed to/.  Implicit but equally important is
that it is not OK to produce false negative.

> +static int prefix_fnmatch(const struct pathspec_item *item,
> +		   const char *pattern, const char *string,
> +		   int prefix)
> +{
> +	if (prefix > 0) {
> +		if (ps_strncmp(item, pattern, string, prefix))
> +			return WM_NOMATCH;
> +		pattern += prefix;
> +		string += prefix;
> +	}
> +
> +	if (item->flags & PATHSPEC_ONESTAR) {
> +		return WM_MATCH;
> +	} else if (item->magic & PATHSPEC_GLOB) {
> +		return wildmatch(pattern, string,
> +				 WM_PATHNAME |
> +				 (item->magic & PATHSPEC_ICASE ?
> +				  WM_CASEFOLD : 0),
> +				 NULL);

Isn't this last one overly tight?  I am wondering about a scenario
where you have a submodule at "sub/" in the superproject, and "sub/"
has a "file" at the top of its working tree.  And you do:

	git ls-files --recurse-submodules ':(glob)??b/fi?e'

at the top of the superproject.  The "pattern" would be '??b/fi?e"
while string would be 'sub', and wildmatch() would not like it, but
there is no way for this caller to append anything to 'sub' before
making this call, as it hasn't looked into what paths appear in the
submodule repository (and it should not want to).  And I think we
would want it to recurse to find sub/file.  IOW, this looks like a
false negative we must avoid in this function.  As we cannot afford
to check if anything that matches 'fi?e' is in the index file of the
submodule repository, we shouldn't try to match 'fi?e' portion of
the given pathspec pattern.

Extending the scenario, if I also create a directory "sib/" in the
superproject next to "sub/" and add a "file" in it, the same
pathspec:

	git ls-files [--recurse-submodules] ':(glob)??b/fi?e'

does find "sib/file" (with or without the recursion option).

    Duy cc'ed because I am not quite sure why it is a good thing
    that I need to add an exlicit ':(glob)' in these examples to
    illustrate the breakage.  This comes from v1.8.3.2-849-gbd30c2e
    ("pathspec: support :(glob) syntax", 2013-07-14) and I do not
    think we want to change its behaviour. I just want to be
    reminded why we did this.  I am guessing that it was because of
    an ancient design decision that we would use fnmatch without
    FNM_PATHNAME by default, i.e. it would be too disruptive if we
    made :(glob), i.e. honor directory boundaries, the default.

With :(glob) that follows FNM_PATHNAME behaviour, ":(glob)s*" would
be rejected as a match with "sub/file" or "sib/file", and that is
OK, but I think our ':(glob)??b/fi?e' example should find both of
these paths as matches to the pattern.

> +
> +	return WM_NOMATCH;
> +}
> +

And of course, if it is not PATHSPEC_GLOB, returning NOMATCH does
not sound like erring on the side to prevent false negatives.  For
example, what does

	git ls-files --recurse-submodule '??b/fi?e'

do in the above scenario with this patch?  Doesn't the if/else
cascade fall through and hit this return that says "Nah, 'sub'
cannot possibly match, do not bother descending into it"?

One thing I was originally confused about was that there are at
least three kinds we need to worry about.

 - PATHSPEC_LITERAL, where we no-wildcard-len should cover
   everything in the pattern string, e.g. "sub/file" may be the
   pattern that would want to produce a match when trying to see if
   we want to descend into "sub".

 - PATHSPEC_GLOB, as discussed above.

 - Not having either LITERAL or GLOB.  's*' would want to say that
   it is worth descending into "sub".  If there were another
   submodule at "sob/dir", that would match the pattern 's*' as
   well, because an asterisk can match 'ob/dir' part unlike in
   PATHSPEC_GLOB case.

Thanks.

