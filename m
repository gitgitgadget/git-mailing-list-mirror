Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A25C433F5
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 06:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31DE760F14
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 06:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhKMGNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 01:13:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59697 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhKMGNU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 01:13:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6882EFDAD;
        Sat, 13 Nov 2021 01:10:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F4s9o0W99b1obw4KhpquOwiIH7nDBUEEAAJ9BV
        8fpic=; b=h+tC613SIh+r+K018uZ1SRkCgZ3M580jbYz7asBKqu2RtmPEeoMN5O
        bJnsqj/dopjyicuSSIeYRivfvbPh4lRs9pRiJa+S7DlBzS1cDkl4TpJB9kq6t6VN
        MftnQlidzmq3W3m8wxl9AWy6ER5NS9aD1dzZmKVNR9W0Npx+PKokY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD938EFDAB;
        Sat, 13 Nov 2021 01:10:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E101EFDA9;
        Sat, 13 Nov 2021 01:10:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH] lib-test: show failed prereq was Re: [PATCH]
 t/lib-git.sh: fix ACL-related permissions failure
References: <20211104192533.2520-1-adam@dinwoodie.org>
        <xmqq7ddn3dlt.fsf@gitster.g> <20211105112525.GA25887@dinwoodie.org>
        <YYUeKt0xQm/6QT+w@coredump.intra.peff.net>
        <xmqqk0hmxyw0.fsf@gitster.g>
        <CA+kUOa=vqFNXe2QKc8K31OLL0zkEsK7wAk6hPMxjQJNVM7PsGQ@mail.gmail.com>
        <xmqqv916wh7t.fsf@gitster.g> <20211112160101.xm7xi4474pgybrh4@fs>
Date:   Fri, 12 Nov 2021 22:10:26 -0800
In-Reply-To: <20211112160101.xm7xi4474pgybrh4@fs> (Fabian Stelzer's message of
        "Fri, 12 Nov 2021 17:01:01 +0100")
Message-ID: <xmqqk0hcmvql.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65696182-4448-11EC-A44D-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> As for the general prereq issue i ran into that as well during
> development. When you depend on other patches / a specific version of
> ssh-keygen for git I always have to remember to set the path correctly
> or the tests might silently be ignored by the missing prereq. Usually
> not a problem for single test runs, but when i run the full suite before
> sending something.

This will become a handy tool for everybody, not just for those on
minority and/or exotic platforms.  When someone prepares a plain
vanilla fresh box and build Git from the source for the first time
on the box, it is fairly easy to end up with a castrated version of
Git, without knowing what is missing.  This is especially so when
autoconf is used, but even without using autoconf, if you do not
have libsvn Perl modules, svn binary, or cvs binary installed, our
tests treat it as a signal that you are uninterested in SVN or CVS
interop tests, rather than flagging it as an error.  Being able to
see what is automatically skipped would be a good way to sanity
check what you actually have vs what you thought you had.  For
example, I just found out that I am still running CVS interop tests
in my installation.

> Subject: [RFC PATCH 1/2] test-lib: show failed prereq summary
>
> Add failed prereqs to the test results.
> Aggregate and then show them with the totals.
>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
>  t/aggregate-results.sh | 12 ++++++++++++
>  t/test-lib.sh          |  4 ++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/t/aggregate-results.sh b/t/aggregate-results.sh
> index 7913e206ed..ad531cc75d 100755
> --- a/t/aggregate-results.sh
> +++ b/t/aggregate-results.sh
> @@ -6,6 +6,7 @@ success=0
>  failed=0
>  broken=0
>  total=0
> +missing_prereq=
>  
>  while read file
>  do
> @@ -30,10 +31,21 @@ do
>  			broken=$(($broken + $value)) ;;
>  		total)
>  			total=$(($total + $value)) ;;
> +		missing_prereq)
> +			missing_prereq="$missing_prereq $value" ;;

