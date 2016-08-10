Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B6F1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 20:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934363AbcHJUS0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 16:18:26 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44208 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934116AbcHJSZx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:25:53 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C8592018E;
	Wed, 10 Aug 2016 08:56:35 +0000 (UTC)
Date:	Wed, 10 Aug 2016 08:56:35 +0000
From:	Eric Wong <e@80x24.org>
To:	Brian Henderson <henderson.bj@gmail.com>
Cc:	git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/3] diff-highlight: add some tests.
Message-ID: <20160810085635.GA1672@starla>
References: <20160730151149.15980-1-henderson.bj@gmail.com>
 <20160730151149.15980-2-henderson.bj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160730151149.15980-2-henderson.bj@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Brian Henderson <henderson.bj@gmail.com> wrote:

Hi Brian,

A few minor portability/style nits below, but contrib/ probably
(still?) has laxer rules than the rest of git...

I think we still require Signed-off-by lines in contrib,
though...

> +++ b/contrib/diff-highlight/t/Makefile
> @@ -0,0 +1,19 @@
> +-include ../../../config.mak.autogen
> +-include ../../../config.mak
> +
> +T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
> +
> +all: test
> +test: $(T)
> +
> +.PHONY: help clean all test $(T)
> +
> +help:
> +	@echo 'Run "$(MAKE) test" to launch test scripts'
> +	@echo 'Run "$(MAKE) clean" to remove trash folders'
> +
> +$(T):
> +	@echo "*** $@ ***"; sh $@ $(GIT_TEST_OPTS)

Probably:

	@echo "*** $@ ***"; '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)

like we do in t/Makefile in case we need to override 'sh'.

> +
> +clean:
> +	$(RM) -r 'trash directory'.*
> diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> new file mode 100644
> index 0000000..ca7605f
> --- /dev/null
> +++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
> @@ -0,0 +1,63 @@
> +#!/bin/sh
> +#
> +# Copyright (C) 2016

IANAL, but I think your name (or who you represent) needs to be
in the copyright.

> +
> +test_description='Test diff-highlight'
> +
> +. ./test-diff-highlight.sh
> +. $TEST_DIRECTORY/test-lib.sh

TEST_DIRECTORY ought to be quoted since it could contain
shell-unfriendly chars (we intentionally name 'trash directory'
this way to trigger errors).

> +
> +# PERL is required, but assumed to be present, although not necessarily modern
> +# some tests require 5.8
> +
> +test_expect_success 'diff-highlight highlightes the beginning of a line' '

You can declare a prereq for PERL::

	test_expect_success PERL 'name' 'true'

And spelling: "highlights" (there's other instances of this, too)

> +  dh_test \
> +    "aaa\nbbb\nccc\n" \
> +    "aaa\n0bb\nccc\n" \
> +"

We use tabs for shell indentation.

<snip>

> diff --git a/contrib/diff-highlight/t/test-diff-highlight.sh b/contrib/diff-highlight/t/test-diff-highlight.sh
> new file mode 100644
> index 0000000..9b26271
> --- /dev/null
> +++ b/contrib/diff-highlight/t/test-diff-highlight.sh
> @@ -0,0 +1,69 @@
> +#!/bin/sh
> +#
> +# Copyright (C) 2016
> +
> +CURR_DIR=$(pwd)
> +TEST_OUTPUT_DIRECTORY=$(pwd)
> +TEST_DIRECTORY="$CURR_DIR"/../../../t
> +cmd=diff-highlight
> +CMD="$CURR_DIR"/../$cmd

Same comments as above on quoting pathnames and empty copyright.

> +
> +CW="\033[7m"
> +CR="\033[27m"
> +
> +export TEST_OUTPUT_DIRECTORY TEST_DIRECTORY CW CR
> +
> +dh_test() {
> +  dh_diff_test "$@"
> +  dh_commit_test "$@"
> +}
> +
> +dh_diff_test() {
> +  local a="$1" b="$2"

"local" is not a portable construct.  It's common for
Debian/Ubuntu systems to use dash as /bin/sh instead of bash;
(dash is faster, and mostly sticks to POSIX)

The "devscripts" package in Debian/Ubuntu-based systems has a
handy "checkbashisms" tool for checking portability of shell
scripts.

> +
> +  printf "$a" > file
> +  git add file
> +
> +  printf "$b" > file
> +
> +  git diff file > diff.raw

Commands should be '&&'-chained here since any of them could fail
("git add"/printf/etc could run out of space or fail on disk errors)

Also, our redirect style is:	command >file
without a space between '>' and destination.

See Documentation/CodingGuidelines for more details.
Unfortunately, the reasoning is not explained for '>NOSPACE'
and I'm not sure exactly why, either...

> +  if test "$#" = 3

Better to use -eq for numeric comparisons: test $# -eq 3
Quoting $# doesn't seem necessary unless your shell is
hopelessly buggy :)

> +  then
> +    # remove last newline
> +    head -n5 diff.raw | head -c -1 > diff.act

"head -c" isn't portable, fortunately Jeff hoisted it out for
use as test_copy_bytes in commit 48860819e8026
https://public-inbox.org/git/20160630090753.GA17463@sigill.intra.peff.net/

> +    printf "$3" >> diff.act
> +  else
> +    cat diff.raw > diff.act
> +  fi
> +
> +  < diff.raw $CMD > diff.exp

$CMD probably needs to be quoted.  However, by the time I got
here I had to ask myself:  What is $CMD again?
A: Oh, look up at the top!

*shrug*  My attention span is tiny and my fonts are gigantic.

Perhaps using:

	DIFF_HIGHLIGHT="$CURR_DIR"/../diff-highlight

Would be more-readable?

> +
> +  diff diff.exp diff.act

Maybe use test_cmp to avoid depending external diff.
(or "git diff -b --no-index" in your later test)

Same comments for the rest of the series, I think.

Typically, we expect a reroll in a few days, and I guess there's
no rush (so you can squash your comment patch in addressing
Junio's concern into 3/3).

Thanks.
