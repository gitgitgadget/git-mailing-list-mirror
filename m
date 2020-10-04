Return-Path: <SRS0=wQ61=DL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EDFC4363C
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 19:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C238206B6
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 19:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TwaphdZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgJDTzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Oct 2020 15:55:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61896 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgJDTzq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Oct 2020 15:55:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81C8F70288;
        Sun,  4 Oct 2020 15:55:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HjesrlX0zpQKA+Nl06mY3wnRMJY=; b=Twaphd
        ZxERJKamqXJu0w+bP5NvRxWFS5WZ8xK1jHDkblKls+SIwtkcwFsreSOQ5gKjR5Bs
        B6mSPgnl8WUqr+dQyHEnnVRLkfh82gK572SbGq0OMpqjn5EAEOXaR8Snn5qA5dMm
        mk+UTcfiRlKuwk3sadED6w5ryFg002JqbZTs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h350vylywEadEMVNRoFdbxeyQoVIYlFD
        JNvNGs1zNcuDENSDOQLiiZtY6vIVm3WwPEA+FYLb8/u5m7MXM7bdZGBnrYo6mJbP
        bGW3AfgvRYZkV7GA82DnwrYVkIMDOJQ+8PVMMXf1ydX0vy1D+su+RHx+tEYmNlyW
        XXVkraK7A04=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7ACBA70287;
        Sun,  4 Oct 2020 15:55:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B0D870285;
        Sun,  4 Oct 2020 15:55:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] gitsubmodules: add '--recurse-submodules' for 'ls-files'
References: <pull.861.git.git.1601774257696.gitgitgadget@gmail.com>
Date:   Sun, 04 Oct 2020 12:55:43 -0700
In-Reply-To: <pull.861.git.git.1601774257696.gitgitgadget@gmail.com> (Philippe
        Blain via GitGitGadget's message of "Sun, 04 Oct 2020 01:17:37 +0000")
Message-ID: <xmqqo8lh7olc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 967F7592-067B-11EB-8359-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -246,20 +246,23 @@ Workflow for an artificially split repo
>    # regular commands recurse into submodules by default
>    git config --global submodule.recurse true
>  
> -  # Unlike the other commands below clone still needs
> +  # Unlike most other commands below, clone still needs
>    # its own recurse flag:
>    git clone --recurse <URL> <directory>
>    cd <directory>
>  
>    # Get to know the code:
>    git grep foo
> -  git ls-files
> +  git ls-files --recurse-submodules
> +
> +[NOTE]
> +`git ls-files` also requires its own `--recurse-submodules` flag.

Makes sense.  Thanks, will queue.
