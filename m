Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DCBCD611D
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 18:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377444AbjJISYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 14:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjJISYK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 14:24:10 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BD69C
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 11:24:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC1B01BAADC;
        Mon,  9 Oct 2023 14:24:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=VtqygRNr673/oarAB1sW01xf5pxnDvd3BUtJ7D
        Fb4QU=; b=RwlTTaL85rSABZ/pB4qUOS7RLcK1OQ1SBuRWXmNUXCHl3qLnITBngh
        THYuY7Bx4qO5QQLapWopxS8SXRylqA2/UFiBH66bVzTmbRrvLPmz7onP5DutXvNu
        XL8FSZV7kn5PRMZ9Dls2hxNS5PgExTbweNVOOXfD//QXLXIiBl35E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC0041BAADB;
        Mon,  9 Oct 2023 14:24:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E7721BAADA;
        Mon,  9 Oct 2023 14:24:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andy Koppe <andy.koppe@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pretty: fix ref filtering for %(decorate) formats
In-Reply-To: <20231008202307.1568477-1-andy.koppe@gmail.com> (Andy Koppe's
        message of "Sun, 8 Oct 2023 21:23:07 +0100")
References: <20231008202307.1568477-1-andy.koppe@gmail.com>
Date:   Mon, 09 Oct 2023 11:24:05 -0700
Message-ID: <xmqq4jiz1woq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08C519A0-66D1-11EE-BA84-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andy Koppe <andy.koppe@gmail.com> writes:

> Mark pretty formats containing "%(decorate" as requiring decoration in
> userformat_find_requirements(), same as "%d" and "%D".

Ah, of course.  The patch makes sense.

> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 16626e4fe9..5aabc9f7d8 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -590,9 +590,9 @@ test_expect_success 'pretty format %decorate' '
>  	git log --format="%(decorate:prefix=,suffix=)" -1 >actual2 &&
>  	test_cmp expect2 actual2 &&
>  
> -	echo "[ HEAD -> foo; tag: bar; qux ]" >expect3 &&
> -	git log --format="%(decorate:prefix=[ ,suffix= ],separator=%x3B )" \
> -		-1 >actual3 &&
> +	echo "[ bar; qux; foo ]" >expect3 &&
> +	git log --format="%(decorate:prefix=[ ,suffix= ],separator=%x3B ,tag=)" \
> +		--decorate-refs=refs/ -1 >actual3 &&
>  	test_cmp expect3 actual3 &&

The original test shares the same, but is the order of multiple
decorations expected to be stable?  I feel a bit uneasy to see a
test that insists multiple things come out in a hardcoded order.

It is not making anything _worse_, so let's take the patch as-is.

Thanks.

>  	# Try with a typo (in "separator"), in which case the placeholder should
