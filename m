Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C5CC2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9287E20857
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J+GB+gid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636954AbgDOPbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:31:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56233 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2636942AbgDOPbr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 11:31:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 31249C440E;
        Wed, 15 Apr 2020 11:31:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Aa8bSRF8KcrQmClPQmaZHitdXWs=; b=J+GB+g
        idBKUOBhyF8etJybnQKfGAna/GOXt24kSIjRq5fMZ7aCGyLB/16bXGx2LhobyaMV
        +n3UHOorf4Txx0NHDyBnFUYiIiVSworrO2J2RraYtu7L4xFU/a7DZcb3qVPCP5tx
        HbJC84vVSFkpfFahQJvONJrW24F0pJdHqDlqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L5poMsY0WqTOsTDpQIkCudOiEeE4lTnY
        H9Fx+ti5fPr1xttKQv88/swVZp/5635yZR+9AstIWHFl8C7KLDmp6P1vVBpFwFq+
        0Z0WXAqeo1dk5FM20k4TmLlbKt9DZA5sE9hq6PwuGVjgJ/9z8Lg5/FRrx70aXp6L
        C5Sg0ZS28UU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A122C440D;
        Wed, 15 Apr 2020 11:31:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6CAD3C440C;
        Wed, 15 Apr 2020 11:31:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Vasil Dimov via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Vasil Dimov <vd@freebsd.org>
Subject: Re: [PATCH 1/2] range-diff: fix a crash in parsing git-log output
References: <pull.760.git.git.1586960921.gitgitgadget@gmail.com>
        <2375e34100e571f9c3ce658d28aba6648fba18a6.1586960921.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Apr 2020 08:31:39 -0700
In-Reply-To: <2375e34100e571f9c3ce658d28aba6648fba18a6.1586960921.git.gitgitgadget@gmail.com>
        (Vasil Dimov via GitGitGadget's message of "Wed, 15 Apr 2020 14:28:40
        +0000")
Message-ID: <xmqqsgh47okk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34854A26-7F2E-11EA-8AB6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Vasil Dimov via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Vasil Dimov <vd@FreeBSD.org>
>
> `git range-diff` calls `git log` internally and tries to parse its
> output. But `git log` output can be customized by the user in their
> git config and for certain configurations either an error will be
> returned by `git range-diff` or it will crash.
>
> To fix this explicitly set the output format of the internally
> executed `git log` with `--pretty=medium`. Because that cancels
> `--notes`, add explicitly `--notes` at the end.

Good finding.  

Shouldn't we also disable customizations that come from the
configuration variables like diff.external, diff.<driver>.command?

Thanks.

