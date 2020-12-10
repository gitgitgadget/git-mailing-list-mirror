Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D92C19425
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43CF923770
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgLJAeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 19:34:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63438 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbgLJAdq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 19:33:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 697D29FC98;
        Wed,  9 Dec 2020 19:32:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7J7JsgeQOt3dFAI6fLNUMWOrcyc=; b=AU6mDn
        A5FQc8G/ibYPnOoNQFrFWhQT3tMFKCLgRCnb3ztwI0XUGSjCkvqzD87nkOVbKoPT
        l3ZuClepTWY492dUDB5fmkabaSXHy5faQnC5rwX8QfnARc+efk9UI0OEMuQ7LY4k
        0XhOZahk2LD32TKsfQPiKJHibPYQO1t1RqIgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fcrlsLsVH8V0o832Mp2DwwPSVdaAIyei
        ahAO3U8coWEuax/+UbsOKl0CEYWRl5bHYEZedl43xjKh9RbBb0tzGuDjbIXBmoiL
        OpJj2HOJeblJPXhtJO+OuXl/t3RjoXIFOfwLfj4Ow7cmynKN72fQec2oXi36Gcvl
        yAGiDC8anf0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60DD69FC97;
        Wed,  9 Dec 2020 19:32:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E040C9FC96;
        Wed,  9 Dec 2020 19:32:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v6 0/4] Maintenance IV: Platform-specific background
 maintenance
References: <pull.776.v5.git.1606191405.gitgitgadget@gmail.com>
        <pull.776.v6.git.1607542142.gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 16:32:58 -0800
In-Reply-To: <pull.776.v6.git.1607542142.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Wed, 09 Dec 2020 19:28:58
        +0000")
Message-ID: <xmqqpn3izeit.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40EB2008-3A7F-11EB-89D1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is based on ds/maintenance-part-3.
>
> After sitting with the background maintenance as it has been cooking, I
> wanted to come back around and implement the background maintenance for
> Windows. However, I noticed that there were some things bothering me with
> background maintenance on my macOS machine. These are detailed in PATCH 3,
> but the tl;dr is that 'cron' is not recommended by Apple and instead
> 'launchd' satisfies our needs.
>
> This series implements the background scheduling so git maintenance
> (start|stop) works on those platforms. I've been operating with these
> schedules for a while now without the problems described in the patches.
>
> There is a particularly annoying case about console windows popping up on
> Windows, but PATCH 4 describes a plan to get around that.
>
>
> Update in V6
> ============
>
>  * The Windows platform uses the tempfile API a bit better, including using
>    the frequency in the filename to make the test simpler.

Are two fix-up patches from Eric that have been queued near the top
of ds/maintenance-part-4 still relevant?  

At least, the "when invoked individually" patch that added an "-f"
option to two invocations of "rm" is still applicable, I would
think (I didn't look at the other one).

commit e3801c41e4d4cb1dd899942e04ab78310e781d07
Author: Eric Sunshine <sunshine@sunshineco.com>

    t7900: make macOS-specific test work on Windows

Notes (amlog):
    Message-Id: <20201130044224.12298-3-sunshine@sunshineco.com>

commit 1e5ddd79e2da18ee19b665a045d4187c5dc6234e
Author: Eric Sunshine <sunshine@sunshineco.com>

    t7900: fix test failures when invoked individually via --run

Notes (amlog):
    Message-Id: <20201130044224.12298-2-sunshine@sunshineco.com>
