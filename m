Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98A4C433EF
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 01:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiAHBbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 20:31:09 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54919 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiAHBbI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 20:31:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4ED0C16FD92;
        Fri,  7 Jan 2022 20:31:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=bwhK+a4Nzya8oxrB+d05bHSgMCy1pRWRfDA/dOamqfQ=; b=tlSG
        BdRddcIonb8HGTc8Xgo/D7PHdNcjRR5ZExctwnAAodMY9wbpp/ZQlx1bLS4ZLbL3
        56l+mCkjyL9YDsMNs9A5d7agFtbMi8NAMHCcraRWtN6Ja5CwYDqdLNccEY+VJpxd
        W+VkmE4ffAJTa/qtLXuJLcvEDrnc3UarcbZ28OI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4723B16FD91;
        Fri,  7 Jan 2022 20:31:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BFA8A16FD8E;
        Fri,  7 Jan 2022 20:31:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: Re: [PATCH v2 4/6] refs: demonstrate excessive execution of the
 reference-transaction hook
References: <cover.1638874287.git.ps@pks.im> <cover.1641556319.git.ps@pks.im>
        <b52e59cdac75e6c4530cb39f7dcb41bb327f50e2.1641556319.git.ps@pks.im>
Date:   Fri, 07 Jan 2022 17:31:04 -0800
Message-ID: <xmqqiluv3tev.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A601A56E-7022-11EC-AC7B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Add tests which demonstate which demonstrates that we're executing the

You demonstrate too often, which may be the point of the test, but
looks wrong.

I actually think this should be done as part of the fix to the code
itself, which presumably is a single-liner to tell the "skip when
running delete in packed-refs backend".  IOW, just fix the code and
test how the externally observable behaviour of the code should be
in new tests, in the same commit.

> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
> index 6c941027a8..0567fbdf0b 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -136,4 +136,68 @@ test_expect_success 'interleaving hook calls succeed' '
>  	test_cmp expect target-repo.git/actual
>  '
>  
> +test_expect_success 'hook does not get called on packing refs' '
> +	# Pack references first such that we are in a known state.
> +	git pack-refs --all &&
> +
> +	write_script .git/hooks/reference-transaction <<-\EOF &&
> +		echo "$@" >>actual
> +		cat >>actual
> +	EOF
> +	rm -f actual &&
> +
> +	git update-ref refs/heads/unpacked-ref $POST_OID &&
> +	git pack-refs --all &&
> +
> +	# We only expect a single hook invocation, which is the call to
> +	# git-update-ref(1). But currently, packing refs will also trigger the
> +	# hook.
> +	cat >expect <<-EOF &&
> +		prepared
> +		$ZERO_OID $POST_OID refs/heads/unpacked-ref
> +		committed
> +		$ZERO_OID $POST_OID refs/heads/unpacked-ref
> +		prepared
> +		$ZERO_OID $POST_OID refs/heads/unpacked-ref
> +		committed
> +		$ZERO_OID $POST_OID refs/heads/unpacked-ref
> +		prepared
> +		$POST_OID $ZERO_OID refs/heads/unpacked-ref
> +		committed
> +		$POST_OID $ZERO_OID refs/heads/unpacked-ref
> +	EOF
> +
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'deleting packed ref calls hook once' '
> +	# Create a reference and pack it.
> +	git update-ref refs/heads/to-be-deleted $POST_OID &&
> +	git pack-refs --all &&
> +
> +	write_script .git/hooks/reference-transaction <<-\EOF &&
> +		echo "$@" >>actual
> +		cat >>actual
> +	EOF
> +	rm -f actual &&
> +
> +	git update-ref -d refs/heads/to-be-deleted $POST_OID &&
> +
> +	# We only expect a single hook invocation, which is the logical
> +	# deletion. But currently, we see two interleaving transactions, once
> +	# for deleting the loose refs and once for deleting the packed ref.
> +	cat >expect <<-EOF &&
> +		prepared
> +		$ZERO_OID $ZERO_OID refs/heads/to-be-deleted
> +		prepared
> +		$POST_OID $ZERO_OID refs/heads/to-be-deleted
> +		committed
> +		$ZERO_OID $ZERO_OID refs/heads/to-be-deleted
> +		committed
> +		$POST_OID $ZERO_OID refs/heads/to-be-deleted
> +	EOF
> +
> +	test_cmp expect actual
> +'
> +
>  test_done
