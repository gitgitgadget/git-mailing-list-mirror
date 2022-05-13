Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A42C433EF
	for <git@archiver.kernel.org>; Fri, 13 May 2022 01:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376322AbiEMBUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 21:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244317AbiEMBUX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 21:20:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5077A45535
        for <git@vger.kernel.org>; Thu, 12 May 2022 18:20:22 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 370301379A3;
        Thu, 12 May 2022 21:20:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rT/KwRaJ7g6H
        Y3hvU0hGTdxBQYY5bxTG0YPA8mlRwTQ=; b=h/B2aK03n6DyFhmzAr+WZl90vFQb
        6wFFWrGo5TJDrTn/sp7lOf2uS4qhnBkYCQN4HKmbvSlYeqY7wH9fjZGG7RezkWdE
        /fcJT+5pKNbFHv82nA2ErCdiTBqW2guKe3RAsow0ddYk16i79htazAQUCJJ1r/eo
        1yhaQ1M5EdCc4F4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D17A1379A2;
        Thu, 12 May 2022 21:20:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C1D81379A1;
        Thu, 12 May 2022 21:20:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 3/4] t0034: add negative tests and allow git init to
 mostly work under sudo
References: <20220510174616.18629-1-carenas@gmail.com>
        <20220513010020.55361-1-carenas@gmail.com>
        <20220513010020.55361-4-carenas@gmail.com>
Date:   Thu, 12 May 2022 18:20:19 -0700
In-Reply-To: <20220513010020.55361-4-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 12 May 2022 18:00:19 -0700")
Message-ID: <xmqqee0ycjos.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DB1B9242-D25A-11EC-B884-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Add a support library that provides one function that can be used
> to run a "scriplet" of commands through sudo and that helps invoking
> sudo in the slightly awkward way that is required to ensure it doesn't
> block the call (if shell was allowed as tested in the prerequisite)
> and it doesn't run the command through a different shell than the one
> we intended.
>
> Add additional negative tests as suggested by Junio and that use a
> new workspace that is owned by root.
>
> Document a regression that was introduced by previous commits where
> root won't be able anymore to access directories they own unless
> SUDO_UID is removed from their environment.
>
> The tests document additional ways that this new restriction could
> be worked around and the documentation explains why it might be instead
> considered a feature, but a "fix" is planned for a future change.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/lib-sudo.sh                  | 15 ++++++++
>  t/t0034-root-safe-directory.sh | 62 ++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>  create mode 100644 t/lib-sudo.sh

Heh.  I am a bit surprised that double sudo would become a separate
prerequisite, instead of a new part of SUDO prerequisite.  After all
we expect from SUDO prerequisite quite a lot (e.g. most sane
installatios facing end-users will futz with $PATH, but we require
not to do so to satisfy the SUDO prereq) and it is already very
narrowly targetted to a throw-away CI environment whose sudo
basically lets us do anything.

But that is not a serious enough "thing" to trigger a reroll.

This step looks good to me (others I'll comment later).

Thanks.
