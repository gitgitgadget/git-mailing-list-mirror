Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2013C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 23:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhKWXqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 18:46:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52766 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhKWXqD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 18:46:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8097EF3682;
        Tue, 23 Nov 2021 18:42:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9Bd8DU801vLuzTY4olzeE/iz9KEWHGYNaFcG8Z
        JTCwY=; b=GgHTF6No+HbPqL7+y2MX93quwNNEpGd2gOrEAsbxXeL7FdlGUNS+Fm
        +1POP3vSBsrcMkIs1PzVuXR38zBehL1IpH2M2gO3vH0XcyBbqZU2ECwKfNO5IvWv
        GABdLQdPAcGm6HHvPr41aK1cwl82fnAh1GuJVwMZqeB/4rrCwurOM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 778D4F3681;
        Tue, 23 Nov 2021 18:42:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C8DA9F367E;
        Tue, 23 Nov 2021 18:42:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v4 2/4] test-read-cache: set up repo after git directory
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
        <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
        <5bc5e8465ab5fe871965e6c6d578efc51e55b505.1637620958.git.gitgitgadget@gmail.com>
Date:   Tue, 23 Nov 2021 15:42:51 -0800
In-Reply-To: <5bc5e8465ab5fe871965e6c6d578efc51e55b505.1637620958.git.gitgitgadget@gmail.com>
        (Lessley Dennington via GitGitGadget's message of "Mon, 22 Nov 2021
        22:42:36 +0000")
Message-ID: <xmqq4k82781w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13E9CFDC-4CB7-11EC-98C2-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Lessley Dennington <lessleydennington@gmail.com>
>
> Move repo setup to occur after git directory is set up. This will ensure
> enabling the sparse index for `diff` (and guarding against the nongit
> scenario) will not cause tests to start failing, since that change will include
> adding a check to prepare_repo_settings() with the new BUG.

This looks obviously the right thing to do.  Would anything break
because of the "wrong" ordering of events in the original code?

IOW, can this "bugfix" be protected with a new test against
regression?

> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---
>  t/helper/test-read-cache.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
> index b52c174acc7..0d9f08931a1 100644
> --- a/t/helper/test-read-cache.c
> +++ b/t/helper/test-read-cache.c
> @@ -39,8 +39,6 @@ int cmd__read_cache(int argc, const char **argv)
>  	int table = 0, expand = 0;
>  
>  	initialize_the_repository();
> -	prepare_repo_settings(r);
> -	r->settings.command_requires_full_index = 0;
>  
>  	for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
>  		if (skip_prefix(*argv, "--print-and-refresh=", &name))
> @@ -56,6 +54,9 @@ int cmd__read_cache(int argc, const char **argv)
>  	setup_git_directory();
>  	git_config(git_default_config, NULL);
>  
> +	prepare_repo_settings(r);
> +	r->settings.command_requires_full_index = 0;
> +
>  	for (i = 0; i < cnt; i++) {
>  		repo_read_index(r);
