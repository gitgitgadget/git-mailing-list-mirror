Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254CCC433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 20:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242835AbiBQUlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 15:41:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiBQUlw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 15:41:52 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A496225C3
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 12:41:36 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B1C61105F0;
        Thu, 17 Feb 2022 15:41:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7n0gjXFu9c0HMCspqpMBrn0RKuhnHNLVxqO4HM
        9Vh+s=; b=F72Bg/DWK3S9HzkbPpat+iU2FpjeQ9LkaFpM4mtJTIw+V8+4iSQiZw
        1tbkyG2yp5ayNROPCi++SUn+S4NiyYGO7vh+ocytth5t3eMNddRMZKAmbIycfdWb
        NPwCzXbXvevsJoCknHkbrl38oAedbbNwQr4RE825P81JF/h6k80xE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 422BF1105EF;
        Thu, 17 Feb 2022 15:41:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 954681105ED;
        Thu, 17 Feb 2022 15:41:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/7] fetch: increase test coverage of fetches
References: <cover.1645102965.git.ps@pks.im>
        <b4ca3f1f3baacde2aea7bae4f583f68c211a557a.1645102965.git.ps@pks.im>
Date:   Thu, 17 Feb 2022 12:41:33 -0800
In-Reply-To: <b4ca3f1f3baacde2aea7bae4f583f68c211a557a.1645102965.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 17 Feb 2022 14:04:16 +0100")
Message-ID: <xmqqczjl8buq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FEEBD238-9031-11EC-B653-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> When using git-fetch(1) with the `--atomic` flag the expectation is that
> either all of the references are updated, or alternatively none are in
> case the fetch fails. While we already have tests for this, we do not
> have any tests which exercise atomicity either when pruning deleted refs
> or when backfilling tags. This gap in test coverage hides that we indeed
> don't handle atomicity correctly for both of these cases.
>
> Add test cases which cover these testing gaps to demonstrate the broken
> behaviour. Note that tests are not marked as `test_expect_failure`: this
> is done to explicitly demonstrate the current known-wrong behaviour, and
> they will be fixed up as soon as we fix the underlying bugs.
>
> While at it this commit also adds another test case which demonstrates
> that backfilling of tags does not return an error code in case the
> backfill fails. This bug will also be fixed by a subsequent commit.

No need to reorganize the series just to fix this, but in general,
adding new tests that are designed to fail in an early commit and
then give fixes in a separate commit is to be avoided for two
reasons.

One is obviously that it breaks bisectability.  And another is that
it makes it unclear what the end-user visible problem was when
reading the actual fix, and makes reviewing the series harder.

If a test that demonstrates an existing bug comes with the code to
fix the bug in the same commit, it obviously will not break
bisectability, and the new test serves also as a documentation of
what the end-user visible symptoms of the bug being fixed are.

Sometimes people work around the bisectability issue by starting
these tests that demonstrates known-to-be-unfixed-yet bugs with
test_expect_failure, but that is not a good solution for the
reviewability issue, as the step that fixes the bug will show the
code fix plus only the first few lines of the test being changed
to expect success and it is not readily visible what the symptom
actually were.

A series of patches, each one of which fixes one issue and
demonstrates the issue with tests that expects success when the
issue is resolved, is much more pleasant to read than a series where
it has tests for multiple issues, followed by a patch or two to
handle each issue.

And in such a series, it is much easier to see what breaks if the
fix weren't there.  Reviewers can apply one step of the patch and
tentatively revert everything outside t/ to see how the added test
breaks without the fix.  It helps those who may want to cherry-pick
a particular fix, together with its associated test, if a series is
done that way.

Thanks.

> +test_expect_success 'atomic fetch with failing backfill' '
> +	git init clone3 &&
> +
> +	# We want to test whether a failure when backfilling tags correctly
> +	# aborts the complete transaction when `--atomic` is passed: we should
> +	# neither create the branch nor should we create the tag when either
> +	# one of both fails to update correctly.
> +	#
> +	# To trigger failure we simply abort when backfilling a tag.

What does this paragraph want the phrase `backfilling tags` to mean?
Just from end-user's perspective, there is only one (i.e. if an
object that is tagged gets fetched and that tag is not here, fetch
it too), but at the mechanism level, there are two distinct code
paths (i.e. if OPT_FOLLOWTAGS gets the job done, there is no need to
call backfill_tags()).  Which failure does this talk about, or it
does not matter which code path gave us the tag?

> +	write_script clone3/.git/hooks/reference-transaction <<-\EOF &&
> +		while read oldrev newrev reference
> +		do
> +			if test "$reference" = refs/tags/tag1
> +			then
> +				exit 1
> +			fi
> +		done
> +	EOF
> +
> +	test_must_fail git -C clone3 fetch --atomic .. $B:refs/heads/something &&
> +
> +	# Creation of the tag has failed, so ideally refs/heads/something
> +	# should not exist. The fact that it does demonstrates that there is
> +	# a bug in the `--atomic` flag.
> +	test $B = "$(git -C clone3 rev-parse --verify refs/heads/something)"
> +'
> +
> +test_expect_success 'atomic fetch with backfill should use single transaction' '
> +	git init clone4 &&
> +
> +	# Fetching with the `--atomic` flag should update all references in a
> +	# single transaction, including backfilled tags. We thus expect to see
> +	# a single reference transaction for the created branch and tags.
> +	cat >expected <<-EOF &&
> +		prepared
> +		$ZERO_OID $B refs/heads/something
> +		$ZERO_OID $S refs/tags/tag2
> +		committed
> +		$ZERO_OID $B refs/heads/something
> +		$ZERO_OID $S refs/tags/tag2
> +		prepared
> +		$ZERO_OID $T refs/tags/tag1
> +		committed
> +		$ZERO_OID $T refs/tags/tag1
> +	EOF
> +
> +	write_script clone4/.git/hooks/reference-transaction <<-\EOF &&
> +		( echo "$*" && cat ) >>actual
> +	EOF

Nicely done.

> +
> +	git -C clone4 fetch --atomic .. $B:refs/heads/something &&
> +	test_cmp expected clone4/actual
> +'
> +
> +test_expect_success 'backfill failure causes command to fail' '
> +	git init clone5 &&
> +
> +	write_script clone5/.git/hooks/reference-transaction <<-EOF &&

Is there a reason why we cannot do <<-\EOF here to lose the
backslashes in the here-text?

> +		while read oldrev newrev reference
> +		do
> +			if test "\$reference" = refs/tags/tag1
> +			then
> +				# Create a nested tag below the actual tag we
> +				# wanted to write, which causes a D/F conflict
> +				# later when we want to commit refs/tags/tag1.
> +				# We cannot just `exit 1` here given that this
> +				# would cause us to die immediately.
> +				git update-ref refs/tags/tag1/nested $B

Wow, nasty ;-)

> +				exit \$!
> +			fi
> +		done
> +	EOF
> +
> +	# Even though we fail to create refs/tags/tag1 the below command
> +	# unexpectedly succeeds.
> +	git -C clone5 fetch .. $B:refs/heads/something &&
> +	test $B = $(git -C clone5 rev-parse --verify refs/heads/something) &&
> +	test $S = $(git -C clone5 rev-parse --verify tag2) &&
> +	test_must_fail git -C clone5 rev-parse --verify tag1
> +'
> +
>  test_done

