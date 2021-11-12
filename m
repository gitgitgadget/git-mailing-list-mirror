Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30768C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 23:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14CD61073
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 23:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhKLX0U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 18:26:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51323 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhKLX0T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 18:26:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA333FBC10;
        Fri, 12 Nov 2021 18:23:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LhnSdM+ezdhe6dtGntVXMzVb7LQhbqAUUkyTcy
        R7++8=; b=ClCQfC7Ca1HMGwDM6/gtDPBWwz45MsIhR30/AdOE5xGo0VdkRgDj2d
        8XigKkhblVDhSpol1Zrsn6WMCIG1qIVG3pfdgglA8mHlfLYj3+5DPemlV5DTPXqy
        1BOouAUsHJ4+sr7eZRa9iBChf+8fg4lFPcFjFW2tk6ZNHs+JpHON8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1E3EFBC0F;
        Fri, 12 Nov 2021 18:23:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3CBF4FBC0E;
        Fri, 12 Nov 2021 18:23:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Samuel Yvon via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Samuel Yvon <samuelyvon9@gmail.com>
Subject: Re: [PATCH v2] builtin-commit: re-read file index before run_status
References: <pull.1127.git.git.1636423586620.gitgitgadget@gmail.com>
        <pull.1127.v2.git.git.1636653331034.gitgitgadget@gmail.com>
Date:   Fri, 12 Nov 2021 15:23:26 -0800
In-Reply-To: <pull.1127.v2.git.git.1636653331034.gitgitgadget@gmail.com>
        (Samuel Yvon via GitGitGadget's message of "Thu, 11 Nov 2021 17:55:30
        +0000")
Message-ID: <xmqqpmr5nekx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A093B68-440F-11EC-8E19-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Samuel Yvon via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The comment suggesting that the cache must be reset after run_status
> and before the editor being launched was added in ec84bd00,
> (git-commit: Refactor creation of log message., 2008-02-05). It is
> unclear why the run_status must be called *after* the cache reset.

An older thread cited earlier suspected that it is to reflect the
changes given to "git commit" proper, excluding whatever pre-commit
did, to the return value of run_status(), which becomes the value of
committable variable to answer "do we have anything to commit?".

And moving the call would affect both the contents of the status
buffer (i.e. the list of paths got changed starts including what
pre-commit did) and the "committable" bit by counting such a change
as a true change, avoiding the "no empty commit by default" check,
in a consistent way, hopefully.  I wonder if we have test to
demonstrate that, and if there isn't perhaps we would want to add
one.

> However, calling run_status after the cache reset does not update
> the status line to state of the current index in the case a
> pre-commit hook is ran and changes files in the staging area.

And if this change also affects the "committable" assignment in a
consistent way, it should probably want to be mentioned in this
paragraph, too.

I am not convinced by the claim that there is no need for careful
transition plans (yet), but I personally agree with the end state
(with the above suggested tweaks, that is).

Thanks for working on the topic.
