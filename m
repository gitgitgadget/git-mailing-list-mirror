Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D855C00A89
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 01:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3042224E
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 01:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xo3u/VQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgKCBNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 20:13:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51613 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgKCBNe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 20:13:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DF67A313A;
        Mon,  2 Nov 2020 20:13:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QSVSU08CEom6dqE+0ikCDeXF8G0=; b=Xo3u/V
        Q++LmpCvlGl4AlrEc2oEnnYTR7DUicKpTXQvl5G6G1mefobpExxpfk+LPIlqHpoD
        BI1raZIlfYsmj79NCEqROhy7IVqdm+hzKoyjsnF/3WGyeMvw6sBCZoNTSqiahJaR
        LPdCfoqwpraj4r5d0RW9MfCmbZ9AKET85pby8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FSAqHVo3LdSNtfUl9zd02yDx9Lxb0yb/
        LydKDHPBAtU/6C5qmlJr0yLFVH9uUjRgsasbxPR/sNXflRoyo2gPxANDR4T7YiCW
        MbzZJLe97FeSuKnmeinRk8omjuT/x71lCap4vgTYTj/7ZcFlIRrOWx1iZ5eQq3S+
        41NwvnW4on8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65F5DA3139;
        Mon,  2 Nov 2020 20:13:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DFD06A3137;
        Mon,  2 Nov 2020 20:13:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] remote-curl: teach --base for http(s)://
References: <cover.1604362701.git.jonathantanmy@google.com>
        <d0a996f77689a12a52b192599fd5e6d27192a648.1604362701.git.jonathantanmy@google.com>
Date:   Mon, 02 Nov 2020 17:13:31 -0800
In-Reply-To: <d0a996f77689a12a52b192599fd5e6d27192a648.1604362701.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 2 Nov 2020 16:26:12 -0800")
Message-ID: <xmqqd00vp7ic.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9D0A008-1D71-11EB-98F7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
> index 22459d37f5..4ee29c1be0 100755
> --- a/t/t5700-protocol-v1.sh
> +++ b/t/t5700-protocol-v1.sh
> ...
> +	# Push to another branch, as the target repository has the
> +	# master branch checked out and we cannot push into it.
> +	GIT_TRACE_PACKET=1 test_might_fail git -C http_child -c protocol.version=1 \
> +		push --base=three origin HEAD:client_branch_four 2>log &&

This attempt to one-shot export GIT_TRACE_PACKET is flagged as an
error by test-lint-shell-syntax.

    test_might_fail env GIT_TRACE_PACKET=1 \
	git -C ... push --base=three ... &&

perhaps?
