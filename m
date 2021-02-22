Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947DBC433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 18:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A0046504E
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 18:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhBVSNT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 13:13:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63019 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhBVSNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 13:13:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45401BB8F3;
        Mon, 22 Feb 2021 13:12:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6uMD2ArR9vPbtYBf4IeqEZ94GeE=; b=Z7oqbe
        VC6XU8uGptxknWUTkEFDArBEThoaoq/HTrQU2nl99UzIiOWPP/Zmo6YrLdKV8ARS
        Wr/8Tv4YYhoEh/5te+wt9HLP1ais+6dsOfAijkQc5NG0i9bODq2BuhXpSLIIODuC
        sfN1Zx06+BSiaOkBl8tSI+hw5qajub5ezFPgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xBAnywTn0iiD8v8c1ZJFHHSs3wPolGpI
        SqRYgFaG2CH77i5KaRsBVR/u4hF5Q3MXGrmomrQQpWvnfR/jD6e87LE6ogpmHGDi
        Yr5lkrP45o/AuoipS/Iwm4H7VFWZos65EU1i8CAjZsy2ElWGfqkEY+6EHRdMBroZ
        L6RfIBMrvqI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B354BB8F2;
        Mon, 22 Feb 2021 13:12:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B6430BB8F0;
        Mon, 22 Feb 2021 13:12:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>,
        Li Linchao <lilinchao@oschina.cn>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4] builtin/clone.c: add --reject-shallow option
References: <pull.865.v3.git.1612793576910.gitgitgadget@gmail.com>
        <pull.865.v4.git.1613891147977.gitgitgadget@gmail.com>
Date:   Mon, 22 Feb 2021 10:12:33 -0800
In-Reply-To: <pull.865.v4.git.1613891147977.gitgitgadget@gmail.com> (Li
        Linchao via GitGitGadget's message of "Sun, 21 Feb 2021 07:05:47
        +0000")
Message-ID: <xmqq35xo7yzy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8909B45E-7539-11EB-9537-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[jc: I've CC'ed Jonathan Tan, who is much more knowledgeable than I
am on the transport layer issues, to sanity check my assumption]

"Li Linchao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -1363,6 +1384,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			goto cleanup;
>  	}
>  
> +	if (reject_shallow) {
> +		if (local_shallow || is_repository_shallow(the_repository)) {

This may reject to clone from a shallow repository, but at this
point the bulk of the tranfer from the origin repository has already
happened, no?  Rejecting after transferring many megabytes feels a
bit too late.  That is one of the reasons why I kept hinting that
the transport layer needs to be taught an option to reject talking
to a shallow counterpart if we want to add this feature [*1*].

Also, wouldn't "clone --depth=1 --reject-shallow" from a repository
that is not shallow make the_repository a shallow one at this point
and makes it fail?  If the goal of the --reject-shallow option were
to make sure the resulting repository is not shallow, then that is a
technically correct implementation (even though it is wasteful to
transfer a full tree worth of megabytes and then abort), but is the
feature is explained to reject cloning from a shallow one, then
users would be suprised to see ...

> +			die(_("source repository is shallow, reject to clone."));

... this message, when cloning from well known publich repositories
that are not shallow.

I think cloning with --depth=<n> when the source repository is deep
enough, should be allowed, so the cleanest solution for the latter
may be to notice the combination of options that make the resulting
repository shallow (I mentioned --depth=<n>, but there may be others)
and the --reject-shallow option and error out before even talking
to the other side at the time we parse the command line.

Thanks.


[Footnote]

*1* Looking at Documentation/technical/pack-protocol.txt, "git
    fetch" seem to learn if the repository is shallow immediately
    upon contacting "upload-pack" during the Reference Discovery
    phase (we'd see 'shallow' packets if they are shallow). I
    suspect that the right solution would be to teach the codepath
    on the "git fetch" side that accepts, parses, and acts on this
    packet to optionally stop communication and error out when the
    caller asks not to talk with a shallow repository.
