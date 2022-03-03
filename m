Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51789C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 21:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiCCV0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 16:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiCCV0n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 16:26:43 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D819144F77
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 13:25:57 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E70FB106CAE;
        Thu,  3 Mar 2022 16:25:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U4j2ogmXRwvCV8TFlaezlfjruwqtue4j7UIOHJ
        9eyrk=; b=jOAbTkfaMCNqsc8BWOqTGWXomNiQ99+a384d5skxMORb+JRrJTD0uw
        x25ic0F2LKQ91efXdZynDU/1mJNdGA0CZ78BWlDuhFtDjBpnvx4J8mvuPqkx3PfG
        1nlOeAbsvywh5Pe+IwXPclsiA1+u3hJrP8whZVa/1JFXFU/3QPw/I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBCAE106CAD;
        Thu,  3 Mar 2022 16:25:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C420106CAC;
        Thu,  3 Mar 2022 16:25:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r?= =?utf-8?Q?=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 05/13] submodule--helper: remove ensure-core-worktree
References: <20220301044132.39474-1-chooglen@google.com>
        <20220303005727.69270-1-chooglen@google.com>
        <20220303005727.69270-6-chooglen@google.com>
Date:   Thu, 03 Mar 2022 13:25:52 -0800
In-Reply-To: <20220303005727.69270-6-chooglen@google.com> (Glen Choo's message
        of "Wed, 2 Mar 2022 16:57:19 -0800")
Message-ID: <xmqqbkymaftr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 815F6EF8-9B38-11EC-9A16-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Move the logic of "git submodule--helper ensure-core-worktree" into
> run-update-procedure. Since the ensure-core-worktree command is

I take it as "... command is now obsolete", or "... has become
obsolete"?

> obsolete, remove it.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  builtin/submodule--helper.c | 12 ++----------
>  git-submodule.sh            |  2 --
>  2 files changed, 2 insertions(+), 12 deletions(-)

On the script side, the removed call to ensure-core-worktree used
to precede these invocations of the helper

    submodule--helper relative-path
    submodule--helper remote-branch
    submodule--helper print-default-remote

before we triggered run-update-procedure, so these helper calls were
done only after we made sure we have a submodule there at the path
and its configuration file has core.worktree set correctly.  If we
failed to do so, we wouldn't have made these calls.

Now we call them unprotected.  It is not immediately obvious if that
is a safe/sensible thing to do.

I would imagine that we would lose more and more code from the
script in the "while" loop before run-update-procedure is triggered,
and presumably the equivalent code will be added _after_ the call to
ensure_core_worktree() this patch adds to the beginning of
update_submodule2(), so in the end, the above will presumably become
a non-issue, but the series structure still feels iffy because of it.

