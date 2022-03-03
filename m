Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26967C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiCCA0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiCCA0C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:26:02 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BAE2F02C
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:25:17 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8CD0E182BEB;
        Wed,  2 Mar 2022 19:25:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BUCVjyALU5NUbWNQ7gO0Hl9ildyXdAqykKzPOg
        TNOgo=; b=ZuU+1K6ngWErSpIkYRE8jr8dV0uMjc3FmUvLmqQHSA5qlrHvhRt6/k
        CG0Yny0guji3IEEvfHHs1tp/Ac+8uVmSODHT+2sRIMef5QCPmZN6HDrpAUkigIO5
        R1We2YLP9JZ3AfNHqgWjrV8i/7XpDU2vA9WjG3se1KsN70F70VY4g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84361182BEA;
        Wed,  2 Mar 2022 19:25:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B4873182BE9;
        Wed,  2 Mar 2022 19:25:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/7] fetch: increase test coverage of fetches
References: <cover.1645102965.git.ps@pks.im>
        <b4ca3f1f3baacde2aea7bae4f583f68c211a557a.1645102965.git.ps@pks.im>
Date:   Wed, 02 Mar 2022 16:25:13 -0800
In-Reply-To: <b4ca3f1f3baacde2aea7bae4f583f68c211a557a.1645102965.git.ps@pks.im>
        (Patrick Steinhardt's message of "Thu, 17 Feb 2022 14:04:16 +0100")
Message-ID: <xmqqwnhbevbq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 654F09EA-9A88-11EC-B384-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> +test_expect_success 'atomic fetch with failing backfill' '
> +	git init clone3 &&
> +
> +	# We want to test whether a failure when backfilling tags correctly
> +	# aborts the complete transaction when `--atomic` is passed: we should
> +	# neither create the branch nor should we create the tag when either
> +	# one of both fails to update correctly.
> +	#
> +	# To trigger failure we simply abort when backfilling a tag.
> +	write_script clone3/.git/hooks/reference-transaction <<-\EOF &&
> +		while read oldrev newrev reference
> +		do
> +			if test "$reference" = refs/tags/tag1
> +			then
> +				exit 1
> +			fi
> +		done
> +	EOF

Without the extra indentation level, all your <<here-doc would
become easier to read.  You are consistently doing this in your
patches, which it is better than random mixes of indentation style,
though.

> +	test_must_fail git -C clone3 fetch --atomic .. $B:refs/heads/something &&
> +
> +	# Creation of the tag has failed, so ideally refs/heads/something
> +	# should not exist. The fact that it does demonstrates that there is
> +	# a bug in the `--atomic` flag.
> +	test $B = "$(git -C clone3 rev-parse --verify refs/heads/something)"
> +'

Makes sense.

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

I think we see two transactions here, even though the comment says
otherwise.  Is this expecting a known breakage?

> +	write_script clone4/.git/hooks/reference-transaction <<-\EOF &&
> +		( echo "$*" && cat ) >>actual
> +	EOF
> +
> +	git -C clone4 fetch --atomic .. $B:refs/heads/something &&
> +	test_cmp expected clone4/actual

Nice way to make sure what is and is not in each transaction.  I
feels a bit too rigid (e.g. in the first transaction, there is no
inherent reason to expect that the update to head/something is
mentioned before the update to tags/tag2, for example).

> +'
> +
> +test_expect_success 'backfill failure causes command to fail' '
> +	git init clone5 &&
> +
> +	write_script clone5/.git/hooks/reference-transaction <<-EOF &&
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

I have been wondering if we need to do this from the hook?  If we
have this ref before we start "fetch", would it have the same
effect, or "fetch" notices that this interfering ref exists and
removes it to make room for storing refs/tags/tag1, making the whole
thing fail to fail?

> +				exit \$!

In any case, "exit 0" or "exit \$?" would be understandable, but
exit with "$!", which is ...?  The process ID of the most recent
background command?  Puzzled.

> +			fi
> +		done
> +	EOF
