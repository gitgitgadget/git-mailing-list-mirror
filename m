Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF7CB1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 02:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfDXCJO (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 22:09:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62484 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfDXCJO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 22:09:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C4CA13EE38;
        Tue, 23 Apr 2019 22:09:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hGt+Rgb/F/lYdUE5OIjq9qGon3E=; b=evG7z1
        EjCGKQLuuyQTK5oPIWlGT4h9eDhhUSveere/hsg/cZ85E5s8getNzZwE2QwJ81Fp
        Viix1utMQTLb1d/kc5jKfJSPkvQnFDL/sXErV9SLPsTmLFikjjp8Kf/Lrz2Eg/8Y
        0u/4Jn4nnObNfYQkIlXaiCqHQRksn9hepcEsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cgJmsQi1CmZryxATgitSXrA6AaL7RkFV
        P2MlyLN06gDTxYVFGXH+xr3Fv05GXnyRMg9BcoNpi0bIrtN19dIn4MniRZLg6rOS
        ffdjHZcWthH+GlnxBR7FCu17p23MsBJyeYXfDQvRiinNJuvLFGyinx89D90JiX4T
        jtDJjjGxPWI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2297E13EE35;
        Tue, 23 Apr 2019 22:09:12 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8733F13EE34;
        Tue, 23 Apr 2019 22:09:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Multiple hook support
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
Date:   Wed, 24 Apr 2019 11:09:10 +0900
In-Reply-To: <20190424004948.728326-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 24 Apr 2019 00:49:43 +0000")
Message-ID: <xmqqtveo2lyx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F37AA3DA-6635-11E9-B9F3-DF19F34BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> To preserve backwards compatibility, we don't run the hooks in the ".d"
> directory if the single file is a valid hook (i.e. it exists and is
> executable). This is because some people already have multiple hook
> scripts configured, and if we ran them both, we'd run the hooks twice.
> This would be bad for e.g. the prepare-commit-msg hook. This is also the
> least surprising behavior.

OK.  An obvious alternative may be to see if the expected hooks path
is a directory and use the contents.  If ".git/hooks/pre-commit" is
a single file, we know it is the single hook as before, and if it is
a directory, we know that is not a custom made (i.e. from the world
before this series supported in the core-git) multi-hook setup.

> We check each hook for its exit status, even if the hook normally
> ignores exit status, and if it fails, we abort executing further hooks.

This part may become the most controversial in the whole topic, but
a design discussion is helped by having a concrete proposal that
makes its own design decision, and this is the simplest design of
the failure case that is the easiest to understand.

Thanks.  Let's see how the review discussion goes ;-)

> brian m. carlson (5):
>   run-command: add preliminary support for multiple hooks
>   builtin/receive-pack: add support for multiple hooks
>   sequencer: add support for multiple hooks
>   builtin/worktree: add support for multiple post-checkout hooks
>   transport: add support for multiple pre-push hooks
>
>  builtin/am.c                       |  28 ++--
>  builtin/commit.c                   |   5 +-
>  builtin/receive-pack.c             | 212 +++++++++++++++++------------
>  builtin/worktree.c                 |  40 ++++--
>  run-command.c                      | 117 ++++++++++++----
>  run-command.h                      |   9 +-
>  sequencer.c                        |  96 ++++++++-----
>  t/lib-hooks.sh                     | 156 +++++++++++++++++++++
>  t/t5403-post-checkout-hook.sh      |   8 ++
>  t/t5407-post-rewrite-hook.sh       |  15 ++
>  t/t5516-fetch-push.sh              |  29 ++++
>  t/t5571-pre-push-hook.sh           |  19 +++
>  t/t7503-pre-commit-hook.sh         |  15 ++
>  t/t7505-prepare-commit-msg-hook.sh |   9 ++
>  transport.c                        |  98 +++++++------
>  15 files changed, 636 insertions(+), 220 deletions(-)
>  create mode 100644 t/lib-hooks.sh
