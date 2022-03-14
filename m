Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E115C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 21:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbiCNVPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 17:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiCNVPM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 17:15:12 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2240D3880
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 14:14:01 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E305188EE5;
        Mon, 14 Mar 2022 17:14:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c1vqdVEMsfklUyGzio2AHA6+ySoYA8oI35f8Ek
        TSbSA=; b=E1bZ1s1O8VwqHwjtQXM/y87U+TtANO+DLWLS5K8i2XinQqhiq3D/oS
        eR9lL7WOc50B7oaYpPLX6yliJsuWG3yUtXQssjmqAR88aR33BInkiw93WxbPMS3c
        rw/yLYgG1INFlSLljt1BPtgwANSvx9jm0+qkUz4xgws9uxvB7F0pQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 01822188EE4;
        Mon, 14 Mar 2022 17:14:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 770B2188EE3;
        Mon, 14 Mar 2022 17:13:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 8/9] git-sparse-checkout.txt: mark non-cone mode as
 deprecated
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <2d2b81986a55f0692d5536dec88079c58853f205.1647054681.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 21:13:57 +0000
In-Reply-To: <2d2b81986a55f0692d5536dec88079c58853f205.1647054681.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 12 Mar 2022
        03:11:20 +0000")
Message-ID: <xmqqa6dsp78q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9E320DA-A3DB-11EC-8E12-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +the default mode, but we do not recommend using it.  It does not work
> +with the `--sparse-index` option, and will likely be incompatible with
> +other new features as they are added.

If we explicitly say we have no intention to remove, while saying
that "non-cone" mode is a second class citizen, the users would be
confused. Does this mixed attitude only apply to non-cone mode, or
is it true for any other fringe features that we do not care about
in Git?

This does not build confidence with the Git software suite.  If we
are removing, then this attitude is OK, but if we are keeping it,
then we should promise that we never add features only to "cone".

> +INTERNALS -- NON-CONE PROBLEMS
> +------------------------------
> +
> +The `$GIT_DIR/info/sparse-checkout` file populated by the `set` and
> +`add` subcommands is defined to be a bunch of patterns (one per line)
> +using the same syntax as `.gitignore` files.  In cone mode, these
> +patterns are restricted to matching directories (and users only ever
> +need supply or see directory names), while in non-cone mode any
> +gitignore-style pattern is permitted.  Using the full gitignore-style
> +patterns in non-cone mode has a number of shortcomings:
> +
> +  * Fundamentally, it makes various worktree-updating processes (pull,
> +    merge, rebase, switch, reset, checkout, etc.) require O(N*M) pattern
> +    matches, where N is the number of patterns and M is the number of
> +    paths in the index.  This scales poorly.
> +
> +  * Avoiding the scaling issue has to be done via limiting the number
> +    of patterns via specifying leading directory name or glob.

These are valid.

> +  * Passing globs on the command line is error-prone as users may
> +    forget to quote the glob, causing the shell to expand it into all
> +    matching files and pass them all individually along to
> +    sparse-checkout set/add.  This both exacerbates the scaling
> +    problem, and hardcodes the list of selected files to those which
> +    were present at the time the initial set/add subcommand was run
> +    (and thus ignoring other files matching the same glob which come
> +    into the working tree after switching branches or pulling down
> +    updates).

That's end-user mistakes that is common to other things like
pathspecs, i.e. "git grep -- \*.c" vs "git grep -- *.c".  It hardly
deserves to spend more than 5 lines shouting.

> +  * It uses "ignore"/"exclude" syntax for selecting what to "include",
> +    which periodically causes confusion.

Well, .gitignore uses the syntax to select the paths to include or
exclude from a set, and then the set specifies what is left out of
the index.  I am not sure if that is the source of confusion.

> +  * It introduces inconsistencies in the Git command line, since other
> +    commands use pathspecs, but sparse-checkout (in non-cone mode) uses
> +    gitignore patterns.

But "cone" mode does not take pathspec, does it?  ":(icase)/A/B/C"
for example?  I do not see this as a credible argument against it.

> +  * It has edge cases where the "right" behavior is unclear.  Two examples:
> +
> +    First, two users are in a subdirectory, and the first runs
> +       git sparse-checkout set '/toplevel-dir/*.c'
> +    while the second runs
> +       git sparse-checkout set relative-dir

Are we aware which mode of sparse-checkout they are in?  Do we give
a mechanism for users to ask "we have 'non-cone' sparse checkout in
the sparse-checkout file.  we want to use the more efficient and
recommended 'cone' mode.  Please convert it", or even if there is
not an automated conversion mechansim, can the user manually do so
(which I suspect is not fundamentally possible---the cone mode is
inherently less expressive)?

If not, then we should expect these two users to _know_ (or at least
check before they run "set" subcommand) which mode is in use.

So, with that expectation,

> +    Should those arguments be transliterated into
> +       current/subdirectory/toplevel-dir/*.c
> +    and
> +       current/subdirectory/relative-dir

If we are using non-cone mode, then both would be recorded as-is.

If we are using cone mode, we may reject the one that ends with "*.c"
based on the two traits it has, i.e. (1) there is no such directory
in the working tree nor the index nor the HEAD, and (2) it has an
unusual character (i.e. glob) '*' to be in a real path.
