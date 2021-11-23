Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D984FC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 22:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbhKWWfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 17:35:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61565 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhKWWfu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 17:35:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B01E15F0E8;
        Tue, 23 Nov 2021 17:32:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=juzu5sBtJZozxu7MbAskpuxc5QQDTmvepFm6yV
        q+DFk=; b=Xh5hwRhsQk4b2xD5Kxqvk1XvMk5j+4cAq4eM0I75nIhw6teiympxbo
        otJYG21yEYlWRNMb9X5ko05hWdLJY/HGLLFRurOMuEpv08h+40hwn4LhHbsT/szw
        ORRAx3F8c1z2V9sXEfobLshYzbSyFv1ypd4kvJhCpfvvI08PL6bv0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6301815F0E7;
        Tue, 23 Nov 2021 17:32:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C35C415F0E6;
        Tue, 23 Nov 2021 17:32:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, congdanhqx@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v4 1/1] ls-tree.c: support `--oid-only` option for
 "git-ls-tree"
References: <cover.1637642029.git.dyroneteng@gmail.com>
        <63876dbeb7f880c0001649b49d5265b744c42765.1637642029.git.dyroneteng@gmail.com>
Date:   Tue, 23 Nov 2021 14:32:35 -0800
In-Reply-To: <63876dbeb7f880c0001649b49d5265b744c42765.1637642029.git.dyroneteng@gmail.com>
        (Teng Long's message of "Tue, 23 Nov 2021 12:58:06 +0800")
Message-ID: <xmqqmtlu7bb0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 425E523E-4CAD-11EC-90F0-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> Sometimes, we only want to get the objects from output of `ls-tree`
> and commands like `sed` or `cut` is usually used to intercept the
> origin output to achieve this purpose in practice.

I can guess what "intercept the origin" wants to say, but it does
not roll off the tongue very well.

> This commit teach the "--oid-only" option to tell the command to
> only show the object name, just like "--name-only" option tells the
> command to only show the path component, for each entry. These two
> options are mutually exclusive.

cf. Documentation/SubmittingPatches[[imperative-mood]]

Perhaps like

    We usually pipe the output from `git ls-files` to tools like
    `sed` or `cut` when we only want to extract some fields.

    When we want only the pathname component, we can pass
    `--name-only` option to omit such a pipeline, but there are no
    options for extracting other fields.

    Teach the "--oid-only" option to the command to only show the
    object name.  This option cannot be used together with
    "--name-only" or "--long".

This does not work well with "--long", right?

> -'git ls-tree' [-d] [-r] [-t] [-l] [-z]
> -	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
> +'git ls-tree' [-d] [-r] [-t] [-l] [-z] [-n] [-s] [-o]

Where does the addition of -n/-s/-o fit in the theme of the patch?
This being a plumbing command, an existing option with long name
does not deserve a shorthand (and --oid-only should start with long
name only, too).

If we were to introduce -n as yet another synonym for --name-only
and --name-status (which we would not), the right way to spell it
in the synopsis section would be:

	[-n | --name-only | --name-status]
 
I would think, but this advise is only for your next topic.  We are
not going to add such a synonym.

> +	    [--name-only | --oid-only]
> +	    [--name-status | --oid-only]

This looks very iffy.  Has this been proof-read before sending out?

> +	    [--full-name] [--full-tree] [--abbrev[=<n>]]
>  	    <tree-ish> [<path>...]
>  
>  DESCRIPTION
> @@ -56,9 +58,19 @@ OPTIONS
>  	\0 line termination on output and do not quote filenames.
>  	See OUTPUT FORMAT below for more information.
>  
> +-n::
>  --name-only::
> ---name-status::
>  	List only filenames (instead of the "long" output), one per line.
> +	Cannot be combined with `--oid-only`.
> +
> +-s::
> +--name-status::
> +	Consistent behavior with `--name-only`.

Usually we say A is "Consistent" with B when A and B are different
but are moral equivalent in their respective contexts.  These are
identical, there is no difference.

Lose all of the above change, except for "Cannot be combined with".
The original is just fine.

> +-o::
> +--oid-only::
> +	List only names of the objects, one per line. Cannot be combined
> +	with `--name-only` or `--name-status`.

Or "--long"?  Does this work with it?

ALso, lose "-o".

> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 3a442631c7..0c2153a5ad 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -18,19 +18,26 @@ static int line_termination = '\n';
>  #define LS_RECURSIVE 1
>  #define LS_TREE_ONLY 2
>  #define LS_SHOW_TREES 4
> -#define LS_NAME_ONLY 8
> -#define LS_SHOW_SIZE 16
> +#define LS_SHOW_SIZE 8
>  static int abbrev;
>  static int ls_options;
>  static struct pathspec pathspec;
>  static int chomp_prefix;
>  static const char *ls_tree_prefix;
>  
> -static const  char * const ls_tree_usage[] = {
> +static const char * const ls_tree_usage[] = {
>  	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
>  	NULL
>  };
>  
> +enum {
> +	MODE_UNSPECIFIED = 0,
> +	MODE_NAME_ONLY,
> +	MODE_OID_ONLY
> +};

I suspect that "--long" would be part of this, if we were to go this
route.

OPT_CMDMODE() is a handy way to ensure "--name-only", "--oid-only",
and "--long" are not given together, but it may be overkill to make
only two or three options mutually exclusive.

In any case, once we pass the parsing part, the code should
translate the option into a bitmask that specifies which among
<mode>, <type>, <object-name>, <size>, and <filename> fields are
shown.  It will result in cleaner code in show_tree() if it uses
that set of fields to decide what is shown and how without looking
at the cmdmode enum.

