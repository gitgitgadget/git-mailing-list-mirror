Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC25C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 17:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352151AbiCXRPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346726AbiCXRPM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 13:15:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2855643B
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 10:13:39 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7227C12B51E;
        Thu, 24 Mar 2022 13:13:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=28Lqc9PZul2iA1hA86K6Ln2FjgkD+sbHdNRIAD
        ZuVYg=; b=Uk2HzMBKInpzt4iTIo9GP/IZ8CN8Dlv/z7jy2sdhbD43LT2Cv0NH7V
        YoPVcd+KogHmh64WX4tf4EqA8JaybI1jsw6z0i1spt8DBn7BHbJ9qE7r+sF91l8G
        NuO4XcLRm/4U1izHQe4oFpW5gLAPUpUCNtqG8eDxyLjxAkFB2aPTM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6883312B51D;
        Thu, 24 Mar 2022 13:13:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D34AB12B51C;
        Thu, 24 Mar 2022 13:13:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/3] reset: make --no-refresh the only way to skip
 index refresh
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
        <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com>
        <6d424915-5c63-bebd-f3b5-f153a541d077@gmail.com>
Date:   Thu, 24 Mar 2022 10:13:36 -0700
In-Reply-To: <6d424915-5c63-bebd-f3b5-f153a541d077@gmail.com> (Phillip Wood's
        message of "Thu, 24 Mar 2022 11:11:02 +0000")
Message-ID: <xmqqsfr7jmtb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BEA8EC86-AB95-11EC-8675-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I should have been clearer in my comments that I think changing the
> option name no '--no-refresh' whilst retaining '--refresh' is 
> worthwhile. '--no-refresh' is the form that users will want most of
> the time and changing the option name means that the useful version
> will be shown by "reset -h".

I am OK with it shown as "--[no-]refresh" or even "--refresh" alone,
as long as the description describes the "refresh" behaviour and
makes it clear that it is the default, with the expectation that the
users know from other boolean options that "--option" listed in "-h"
would naturally take "--no-option".

But as posted, 

    $ rungit seen reset -h 2>&1 | grep refresh
        --refresh             skip refreshing the index after reset

the explanation given is for "--no-refresh" (which is wrong), so
we'd need some fix in the area.  We could rephrase it to read

        --refresh             refresh the index after reset (default)

but as you suggested, I think mimicking how existing commands with
"--no-<option>" are shown, e.g. builtlin/update-ref.c does
"--no-deref",

    $ git update-ref -h 2>&1 | grep deref
        --no-deref            update <refname> not the one it points to
    $ git grep 'OPT_BOOL.*"no-deref"'
    builtin/update-ref.c:		OPT_BOOL( 0 , "no-deref", &no_deref,

would be a good approach.

> The range-diff for the other changes looks good

Thanks.

#leftoverbit: we may want to discuss if it is a good idea to teach
OPT_BOOL() to list "--[no-]<option>" in "git cmd -h", instead of
just "--<option>".
