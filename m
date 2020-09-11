Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A709C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3997722208
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TMtsB5nb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgIKTel (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 15:34:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64212 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgIKTe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 15:34:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7252E81E1C;
        Fri, 11 Sep 2020 15:34:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ww8NkPMgBV24S9gOwo/MCBDKMTM=; b=TMtsB5
        nbxdPaHqE4qx8sp074zwz9oKpEaM7pAs2qk8j1SW3VrFobKbOZw4/CZp+nYXEpzB
        Us/tdhm+gvJZ4CIMUsK9rqfX4IwCLJfHMw/w/lZloLMFSkm36xCniILv9AGYakIr
        QYIyznFVPvhNOzJyAyPfeNPLUbnw801QVQs/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yYeSrMwMhn3noqaw+/2ylS9G6LNFVg0l
        B+3XMoPkvwOxRUzU39cBhg6VltKZwVdb8NeXjg/oDJXrYfrYM1eSecI0fb40huMq
        XcgyrsqI16IvyZc7Evf2sp/OnDGXnqIekI3lJxy+Fi+PFRJ6CehemL+4ICd0bTOu
        DBDgO4sbGNE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 69C3881E1B;
        Fri, 11 Sep 2020 15:34:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E98C781E1A;
        Fri, 11 Sep 2020 15:34:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>
Subject: Re: [PATCH 0/4] clone: allow configurable default for -o/--origin
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
Date:   Fri, 11 Sep 2020 12:34:24 -0700
In-Reply-To: <pull.727.git.1599848727.gitgitgadget@gmail.com> (Sean Barag via
        GitGitGadget's message of "Fri, 11 Sep 2020 18:25:23 +0000")
Message-ID: <xmqqblicnm4f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC99E8D8-F465-11EA-854D-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sean Barag via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Took another pass at supporting a configurable default for-o/--origin, this
> time following Junio's suggestions from a previous approach as much as
> possible [1]. Unfortunately, Johannes mentioned that --template can write
> new config values that aren't automatically merged without re-calling 
> git_config. There doesn't appear to be a way around this without rewriting
> significant amounts of init and config logic across the codebase.
>
> While this could have been v2 of the original patchset, it's diverged so
> drastically from the original that it likely warrants its own root thread.
> If that's not appropriate though, I'd be happy to restructure!

I did wonder if this series came from the same motivation while
scanning messages in the mailbox and saw no "v2" in the subject, but
I am OK either way in a case like this.  

I DO appreciate this note to explain why it is not marked with "v2".
