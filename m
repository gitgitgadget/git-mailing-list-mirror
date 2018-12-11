Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 299C720A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 11:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeLKLJo (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 06:09:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:38008 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726170AbeLKLJo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 06:09:44 -0500
Received: (qmail 15670 invoked by uid 109); 11 Dec 2018 11:09:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Dec 2018 11:09:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4111 invoked by uid 111); 11 Dec 2018 11:08:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Dec 2018 06:08:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2018 06:09:19 -0500
Date:   Tue, 11 Dec 2018 06:09:19 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/7] test-lib: parse some --options earlier
Message-ID: <20181211110919.GC8452@sigill.intra.peff.net>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181209225628.22216-1-szeder.dev@gmail.com>
 <20181209225628.22216-3-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181209225628.22216-3-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 09, 2018 at 11:56:23PM +0100, SZEDER Gábor wrote:

> 'test-lib.sh' looks for the presence of certain options like '--tee'
> and '--verbose-log', so it can execute the test script again to save
> its standard output and error.  This happens way before the actual
> option parsing loop, and the condition looking for these options looks
> a bit odd, too.  This patch series will add two more options to look
> out for, and, in addition, will have to extract these options' stuck
> arguments (i.e. '--opt=arg') as well.
> 
> Add a proper option parsing loop to check these select options early
> in 'test-lib.sh', making this early option checking more readable and
> keeping those later changes in this series simpler.  Use a 'for opt in
> "$@"' loop to iterate over the options to preserve "$@" intact, so
> options like '--verbose-log' can execute the test script again with
> all the original options.
> 
> As an alternative, we could parse all options early, but there are
> options that do require an _unstuck_ argument, which is tricky to
> handle properly in such a for loop, and the resulting complexity is,
> in my opinion, worse than having this extra, partial option parsing
> loop.

In general, I'm not wild about having multiple option-parsing loops that
skip the normal left-to-right parsing, since it introduces funny corner
cases (like "-foo --bar" which should be the same as "--foo=--bar"
instead thinking that "--bar" was passed as an option).

But looking at what this is replacing:

> -case "$GIT_TEST_TEE_STARTED, $* " in
> -done,*)
> -	# do not redirect again
> -	;;
> -*' --tee '*|*' --va'*|*' -V '*|*' --verbose-log '*)

your version is easily an order of magnitude less horrible. ;)

>  t/test-lib.sh | 53 +++++++++++++++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 21 deletions(-)

This looks good to me overall, though...

> +# Parse some options early, taking care to leave $@ intact.
> +for opt
> +do
> +	case "$opt" in
> +	--tee)
> +		tee=t ;;
> +	-V|--verbose-log)
> +		verbose_log=t ;;
> +	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
> +		valgrind=memcheck ;;
> +	--valgrind=*)
> +		valgrind=${opt#--*=} ;;
> +	--valgrind-only=*)
> +		valgrind_only=${opt#--*=} ;;
> +	*)
> +		# Other options will be handled later.
> +	esac
> +done
> [...]
> +elif test -n "$tee" || test -n "$verbose_log" ||
> +     test -n "$valgrind" || test -n "$valgrind_only"

Now that we've nicely moved the parsing up, would it make sense to put
the annotation for "this option implies --tee" with those options?

I.e., set tee=t when we see --verbose-log, which keeps all of the
verbose-log logic together?

> @@ -336,9 +344,12 @@ do
>  			echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
>  		fi
>  		shift ;;
> -	-V|--verbose-log)
> -		verbose_log=t
> -		shift ;;
> +	--tee|\
> +	-V|--verbose-log|\
> +	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind|\
> +	--valgrind=*|\
> +	--valgrind-only=*)
> +		shift ;; # These options were handled already.
>  	*)

It's too bad there's not an easy way to selectively remove from the $@
array (which would avoid duplicating this list here).

The best I could come up with is:

-- >8 --
first=t
for i in "$@"; do
	test -n "$first" && set --
	first=

	case "$i" in
	--foo)
		echo "saw foo" ;;
	*)
		set -- "$@" "$i" ;;
	esac
done

for i in "$@"; do
	echo "remainder: $i"
done
-- 8< --

but I won't be surprised if there are portability problems with
assigning $@ in the middle of a loop that iterates over it.

-Peff
