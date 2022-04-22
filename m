Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C97C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 23:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiDVXqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 19:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiDVXqT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 19:46:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCF5DAA26
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 16:43:24 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09FEA1096C7;
        Fri, 22 Apr 2022 19:43:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PdX8/HB0ubtJRNsFCdzMcd+j7+ncNKF5SICyy6
        TMLJQ=; b=B0xd/4nbrx7rLQD4ah/GAIIFFNCe3S+CMdCQ35PThFOv+HFeI8dW4c
        9fm9rmawQ9rbzUPZDzpZRrQ0umzPteXLM4oGtFEubhBO6S+oz/24QBNnkqotT/SC
        DPsmiifyeYqIfOdMhUyCGK1dTNvuyB5oHlAhgWxS2mOHNwEryRhqg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 011B31096C6;
        Fri, 22 Apr 2022 19:43:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6CAD41096C4;
        Fri, 22 Apr 2022 19:43:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miklos Vajna <vmiklos@vmiklos.hu>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: [PATCH v6] log: "--since-as-filter" option is a non-terminating
 "--since" variant
References: <Yka2GSGs3EIXm6Xt@vmiklos.hu> <xmqq1qygy9nd.fsf@gitster.g>
        <Yk8Gvf/fjVca9hDB@vmiklos.hu> <xmqqv8vkpara.fsf@gitster.g>
        <xmqqtub3moa0.fsf@gitster.g>
        <CANgJU+Wr+tKNPfeh4dst-E_LSnoYYmN1easqmkFUA9spp-rpKQ@mail.gmail.com>
        <xmqqilrfk14q.fsf@gitster.g> <xmqqzgkd7y42.fsf@gitster.g>
        <YmMJqvKN6itSHEZW@vmiklos.hu>
Date:   Fri, 22 Apr 2022 16:43:21 -0700
In-Reply-To: <YmMJqvKN6itSHEZW@vmiklos.hu> (Miklos Vajna's message of "Fri, 22
        Apr 2022 22:01:46 +0200")
Message-ID: <xmqqsfq44rc6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FEEE8352-C295-11EC-A371-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miklos Vajna <vmiklos@vmiklos.hu> writes:

> +test_expect_success 'git blame --since=...' '
> +	git blame --since="2020-02-15" file >actual &&
> +	cat >expect <<-\EOF &&
> +	^c7bc5ce (A U Thor 2020-02-01 00:00:00 +0000 1) a
> +	^c7bc5ce (A U Thor 2020-02-01 00:00:00 +0000 2) a
> +	33fc0d13 (A U Thor 2020-03-01 00:00:00 +0000 3) a
> +	ec76e003 (A U Thor 2020-04-01 00:00:00 +0000 4) a
> +	EOF
> +	test_cmp expect actual
> +'

Hardcoding the object names like this does not pass our test suite.
These abbreviated object names hardcode the use of SHA-1, but the
code is tested in repositories that use SHA-256 as well.

As you are creating four commits with distinct timestamps, I think
you can simply filter out the object name part for comparison,
perhaps like:

redact_blame_output () {
	sed -e 's/\([^]*\)\([0-9a-f]*\) /\1HASH /'
}

test_expect_success 'git blame --since=...' '
	git blame --since=2020-02-15 file >raw &&
	redact_blame_output <raw >actual &&
	redact_blame_output <<-\EOF &&
	^c7bc5ce (A U Thor 2020-02-01 00:00:00 +0000 1) a
	^c7bc5ce (A U Thor 2020-02-01 00:00:00 +0000 2) a
	33fc0d13 (A U Thor 2020-03-01 00:00:00 +0000 3) a
	ec76e003 (A U Thor 2020-04-01 00:00:00 +0000 4) a
	EOF
	test_cmp expect actual
'

But did you really mean to test how --since works with blame?  Given
that there does not seem to be any clock skew in the history being
tested, I am wondering if this new test file should even be a part
of the topic.

Thanks.


