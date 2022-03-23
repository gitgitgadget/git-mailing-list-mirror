Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E69C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240710AbiCWUxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344803AbiCWUwy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:52:54 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B5A710C6
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:51:24 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14B6A122711;
        Wed, 23 Mar 2022 16:51:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mDjLGBkzlPMJ4g8aHhI6RoITnIXLWmmJMBSwje
        d8wcU=; b=g+0ONx7yrFdwZ/E5WsUKa4SqAdfy+uCShLhgnHWUOLMgI5WlJKkmc/
        X+X1htrHhWU6HxlNSb749zmkrbCRHIQu0fyh7wghbmcDUXzH5dsVslUlLd+X5kEK
        eJ7Paj+L6CzAt+bBIrwNpCvaFnmSZLSpvKNuzg1ELwQmXrUHs+Uns=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D018122710;
        Wed, 23 Mar 2022 16:51:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 77DE012270E;
        Wed, 23 Mar 2022 16:51:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, lessleydennington@gmail.com
Subject: Re: [RFC PATCH] repo-settings: set defaults even when not in a repo
References: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
Date:   Wed, 23 Mar 2022 13:51:22 -0700
In-Reply-To: <1b27e0b115f858a422e0a2891688227be8f3db01.1648055915.git.steadmon@google.com>
        (Josh Steadmon's message of "Wed, 23 Mar 2022 11:03:05 -0700")
Message-ID: <xmqqtuboqto5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FFF6FD64-AAEA-11EC-8ACB-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> prepare_repo_settings() initializes a `struct repository` with various
> default config options and settings read from a repository-local config
> file. In 44c7e62 (2021-12-06, repo-settings:prepare_repo_settings only
> in git repos), prepare_repo_settings was changed to issue a BUG() if it
> is called by a process whose CWD is not a Git repository. This approach
> was suggested in [1].
>
> This breaks fuzz-commit-graph, which attempts to parse arbitrary
> fuzzing-engine-provided bytes as a commit graph file.
> commit-graph.c:parse_commit_graph() calls prepare_repo_settings(), but
> since we run the fuzz tests without a valid repository, we are hitting
> the BUG() from 44c7e62 for every test case.

I think the right approach for such a breakage is to ensure it is in
a repository, not to force prepare_repo_settings() to lie.  In the
day-to-day real code paths the end user uses, we do want to catch
mistakes in our code that calls prepare_repo_settings() when we are
not in a repository.

