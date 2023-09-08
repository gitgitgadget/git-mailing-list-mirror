Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E28EEB56E
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 21:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244065AbjIHVwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 17:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344411AbjIHVwy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 17:52:54 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A08A1FDF
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 14:52:49 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBED11A7F9C;
        Fri,  8 Sep 2023 17:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=6nXmuqtjfI5CaLA8+Z7mECt7xXe/JT2tC0rOfc
        K4AV4=; b=ggJyV8SMcQNciol4iwVIz5EUZxRskR+iCbUWlRY8OszfGVxN+pDfWu
        f328vhfzNZoaUVcwGbGM2tLMKlpkeqGxYuVXizIkGgp8shU98U408c2aWxBLY8tl
        DAiSF/ZgttrlN+OtJMt8ITOuaYczNArUaSU7Czu3Svitu1d5Dn4NY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D43A51A7F9B;
        Fri,  8 Sep 2023 17:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48FDF1A7F98;
        Fri,  8 Sep 2023 17:52:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>
Subject: Re: [PATCH v3 03/13] trailer: add tests to check defaulting
 behavior with --no-* flags
In-Reply-To: <4b5c458ef436c2d208e6d6d0a1f99c65e9a11125.1694125210.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Thu, 07 Sep 2023 22:19:59
        +0000")
References: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
        <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
        <4b5c458ef436c2d208e6d6d0a1f99c65e9a11125.1694125210.git.gitgitgadget@gmail.com>
Date:   Fri, 08 Sep 2023 14:52:47 -0700
Message-ID: <xmqqfs3os574.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CDEAC2E-4E92-11EE-B870-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> While the "--no-where" flag is tested, the "--no-if-exists" and
> "--no-if-missing" flags are not, so add tests for them. But also add
> tests for all "--no-*" flags to check their effects, both when (1) there
> are relevant configuration variables set, and (2) they are not set.
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/git-interpret-trailers.txt |  14 ++-
>  t/t7513-interpret-trailers.sh            | 130 +++++++++++++++++++++++
>  2 files changed, 140 insertions(+), 4 deletions(-)

The commentary before each test_expect_success makes it quite a
pleasant read.

> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> index ed0fc04bd95..832aff06167 100755
> --- a/t/t7513-interpret-trailers.sh
> +++ b/t/t7513-interpret-trailers.sh
> @@ -812,6 +812,53 @@ test_expect_success 'using "--where after" with "--no-where"' '
>  	test_cmp expected actual
>  '
>  
> +# Check whether using "--no-where" clears out only the "--where after", such
> +# that we still use the configuration in trailer.where (which is different from
> +# the hardcoded default (in WHERE_END) assuming the absence of .gitconfig).
> +# Here, the "start" setting of trailer.where is respected, so the new "Acked-by"
> +# and "Bug" trailers are placed at the beginning, and not at the end which is
> +# the harcoded default.
> +test_expect_success 'using "--where after" with "--no-where" defaults to configuration' '
> +	test_config trailer.ack.key "Acked-by= " &&
> +	test_config trailer.bug.key "Bug #" &&
> +	test_config trailer.separators ":=#" &&
> +	test_config trailer.where "start" &&
> +	cat complex_message_body >expected &&
> +	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
> +		Bug #42
> +		Acked-by= Peff
> +		Fixes: Z
> +		Acked-by= Z
> +		Reviewed-by: Z
> +		Signed-off-by: Z
> +	EOF
> +	git interpret-trailers --where after --no-where --trailer "ack: Peff" \
> +		--trailer "bug: 42" complex_message >actual &&
> +	test_cmp expected actual
> +'
> +
> +# The "--where after" will only get respected for the trailer that came
> +# immediately after it. For the next trailer (Bug #42), we default to using the
> +# hardcoded WHERE_END because we don't have any "trailer.where" or
> +# "trailer.bug.where" configured.
> +test_expect_success 'using "--no-where" defaults to harcoded default if nothing configured' '
> +	test_config trailer.ack.key "Acked-by= " &&
> +	test_config trailer.bug.key "Bug #" &&
> +	test_config trailer.separators ":=#" &&
> +	cat complex_message_body >expected &&
> +	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
> +		Fixes: Z
> +		Acked-by= Z
> +		Acked-by= Peff
> +		Reviewed-by: Z
> +		Signed-off-by: Z
> +		Bug #42
> +	EOF
> +	git interpret-trailers --where after --trailer "ack: Peff" --no-where \
> +		--trailer "bug: 42" complex_message >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'using "where = after"' '
>  	test_config trailer.ack.key "Acked-by= " &&
>  	test_config trailer.ack.where "after" &&
> @@ -1176,6 +1223,56 @@ test_expect_success 'overriding configuration with "--if-exists replace"' '
>  	test_cmp expected actual
>  '
>  
> +# "trailer.ifexists" is set to "doNothing", so using "--no-if-exists" defaults
> +# to this "doNothing" behavior. So the "Fixes: 53" trailer does not get added.
> +test_expect_success 'using "--if-exists replace" with "--no-if-exists" defaults to configuration' '
> +	test_config trailer.ifexists "doNothing" &&
> +	cat complex_message_body >expected &&
> +	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
> +		Fixes: Z
> +		Acked-by: Z
> +		Reviewed-by: Z
> +		Signed-off-by: Z
> +	EOF
> +	git interpret-trailers --if-exists replace --no-if-exists --trailer "Fixes: 53" \
> +		<complex_message >actual &&
> +	test_cmp expected actual
> +'
> +
> +# No "ifexists" configuration is set, so using "--no-if-exists" makes it default
> +# to addIfDifferentNeighbor. Because we do have a different neighbor "Fixes: 53"
> +# (because it got added by overriding with "--if-exists replace" earlier in the
> +# arguments list), we add "Signed-off-by: addme".
> +test_expect_success 'using "--no-if-exists" defaults to hardcoded default if nothing configured' '
> +	cat complex_message_body >expected &&
> +	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
> +		Acked-by: Z
> +		Reviewed-by: Z
> +		Signed-off-by: Z
> +		Fixes: 53
> +		Signed-off-by: addme
> +	EOF
> +	git interpret-trailers --if-exists replace --trailer "Fixes: 53" --no-if-exists \
> +		--trailer "Signed-off-by: addme" <complex_message >actual &&
> +	test_cmp expected actual
> +'
> +
> +# The second "Fixes: 53" trailer is discarded, because the "--no-if-exists" here
> +# makes us default to addIfDifferentNeighbor, and we already added the "Fixes:
> +# 53" trailer earlier in the argument list.
> +test_expect_success 'using "--no-if-exists" defaults to hardcoded default if nothing configured (no addition)' '
> +	cat complex_message_body >expected &&
> +	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
> +		Acked-by: Z
> +		Reviewed-by: Z
> +		Signed-off-by: Z
> +		Fixes: 53
> +	EOF
> +	git interpret-trailers --if-exists replace --trailer "Fixes: 53" --no-if-exists \
> +		--trailer "Fixes: 53" <complex_message >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'using "ifExists = replace"' '
>  	test_config trailer.fix.key "Fixes: " &&
>  	test_config trailer.fix.ifExists "replace" &&
> @@ -1425,6 +1522,39 @@ test_expect_success 'using "ifMissing = doNothing"' '
>  	test_cmp expected actual
>  '
>  
> +# Ignore the "IgnoredTrailer" because of "--if-missing doNothing", but also
> +# ignore the "StillIgnoredTrailer" because we set "trailer.ifMissing" to
> +# "doNothing" in configuration.
> +test_expect_success 'using "--no-if-missing" defaults to configuration' '
> +	test_config trailer.ifMissing "doNothing" &&
> +	cat complex_message_body >expected &&
> +	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
> +			Fixes: Z
> +			Acked-by: Z
> +			Reviewed-by: Z
> +			Signed-off-by: Z
> +	EOF
> +	git interpret-trailers --if-missing doNothing --trailer "IgnoredTrailer: ignoreme" --no-if-missing \
> +			--trailer "StillIgnoredTrailer: ignoreme" <complex_message >actual &&
> +	test_cmp expected actual
> +'
> +
> +# Add the "AddedTrailer" because the "--no-if-missing" clears the "--if-missing
> +# doNothing" from earlier in the argument list.
> +test_expect_success 'using "--no-if-missing" defaults to hardcoded default if nothing configured' '
> +	cat complex_message_body >expected &&
> +	sed -e "s/ Z\$/ /" >>expected <<-\EOF &&
> +			Fixes: Z
> +			Acked-by: Z
> +			Reviewed-by: Z
> +			Signed-off-by: Z
> +			AddedTrailer: addme
> +	EOF
> +	git interpret-trailers --if-missing doNothing --trailer "IgnoredTrailer: ignoreme" --no-if-missing \
> +			--trailer "AddedTrailer: addme" <complex_message >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'default "where" is now "after"' '
>  	git config trailer.where "after" &&
>  	test_config trailer.ack.ifExists "add" &&
