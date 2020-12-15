Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2948FC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAEFB22CBB
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbgLOVpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 16:45:06 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62406 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgLOVow (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 16:44:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6633D115D1A;
        Tue, 15 Dec 2020 16:44:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qWkDCW2gY5YfC2OalEzS2lfuFe4=; b=YsdWIy
        8j2cYvULWrhBIXt1MCGgFJ9tk57i134TXYHUpmBiEDFnkTY2u1GxW8oq+SbpplFR
        n3r1ts+ECH7til8JEkHwstoUb7+6HB0VX9OMNPc4s/E6XweAlU4LUptuYEwlkY3e
        PhWOCKxyFBg9i3uwFjXlt1ZhRrB/3TVqORtmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s2CrGOB7D3K9SlfVmkmupOnXde7XHMkD
        SLJuLeme0v44B3bmodR7of9kTu6R3XOssEFsLzaaGaJKyiwYraMN/z9BdsDqDxBH
        Ua5nMqYVC4zWMRRsN22N9fE9f0Th2Bc7riw/JefHcBNlosazsJmtlJvxlwSMb1Vb
        r/qE5f1XF1g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E216115D19;
        Tue, 15 Dec 2020 16:44:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A5F5C115D18;
        Tue, 15 Dec 2020 16:44:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <periperidip@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v3 0/3] submodule: port subcommand add from shell to C
References: <20201214231939.644175-1-periperidip@gmail.com>
Date:   Tue, 15 Dec 2020 13:44:05 -0800
In-Reply-To: <20201214231939.644175-1-periperidip@gmail.com> (Shourya Shukla's
        message of "Tue, 15 Dec 2020 04:49:36 +0530")
Message-ID: <xmqqlfdy7niy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8B5606A-3F1E-11EB-8001-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <periperidip@gmail.com> writes:

>     3. In the following segment:
>         /*
>          * NEEDSWORK: In a multi-working-tree world, this needs to be
>          * set in the per-worktree config.
>          */
>         if (!git_config_get_string("submodule.active", &var) && var) {
>
>         There was a comment: "What if this were a valueless true
>         ("[submodule] active\n" without "= true")?  Wouldn't get_string()
>         fail?"
>
>         I was under the impression that even if the above failed, it
>         will not really affect the big picture since at the we will set
>         'submodule.name.active" as true irrespective of the above value.
>         Is this correct?

Let's see what kind of value the "submodule.active" variable is
meant to be set to.  Documentation/config/submodule.txt has this:

    submodule.active::
            A repeated field which contains a pathspec used to match against a
            submodule's path to determine if the submodule is of interest to git
            commands. See linkgit:gitsubmodules[7] for details.

It definitely is a string value, and making it a valueless true is
an error in the configuration.  I wonder if we want to diagnose such
an error, or can we just pretend we didn't see it and keep going?

Also the "var" (one of the values set for this multi-valued
variable) is never used in the body of the "if" statement.  The
other user of "submodule.active" in module_init() seems to use
config_get_value_multi() on it.  The new code may deserve a comment
to explain why that is OK to (1) grab just a single value out of the
multi-valued variable, and (2) not even look at its value.
