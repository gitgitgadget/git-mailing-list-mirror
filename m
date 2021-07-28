Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE2FC4320A
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 20:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11CB9604DB
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 20:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhG1UIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 16:08:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55332 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhG1UIK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 16:08:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2ED3FE4080;
        Wed, 28 Jul 2021 16:08:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NjrKNSeKnWUdUqIcY3R6uxac/huPPqNItjVAP5
        has34=; b=NnzKawgyEovmFKmKaclzJeZaYmPKlQ4OC74DdAcPN0gPc5m4HO2ZTr
        XeaTf7oXrHlEmXS266GC+XUQWP6tbrFkHIYg0irM2dhBXA1Kbo9vhj4HLuFxcmZ6
        WPuvnPa1kKrHORYtQA3wYoMay/EZByAUqgyxSzTpUgVvF9k3Qqc4Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04773E407F;
        Wed, 28 Jul 2021 16:08:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D00D0E407E;
        Wed, 28 Jul 2021 16:08:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     Git Mailing List <git@vger.kernel.org>, lilinchao@oschina.cn
Subject: Re: [PATCH] git-apply: fix --3way with binary patch
References: <20210728024434.20230-1-jerry@skydio.com>
        <xmqqh7gfawlt.fsf@gitster.g>
        <CAMKO5CvZCMHuzRLSs2aHJ3iUH-LBJfFP3fG+GgwtQvsKQPtT5Q@mail.gmail.com>
Date:   Wed, 28 Jul 2021 13:08:04 -0700
In-Reply-To: <CAMKO5CvZCMHuzRLSs2aHJ3iUH-LBJfFP3fG+GgwtQvsKQPtT5Q@mail.gmail.com>
        (Jerry Zhang's message of "Wed, 28 Jul 2021 12:38:20 -0700")
Message-ID: <xmqq1r7i9p7f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8556C448-EFDF-11EB-8485-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> So basically, another way of stating the problem would be that binary
> patches can apply cleanly with direct application in some cases where
> merge application is not clean. If i understand correctly this is unique
> to binary files, although it would be possible for a user to supply a custom
> merge driver for text files that is worse than direct application, that is
> most likely heavy user error that we shouldn't have to cater to.

Not really.  The built-in binary merge driver luckily had such
characteristics to allow us to catch this regression, but I see no
reason to believe that it is unique to binary.  Funky merge backends
like union merges can turn an otherwise conflicting merge into a
clean merge even for non-binary files.  And no, it is not an error
for a merge driver to fail "apply --3way" merge on incoming data
that "apply --no-3way" would apply cleanly.

> However
> the issue with binary is that the *default* merge driver is actually worse
> than direct application (in some cases).

> 1. do as you suggest and run 3way -> direct -> 3way. I would modify
> this and say we should only attempt this for binary patches, since a text
> file that fails 3way would most likely also fail direct,...

No, I do not trust our (myself and your) unsubstantiated belief that
it is limited to binary.  We saw a problem with binary, and I would
think it is a tip of iceberg for any non-straight-text-merge backend
(and I do not have any sound reason to believe that straight
text-merge backend will not have this issue).  I'd rather treat this
as coalmine canary.

I think the real problem, even without the "try threeway, fall back
to direct application, and then try threeway again", is that after
swapping the fallback order, a failed threeway does *not* fall back
to direct application in this case.  Regardless of what ll_merge()
and its backend does, if they fail, shouldn't the caller of
try_threeway() notice the failure and fall back to direct
application, just like the earlier code tried direct application
first and then _always_ fell back to threeway if it failed?  I do
not know exactly why today's code fails to do so, but I suspect that
fixing that is the real solution, no?

Independent from that, I suspect that it may be a good thing to do
to (at least optionally) allow ll_merge() to notice trivial merges
that proper merge frontends would never ask it to do and resolve
them trivially.  The patch you saw from me to ll_merge_binary() may
do so at a wrong layer (doing it in ll_merge() before it dispatches
to ll_merge_binary() and other backends might be a better approach)
but would be a good starting point for that independent effort, but
"apply --3way" should work correctly even with user-configured merge
drivers (after all, the "direct application first and then fall back
to 3way" code would have worked perfectly fine even with broken
custom merge drivers in the case we are discussing right now).

Thanks.


