Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784F3C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 23:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbiAaXFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 18:05:30 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55483 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiAaXF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 18:05:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BDEDA165E35;
        Mon, 31 Jan 2022 18:05:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l0RC9Jf/3vJWW/V+eS4fdPCWuxO1YUukWu8NmX
        +/zBI=; b=YEcmJRqCtnnOj7Zz5n2e7MNS5fnlRktpRYve40O2U5fNibi9yOdemU
        oiDGqLehvjv7QtW0SaA38rHU5NdVkWL89BN/KyRkyEl1EBE83lST8PKYSXQDzqH0
        5RzHHoR5LmAhcG4wQmTPB+1eU/JQFSCI6p5XPGqkgcb7fBf6ao+WU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B6B6E165E34;
        Mon, 31 Jan 2022 18:05:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 26C5C165E33;
        Mon, 31 Jan 2022 18:05:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH V2] patch-id: fix scan_hunk_header on diffs with 1 line
 of before/after
References: <20220125221602.26557-1-jerry@skydio.com>
        <20220129024757.24763-1-jerry@skydio.com>
Date:   Mon, 31 Jan 2022 15:05:25 -0800
In-Reply-To: <20220129024757.24763-1-jerry@skydio.com> (Jerry Zhang's message
        of "Fri, 28 Jan 2022 18:47:57 -0800")
Message-ID: <xmqqmtjbh5fu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 474BAB52-82EA-11EC-ADFD-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
> index 80f4a65b28..34a386aee2 100755
> --- a/t/t4204-patch-id.sh
> +++ b/t/t4204-patch-id.sh
> @@ -200,6 +200,36 @@ EOF
>  test_expect_success 'patch-id handles no-nl-at-eof markers' '
>  	cat nonl | calc_patch_id nonl &&
>  	cat withnl | calc_patch_id withnl &&
>  	test_cmp patch-id_nonl patch-id_withnl
>  '

This is not a new issue, but this old test script needs updating.
And worse yet, your new test copies the existing badness and make it
twice as bad.

We frown upon doing anything outside test_expect_* blocks these
days, so the commands to prepare nonl and withnl files before thie
precontext of this patch needs to be folded into the test body.

Also, sending a single file using "cat" into pipeline is an
antipattern.  Just redirect into the downstream command instead,
i.e.

	test_expect_success 'patch-id handles no-nl-at-eof markers' '
		cat >nonl <<-\EOF &&
                diff --git i/a w/a
                index e69de29..2e65efe 100644
                --- i/a
                +++ w/a
                @@ -0,0 +1 @@
                +a
                \ No newline at end of file
                diff --git i/b w/b
                index e69de29..6178079 100644
                --- i/b
                +++ w/b
                @@ -0,0 +1 @@
                +b
                EOF
		cat >withnl <<-\EOF &&
		... likewise ...
		EOF
		calc_patch_id nonl <nonl &&
		calc_patch_id withnl <withnl &&
		test_cmp patch-i_ nonl patch-id-withnl
	'
	
or something like that.

I think the "handles no-nl-at-eof markers" test at the end is the
first and only serious offender, so instead of leaving it after the
series, we probalby would want to have a preliminary clean-up patch
before this patch, and fix the test this patch adds.

Thanks.
