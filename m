Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9614BC433E0
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F01022573
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbhADX6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:58:30 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64181 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbhADX63 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:58:29 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3743101732;
        Mon,  4 Jan 2021 18:57:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=h8NUv30Nws7s8PphIUaOPxzDZ+c=; b=ZMcZkNqCxxTB+f1i0U2K
        gcNK1ayuGUyhSQbiwM/Ex4sasR2wSZyhLfzsFJzUQXpxxM6OUgUKaZPNA2Jlnj5k
        qA12mPbpPIvjLw0PnZRWnFgz7LpLj9Rxm3sAJZOj7UT3XDsBTwu1D30yXT69pUAV
        a9kpjzn6RkeCfY4ir5hUAlM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=giFby824vOTh57bdS93JOUaWdzrpvv7cDqdrKvRAtfui0r
        HnXFanuK39uAYCBvJhSX5dRf8xRBPBTYIyk8p3lVrl0AY50aIiJ3P+AuPPcQlY0G
        l7Ps+HG2V9EZZ89DcC3O4zvTrec98KHdxwgCkirfOsuLIukM1J9Mgz5XwpTFY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EB8F7101731;
        Mon,  4 Jan 2021 18:57:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A48C101730;
        Mon,  4 Jan 2021 18:57:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, me@ikke.info
Subject: Re: [PATCH] t4129: don't fail if setgid is set in the parent directory
References: <X+xtAR87vWuNiLoE@alpha>
        <88398ff952a68e8d134dcd50ef0772bb6fc3b456.1609339792.git.matheus.bernardino@usp.br>
Date:   Mon, 04 Jan 2021 15:57:43 -0800
Message-ID: <xmqqpn2k1ci0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3D86BBC-4EE8-11EB-88D9-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
> index 41818d8315..3818398ca9 100755
> --- a/t/t4129-apply-samemode.sh
> +++ b/t/t4129-apply-samemode.sh
> @@ -90,12 +90,10 @@ test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
>  		rm -rf d f1 &&
>  		git apply patch-f1-and-f2.txt &&
>  
> -		echo "-rw-------" >f1_mode.expected &&
> -		echo "drwx------" >d_mode.expected &&
> -		test_modebits f1 >f1_mode.actual &&
> -		test_modebits d >d_mode.actual &&
> -		test_cmp f1_mode.expected f1_mode.actual &&
> -		test_cmp d_mode.expected d_mode.actual
> +		test_modebits f1 >f1_mode &&
> +		test_modebits d >d_mode &&
> +		grep "^-rw-------$" f1_mode &&
> +		grep "^drwx--[-S]---$" d_mode
>  	)
>  '

It somehow feels to me that this approach would not scale well.
Shouldn't this knowledge of inherited sticky gid bit hidden behind
the test_modebits helper function?

Thanks.
