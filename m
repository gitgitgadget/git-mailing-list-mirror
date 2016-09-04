Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B5C01F6BF
	for <e@80x24.org>; Sun,  4 Sep 2016 01:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbcIDBwQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 21:52:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:37531 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932256AbcIDBwN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 21:52:13 -0400
Received: (qmail 3129 invoked by uid 109); 4 Sep 2016 01:52:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Sep 2016 01:52:12 +0000
Received: (qmail 3541 invoked by uid 111); 4 Sep 2016 01:52:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Sep 2016 21:52:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Sep 2016 21:52:09 -0400
Date:   Sat, 3 Sep 2016 21:52:09 -0400
From:   Jeff King <peff@peff.net>
To:     Aaron M Watson <watsona4@gmail.com>
Cc:     git@vger.kernel.org, Jon Seymour <jon.seymour@gmail.com>,
        David Caldwell <david@porkrind.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] stash: allow ref of a stash by index
Message-ID: <20160904015209.ba6arov46ntr2ouq@sigill.intra.peff.net>
References: <1472944878.19860.4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1472944878.19860.4.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 03, 2016 at 07:21:18PM -0400, Aaron M Watson wrote:

> Allows stashes to be referenced by index only. Instead of referencing
> "stash@{n}" explicitly, it can simply be referenced as "n".

This says "what" but not "why". I assume it is "because the former is
more annoying to type".

Are there any backwards-compatibility issues you can think of?

I think that "123456" could be a sha1, but I do not see much point in
referencing a sha1 as the argument of "stash show". And it looks like
this code path is called only from is_stash_like(), so presumably the
same logic would apply to other callers.

So I can't immediately think of any downside to this.

> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 92df596..af11cff 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -35,11 +35,12 @@ A stash is by default listed as "WIP on
> 'branchname' ...", but
>  you can give a more descriptive message on the command line when
>  you create one.
>  
> -The latest stash you created is stored in `refs/stash`; older
> -stashes are found in the reflog of this reference and can be named using
> -the usual reflog syntax (e.g. `stash@{0}` is the most recently
> -created stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}`
> -is also possible).
> +The latest stash you created is stored in `refs/stash`; older stashes
> +are found in the reflog of this reference and can be named using the
> +usual reflog syntax (e.g. `stash@{0}` is the most recently created
> +stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}` is also
> +possible). Stashes may also be references by specifying just the stash
> +index (e.g. the integer `n` is equivalent to `stash@{n}`).

Yay, a documentation update. Should it be s/references/referenced/ in
the second-to-last line?

> diff --git a/git-stash.sh b/git-stash.sh
> index 826af18..a0c7f12 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash

I like that you were careful in thinking about bash versus other shells,
but this unfortunately isn't going to work. The #!-line here is just a
placeholder, and is replaced by the contents of $(SHELL_PATH) by the
Makefile.

But that's just the mechanical issue. The greater problem is that we
can't assume that bash is present at all. So we need to figure out a way
to avoid using bash-specific features in the rest of the patch.

> @@ -371,6 +371,14 @@ parse_flags_and_rev()
>  	test "$PARSE_CACHE" = "$*" && return 0 # optimisation
>  	PARSE_CACHE="$*"
>  
> +	args=()
> +	for arg
> +	do
> +		[[ $arg =~ ^[0-9]+$ ]] && arg="stash@{$arg}"
> +		args+=("$arg")
> +	done
> +	set -- "${args[@]}"
> +

So here we replace any pure-numeric arguments with stash@{}. I don't
think this is quite what we want, as it doesn't take into account where
in the parsing we are. When ALLOW_UNKNOWN_FLAGS is set, we might have
arbitrary options to pass to "git diff". So:

  git stash show -l 300 stash@{0}

would mistakenly re-write "300" (actually, I think that is already
broken because we feed the options to rev-parse which is similarly blind
about parsing).

Another one is perhaps:

  git stash show -- 300 ;# only show path "300" of the diff

which rev-parse _does_ handle correctly (although we then complain about
multiple revs, oblivious to the presence of the "--").

So I don't think this is technically a regression in any
currently-functioning behavior, but it seems like a step in the wrong
direction to add yet another layer of blind parsing.

I wonder if we could do better by making our $FLAGS loop a bit smarter,
and stopping at the first non-option (that unfortunately still gets "-l
300" wrong, but is the best we can do, I think). That option becomes
$REV, which we can then munge (as your patch does), and feed to "git
rev-parse --verify" (which it looks like we already do, though it seems
redundant with the earlier call).


> +	args=()
> +	for arg
> +	do
> +		[[ $arg =~ ^[0-9]+$ ]] && arg="stash@{$arg}"
> +		args+=("$arg")
> +	done
> +	set -- "${args[@]}"

Obviously all the array-handling is bash-specific, but that goes away if
we just munge the single $REV we find.

The "=~" is another bash-ism; it can be replaced with "expr".

> diff --git a/t/t3907-stash-index.sh b/t/t3907-stash-index.sh
> new file mode 100755
> index 0000000..72a1838
> --- /dev/null
> +++ b/t/t3907-stash-index.sh

Double yay, tests.

Do we really need a whole new script for this, though? There are already
"stash show" tests in t3903. We should be able to repeat one of them
using "2" instead of "stash@{2}" (for example).

-Peff

PS I think this is your first patch. Welcome to the git list. :)
