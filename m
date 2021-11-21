Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0755C433F5
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 08:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhKUIOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 03:14:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59073 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhKUIOS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 03:14:18 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2609B1794B9;
        Sun, 21 Nov 2021 03:11:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t5Eom/d7IwyRgNrWN6SxgcPAQtw7X3b4z2dDGR
        tzsWw=; b=sPWAI9dYNS/ZGwd6v/aXXRv0dSwpiakfL+6vWQXlVUKTqmdSjspfCS
        qwCpPQrcq0bniALYUJNbm/i4v/HMq3BO3YHf++UM18Mkv/BrVN7uQmh7JeKGiJbS
        CYZIlyIERwjlbKwUUNSJak33ppvutxfQLDqd+ffvpShUEvng1Ct7Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1153A1794B8;
        Sun, 21 Nov 2021 03:11:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 615AA1794B7;
        Sun, 21 Nov 2021 03:11:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/8] Avoid removing the current working directory, even
 if it becomes empty
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
Date:   Sun, 21 Nov 2021 00:11:10 -0800
In-Reply-To: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Sun, 21 Nov 2021 00:46:52
        +0000")
Message-ID: <xmqqo86elyht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96A44D88-4AA2-11EC-825C-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Traditionally, if folks run git commands such as checkout or rebase from a
> subdirectory, that git command could remove their current working directory
> and result in subsequent git and non-git commands either getting confused or
> printing messages that confuse the user (e.g. "fatal: Unable to read current
> working directory: No such file or directory"). We already refuse to remove
> directories that have untracked files within them[1], preferring to show an
> error; with this series, we tweak that rule a bit to also refuse to remove
> the current working directory even if it has no untracked files within it.

The goal is roughly that we do not allow rmdir() of a directory at
"prefix" in the working tree, or any parent directory of it, for
functions that uses RUN_SETUP?  By the time we attempt to rmdir(),
most likely we'd chdir()'ed up to the top of the working tree
ourselves, so we need to remember where the original cwd was when we
started, and protecting the original cwd would mean that we protect
the directory in which the process that spawned us, like the user's
interactive shell, is still sitting, which makes sense.


