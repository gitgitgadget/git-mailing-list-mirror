Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0C3C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 22:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EAC160EC0
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 22:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhHIWD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:03:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56636 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbhHIWD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 18:03:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF70C130696;
        Mon,  9 Aug 2021 18:03:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4gqtPRQyshr+daNkQo3WetEvtM0kDsDBgG6Gvx
        X/K1w=; b=ecN6Fv1SB4iLWpQKPCGXbsaArnrZhr9CaDyp+FqokdRjoz2HnqTkYm
        D10DjYDmaqTfFbrCauKa3w5IFHSb5Afk+mDcUWl4ueqGvvf+I1tb4vNbiOK32sFg
        LBaj75sODwOS1ze58bwsxK6EDYS9KESty/DIlBFjRu8xD7SyKdu1g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6BF1130695;
        Mon,  9 Aug 2021 18:03:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0CA15130693;
        Mon,  9 Aug 2021 18:03:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kim Altintop <kim@eagain.st>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        jonathantanmy@google.com, bwilliams.eng@gmail.com
Subject: Re: [PATCH 1/3] t5730: introduce fetch command helper
References: <20210730135845.633234-1-kim@eagain.st>
        <20210731203415.618641-1-kim@eagain.st>
        <20210804203829.661565-1-kim@eagain.st>
        <20210804205951.668140-1-kim@eagain.st>
        <20210809175530.75326-1-kim@eagain.st>
        <20210809175530.75326-2-kim@eagain.st> <YRGEwFauT5QjMSNO@google.com>
        <CDFBG4S23B1M.141X9FIPP7YHS@schmidt>
Date:   Mon, 09 Aug 2021 15:03:01 -0700
In-Reply-To: <CDFBG4S23B1M.141X9FIPP7YHS@schmidt> (Kim Altintop's message of
        "Mon, 09 Aug 2021 21:56:49 +0000")
Message-ID: <xmqqpmume0oa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9158287C-F95D-11EB-B411-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kim Altintop <kim@eagain.st> writes:

> Perhaps an alternative would be:
>
> 	write_fetch_command () {
> 		write_command fetch &&
> 		echo "0001" &&
> 		echo "no-progress" &&
> 		cat /dev/stdin &&
> 		echo "done" &&
> 		echo "0000"
>  	}
>
>
> Which would then be called like so:
>
> 	write_fetch_command >pkt_cmd <<-EOF &&
> 	want-ref refs/heads/main
> 	have $(git rev-parse a)
> 	EOF
> 	test-tool pkt-line pack <pkt_cmd >in &&
> 	test-tool serve-v2 --stateless-rpc >out <in &&
>
>
> I'm not sure how portable that is, though. Maybe using `while read -r` instead
> of `cat /dev/stdin`?

If you drop /dev/stdin, the result would be emimently portable.
"cat" without any argument reads from the standard input stream
and copies it to the standard output stream.
