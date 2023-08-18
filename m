Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FADEE4992
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 21:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240471AbjHRVPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 17:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240380AbjHRVPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 17:15:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C294214
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 14:15:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 094F51F1EB;
        Fri, 18 Aug 2023 17:15:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QfiQ7KRb7C5dqozfzP4MS2ivIqJI61yKiXrvEd
        hVZXM=; b=bQsmD8Fzo4MsU+syxeQ8zxeMdwrCQv0tswu6v5fDqJGXVZb+fwmx16
        jX6hTs3YQ6mHVSyfpIzlLOZvmgqmUaAedNaHm5O+mFXxdOqQ/5bvg+niK2B3JwjX
        kQZf/6MF7cfBeWhkXY2H4fx79RqkYkNjlcfkNthl83/d0fhEPh8JM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 019361F1EA;
        Fri, 18 Aug 2023 17:15:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 604611F1E8;
        Fri, 18 Aug 2023 17:15:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/5] diff: mode-only change should be noticed by
 "--patch -w --exit-code"
References: <xmqqttsxbfyw.fsf@gitster.g>
        <20230817222949.3835424-1-gitster@pobox.com>
        <20230817222949.3835424-4-gitster@pobox.com>
Date:   Fri, 18 Aug 2023 14:15:00 -0700
In-Reply-To: <20230817222949.3835424-4-gitster@pobox.com> (Junio C. Hamano's
        message of "Thu, 17 Aug 2023 15:29:47 -0700")
Message-ID: <xmqq4jkwuk6j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B032426-3E0C-11EE-A22D-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index f3e20dd5bb..943ad252d4 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -11,6 +11,39 @@ TEST_PASSES_SANITIZE_LEAK=true
> + ...
> +	test_expect_success "status with $opts (mode differs)" '
> +		test_when_finished "git update-index --chmod=-x x" &&
> +		echo foo >x &&
> +		git add x &&
> +		git update-index --chmod=+x x &&
> +		test_expect_code 1 git diff -w $opts --exit-code x
> +	'

Apparently this one needs to skipped on a filesystem without
support for the executable bit.

cf. https://github.com/git/git/actions/runs/5897310248/job/15996914969#step:5:218

I'll give POSIXPERM prerequisite to this test piece.
