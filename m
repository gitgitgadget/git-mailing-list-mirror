Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFAEC433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 16:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbiEPQlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 12:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343742AbiEPQk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 12:40:56 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6722140D8
        for <git@vger.kernel.org>; Mon, 16 May 2022 09:40:53 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F094019124F;
        Mon, 16 May 2022 12:40:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VExm7+Xv9OBxU8D1S7YCaty2LIHVXwKFB4xSSa
        CEwws=; b=RT0cdIxSWUd+1t59YtwRR8EB1sPRKQT1IOMyOTCzfoegkytOiapl7s
        OC+6CNxwZMOxPHZqGQkZ90EQWcEE+WnLCcs3ielQoZoiQlR3KLY9yv7umsXIO51Z
        33vgr3IKFYSbABodkt9JTnXG1BoMaSJCjLgfv7OZSmmOkR2Y9QP90=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E8D1D19124E;
        Mon, 16 May 2022 12:40:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8A88019124D;
        Mon, 16 May 2022 12:40:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2 0/2] setup.c: make bare repo discovery optional
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
        <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 09:40:48 -0700
In-Reply-To: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Fri, 13 May 2022 23:37:36 +0000")
Message-ID: <xmqqy1z12zxr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F15A933A-D536-11EC-BE27-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * die()-ing is necessary if we're trying to flip the default value of
>    discovery.bare. We'd expect many bare repo users to be broken, and it's
>    more helpful to fail loudly than to silently ignore the bare repo.
>
>    But in the long term, long after we've flipped the default and users know
>    that they need to opt into bare repo discovery, would it be a better UX
>    to just silently ignore the bare repo?

Would a middle-ground of giving a warning() message help?  Can it be
loud and annoying enough to knudge the users to adjust without
breaking the functionality?

The longer-term default should be "cwd is allowed, but we do not
bother going up from object/04 subdirectory of a bare repository",
not "bare repositories should not be usable at all without GIT_DIR".

>      +    Add a config variable, `discovery.bare`, that tells Git whether or not
>      +    it should work with the bare repository it has discovered i.e. Git will
>      +    die() if it discovers a bare repository, but it is not allowed by

Missing comma before "i.e."

>      ++discovery.bare::
>      ++	Specifies what kinds of directories Git can recognize as a bare
>      ++	repository when looking for the repository (aka repository
>       +	discovery). This has no effect if repository discovery is not
>       +	performed e.g. the path to the repository is set via `--git-dir`
>       +	(see linkgit:git[1]).
>       ++
>       +This config setting is only respected when specified in a system or global
>       +config, not when it is specified in a repository config or via the command
>      ++line option `-c discovery.bare=<value>`.

;-)

>      +++
>      ++The currently supported values are `always` (Git always recognizes bare
>      ++repositories) and `never` (Git never recognizes bare repositories).
>      ++This defaults to `always`, but this default is likely to change.
>      +++
>      ++If your workflow does not rely on bare repositories, it is recommended that
>      ++you set this value to `never`. This makes repository discovery easier to
>      ++reason about and prevents certain types of security and non-security
>      ++problems, such as:

Hopefully "git fetch" over ssh:// and file:/// would run the other
side with GIT_DIR explicitly set?  As long as this recommendation
does not break these use cases, I think we are OK, but I do not yet
find these "problems, such as..." so convincing.
