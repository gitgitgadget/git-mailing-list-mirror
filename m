Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C890C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF19161241
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243405AbhIWVyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 17:54:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50555 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243407AbhIWVy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 17:54:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64F93D8970;
        Thu, 23 Sep 2021 17:52:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NFM7oSr9OSHokYH9G59gHm1KQKDDRcnRX7x1aF
        WU2pM=; b=HaDsf5RG/yOy39eA/tj79oo1opz1iUXULG7yAkyMHLU3MqxNQYzpzf
        Do72Uu8xGj7/G8l90e/fPiNZtGNXWqqkdMgL2h2gHWPYddeVuiBDPR7sXqloOo5Q
        PUKxKgKF6j0he0oHM4nZz+AnbEG7hp4EIc1Gz7QAXClC+lUcUwXcY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D1DBD896F;
        Thu, 23 Sep 2021 17:52:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3507D896E;
        Thu, 23 Sep 2021 17:52:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH] connect: also update offset for features without values
References: <pull.1091.git.git.1631970872884.gitgitgadget@gmail.com>
        <xmqq4kabyoo3.fsf@gitster.g>
        <YUzzwCwlR9AwSeOD@coredump.intra.peff.net>
Date:   Thu, 23 Sep 2021 14:52:53 -0700
In-Reply-To: <YUzzwCwlR9AwSeOD@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 23 Sep 2021 17:38:08 -0400")
Message-ID: <xmqqr1dfx8lm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B630FC0-1CB8-11EC-982B-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think the problem is that our fake upload-pack exits immediately, so
> ls-remote gets SIGPIPE. In a v0 conversation, ls-remote expects to say
> "0000" to indicate that it's not interested in fetching anything (in v2,
> it doesn't bother, since fetching would be a separate request that it
> just declines to make).

Ah, Makes sense---the usual SIGPIPE problem ;-)

> This seems to fix it:
>
> diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
> index 34538cebf0..0983c2b507 100755
> --- a/t/t5704-protocol-violations.sh
> +++ b/t/t5704-protocol-violations.sh
> @@ -40,7 +40,7 @@ test_expect_success 'bogus symref in v0 capabilities' '
>  			test-tool pkt-line pack-raw-stdin &&
>  		printf "0000"
>  	} >input &&
> -	git ls-remote --upload-pack="cat input ;:" . >actual &&
> +	git ls-remote --upload-pack="cat input; read junk;:" . >actual &&
>  	printf "%s\tHEAD\n" "$oid" >expect &&
>  	test_cmp expect actual
>  '

Yup.  In the original thread there was some further back-and-forth
about further improving the test, if I recall correctly; has the
issue been settled there, or is everybody happy with the above
version?

Thanks.
