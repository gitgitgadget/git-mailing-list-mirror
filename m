Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C460C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 05:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33479613DC
	for <git@archiver.kernel.org>; Mon, 10 May 2021 05:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhEJFtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 01:49:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58525 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhEJFtK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 01:49:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18FC3C69BA;
        Mon, 10 May 2021 01:48:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7huFrdImWW+ViOUd0TAFligvZlCT+VRX2PPi6T
        sS8BQ=; b=pBVk2gpSdB2HbY0rqCFiTC+Z+LnuASmk5Xzp2yB5tQZ/0lZ97x/0V6
        s4Wmtv1QPBpLlgzNiYB16c/qnOamqixJ8q3zbdkQfquJ2mxvG7f7GEgQPKCtwVIt
        1CHsZy68EclW6bIC07mT6dS2pOAbBlk7ERhymX/xjR6NXuGxHZYlE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EDF9C69B9;
        Mon, 10 May 2021 01:48:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 44C72C69B8;
        Mon, 10 May 2021 01:48:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 6/8] dir: avoid unnecessary traversal into ignored
 directory
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
        <66ffc7f02d08f3f07cb3cb2605b113a630f1e127.1620503945.git.gitgitgadget@gmail.com>
Date:   Mon, 10 May 2021 14:48:04 +0900
In-Reply-To: <66ffc7f02d08f3f07cb3cb2605b113a630f1e127.1620503945.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sat, 08 May 2021
        19:59:02 +0000")
Message-ID: <xmqq35uvrvfv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A5E2D1A-B153-11EB-A6CE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Some sidenotes about possible confusion with dir.c:

Thanks for working on untangling this mess ;-)

> * "ignored" often refers to an untracked ignore", i.e. a file which is
>   not tracked which matches one of the ignore/exclusion rules.  But you
>   can also have a "tracked ignore", a tracked file that happens to match
>   one of the ignore/exclusion rules and which dir.c has to worry about
>   since "git ls-files -c -i" is supposed to list them.

OK.  This is to find a pattern in .gitignore that is too broad
(i.e. if the path were to be added as a new thing today, it would
require "add -f"), right?  The combination of "-i -c" does make
sense for that purpose.

> * The dir code often uses "ignored" and "excluded" interchangeably,
>   which you need to keep in mind while reading the code.  

True.  In tree .gitignore files are to hold exclude patterns, and
per repository personal exclude file is called $GIT_DIR/info/exclude
which is confusing.

> Sadly, though,
>   it can get very confusing since ignore rules can have exclusions, as
>   in the last of the following .gitignore rules:
>       .gitignore
>       *~
>       *.log
>       !settings.log
>   In the last entry above, (pathspec->items[3].magic & PATHSPEC_EXCLUDE)
>   will be true due the the '!' negating the rule.  Someone might refer
>   to this as "excluded".

That one I've never heard of.  As far as I am concerned, that is a
negative exclude pattern.

I do wish we started the project with .gitignore files and
$GIT_DIR/info/ignore both of which holds ignore patterns and
negative ignore patterns from day one, but the boat sailed
long time ago.

