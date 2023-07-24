Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF8CEB64DD
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 21:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjGXVsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 17:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjGXVsj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 17:48:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2864170E
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 14:48:37 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 16070361A7;
        Mon, 24 Jul 2023 17:48:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CROjoeWaZC4QpbreLeD0XBhlL1ByUwIlUYpxZN
        aFILU=; b=VqtgWKOqNeHoTJQ8HcYZvDOKHQ+hotiSFyn85I2lL2s0iqOSyTsBJD
        e+VTAH0Q/d8BxVMGQI/QN/jZoGNaalBJ8JrSWGIrjDr8+nHuwhFwHEotET6teo1D
        rUj7gnTbgRs/spxAXOVIouYOmy3nzMUK3DQEJOEvwG5wmfgVjR28Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0EBF9361A6;
        Mon, 24 Jul 2023 17:48:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A654D361A4;
        Mon, 24 Jul 2023 17:48:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/5] t5318: avoid top-level directory changes
References: <cover.1689960606.git.me@ttaylorr.com>
        <cover.1690216758.git.me@ttaylorr.com>
        <12ce967bafecf993bb4eb1ed3c17878ae98c9fc4.1690216758.git.me@ttaylorr.com>
Date:   Mon, 24 Jul 2023 14:48:32 -0700
In-Reply-To: <12ce967bafecf993bb4eb1ed3c17878ae98c9fc4.1690216758.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 24 Jul 2023 12:39:28 -0400")
Message-ID: <xmqq7cqpnfpr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D61A2D48-2A6B-11EE-9D99-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>  test_expect_success 'exit with correct error on bad input to --stdin-packs' '
> -	cd "$TRASH_DIRECTORY/full" &&
>  	echo doesnotexist >in &&
> -	test_expect_code 1 git commit-graph write --stdin-packs <in 2>stderr &&
> +	test_expect_code 1 git -C full commit-graph write --stdin-packs \
> +		<in 2>stderr &&
>  	test_i18ngrep "error adding pack" stderr
>  '

Strictly speaking, this changes behaviour in that "in" and "stderr"
files are now left in the top-level directory (they used to be in
the "full" directory).  It is rather hard to make sure that this
difference (and similar ones the patch makes) does not matter in the
rest of the tests only from the patch context, but I'll read through
"git diff -U999" and did not spot anything questionable.
