Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCC9C2BA2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 22:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C8A21973
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 22:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XRhUyhp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgDPWVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:21:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58081 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgDPWVu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 18:21:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB35A55DD1;
        Thu, 16 Apr 2020 18:21:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wivhHjpniRrUHAGjsUmNCogEbiA=; b=XRhUyh
        p78Vlq/ui5Uq/dju1BtYOojcX4XMAuE4ivjGBeGfyBddyme8z8QZ/YoHA5BtDvhR
        YzMA0ub94+KKgJ6bjYYYeur+rrh7EY1zGU0rWUksTIqB7pfqYicdQApQIso8dW41
        na6LLfXCiyxx8FAKH6O1vtouw/hPnIXYUHQmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=konjVWjpg0DtIJ2sxHiFb5fl9eypy7M5
        09v6h7qmq1YnXzGU1U0J59sp9ZehY7+i5ztH8Ud+nI2XPh2XFp0vLlLcl1Z4xOqt
        JZ85wBzMQYMmwPDl0Za+9l36R5LEsGJmbeOI6ATpI62wdpsPPwpo6qM+O7yOCf5k
        XCOo4SObxvU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A12F455DD0;
        Thu, 16 Apr 2020 18:21:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2EE5B55DCF;
        Thu, 16 Apr 2020 18:21:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v13 1/5] help: move list_config_help to builtin/help
References: <20200416211807.60811-1-emilyshaffer@google.com>
        <20200416211807.60811-2-emilyshaffer@google.com>
Date:   Thu, 16 Apr 2020 15:21:46 -0700
In-Reply-To: <20200416211807.60811-2-emilyshaffer@google.com> (Emily Shaffer's
        message of "Thu, 16 Apr 2020 14:18:03 -0700")
Message-ID: <xmqqd087xe9x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A91A3830-8030-11EA-85E5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Starting in 3ac68a93fd2, help.o began to depend on builtin/branch.o,
> builtin/clean.o, and builtin/config.o. This meant that help.o was
> unusable outside of the context of the main Git executable.
>
> To make help.o usable by other commands again, move list_config_help()
> into builtin/help.c (where it makes sense to assume other builtin libraries
> are present).
>
> When command-list.h is included but a member is not used, we start to
> hear a compiler warning. Since the config list is generated in a fairly
> different way than the command list, and since commands and config
> options are semantically different, move the config list into its own
> header and move the generator into its own script and build rule.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>
> msvc: the bugreport topic depends on a generated config-list.h file
>
> For reasons explained in 976aaedc (msvc: add a Makefile target to
> pre-generate the Visual Studio solution, 2019-07-29), some build
> artifacts we consider non-source files cannot be generated in the
> Visual Studio environment, and we already have some Makefile tweaks
> to help Visual Studio to use generated command-list.h header file.
>
> As this topic starts to depend on another such generated header file,
> config-list.h, let's do the same to it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Forgot to proofread and edit the log message into reasonable shape
when you squashed two patches together?

I wonder if the "squash" action of "rebase -i" can be taught to
detect a mistake like this?
