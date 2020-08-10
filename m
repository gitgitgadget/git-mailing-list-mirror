Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B66C433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 16:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A727520855
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 16:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i8xshplb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgHJQWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:22:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53350 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgHJQWa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 12:22:30 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B7ED3E9374;
        Mon, 10 Aug 2020 12:22:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9VhqnjlvvIJr3UMmNL9ZADVe2Bw=; b=i8xshp
        lb3W7Smc96dIE63aTbStyyUbCKZKWM6eJ8yBnk8l6MOrBpxL4LjsbuOE6G0lK3xI
        RJhW5sMgmsYwasZtguksG97YgFlA8OrNHc993j9d7f/pPwAxwnGL88AEa9seantF
        BLoBt2PkZJ7ryMfA8KlGzT7yvXPJJ/+nD8FAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=efsKl9eFADTsROytSA2H1U6Kc7G6bGHp
        xl+GXP3g3BJ3I1AHMPlxzuxmqZeTMqY0cuwq1wmD57ePPI6MVpXoPCmEnibS9fFy
        b6x79yKaHPD1bgrVKZfPxCnM/bUzSpvuDzr8beapLqXal1ihY+KNz45BweCRF1nD
        dlAi0dcm8vQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B1492E9373;
        Mon, 10 Aug 2020 12:22:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F3FD1E9372;
        Mon, 10 Aug 2020 12:22:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH] t4069: test diff behavior with i-t-a paths
References: <20200808075323.36041-1-ray@ameretat.dev>
        <20200810085343.43717-1-ray@ameretat.dev>
Date:   Mon, 10 Aug 2020 09:22:22 -0700
In-Reply-To: <20200810085343.43717-1-ray@ameretat.dev> (Raymond E. Pasco's
        message of "Mon, 10 Aug 2020 04:53:43 -0400")
Message-ID: <xmqqa6z2cvy9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC5B0D94-DB25-11EA-9547-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Raymond E. Pasco" <ray@ameretat.dev> writes:

> Add a small test suite to test the behavior of diff with intent-to-add
> paths. Specifically, the diff between an i-t-a entry and a file in the
> worktree should be a "new file" diff, and the diff between an i-t-a
> entry and no file in the worktree should be a "deleted file" diff.
> However, if --ita-visible-in-index is passed, the former should instead
> be a diff from the empty blob.
>
> Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
> ---
>  t/t4069-diff-intent-to-add.sh | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 t/t4069-diff-intent-to-add.sh

It indeed is that "add -N" appears only once in our test suite and
tests around it is lacking, but I'd prefer to see i-t-a to be taken
as just one of the normal things by not adding a special test for
it.  I wonder if there is a reason why these are not part of say
t4013 (diff-various)?

By adjusting and adding to existing test, we'd avoid a mistake of
adding a test script that is not executable (didn't your "make
DEVELOPER=1 test" catch the error?) ;-)

Thanks.


> diff --git a/t/t4069-diff-intent-to-add.sh b/t/t4069-diff-intent-to-add.sh
> new file mode 100644
> index 0000000000..85c1a35ca7
> --- /dev/null
> +++ b/t/t4069-diff-intent-to-add.sh
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +
> +test_description='behavior of diff with intent-to-add entries'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	test_write_lines 1 2 3 4 5 >blueprint
> +'
> +
> +test_expect_success 'diff between i-t-a and file should be new file' '
> +	cat blueprint >test-file &&
> +	git add -N test-file &&
> +	git diff >output &&
> +	grep "new file mode 100644" output
> +'
> +
> +test_expect_success 'diff between i-t-a and no file should be deletion' '
> +	rm -f test-file &&
> +	git diff >output &&
> +	grep "deleted file mode 100644" output
> +'
> +
> +test_expect_success '--ita-visible-in-index diff should be from empty blob' '
> +	cat blueprint >test-file &&
> +	git diff --ita-visible-in-index >output &&
> +	grep "index e69de29" output
> +'
> +
> +test_done
