Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A60C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C646101C
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhHWQfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 12:35:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64400 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhHWQfx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 12:35:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5F353146889;
        Mon, 23 Aug 2021 12:35:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8lV/kG3bFDVfOtqKt46YjuXCv2wJ9ddmLkMHjc
        K1z/k=; b=WgUnJLfIia+y9zA7tGLr7+R+cGXMAyNuLAuyBJ9+tELVlYPnoq/RAj
        jV4UevOgXp3+wtf0912PQViLkrSJVdl9ZjnwTXZKtYhygLWLg+Z3Y7FL/shH6RBB
        rAegWVX015pVr9YTy7CS+CXJVhUBkJE17mspk55PCLT9jr3dcaFK8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57AAA146888;
        Mon, 23 Aug 2021 12:35:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9FC14146886;
        Mon, 23 Aug 2021 12:35:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Rafael Santiago <voidbrainvoid@tutanota.com>,
        Rafael Santiago via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Give support for hooks based on platform
References: <pull.1069.git.git.1629576007891.gitgitgadget@gmail.com>
        <YSF1GfpHXRrXebsB@camp.crustytoothpaste.net>
        <Mheyv1D--3-2@tutanota.com>
        <YSLKrX/QTZtxBGDz@camp.crustytoothpaste.net>
Date:   Mon, 23 Aug 2021 09:35:05 -0700
In-Reply-To: <YSLKrX/QTZtxBGDz@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Sun, 22 Aug 2021 22:07:41 +0000")
Message-ID: <xmqqo89oqfuu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13AD29BC-0430-11EC-A6EA-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Then, in general, it can be done in a shell script containing an if-then
> statement per platform using the native tools, so I'm not seeing the
> particular reason that this series is necessary if the hooks being
> executed aren't binaries.  All systems on which Git runs must contain a
> POSIX-compatible shell.

When we start defining our hooks in the configuration, this may fit
with the conditional inclusion of configuration files.  Current
conditions only can depend on where the repository is, but it is
easy to imagine that a conditional inclusion based on the value of
the configuration variable, so

	[includeIf "var:dev.host=mac"]
		path = ...
	[includeIf "var:dev.host=win"]
		path = ...

might be a way to say "if the dev.host configuration (presumably set
in somewhere like /etc/gitconfig or ~/.gitconfig) is set to this
value, take the configuration from the specified path.

It is up to the project to define the variable they use to switch
on; some project may ship with a set of hooks that can be used on
both windows and cygwin at the same time, in which case they do not
need the distinction between the two, and some other project may
care about the distinction.  Git does not have to impose or enforce
any policy about the granularity of what "the platform" is, with
such a scheme.

