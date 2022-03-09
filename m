Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1E4C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 19:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbiCITO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237326AbiCITOV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 14:14:21 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD93BDBD13
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 11:13:22 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4905218F25E;
        Wed,  9 Mar 2022 14:13:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hTWyaHzTxODumPvtiulLTL9I0p97JD7ZpXriiH
        ShVs0=; b=q7QBh0BPu/Q5sYmQ36he5St0atWr75WMRM9/A6phcey/QBYzAk+MuA
        CqeekTwyFtOB2JOH/YO11Y7+Sypn64Drw0IB0cnNr9jIhfL6tmrUPmrubT4aMMDg
        r2z6FxXJw8kyd6yAzcGq7EZCGnrQ39rR30PYIKgm8YcOtmbzWkUeU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 40DC318F25D;
        Wed,  9 Mar 2022 14:13:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ACC1818F25C;
        Wed,  9 Mar 2022 14:13:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v5 00/10] fetch --recurse-submodules: fetch unpopulated
 submodules
References: <20220304005757.70107-1-chooglen@google.com>
        <20220308001433.94995-1-chooglen@google.com>
        <xmqqr17dp8s9.fsf@gitster.g>
        <kl6lh7885mm3.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 09 Mar 2022 11:13:18 -0800
In-Reply-To: <kl6lh7885mm3.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Tue, 08 Mar 2022 10:24:04 -0800")
Message-ID: <xmqqfsnrkkhd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB2BE7AE-9FDC-11EC-8DD1-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> This uses a "first one wins approach", which obviously doesn't have
> correctness guarantees. But in practice, I don't think this is likely to
> cause problems:
>
> - As far as I can tell, the only value we read from .gitmodules is
>   'submodule.<name>.fetchRecurseSubmodules', and this value gets
>   overridden by two other values: the CLI option, and the config
>   variable with the same name in .git/config.
>
>   During "git submodule init", we copy the config values from
>   .gitmodules to .git/config. Since we can only fetch init-ed submodules
>   anyway, it's quite unlikely that we will ever actually make use of the
>   .gitmodules config.

These are reasonable.

> - Even if we do use the .gitmodules config values, it's unlikely that
>   the values in .gitmodules will change often, so it _probably_ won't
>   matter which one we choose.

What bad things would we see if the value changes during the span of
history of the superproject we fetched?  How often we would see
broken behaviour is immaterial and breakage being rare is a no excuse
to import a new code with designed-in flaw.  Unless the "rare" is
"never", that is.

I would think using ANY values from .gitmodules without having the
end-user agree with the settings and copying the settings to the
.git/config is a BUG.  So if it mattered from which superproject
commit we took .gitmodules from, that would mean we already have
such a bug and it is not a new problem.

That would be a reasonable argument for this topic. Together with
the previous point, i.e. we do not copy values we see in the in-tree
.gitmodules file to .git/config anyway, it would make a good enough
assurance, I would think.

> - This only matters when the submodule is not in the index. If the
>   submodule _is_ in the index, we read .gitmodules from the filesystem
>   i.e. these patches shouldn't change the behavior for submodules in the
>   index.

How often we would see broken behaviour does not matter.  If it is
broken when the submodule is not in the index, we need to know.

But as you said, it does not sound likely that in-tree .gitmodules
matters.

It leads to a possible #leftoverbit clean-up.  Because we only fetch
submodules that are initialized, the API functions we are using in
this series has no reason to require us to feed _a_ commit in the
superproject to them so that they can find .gitmodules in them.

Fixing the API can probably be left outside the scope of the topic,
to be done soon after the dust from the topic settles, I think, to
avoid distracting us from the topic.

Thanks.


