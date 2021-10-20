Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F727C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 19:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A10461372
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 19:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhJTTro (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:47:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56082 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhJTTro (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 15:47:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3348F4B6F;
        Wed, 20 Oct 2021 15:45:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N++pB8m0m+8lu8Rf4dwFxO3kicHQkTiMRSFl1c
        t1Ltc=; b=mcN2WlXYGX6IuSA9t2TO37KxSdB/PFk7Ft6EmG/0N04R/MJv4NT18Y
        qDq5YGy04+DtTULzVzCFtSvFGZQDJRrp4U/u+zC5u/QpreBWmvtaPL3EDoJH6lk4
        lpxIsMbLo5LNH+WIlZoRnObQkslv0nsGZyGSJ96gbkLJIXhq5YpBo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB28FF4B6E;
        Wed, 20 Oct 2021 15:45:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1BEADF4B6C;
        Wed, 20 Oct 2021 15:45:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/4] remote: use remote_state parameter internally
References: <20211013193127.76537-1-chooglen@google.com>
        <20211019224339.61881-1-chooglen@google.com>
        <20211019224339.61881-3-chooglen@google.com>
Date:   Wed, 20 Oct 2021 12:45:27 -0700
In-Reply-To: <20211019224339.61881-3-chooglen@google.com> (Glen Choo's message
        of "Tue, 19 Oct 2021 15:43:37 -0700")
Message-ID: <xmqqzgr3o4yw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46C25F08-31DE-11EC-A9FF-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Introduce a struct remote_state member to structs that need to
> 'remember' their remote_state. Without changing external-facing
> functions, replace the_repository->remote_state internally by using the
> remote_state member where it is applicable i.e. when a function accepts
> a struct that depends on the remote_state. If it is not applicable, add
> a struct remote_state parameter instead.
>
> As a result, external-facing functions are still tied to the_repository,
> but most static functions no longer reference
> the_repository->remote_state. The exceptions are those that are used in
> a way that depends on external-facing functions e.g. the callbacks to
> remote_get_1().
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  remote.c | 153 ++++++++++++++++++++++++++-----------------------------
>  remote.h |  10 ++++
>  2 files changed, 81 insertions(+), 82 deletions(-)

This made my "git push" to k.org and other places over ssh segfault
when their tip and what I am attempting to push are identical.  I
haven't spent more time than just to bisect the history down to
identify this commit as the possible culprit.


