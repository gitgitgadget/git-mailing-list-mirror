Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F4EC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbhKVR60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:58:26 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52451 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhKVR6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:58:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AB10A16FFC9;
        Mon, 22 Nov 2021 12:55:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KD4xOkA33tDDzhgbQbb1fmyqKMvNhGMc8KJ71+
        rpnxU=; b=hmEBPVb3a/sH7TQiomiN23uvbupFLtszHiffcYurRZF+hSCdBcLtHA
        jGbCOle8B7LuVS5b40fiqxLIXqtH+Pt0q3UWX37pJzS1v4BBdfWTNKj/STNczhDh
        Z5yCcRIL3LtGdBAv0FkzCqx9iUyv2D9N6dZelbLVOCwK1u/BsJcTY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A376916FFC8;
        Mon, 22 Nov 2021 12:55:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 090B016FFC7;
        Mon, 22 Nov 2021 12:55:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] pager: fix crash when pager program doesn't exist
References: <20211120194048.12125-1-ematsumiya@suse.de>
        <YZqSBlvzz2KgOMnJ@coredump.intra.peff.net>
        <xmqqfsrplz3z.fsf@gitster.g>
        <20211122153119.h2t2ti3lkiycd7pb@cyberdelia>
        <211122.86a6hwyx1b.gmgdl@evledraar.gmail.com>
        <20211122164635.6zrqjqow4xa7idnn@cyberdelia>
Date:   Mon, 22 Nov 2021 09:55:14 -0800
In-Reply-To: <20211122164635.6zrqjqow4xa7idnn@cyberdelia> (Enzo Matsumiya's
        message of "Mon, 22 Nov 2021 13:46:35 -0300")
Message-ID: <xmqqk0h0gjnh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 594976E0-4BBD-11EC-AA5F-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enzo Matsumiya <ematsumiya@suse.de> writes:

> However, IMHO it would make sense to try pager.<subcommand> if a
> previous attempt failed, e.g.:
>
> $ git config pager.show my-valid-pager
> $ GIT_PAGER=invalid-pager git -p show
>
> So this will first try invalid-pager, fail, and not try again, with the
> above patch. As a user, I would expect that my-valid-pager to be run in
> case invalid-pager failed.
>
> What do you think?

Interesting.  As presented here, it makes it look as if the user is
trying to override configured values for this particular invocation,
which would mean the environment must win (i.e. we should ignore
pager.<cmd> and only pay attention to GIT_PAGER), but if we consider
the way envionment is normally used, that is a faulty logic.  Just
like configuration variables are to set the value that the user
normally uses unless overridden, environment variables are the same
way.

I know $GIT_PAGER trumps core.pager, which indicates between
equivalents, environment is taken as a stronger wish.  But I do not
mind if the order were updated to pager.<cmd> trumps $GIT_PAGER,
which in turn trumps core.pager, which in turn trumps $PAGER.