It is unclear yet what shape $value has at this point (because we
haven't seen what is in test-lib.sh), but we accumulate them in the
$missing_prereq variable, separated by a space.  Also, I notice that
$missing_prereq will begin with a space when it is not empty, which
probably is not a big deal.

>  		esac
>  	done <"$file"
>  done
>  
> +if test -n "$missing_prereq"
> +then
> +	unique_missing_prereq=$(
> +		echo $missing_prereq | tr -s "," | \

You do not need backslash there; the line ends with '|' and shell
knows you haven't completed the pipeline yet, so it will go on to
read the next line.  The same for the next line; instead of adding
a backslash and breaking the line after it, just have the pipe there
and you can break the line safely without a backslash.

> +		sed -e 's/ //g' -e 's/^,//' -e 's/,$//' -e 's/,/\n/g' \
> +		| sort | uniq | paste -s -d ',')

I suspect you are making more work than necessary for yourself by
choosing to use SP when accumulating values in $missing_prereq
variable.  If you used comma instead, "tr -s ','" here will make a
neat sequence of tokens separated with one comma each, possibly with
one extra comma at the beginning and at the end if some $value were
empty.

Would something like this work better, I wonder?

	unique_missing_prereq=$(
                echo "$missing_prereq" |
                tr -s "," "\012" |
                grep -v "^$" |
                sort -u |
                paste -s -d ,
	)

> +	printf "\nmissing prereq: $unique_missing_prereq\n\n"

I think it is possible that a $missing_prereq that is not empty
still yields an empty $unique_missing_prereq.  If $value read from
the files all are empty strings, $missing_prereq will have many SP
(or comma if you take my earlier suggestion), but no actual prereq
will remain after the "unique" thing is computed.  I think this
printf should be shown only when $unique_missing_prereq is not
empty.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 2679a7596a..472387afec 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -669,6 +669,8 @@ test_fixed=0
>  test_broken=0
>  test_success=0
>  
> +test_missing_prereq=
> +
>  test_external_has_tap=0
>  
>  die () {
> @@ -1068,6 +1070,7 @@ test_skip () {
>  		then
>  			of_prereq=" of $test_prereq"
>  		fi
> +		test_missing_prereq="$missing_prereq,$test_missing_prereq"

OK.  We accumulate in $test_missing_prereq what is in missing_prereq
(assigned in test_have_prereq check).  I notice that over there, it
takes pains to make sure it uses only one comma between each token,
without excess leading or trailing comma, but we are not taking the
same care here.  It would be OK as we'd run "tr -s ," on the side
that reads the output, but looks somewhat sloppy.

>  		skipped_reason="missing $missing_prereq${of_prereq}"
>  	fi
>  
> @@ -1175,6 +1178,7 @@ test_done () {
>  		fixed $test_fixed
>  		broken $test_broken
>  		failed $test_failure
> +		missing_prereq $test_missing_prereq
>  
>  		EOF

And this part is quite obvious, after having read the consumer side
already.

Nicely done.

>  	fi
> -- 
> 2.31.1
>
> From d13d4c8ccbd832e1d62044b18b8b771f6586ee2a Mon Sep 17 00:00:00 2001
> From: Fabian Stelzer <fs@gigacodes.de>
> Date: Fri, 12 Nov 2021 16:43:18 +0100
> Subject: [RFC PATCH 2/2] test-lib: introduce required prereq for test runs
>
> Allows setting GIT_TEST_REQUIRE_PREREQ to a number of prereqs that must
> succeed for this run. Otherwise the test run will abort.

I am not quite sure what the sentence means, so let me read the code
first before commenting.

> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
>  t/test-lib-functions.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index eef2262a36..d65995cd15 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -669,6 +669,14 @@ test_have_prereq () {
>  			satisfied_this_prereq=t
>  			;;
>  		*)

At this point, we know $prerequisite we are looking at (note that
what is written as a guard for a particular test might be negated,
e.g. "test_expect_success !WINDOWS 'title' 'code'" that runs on
non-WINDOWS platforms, but here the negation has been stripped away,
so the test says "I require to be on non-Windows", but this new code
only knows that WINDOWS prereq has failed)

> +			if ! test -z $GIT_TEST_REQUIRE_PREREQ

Why not 

	if test -n "$GIT_TEST_REQUIRE_PREREQ"

?


> +			then
> +				case ",$GIT_TEST_REQUIRE_PREREQ," in
> +				*,$prerequisite,*)
> +					error "required prereq $prerequisite failed"
> +					;;

So GIT_TEST_REQUIRE_PREREQ could be set to a comma separated list of
prerequisites, e.g. WINDOWS,PDP11,CRAY, and we see if $prerequisite
we have just found out is missing is any one of them.  And abort the
test if that is true.  Makes sense, except for the negation.  You
want to be able to say GIT_TEST_REQUIRE_PREREQ=!WINDOWS,PERL to
require that you are not on Windows and have PERL, for example.

Perhaps this new block should be moved a bit further down in the
code, i.e.

|		total_prereq=$(($total_prereq + 1))
|		case "$satisfied_prereq" in
|		*" $prerequisite "*)
|			satisfied_this_prereq=t
|			;;
|		*)

... you are inserting the new code here, but don't do that yet, and ...

|			satisfied_this_prereq=
|		esac
|
|		case "$satisfied_this_prereq,$negative_prereq" in
|		t,|,t)
|			ok_prereq=$(($ok_prereq + 1))
|			;;
|		*)
|			# Keep a list of missing prerequisites; restore
|			# the negative marker if necessary.
|			prerequisite=${negative_prereq:+!}$prerequisite

... do it here instead?  We have restored the negation in prerequisite 
at this point, so we can say

			case ",$GIT_TEST_REQUIRE_PREREQ," in
			*,$prerequisite,*)
				error you do not have $prerequisite.
				;;
			esac

safely here, before we accumulate it into $missing_prereq variable.

|			if test -z "$missing_prereq"
|			then
|				missing_prereq=$prerequisite
|			else
|				missing_prereq="$prerequisite,$missing_prereq"
|			fi
|		esac

Thanks for working on this.
Looking good.
