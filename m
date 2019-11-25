Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866BAC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 04:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC472082C
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 04:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v2mppj6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfKYEvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 23:51:32 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57189 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfKYEvc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 23:51:32 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F2E6E8B757;
        Sun, 24 Nov 2019 23:51:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RaF7a6PD2aPkU40k5UtVYeliOok=; b=v2mppj
        6ITYjcBtdnVrzkDoOuBP1K3CD4fAiJrXYuSbwmuvhktNDjCyWZegFbkE1/u52FH/
        N6QHOsWaDrP9ZjAmIt6Eq9pa3RIgXrty3esDKh+0B3TsIUH48o4MRcPwTpDbOi28
        H7ckr5tn1siUTOtCqBbs0l3/vhpcsuDv3XsfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JRx6a/4V4snV8fhMx0x3XLyd/PixseMz
        6u2vGQ4PMLRzuCiBVIiDt6drQojEjkj9iUfUIYqORWDMqeVMnWMVv/+FLR5v8zUD
        MlsC84snuiY6z+0zSWFEggLhgQOyczoIpslb5LnCdqr5JZ9SqtcDIqOTK2OpDkL8
        DTtCyxQrJF4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE9518B756;
        Sun, 24 Nov 2019 23:51:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EC3C98B750;
        Sun, 24 Nov 2019 23:51:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Manish Goregaokar <manishsmail@gmail.com>
Subject: Re: [PATCH v3 1/1] submodule: fix 'submodule status' when called from a subdirectory
References: <pull.472.v2.git.1574582473.gitgitgadget@gmail.com>
        <pull.472.v3.git.1574655344.gitgitgadget@gmail.com>
        <8dcea6b399923e931625ef09d66661e93975b93a.1574655344.git.gitgitgadget@gmail.com>
Date:   Mon, 25 Nov 2019 13:51:24 +0900
In-Reply-To: <8dcea6b399923e931625ef09d66661e93975b93a.1574655344.git.gitgitgadget@gmail.com>
        (Manish Goregaokar via GitGitGadget's message of "Mon, 25 Nov 2019
        04:15:44 +0000")
Message-ID: <xmqqmucky2wj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D0CCD4A-0F3F-11EA-ACEF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +		test_cmp ../expect ../actual &&

Note that "test_cmp expect actual" highlights a breakage, when it
finds one, by showing a diff that shows "what we saw is different
from what we expected to see in this way".  So this invocation is
good.

> +		git -C ../submod checkout HEAD^ &&
> +		git submodule status >../output &&
> +		awk "{print \$1}" <../output >../actual2 &&
> +		cd .. &&
> +		git submodule status >output &&
> +		awk "{print \$1}" <output >expect2 &&
> +		test_cmp actual2 expect2 &&

But this one is probably the other way around.  I'll fix this up
while queuing, so if there is no other changes necessary, there is
no need to resend the patch.

> +		! test_cmp actual actual2

And the order of this one actually does not matter ;-)

> +	)
> +'

Thanks.
