Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 264F51FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 01:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbdBNBUk (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 20:20:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:54679 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751580AbdBNBUk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 20:20:40 -0500
Received: (qmail 23422 invoked by uid 109); 14 Feb 2017 01:20:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 01:20:39 +0000
Received: (qmail 30709 invoked by uid 111); 14 Feb 2017 01:20:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 20:20:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2017 20:20:37 -0500
Date:   Mon, 13 Feb 2017 20:20:37 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH for NEXT] grep: do not unnecessarily query repo for "--"
Message-ID: <20170214012037.u2eg2n7mvteullcx@sigill.intra.peff.net>
References: <20170214001159.19079-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214001159.19079-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 04:11:59PM -0800, Jonathan Tan wrote:

> When running a command of the form
> 
>   git grep --no-index pattern -- path
> 
> in the absence of a Git repository, an error message will be printed:
> 
>   fatal: BUG: setup_git_env called without repository
> 
> This is because "git grep" tries to interpret "--" as a rev. "git grep"
> has always tried to first interpret "--" as a rev for at least a few
> years, but this issue was upgraded from a pessimization to a bug in
> commit 59332d1 ("Resurrect "git grep --no-index"", 2010-02-06), which
> calls get_sha1 regardless of whether --no-index was specified. This bug
> appeared to be benign until commit b1ef400 ("setup_git_env: avoid blind
> fall-back to ".git"", 2016-10-20) when Git was taught to die in this
> situation.  (This "git grep" bug appears to be one of the bugs that
> commit b1ef400 is meant to flush out.)
> 
> Therefore, always interpret "--" as signaling the end of options,
> instead of trying to interpret it as a rev first.

Nicely explained.

> There is probably a similar bug for commands of the form:
> 
>   git grep --no-index pattern foo
> 
> If there is a repo and "foo" is a rev, the "--no-index or --untracked
> cannot be used with revs." error would occur. If there is a repo and
> "foo" is not a rev, this command would proceed as usual. If there is no
> repo, the "setup_git_env called without repository" error would occur.
> (This is my understanding from reading the code - I haven't tested it
> out.)

Yes, it's easy to see that "git grep --no-index foo bar" outside of a
repo generates the same BUG. I suspect that "--no-index" should just
disable looking up revs entirely, even if we are actually in a
repository directory.

> This patch does not fix this similar bug, but I decided to send it out
> anyway because it still fixes a bug and unlocks the ability to
> specify paths with "git grep --no-index".

Yes, I think even if we fix the other bug, fixing this "--" thing is an
improvement.

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 2c727ef49..1b68d1638 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1154,6 +1154,11 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		const char *arg = argv[i];
>  		unsigned char sha1[20];
>  		struct object_context oc;
> +		if (!strcmp(arg, "--")) {
> +			i++;
> +			seen_dashdash = 1;
> +			break;
> +		}
>  		/* Is it a rev? */
>  		if (!get_sha1_with_context(arg, 0, sha1, &oc)) {
>  			struct object *object = parse_object_or_die(sha1, arg);

So I think this is a definite improvement, but I see a few leftover
oddities:

  - the end logic for this loop is now:

      if (arg is a rev) {
         ... handle rev ...
         continue;
      }
      break;

    It would probably be more obvious as:

      if (arg is not a rev)
          break;
      ... handle rev ...

  - the rev-handling code does:

      if (!seen_dashdash)
          verify_non_filename(prefix, arg);

    But I do not see how seen_dashdash could ever be untrue. We set it
    inside this loop, and break immediately when we see it. And indeed,
    running:

      echo content >master
      git grep content master --

    does not work. The "--" should tell us that "master" is a rev, but
    we don't know yet that we have a dashdash.

    I think we need a separate loop to find the "--" first, and _then_
    walk through the arguments, treating them as revs or paths as
    appropriate. This is how setup_revisions() does it.

    So this isn't a problem introduced by your patch, but it's
    intimately related.

> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 19f0108f8..29202f0e7 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -982,6 +982,18 @@ test_expect_success 'grep -e -- -- path' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'grep --no-index pattern -- path' '
> +	rm -fr non &&
> +	mkdir -p non/git &&
> +	(
> +		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
> +		export GIT_CEILING_DIRECTORIES &&
> +		cd non/git &&
> +		echo hello >hello &&
> +		git grep --no-index o -- .
> +	)
> +'

Since de95302a4, you can do:

  nongit git grep --no-index -o -- .

Though if this is destined for maint, it might need to be done
separately this way and cleaned up later.

It might also be a good idea to confirm that the pathspec is actually
being respected in the --no-index case. Something like:

  echo hello >hello &&
  echo goodbye >goodbye &&
  echo hello:hello >expect &&
  git grep --no-index o -- hello >actual &&
  test_cmp expect actual

-Peff
