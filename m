Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836B6C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 16:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F7A6138D
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 16:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhJUQj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:39:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52343 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUQj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 12:39:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68939161088;
        Thu, 21 Oct 2021 12:37:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ySodfcoQ3eE2WZIBVhtYVWeOinYDWKQCIAfyxO
        JOKcA=; b=n6noid5hPa5hjw0v3hT9Bm95izBfuxp3kahROkVKQZ2zbUuex8ZAPP
        1Jyf2ZMEJGK6oh5+TH7x1hbqlJu8vUgKFpjZWyrycRe/C78MvYYdC1PSOzlmXsRE
        KR54fJeP6xFXUfleTFr83mKB2ewc0iLeiS73RFntNL5Mxlx9k7mnM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61407161087;
        Thu, 21 Oct 2021 12:37:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C9A0F161086;
        Thu, 21 Oct 2021 12:37:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        peff@peff.net
Subject: Re: [PATCH 05/11] builtin/repack.c: avoid leaking child arguments
References: <cover.1634787555.git.me@ttaylorr.com>
        <a68c77c00638bef7e8ce88929015a587d2d1b6f8.1634787555.git.me@ttaylorr.com>
Date:   Thu, 21 Oct 2021 09:37:07 -0700
In-Reply-To: <a68c77c00638bef7e8ce88929015a587d2d1b6f8.1634787555.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 20 Oct 2021 23:39:57 -0400")
Message-ID: <xmqqmtn2mj0s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 224552AC-328D-11EC-9582-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> `git repack` invokes a handful of child processes: one to write the
> actual pack, and optionally ones to repack promisor objects and update
> the MIDX.
>
> In none of these cases do we bother to call child_process_clear(), which
> frees the memory associated with each child's arguments and environment.
>
> In order to do so, tweak each function that spawns a child process to
> have a `cleanup` label that we always visit before returning from each
> function. Then, make sure that we call child_process_clear() as a part
> of that label.

I have a slight aversion against the fact that this patch makes us
call child_process_clear(), when we know we may have called
finish_command().  Callers of finish_command() in other codepaths
rely on the fact that finish_command() calls child_process_clear(),
which means that because of this change, we are now constrained to
keep child_process_clear() idempotent?
