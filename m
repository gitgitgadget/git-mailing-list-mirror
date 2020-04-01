Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0735CC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 20:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEF420772
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 20:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rvHOwACS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbgDAUqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:46:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61187 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732345AbgDAUqY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 16:46:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5300D47AB4;
        Wed,  1 Apr 2020 16:46:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k72o5Qho6MpaM9qpTSEiMm2a1TY=; b=rvHOwA
        CStVY6lYzGypyESaL21FVN4CxQp/ymxJYKvsYCBjxW2N0plVUn2C2VhEhqUdjHPC
        hwJARRJRYFuYpzeEq89MvIzmoqWjX/bQ2cUr0Bmv7GqcrSVxsK8EXKiWIut8HYMi
        Oyf/nSyvNE7r+m0ImqmQ+oPoTGdYlMwxjUTl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mZGUIpU4h30eo+YOFz+Zs4TCBxoEt70t
        td4TPSz0FXuFKKAx2zB1Spb5Ov8qkyrJBcspA9XhD+1UnwYM4P7ZGWzygXXT9Yl7
        xTuDaUABX15IFIZ9oo6s41qnMqnS7Coqr9OYlmEPpreIOD1XKXn8ZGa9UopZ83g8
        zNQpd/OZgZw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49E8547AB2;
        Wed,  1 Apr 2020 16:46:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB74C47AB1;
        Wed,  1 Apr 2020 16:46:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, elbrus@debian.org,
        ijackson@chiark.greenend.org.uk, phillip.wood@dunelm.org.uk,
        alban.gruin@gmail.com, Johannes.Schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: honor GIT_REFLOG_ACTION
References: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 13:46:21 -0700
In-Reply-To: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Wed, 01 Apr 2020 20:31:35
        +0000")
Message-ID: <xmqqftdn53z6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D853F22C-7459-11EA-A614-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> There is a lot of code to honor GIT_REFLOG_ACTION throughout git,
> including some in sequencer.c; unfortunately, reflog_message() and its
> callers ignored it.  Instruct reflog_message() to check the existing
> environment variable, and use it when present as an override to
> action_name().
>
> Also restructure pick_commits() to only temporarily modify
> GIT_REFLOG_ACTION for a short duration and then restore the old value,

Yeah, I was wondering what you'd be doing about that setenv().  The
code around there looks good.  I briefly wondered what would happen
when the environment variable is totally unset upon entry, but then
we'd have the fallback value of action_name(opts) in there, so we
won't have a risk of running xstrdup(NULL).

