Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E76C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 23:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbhLUX0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 18:26:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55754 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbhLUX0y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 18:26:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80075FA0AD;
        Tue, 21 Dec 2021 18:26:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OAjOCn8jRPam71YtGqrpttmCYJLGKODWtA7o2a
        pslgg=; b=ITsVExujw6FqbtJL6q6qPChYOd0D9JV0fpdUgJRSdIPqsiCCcHqpew
        PUDbaXRb8p7DZ/pWoFoubXRvAHzdVIkSHyh8ZEcAZaXGJNjAUqzj2k0KN5CtNHuN
        tuvPonJ0pcn3mSzlcIVuiO8Qf2XLR7PBwydLObwa4xLsPvg252NEM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76CAFFA0A9;
        Tue, 21 Dec 2021 18:26:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE84EFA0A8;
        Tue, 21 Dec 2021 18:26:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH 1/9] tmp_objdir: add a helper function for discarding
 all contained objects
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
        <fab1b2c69eafbd3f211745886786c1d0ebdc05c2.1640109948.git.gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 15:26:48 -0800
In-Reply-To: <fab1b2c69eafbd3f211745886786c1d0ebdc05c2.1640109948.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 21 Dec 2021
        18:05:40 +0000")
Message-ID: <xmqqmtkto7yf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78F12588-62B5-11EC-8485-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  tmp-objdir.c | 5 +++++
>  tmp-objdir.h | 6 ++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/tmp-objdir.c b/tmp-objdir.c
> index 3d38eeab66b..adf6033549e 100644
> --- a/tmp-objdir.c
> +++ b/tmp-objdir.c
> @@ -79,6 +79,11 @@ static void remove_tmp_objdir_on_signal(int signo)
>  	raise(signo);
>  }
>  
> +void tmp_objdir_discard_objects(struct tmp_objdir *t)
> +{
> +	remove_dir_recursively(&t->path, REMOVE_DIR_KEEP_TOPLEVEL);
> +}
> +

OK.

Without a caller, it is a bit hard to judge if a separate helper
makes the caller easier to read and understand, or becomes an extra
layer of abstraction that obscures the logic.  Hopefully, having a
more specific function name with "tmp" and "discard" in it makes the
intent at callers more clear than the function that is named after
the detail of the operation.

> +/*
> + * Remove all objects from the temporary object directory, while leaving it
> + * around so more objects can be added.
> + */
> +void tmp_objdir_discard_objects(struct tmp_objdir *);
> +
>  /*
>   * Add the temporary object directory as an alternate object store in the
>   * current process.
