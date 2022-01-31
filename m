Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DF8C433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 23:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiAaXgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 18:36:47 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54842 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiAaXgr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 18:36:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 06BCC16B76A;
        Mon, 31 Jan 2022 18:36:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h8GKJ+PC5CmCU2qmrpSNnnyBVyr+XoYyeQS9g3
        EQNC8=; b=cxi9Uer3mlPXu8+XnQd8MZo5iOfg5Yey9iQn0XoUiMfTYoOJ55lfCe
        aCYc+Zo8oXwZB23gwUJZcJNFTNDHzmbw2j1gsZUQU6lvwsxgkQpq+xAsjDZRRidR
        z/1D/BA+so32CKOHckhLWk3FL16P9gGUYxSiYEBfV+qKtYdUhbUJ0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F418816B768;
        Mon, 31 Jan 2022 18:36:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 42BBF16B767;
        Mon, 31 Jan 2022 18:36:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH V2 1/2] patch-id: Fix antipatterns in tests
References: <20220131232318.8248-1-jerry@skydio.com>
        <20220131232529.8484-1-jerry@skydio.com>
Date:   Mon, 31 Jan 2022 15:36:43 -0800
In-Reply-To: <20220131232529.8484-1-jerry@skydio.com> (Jerry Zhang's message
        of "Mon, 31 Jan 2022 15:25:29 -0800")
Message-ID: <xmqqfsp3h3zo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6246264-82EE-11EC-BE79-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

>  test_expect_success 'patch-id handles no-nl-at-eof markers' '
> -	cat nonl | calc_patch_id nonl &&
> -	cat withnl | calc_patch_id withnl &&
> +	cat >nonl <<-EOF &&

Unless you use $variable_expanded_to_its_value in the here-doc,
always make it a habit to quote the EOF marker.  That helps the
readers by assuring that there is no funny interpolation going on.

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
> +	EOF
> +	cat >withnl <<-EOF &&

Likewise.

> +	diff --git i/a w/a
> +	index e69de29..7898192 100644
> +	--- i/a
> +	+++ w/a
> +	@@ -0,0 +1 @@
> +	+a
> +	diff --git i/b w/b
> +	index e69de29..6178079 100644
> +	--- i/b
> +	+++ w/b
> +	@@ -0,0 +1 @@
> +	+b
> +	EOF
> +	calc_patch_id nonl <nonl &&
> +	calc_patch_id withnl <withnl &&
>  	test_cmp patch-id_nonl patch-id_withnl
>  '
>  test_done
