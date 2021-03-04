Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79A4C1551A
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9503964F53
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354265AbhCDBDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:03:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64488 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452911AbhCDAjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E68310F391;
        Wed,  3 Mar 2021 19:38:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vjb9KR3iVIXKjJmeRSU6QchMcjc=; b=iZKUw8
        nAORyMp6/qVrGGxIpHlJzDN2wdGE+5QZdPfLhj16SwhSwGXXLq7BFiAP/G3a8xCb
        DsYzO4KEM5O1TjPyZ5Cpgh7vKT4pB9rJvxVQZlh2yPObY2l4N1bWEW0n3Zmi3/Ii
        sTMdeF8eG6tQ0cbQxwM2IZnVodjbJTZA1wQgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m/7Ra+5fRzi7iugiPkn3dXdKNnCCfEIV
        +QjM6Y6VhK00s7aRQ5+SMht2VefOcPIm8sWRRx2rcTee3BtIDa29R9xtmC1s7H+f
        kOjQDZ1bTYLh3389ez1BJG20aUCCfcyx7Cr6J5v5sKyFSXIQMdTnfURXnIqDeOQr
        QshkRESM5TQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0708010F38F;
        Wed,  3 Mar 2021 19:38:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4BC1410F38E;
        Wed,  3 Mar 2021 19:38:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/2] stash show: learn --include-untracked and
 --only-untracked
References: <cover.1613459474.git.liu.denton@gmail.com>
        <cover.1614770171.git.liu.denton@gmail.com>
Date:   Wed, 03 Mar 2021 16:38:31 -0800
In-Reply-To: <cover.1614770171.git.liu.denton@gmail.com> (Denton Liu's message
        of "Wed, 3 Mar 2021 03:16:41 -0800")
Message-ID: <xmqq4khrhhx4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2EE62A8-7C81-11EB-9BEC-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> A blindspot that I've noticed in git is that it's not possible to
> properly view a stash entry that has untracked files via `git stash
> show`. Teach `git stash show --include-untracked` which should do this.
> In addition, this series also teaches `--only-untracked` and the
> `stash.showIncludeUntracked` config option.
>
> This series is based on 'dl/stash-cleanup'.
>
> Changes since v3:
>
> * Incorporate Junio's SQUASH??? commits
>
> * Implement a custom unpack_trees() callback to detect the case where
>   there are duplicate entries in worktree and untracked commits

I actually expected the latter enhancement to be done outside the
scope of this series.  I briefly looked at the callback but I am not
convinced that it is correct (e.g. how do you notice and barf when
the untracked tree records foo/bar.txt and the index or the working
tree records foo as a file?).

Thanks.
