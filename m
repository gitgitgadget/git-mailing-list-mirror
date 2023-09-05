Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B11CA0FF8
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 16:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjIEQAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244017AbjIEBJx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 21:09:53 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B561B9
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 18:09:48 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4B5518B39;
        Mon,  4 Sep 2023 21:09:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=d3rkQW7m/gX07UVUjZ4tVyzb12X1vizOKmHCQw
        qFj0Q=; b=S9Y0opUbJIJIQbOMlO3QeLJp4prGfH292RXs9hUAIIu3ckDjPKu8Av
        Py1JO1p0WpbetmYkDCniL7wWwE029pHsflsqNY85LMRt9PpHmANmaJkLIx845lfD
        dwkUrgHIW/xKofDwU3DAuiRik0uq2f/G82UboW175J3oy9lf2ThgE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF9B818B38;
        Mon,  4 Sep 2023 21:09:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6F74B18B37;
        Mon,  4 Sep 2023 21:09:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird?
 Bitmap error in git gc.
In-Reply-To: <CAPig+cTeQDMpWQ-zCf6i9H-yhrdCndX6gs67sypuqmHZZcHm7w@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 4 Sep 2023 20:26:10 -0400")
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
        <CAPig+cTeQDMpWQ-zCf6i9H-yhrdCndX6gs67sypuqmHZZcHm7w@mail.gmail.com>
Date:   Mon, 04 Sep 2023 18:09:42 -0700
Message-ID: <xmqqedjdtoh5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E599869A-4B88-11EE-9663-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This is not accurate. There is no default location for new worktrees;
> git-worktree creates the new worktree at the location specified by the
> user:
>
>     git worktree add [<options>] <path> [<commit>]
>
> where <path> -- the only mandatory argument -- specifies the location.

All correct.  The per-worktree part of the repository data does live
in a subdirectory of the ".git" directory and that was probably what
Tao had in mind, though.

> It indeed was designed to work this way. It is perfectly legitimate to
> create worktrees attached to a bare repository[1].
>
> [1]: Support for bare repositories in conjunction with multiple-
> worktrees, however, came after the initial implementation of multiple-
> worktrees. An unfortunate side-effect is that established terminology
> became somewhat confusing. In particular, in a bare repository
> scenario, the term "main worktree" refers to the bare repository, not
> to the "blessed" worktree containing the ".git/" directory (since
> there is no such worktree in this case).

Again all correct.

>> Is it the case that this contrib script predates the current "git
>> worktree" support?
>
> git-new-workdir predates git-worktree by quite a few years and, as I
> understand it, remains in-tree because it fills a niche not entirely
> filled by git-worktree.

I actually think there is no longer a valid workflow whose support
by "worktree" is still insufficient and the script has outlived its
usefulness.  I have been a heavy user of the new-workdir script to
maintain my build environments, but I always have the HEAD of these
workdir's detached, so I can easily switch my arrangement to use the
"git worktree" without losing any flexibility.

Perhaps we should remove it, possibly leaving a tombstone file like
how we removed stuff from the contrib/examples directory.
