Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE36C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 23:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242786AbiBAXQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 18:16:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57505 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiBAXQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 18:16:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64678105E25;
        Tue,  1 Feb 2022 18:16:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oIAqW2xsqASZYFSmcvX+mKBN4ChGu6nAjh3K7H
        e1E84=; b=JHRmOItqcQFIOUgVw4O8nIaz3B/+edaF+mL5vOeEXHP7jyiuZHdAL4
        IvCq+o3x2oLkM8s8uKhBhgOKg3U0zi03Ngdr+u8c/nG8+U7qMRQdBKkOKd5izZy8
        +S7ZVYAG0KRbw8B77cVEQaqRyyjEVUAlXC+Y6DfThHkqCHd26+J6I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C368105E23;
        Tue,  1 Feb 2022 18:16:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82714105E22;
        Tue,  1 Feb 2022 18:16:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH V3 1/2] patch-id: Fix antipatterns in tests
References: <20220131232529.8484-1-jerry@skydio.com>
        <20220131235218.27392-1-jerry@skydio.com>
Date:   Tue, 01 Feb 2022 15:16:24 -0800
In-Reply-To: <20220131235218.27392-1-jerry@skydio.com> (Jerry Zhang's message
        of "Mon, 31 Jan 2022 15:52:18 -0800")
Message-ID: <xmqqy22u9nzr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA21778C-83B4-11EC-81AB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> Clean up the tests for patch-id by moving file preparation
> tasks inside the test body and redirecting files directly into
> stdin instead of using 'cat'.
>
> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> ---
> V2->V3:
> - Quote the EOF marker


Yes but no.

>  test_expect_success 'patch-id handles no-nl-at-eof markers' '
> -	cat nonl | calc_patch_id nonl &&
> -	cat withnl | calc_patch_id withnl &&
> +	cat >nonl <<-'EOF' &&

We started the "executable" part of the test_expect_success as a
single-quoted string, and then after writing <<-, we stepped out of
that single-quote pair.  Then we are writing E O F unquoted, and
stepped back into another single-quote pair here.  So, to the shell
that runs this executable part, it is exactly the same as

	cat >nonl <<-EOF &&

side note: if it were not in a plain shell script (not the
executable part that is passed as a single string to the
test_expect_success function as an argument), what we see above,
quoting EOF within a pair of single-quotes, is perfectly acceptable
thing to do.  But not here, for the reasons explained above.

> +	diff --git i/a w/a
> +	index e69de29..2e65efe 100644
> +	--- i/a
> +	+++ w/a
> +	@@ -0,0 +1 @@
> +	+a
> +	\ No newline at end of file
> +	diff --git i/b w/b
> +	index e69de29..6178079 100644
> +	--- i/b
> +	+++ w/b
> +	@@ -0,0 +1 @@
> +	+b
> +	'EOF'

Same here.  It is exactly the same as writing EOF without any quotes
around it, just like the opening one we saw earlier.

In other words, the above is not quoting at all.

I think I demonstrated the way we should write this in my earlier
review when I pointed out this exiting issue this step is fixing
(https://lore.kernel.org/git/xmqqmtjbh5fu.fsf@gitster.g/):

	test_expect_success "title string" '
		...
		command <<-\EOF &&
		here document indented by tab
		more document
		EOF
