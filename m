Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F4AC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 17:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F8560C40
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 17:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhG2ROJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 13:14:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56569 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhG2ROI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 13:14:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32C951398EA;
        Thu, 29 Jul 2021 13:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=28lxeCjglxzcUlq1/06Qcf+QHWeQ7y/zvjbWTb
        pIiT0=; b=b337zcfu29GZx/hZkZ8Eg6VgTPScLyY92gQG3xo3RWUMVAXP1aJ5Yh
        LKaWaSM7UTKFmmeampgWxP7kVac2nl2cMdcyQMLlfH9KqgwdyA7oCu9HHHXsIo7K
        hNU/5pNTwIpAPeq7AirWwPhodRyQkE1Y8qdoWAbbD3PxRuMaeMOfY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2AB941398E9;
        Thu, 29 Jul 2021 13:14:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6AD221398E8;
        Thu, 29 Jul 2021 13:14:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Daniel Knittl-Frank <knittl89@googlemail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Using two-dot range notation in `git rebase`?
References: <b3b5f044-8c76-ec71-45d6-1c7fea93c519@iee.email>
        <CACx-yZ1Je+tnZdJ21gDPeuQa-QTuY2t9mDujNr7wqJWFMwwzxA@mail.gmail.com>
        <dc7668ff-37ad-1d9e-fc92-df432549b4e2@iee.email>
        <YQKBNXsMdroX3DfY@coredump.intra.peff.net>
Date:   Thu, 29 Jul 2021 10:13:59 -0700
In-Reply-To: <YQKBNXsMdroX3DfY@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 29 Jul 2021 06:21:41 -0400")
Message-ID: <xmqqr1fh59go.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EFCB44A-F090-11EB-AD0B-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> long as there is only one negative tip given, that becomes the "--onto"
> point).

So "git newbase [--options] A..B" would

 - checks if B names an existing branch or just a commit

 - detaches HEAD at commit A

 - replays commits in DAG A..B on top of it; the exact way the
   history is replayed is affected by the options given (e.g. "-m"
   and "-p" may try to preserve history shapes)

 - if B was determined to be a branch name, "git branch -f" to it;
   otherwise leave the HEAD detached.

which all sounds OK, but I do not see a huge improvement over the
current "git rebase [--options] A B" (other than that you can type
double dot instead of a single space).
