Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3883FC433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 23:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343630AbiAFXzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 18:55:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63273 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245710AbiAFXzK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 18:55:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 141F5109D4A;
        Thu,  6 Jan 2022 18:55:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VYyfXoVqE7IwLkNPphxgxrmeNYhgVDeAKXF5wE
        HV0zA=; b=Y8xhpps58T4+u2f4jbi5ZayDCk+pYck8DuhYwuT+12JM9oO+4dGWcE
        amL93UZNtddqHBEl1C7/l6WdLj77qut5s6iBQRg2f9h8e1OMQy3pzJ7CUHu7hfeU
        kCJapzfzOLST6X6Vt/boNFwFes5delPBg6T4yTZutnd/GKii5UeAA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A809109D49;
        Thu,  6 Jan 2022 18:55:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B75F109D48;
        Thu,  6 Jan 2022 18:55:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: [PATCH v3 1/4] test-lib: introduce API for verifying file mtime
References: <pull.1105.v2.git.1641388523.gitgitgadget@gmail.com>
        <pull.1105.v3.git.1641508499.gitgitgadget@gmail.com>
        <e6301e9d770bc7b6a2a3eeddcaf4e0123a0b23ab.1641508499.git.gitgitgadget@gmail.com>
Date:   Thu, 06 Jan 2022 15:55:08 -0800
In-Reply-To: <e6301e9d770bc7b6a2a3eeddcaf4e0123a0b23ab.1641508499.git.gitgitgadget@gmail.com>
        (Marc Strapetz via GitGitGadget's message of "Thu, 06 Jan 2022
        22:34:55 +0000")
Message-ID: <xmqqmtk8a083.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 148251F0-6F4C-11EC-9AC7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +# Set a fixed "magic" mtime to the given file,
> +# with an optional increment specified as second argument.
> +# Use in combination with test_is_magic_mtime.
> +test_set_magic_mtime () {
> +	# We are using 1234567890 because it's a common timestamp used in
> +	# various tests. It represents date 2009-02-13 which should be safe
> +	# to use as long as the filetime clock is reasonably accurate.

In the original context of "setting an ancient time, and detect
filesystem modification by noticing that the timestamp has or has
not changed", such an ancient timestamp "should be safe to use", but
if you expose it to more general audience, the context of their use
must be in line with your intended use to be safe.

	# Set mtime to mid February 2009, before we run an operation
	# that may or may not touch the file.  If the file was
	# touched, its timestamp will not accidentally have such an
	# old timestamp, as long as your filesystem clock is
	# reasonably correct.

perhaps?

> +	local inc=${2:-0} &&
> +	local mtime=$((1234567890 + $inc)) &&
> +	test-tool chmtime =$mtime $1 &&
> +	test_is_magic_mtime $1 $inc
> +}

Also as a helper function in the library that is (hopefully) useful
to many other callers, make sure you got your quoting correct.

There is no rule that you must use filenames without SP in it in
your tests, for example, so make sure "$1" above are quoted.  The
same applies to the next function.

> +# Test whether the given file has the "magic" mtime set,
> +# with an optional increment specified as second argument.
> +# Use in combination with test_set_magic_mtime.
> +test_is_magic_mtime () {
> +	local inc=${2:-0} &&
> +	local mtime=$((1234567890 + $inc)) &&
> +	echo $mtime >.git/test-mtime-expect &&
> +	test-tool chmtime --get $1 >.git/test-mtime-actual &&
> +	test_cmp .git/test-mtime-expect .git/test-mtime-actual
> +	local ret=$?
> +	rm .git/test-mtime-expect
> +	rm .git/test-mtime-actual

Use "rm -f" here?  Otherwise, if the main test failed somewhere
before it runs test_cmp, we'd see an error from an attempt to remove
a file that does not exist.

> +	return $ret
> +}

Other than that, quite nicely done (both these two functions and its
users).

Thanks.
