Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0093D20248
	for <e@80x24.org>; Tue, 26 Feb 2019 21:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfBZVBE (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 16:01:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:59108 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728673AbfBZVBE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 16:01:04 -0500
Received: (qmail 5954 invoked by uid 109); 26 Feb 2019 21:01:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Feb 2019 21:01:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32502 invoked by uid 111); 26 Feb 2019 21:01:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Feb 2019 16:01:18 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Feb 2019 16:01:01 -0500
Date:   Tue, 26 Feb 2019 16:01:01 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: Do test-path_is_{file,dir,exists} make sense anymore with -x?
Message-ID: <20190226210101.GA27914@sigill.intra.peff.net>
References: <pull.152.git.gitgitgadget@gmail.com>
 <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
 <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com>
 <87sgwav8cp.fsf@evledraar.gmail.com>
 <20190226170400.GC19739@szeder.dev>
 <20190226174316.GD19606@sigill.intra.peff.net>
 <20190226193912.GD19739@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190226193912.GD19739@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 08:39:12PM +0100, SZEDER Gábor wrote:

> > > I didn't find this to be an issue, but because of functions like
> > > 'test_seq' and 'test_must_fail' I've thought about suppressing '-x'
> > > output for test helpers (haven't actually done anything about it,
> > > though).
> > 
> > I'd be curious how you'd do that.
> 
> Well, I started replying with "Dunno" and explaining why I don't think
> that it can be done with 'test_must_fail'... but then got a bit of a
> lightbulb moment.  Now look at this:
> [...]
> +	{ set +x ; } 2>/dev/null 4>/dev/null

Ah, this is the magic. Doing:

  set +x 2>/dev/null

will still show it, but doing the redirection in a wrapping block means
that it is applied before the command inside the block is run. Clever.

I think this braces trick could be used in general to fix all of the
remaining "you can't run this under -x" cases, though it might be ugly.
It might also be possible to make test_eval_ a bit less subtle with it,
though I think it is relying on the braces already (which makes me
wonder if I just totally forgot about its existence today, or if I
earlier somehow stumbled onto a working recipe because I wanted to run
multiple redirected commands).

> There are a couple of tricky cases:
> 
>   - Some test helper functions call other test helper functions, and
>     in those cases tracing would be enabled upon returning from the
>     inner helper function.  This is not an issue with e.g.
>     'test_might_fail' or 'test_cmp_config', because the inner helper
>     function is the last command anyway.  However, there is
>     'test_must_be_empty', 'test_dir_is_empty', 'test_config',
>     'test_commit', etc. which call the other test helper functions
>     right at the start or in the middle.

Yeah, this is inherently a global flag that we're playing games with. It
does seem like it would be easy to get it wrong. I guess the right model
is considering it like a stack, like:

-- >8 --
#!/bin/sh

x_counter=0
pop_x() {
	ret=$?
	case "$x_counter" in
	0)
		echo >&2 "BUG: too many pops"
		exit 1
		;;
	1)
		x_counter=0
		set -x
		;;
	*)
		x_counter=$((x_counter - 1))
		;;
	esac
	{ return $ret; } 2>/dev/null
}

# you _must_ call this as "{ push_x; } 2>/dev/null" to avoid polluting
# trace output with the push call
push_x() {
	set +x 2>/dev/null
	x_counter=$((x_counter + 1))
}

bar() {
	{ push_x; } 2>/dev/null
	echo in bar
	pop_x
}

foo() {
	{ push_x; } 2>/dev/null
	echo in foo, before bar
	bar
	echo in foo, after bar
	false
	pop_x
}

set -x
foo
echo \$? is $?
-- 8< --

I wish there was a way to avoid having to do the block-and-redirect in
the push_x calls in each function, though.

I dunno. I do like the output, but this is rapidly getting complex.

>   - && chains in test helper functions; we must make sure that the
>     tracing is restored even in case of a failure.

Yeah, there is no "goto out" to help give a common exit point from the
function. You could probably do it with a wrapper, like:

  foo() {
	{ push_x; } 2>/dev/null
	real_foo "$@"
	pop_x
  }

and then real_foo() is free to return however it likes. I wonder if you
could even wrap that up in a helper:

  disable_function_tracing () {
	# rename foo() to orig_foo(); this works in bash, but I'm not
	# sure if there's a portable way to do it (and ideally one that
	# wouldn't involve an extra process).
	eval "real_$1 () $(declare -f $1 | tail -n +2)"

	# and then install a wrapper which pushes/pops tracing
	eval "$1 () { { push_x; } 2>/dev/null; real_$1 \"\$@\"; pop_x; }"
  }

  foo () { .... }
  disable_function_tracing foo

It would be easier if you could just declare the function body as an
argument (and then it would be "declare_untraceable_function", where you
do it all in one step). But then the function body has to be in single
quotes, which is a pain. I think this is definitely pushing the limits
of portable shell (and quite possibly the limits of good taste).

-Peff
