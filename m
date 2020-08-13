Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3AFC433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07872078B
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 18:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fanot6YZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHMSmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:42:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53343 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgHMSmB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 14:42:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9233BE02AE;
        Thu, 13 Aug 2020 14:42:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wbbuqywybBEyf4jgApNQL/g6O9c=; b=Fanot6
        YZuAi2b1mT/GZakodM4TDkKG9/qhTRiY0b0TJsr3Y64LU1RPBCaPXcAHjbM1Y307
        nuJAImU/hevmTLn/vhcMKK4Apnsr4fWuTa9EcXoidMOSWl/l45HCwZ7xLRRmgJ9R
        vgQGLcQLOYpnCFc0iTCn/++aVkDb8UtSZd4Ys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mtNYSGt/+gxMxNwi0IskHvpFa5YkqNGg
        iaKDnCB7tuLaErRDFlLP24EE5qympfU0sS9wNO98DkglxjRzjxGeuFMLG9zOIE81
        51u26VA81u+++weqQLIV6uPpgeYprcN1aN/T0wGYN6npy7yuIIFsRvKY5ZpXBP/q
        fl+mzSJfPIE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8ABEFE02AD;
        Thu, 13 Aug 2020 14:42:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C0EDBE02AB;
        Thu, 13 Aug 2020 14:41:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Barret Rhoden <brho@google.com>, Nuthan Munaiah <nm6061@rit.edu>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] blame: only coalesce lines that are adjacent in result
References: <20200813052054.GA1962792@coredump.intra.peff.net>
        <20200813052531.GC2514880@coredump.intra.peff.net>
Date:   Thu, 13 Aug 2020 11:41:57 -0700
In-Reply-To: <20200813052531.GC2514880@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 13 Aug 2020 01:25:31 -0400")
Message-ID: <xmqqv9hm1j7u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB5BC5D4-DD94-11EA-97CC-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +test_expect_success 'blame does not coalesce non-adjacent result lines' '
> +	cat >expect <<-EOF &&
> +	$orig 1) ABC
> +	$orig 3) DEF
> +	EOF
> +	git blame --no-abbrev -s -L1,1 -L3,3 $split giraffe >actual &&

I like this much better than "git -c core.abbrev=40", too.  Good.

> +	test_cmp expect actual
> +'
> +
>  test_done
