Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8E3E1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 18:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755081AbcHSSK7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 14:10:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60042 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754593AbcHSSK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 14:10:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B24F53445E;
        Fri, 19 Aug 2016 14:10:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bD4DLrhguFLOl9M/kDftG1QsDB0=; b=GiU4HQ
        O2RAYEm1Kqsw9QY5xLnzBZmXc3EExwui7II+5/ou7gombJcng0c+IlSS0iY/WxHi
        anYwmJXI2H5Cm9eGOstJvEULLAHsPCf18VKk0gdHjOrU0cOh4DVSwQ8PuKkcUv85
        lX23ES/3CxszlfVp6m2UT1BJP2E/r5WQrTR+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TjV9S+N+HB6v3ZYuj2C+7wlng1VSk/LB
        RcC9HkOTAor0k5et9OVKGXxcD200CJvCuuRBnxcGY8iYl2l8Auk7JCdKDjzrsdDj
        AMsmvGtHaxh6eRRInwB14To36QuA0j9evYGPCAX7/hr0sEH8wyRe4G7BEEA8rFAM
        fzir53HdTss=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA84F3445D;
        Fri, 19 Aug 2016 14:10:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 303433445C;
        Fri, 19 Aug 2016 14:10:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brian Henderson <henderson.bj@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, e@80x24.org
Subject: Re: [PATCH v3 1/3] diff-highlight: add some tests.
References: <20160819170812.1676-1-henderson.bj@gmail.com>
        <20160819145123.73hf7ffysy53l3kz@sigill.intra.peff.net>
        <20160819170812.1676-2-henderson.bj@gmail.com>
Date:   Fri, 19 Aug 2016 11:10:55 -0700
In-Reply-To: <20160819170812.1676-2-henderson.bj@gmail.com> (Brian Henderson's
        message of "Fri, 19 Aug 2016 10:08:10 -0700")
Message-ID: <xmqqh9ag39zk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46B8D770-6638-11E6-A857-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> +# dh_test is a test helper function which takes 1) some file data, 2) some
> +# change of the file data, creates a diff and commit of the changes and passes
> +# that through diff-highlight. The optional 3rd parameter is the expected
> +# output of diff-highlight minus the diff/commit header. Don't include a 3rd
> +# parameter if diff-highlight is stupposed to leave the input unmodified.

Good explanation, but it fails to say one crucial thing.  The third
parameter is directly fed to printf and not to "printf '%s' $3",
hence any '%' you expect to see in diff output need to be doubled to
protect it.

> +# see dh_test for usage
> +dh_diff_test () {
> +	a="$1" b="$2"
> +
> +	printf "$a" >file
> +	git add file
> +
> +	printf "$b" >file
> +	git diff file >diff.raw
> +
> +	if test $# -ge 3
> +	then
> +		# Add the diff header to the expected file
> +		# we remove the trailing newline to make the test a little more readable
> +		# this means $3 should start with a newline
> +		head -n5 diff.raw | test_chomp_eof >diff.exp
> +		printf "$3" >>diff.exp
> +	else
> +		cat diff.raw >diff.exp
> +	fi

Sorry, but I do not understand why you hardcode -n5 or why you need
chomp-eof.

I _think_ you are expecting "git diff file" to start with

    diff --git a/file b/file
    index fffffff..fffffff 100644
    --- a/file
    +++ b/file
    @@ -l,k +m,n @@ comments

and want to grab everything before and including this first hunk
header.  A more future-proof way to do the "stop at the first
occurrence of this" (this comment applies to -n11 we see below) is

	sed -e '/^@@/q' diff.raw

As to chomp-eof, I still do not see the point, especially with the
new comment you added: "this means $3 should start with newline".

You are forcing the caller to have an extra empty line at the
beginnig ONLY because you do this "chomp" thing.  Otherwise the
callers do not need to.

Unless you actually mean something else by the new comment, e.g. "I
think the callers look prettier if it begins with a newline, so we
compensate for that by removing the end of line from what comes
before it", that is.  If "this means $3 should" is what it sounds
like, i.e. imposing an unnatural constraint on the callers of this
helper function, then the helper can do this

	printf "\n$3" >>diff.exp

so that the callers do not have to worry about it.

If "I think the caller looks prettier if it begins with a newline"
is the true motivation, then "this means $3 should start..." needs
to be rephrased.  And as to the implementation of the helper, I
think

	{
		sed -e '/^@@/q' diff.raw
		printf "$3" | sed -e 1d
	} >diff.expected

may be easier to see what is going on.

> +
> +	"$DIFF_HIGHLIGHT" <diff.raw >diff.act &&

> +	# check that at least one of the files is not empty (any of the above
> +	# commands could have failed resulting in an empty file)
> +	test -s diff.act &&

A more established way in our test suite to ensure that "any of the
above commands could have failed" is caught is to &&-chain all the
commands, like this:

	a=$1 b=$2 &&
	printf "$a" >file && git add file &&
        printf "$b" >file && git diff file >diff.raw &&
        if test $# = 3
        then
        	...
	else
        	...
	fi &&

> +test_done
> +
> +# vim: set noet

We tend to avoid cluttering the source with editor specific insns
like this.

Stepping back a bit.  Because you are only interested in making sure
the body of the diff match what is expected, it may be a better
alternative approach to make the comparison _after_ stripping the
headers from the actual output with the expected (which you do not
have headers for), rather than comparing the expected (with fake
headers added in as necessary) and the actual output with headers,
i.e.

	git diff file >diff.raw &&
	if test $# = 3
	then
		printf "$3"
	else
	        sed -e '1,/^@@/d' <diff.raw
	fi >diff.expected &&
	"$DIFF_HIGHLIGHT" <diff.raw >diff.highlight &&
	sed -e '1,/^@@/d' <diff.highlight >diff.actual &&
	test_cmp diff.expected diff.actual

or something like that.

That does not address "is it a good idea to require an empty line at
the beginning of $3"? at all, though.  If you want to require a
blank in front of "$3", the "printf" needs to be tweaked to somehow
strip it.
