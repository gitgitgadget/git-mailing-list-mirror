Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 430081F454
	for <e@80x24.org>; Fri,  8 Nov 2019 04:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfKHEti (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 23:49:38 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64116 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfKHEth (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 23:49:37 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 832699BCA6;
        Thu,  7 Nov 2019 23:49:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rFULOufa2KL/Z3Xwtj7ywbMcNac=; b=jiBsGU
        9s35Kmf4n+d3sSph66EaJJcK7JlfinOOquQUDSg/Ox4tv+ZwPFE85Q+FojeyvL80
        /b8BI6hM2Er+gWW+XI2c4fBV3/WiCcPr/ppm4YNtpVgFAY2W5YluA9Aqf4TFiBdb
        yZCRzgMMbujo71EmKOgSb5LgGnA/14U03bufg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AvHPfa4L2EIg2EuLP6YrDzSB0lSORNRE
        ACTze9UPfGMEao3mtOsyef/iO8C00EiDRB6XK6ToX2scA6jxd0vBS6Sl9oH6eJLY
        k7CrPrWFhuu54qEbX72SvckngmseBmONGTA/lYSZ8xKVYpmHWAOjJw+GyTJL/FZX
        gCxR52sjJqo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E8B09BCA5;
        Thu,  7 Nov 2019 23:49:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8D8D69BCA4;
        Thu,  7 Nov 2019 23:49:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 1/9] Start to implement a built-in version of `git add --interactive`
References: <pull.170.v4.git.gitgitgadget@gmail.com>
        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
        <ff59d2d0b3b8b591a806ef71b4bcfd350000b06e.1572869729.git.gitgitgadget@gmail.com>
Date:   Fri, 08 Nov 2019 13:49:26 +0900
In-Reply-To: <ff59d2d0b3b8b591a806ef71b4bcfd350000b06e.1572869729.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 04 Nov 2019
        12:15:21 +0000")
Message-ID: <xmqqh83fnfah.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25767776-01E3-11EA-94FE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This is hardly the first conversion of a Git command that is implemented
> as a script to a built-in. So far, the most successful strategy for such
> conversions has been to add a built-in helper and call that for more and
> more functionality from the script, as more and more parts are
> converted.
>
> With the interactive add, we choose a different strategy....

This is hardly the first conversion that we took the "build the
whole program piece by piece and flip the whole thing on with
usebuiltin" conversion successfully.  Pratik's rebase-in-c series
comes to mind.

Personally, I do not think the first two paragraphs of the proposed
log message do not belong here.  Cover letter is a different story
and it may make sense to explain why the approach was taken there,
but here, I'd prefer to see it more succinctly tell what approach is
taken and go directly to describe what this step in that approach
does to the readers, which is more important.

> diff --git a/Documentation/config/add.txt b/Documentation/config/add.txt
>  	variables.
> +
> +add.interactive.useBuiltin::
> +	[EXPERIMENTAL] Set to `true` to use the experimental built-in
> +	implementation of the interactive version of linkgit:git-add[1]
> +	instead of the Perl script version. Is `false` by default.

Good.

> diff --git a/Makefile b/Makefile
> index 58b92af54b..6c4a1e0ee5 100644
> --- a/Makefile
> +++ b/Makefile
>  LIB_OBJS += abspath.o
> +LIB_OBJS += add-interactive.o
>  LIB_OBJS += advice.o
>  LIB_OBJS += alias.o
>  LIB_OBJS += alloc.o

OK.

> diff --git a/add-interactive.c b/add-interactive.c
> new file mode 100644
> index 0000000000..482e458dc6
> --- /dev/null
> +++ b/add-interactive.c
> @@ -0,0 +1,7 @@
> +#include "cache.h"
> +#include "add-interactive.h"
> +
> +int run_add_i(struct repository *r, const struct pathspec *ps)
> +{
> +	die(_("No commands are available in the built-in `git add -i` yet!"));
> +}

OK, with or without s/commands/sub&/;

> diff --git a/add-interactive.h b/add-interactive.h
> new file mode 100644
> index 0000000000..7043b8741d
> --- /dev/null
> +++ b/add-interactive.h

OK.

> diff --git a/builtin/add.c b/builtin/add.c
> index dd18e5c9b6..4f625691b5 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -20,6 +20,7 @@
>  #include "bulk-checkin.h"
>  #include "argv-array.h"
>  #include "submodule.h"
> +#include "add-interactive.h"
>  
>  static const char * const builtin_add_usage[] = {
>  	N_("git add [<options>] [--] <pathspec>..."),
> @@ -185,6 +186,14 @@ int run_add_interactive(const char *revision, const char *patch_mode,
>  {
>  	int status, i;
>  	struct argv_array argv = ARGV_ARRAY_INIT;
> +	int use_builtin_add_i =
> +		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);

Have blank here at the boundary between decl and stmt ...

> +	if (use_builtin_add_i < 0)
> +		git_config_get_bool("add.interactive.usebuiltin",
> +				    &use_builtin_add_i);
> +

... and lose it here (optional).

> +	if (use_builtin_add_i == 1 && !patch_mode)
> +		return !!run_add_i(the_repository, pathspec);
>  

Strictly speaking, we can bypass the probing of environment and
config when upon the entry of the function, where patch_mode is
already known.  I do not know offhand if rearranging the code to
take advantage of that fact would result in a flow that is also
easier to follow, but I suspect it would.

> +GIT_TEST_ADD_I_USE_BUILTIN=<boolean>, when true, enables the
> +built-in version of git add -i. See 'add.interactive.useBuiltin' in
> +git-config(1).

Makes sense.

Thanks.
