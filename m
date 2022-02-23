Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B3EC433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 21:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242426AbiBWV3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbiBWV3G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 16:29:06 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D331377FF
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:28:38 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 48F8B178F5B;
        Wed, 23 Feb 2022 16:28:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=q9/Xs+8VaqbD
        6qGnQASTcmZEC28c+GrkKLhOoPFzxTs=; b=LtnfY4drrVj+yIHJy15HtVN4y4fF
        sXHRiks2JHw0gQ7YI96QVeKE2F/7jeyFxmsU47oXskRQByyz1LHdCLjTRB0UmosV
        D74eMt+BMr0kNQUNCgF+v0zRCivNDBb8M3R9EuhTU0z6FtiH6PtOb2wadmeKy4Ew
        Q3qHj3rWQn/PQ2M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41578178F5A;
        Wed, 23 Feb 2022 16:28:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD9C0178F59;
        Wed, 23 Feb 2022 16:28:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 2/3] reflog: libify delete reflog function and helpers
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
        <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
        <e7c950218b1b6b91a3cecedf3d2339230522e2e0.1645554652.git.gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 13:28:34 -0800
In-Reply-To: <e7c950218b1b6b91a3cecedf3d2339230522e2e0.1645554652.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Tue, 22 Feb 2022 18:30:50
        +0000")
Message-ID: <xmqqzgmhs265.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8EE7224A-94EF-11EC-95AC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Currently stash shells out to reflog in order to delete refs. In an
> effort to reduce how much we shell out to a subprocess, libify the
> functionality that stash needs into reflog.c.
>
> Add a reflog_delete function that is pretty much the logic in the while
> loop in builtin/reflog.c cmd_reflog_delete(). This is a function that
> builtin/reflog.c and builtin/stash.c can both call.
>
> Also move functions needed by reflog_delete and export them.
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  Makefile         |   1 +
>  builtin/reflog.c | 451 +----------------------------------------------
>  object.h         |   2 +-
>  reflog.c         | 435 +++++++++++++++++++++++++++++++++++++++++++++
>  reflog.h         |  49 +++++
>  5 files changed, 490 insertions(+), 448 deletions(-)
>  create mode 100644 reflog.c
>  create mode 100644 reflog.h

This round, without polluting global namespace in reflog.h by moving
too many things there and instead keeping what is private to the
implementation in reflog.c, looks much better than the previous
round.

Looking good.

Thanks.
