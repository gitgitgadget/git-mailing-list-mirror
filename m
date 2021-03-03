Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC92FC433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9259464EBA
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382487AbhCDAYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60874 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbhCDAAC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 19:00:02 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D8C2BEBCC;
        Wed,  3 Mar 2021 18:59:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GRydcKcYZaGsGpyvx6jbXwg2yds=; b=pM5cNN
        JOfmmF8zCeid52nZsZpC+7mBxBRYrRTRCCo2MjJO/N6X4lIIpdpAfSnrX6fIVeD4
        uibm/7zF/DU9M5ud44eSKc98gIHmxOUPGldC3gn3TG8AdIJp1Sc0k7FF/ez7ezDE
        6Wko6MYX3o/RRTKpIIwiIHP5F1LY/CgakEXvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LIXtRGtlIbRtnT67aw+o9YZxF5xphZns
        NHAHYVqeHaEEsuUnvneYSTQJ6GqGrAwVhLc/PqvBuhpItIWrEhAvU7x5VyxqRaoR
        F/UH8iSKmT4XUc6ikJuP/WPK7ankSLEs3H3qrq0NYnwJ5n7+zUSbdydHei3WIsYv
        MVAwDxUTt3Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 833DEBEBCB;
        Wed,  3 Mar 2021 18:59:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F41DBEBCA;
        Wed,  3 Mar 2021 18:59:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, stolee@gmail.com,
        johannes.schindelin@gmx.de, lilinchao@oschina.cn
Subject: Re: [PATCH v4] builtin/clone.c: add --reject-shallow option
References: <xmqq35xo7yzy.fsf@gitster.g>
        <20210301220319.3426185-1-jonathantanmy@google.com>
Date:   Wed, 03 Mar 2021 15:59:20 -0800
In-Reply-To: <20210301220319.3426185-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 1 Mar 2021 14:03:19 -0800")
Message-ID: <xmqqy2f3hjqf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78E29E5C-7C7C-11EB-98F3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This is true with protocol v0, but protocol v2 bundles all shallow
> information (whether coming from the fact that the remote is shallow or
> the fact that the fetcher specified --depth etc.) and sends them
> together with the packfile.

By the above do you mean what happens in FETCH_GET_PACK arm where
receive_shallow_info() is called when "shallow-info" header is seen,
before the code continues to process wanted-refs, packfile-uris and
then finally the packfile?

I do not think it makes much sense to ask any option to make us
shallow (like --depth=<n>) while --reject-shallow is in use (after
all, if the other side is deep enough to make us <n> commits deep,
there is no reason to reject the other side as the source), so your
"whether coming from the fact ..." part, while is a valid
observation, can be ignored in practice (meaning: it is OK to make
"--reject-shallow" be in effect only when we are trying to make a
full clone, and reject combinations of it with --depth=<n> and such
at the command parsing time).

> It may be possible to stop packfile download (saving bandwidth on
> the client side, at least) once such information is returned,
> though.

Just like "upload-pack" does not get upset by a client that comes
only for the initial refs advertisement and disconnects without
asking for any "want" (aka "ls-remote"), the server side should be
prepared to see if the other side cuts off after seeing the
"shallow-info" section header or after seeing the the whole
"shallow-info" section, so we should be able to leave early without
having to download the bulk data.  If the "upload-pack" spends
unnecessary cycles when it happens, then we need to fix that.  Even
if the "fetch" client does not willingly disconnect in the middle,
the network disconnect may happen at any point in the exchange, and
we'd need to be prepared for it.

Do we need to read and parse the "shallow-info" section, or would
the mere presense of the section mean the other side knows this side
needs to futz with the .git/shallow information (either because we
asked to be made shallow with --depth and the like, or because we
tried to clone from them and they are shallow)?

Thanks.

