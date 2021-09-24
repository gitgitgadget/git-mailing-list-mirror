Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263FBC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB9A61076
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347982AbhIXSOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:14:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51664 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344906AbhIXSOd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:14:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A374152E52;
        Fri, 24 Sep 2021 14:13:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p9shYcl6i82iIJ/32/Yf2b6R8nFLVfpG40tKTQ
        KCVVU=; b=oecpmsNZKbV3DSXQ6KJXbNXx2GDiyW+GrjBv6MbWOfZucDtBgvFvfd
        e2j8MV4CumRvLEZQ0pkE+utg5t2/fb/LQ7vlL4zPRe/MCfTmcZBIjbKt5Tp7EGck
        9yx/9VBJR3DkJhv4ICENykwS4giOkeoVwlPA3iTXuFCslEEuUbVSU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 63186152E51;
        Fri, 24 Sep 2021 14:13:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C6223152E50;
        Fri, 24 Sep 2021 14:12:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>
Cc:     git@vger.kernel.org
Subject: Re: Wrong option -h in grep, ls-remote, and show-ref.
References: <20210924141920.ezfpyf4uutob2h5z@zenon.in.qult.net>
Date:   Fri, 24 Sep 2021 11:12:56 -0700
In-Reply-To: <20210924141920.ezfpyf4uutob2h5z@zenon.in.qult.net> (Ignacy
        Gawedzki's message of "Fri, 24 Sep 2021 16:19:20 +0200")
Message-ID: <xmqqilypvo47.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BC83628-1D63-11EC-9851-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr> writes:

> What did you do before the bug happened? (Steps to reproduce your issue)
>
> git ls-remote -h
>
> What did you expect to happen? (Expected behavior)
>
> The same as git ls-remote --heads.
>
> What happened instead? (Actual behavior)
>
> Displayed the git ls-remote usage.

Thanks for a report, but this is very much working as intended.

There may be some subcommands that assign their own meaning to "-h"
for historical reasons (like "ls-remote -h origin"), or for external
reasons (like "grep -h -e pattern"), but most newbies expect a short
help out of "-h" uniformly across subcommands.

Fortunately, "-h" alone would not make any sense for "grep" (you
need a pattern) and you do not need to use "-h" for "ls-remote" [*].
We prioritized to help newbies by consistently giving a short help
across subcommands, over letting "git grep -h" to complain "you need
to give me a pattern", like so:

    $ git ls-remote --heads
    fatal: No remote configured to list refs from.

    $ git grep
    fatal: no pattern given

    $ git grep -h
    usage: git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]

    --cached              search in index instead of in the work tree
    ...

    $ git ls-remote -h
    usage: git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]
                         [-q | --quiet] [--exit-code] [--get-url]
    ...

HTH.


[Footnote]

* It is not end-user facing Porcelain, but is meant for scripting,
  and you can afford to write "--heads".  Besides, "-h" acts as
  "--heads" in "git ls-remote -h origin" or "git ls-remote -h -q"
  just fine.  Only the "-h and nothing else is given" case is
  sacrificed to help newbies in the case of this subcommand.



