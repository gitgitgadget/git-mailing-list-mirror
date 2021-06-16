Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F6EC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E538613B6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhFPAyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 20:54:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60716 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhFPAyo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 20:54:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9353512E6B8;
        Tue, 15 Jun 2021 20:52:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8KG3M4O7jvisjZZy0Xu6oufgxJgniYtuLPGp1P
        SKBhc=; b=QdARAtfCXa4kf+vEZQCfnhP4e6Jcyl0tO6Oxximh0CAISlFo3G9u3i
        N4EUOQ/OTJ1vhxzZ96Jzz3BRrzUjYU0wsXRuh8u2/LgP4sJ+m+/UN1mOCmVBFYZY
        PHdPRzJ8pG9XYTNttK4fyXUb+WcZgsjau7Mfr1GeE34bNt6bpt1qo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BC5412E6B7;
        Tue, 15 Jun 2021 20:52:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0D05412E6B5;
        Tue, 15 Jun 2021 20:52:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Shumaker <lukeshu@lukeshu.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH 1/2] subtree: fix the GIT_EXEC_PATH sanity check to work
 on Windows
References: <pull.978.git.1623316412.gitgitgadget@gmail.com>
        <a91ac6c18938116c4a74e19466da456b67376fa5.1623316412.git.gitgitgadget@gmail.com>
        <87bl8d6xoq.wl-lukeshu@lukeshu.com>
        <nycvar.QRO.7.76.6.2106111213050.57@tvgsbejvaqbjf.bet>
        <875yyk7c3j.wl-lukeshu@lukeshu.com>
        <nycvar.QRO.7.76.6.2106141330410.57@tvgsbejvaqbjf.bet>
        <xmqqtulzyhyh.fsf@gitster.g>
        <YMiHX6H/k1Z8C6Ws@coredump.intra.peff.net>
Date:   Wed, 16 Jun 2021 09:52:34 +0900
In-Reply-To: <YMiHX6H/k1Z8C6Ws@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 15 Jun 2021 06:56:31 -0400")
Message-ID: <xmqq8s3avdf1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2434D3EE-CE3D-11EB-8DEA-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> So,... is contrib/subtree for Windows only?
>
> I read it as "this workaround is needed only on Windows, and will kick
> in only there; on other platforms, the "-ef" code will not run at all,
> so we don't have to worry about its portability".

Yes, in the latest round that I queued yesterday, it is clear that
the use of non-POSIX "test" comes after the original condition
followed by "||", and even if "test" may sometimes be a builtin, I
do not think we will trigger an error at parse-time [*1*], so it is
a safe change.

Thanks.


[Footnote]

*1* I recall we had one interesting breakage of a script that tried
    to do what is essentially:

        if are we running a shell with that funky feature?
        then
            shell commands that use the funky feature
        else
            portable POSIX shell feature
        fi

    but the part that were supposed to be excluded from the
    "portable" codepath by being between "then" and "else" still
    were parsed and caused a parse error.
