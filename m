Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B7FC433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 21:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiFWV7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 17:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFWV7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 17:59:24 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EED52AE22
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 14:59:23 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95FB613EFCE;
        Thu, 23 Jun 2022 17:59:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BNov7GHBpcnwKlGeXgeEDAZDGd+fnUdgfex+q4
        B1xeI=; b=kogsuDc+RVF670FIs11k3GStW12tkYCi739x1BPyAf6A55RGgm4xbu
        uc8m170r4LMr02fF0S6ioDDI0nyevfTzXDid97QyV32DmtqLo3AABYenvgzI59xk
        ocZ0g/ByyviVUodKi/1bv0sublbV1Dk2nAm/u3dV2+lEkqL8QjIl8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D1CE13EFCC;
        Thu, 23 Jun 2022 17:59:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E951A13EFCB;
        Thu, 23 Jun 2022 17:59:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, derrickstolee@github.com,
        lessleydennington@gmail.com, vdye@github.com, avarab@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3] commit-graph: refactor to avoid prepare_repo_settings
References: <Yjt6mLIfw0V3aVTO@nand.local>
        <9b56496b0809cc8a25af877ea97042e2cb7f2af6.1655246092.git.steadmon@google.com>
Date:   Thu, 23 Jun 2022 14:59:20 -0700
In-Reply-To: <9b56496b0809cc8a25af877ea97042e2cb7f2af6.1655246092.git.steadmon@google.com>
        (Josh Steadmon's message of "Tue, 14 Jun 2022 15:37:21 -0700")
Message-ID: <xmqq1qvfyrbb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCED0250-F33F-11EC-8A6C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> This series of changes broke fuzz-commit-graph, which attempts to parse
> arbitrary fuzzing-engine-provided bytes as a commit graph file.
> commit-graph.c:parse_commit_graph() calls prepare_repo_settings(), but
> since we run the fuzz tests without a valid repository, we are hitting
> the BUG() from 44c7e62 for every test case.
>
> Fix this by moving the majority of the implementaiton of
> `parse_commit_graph()` into a new function,
> `parse_commit_graph_settings()` that accepts a repo_settings pointer.
> This allows fuzz-commit-graph to continue to test the commit-graph
> parser implementation without relying on prepare_repo_settings().

It sounds like this is not a "fix" but a workaround to bend the
production code so that a non-production test shim can be inserted
more easily.

I am OK with the idea, but have a huge problem with the new name.

Is it just me who thinks parse_commit_graph_settings() is a function
that parses some kind of settings that affects the way the commit
graph gets used or written?

Stepping back a bit, why can't fuzz-commit-graph prepare a
repository object that looks sufficiently real?  Something along the
lines of...

                struct repository fake_repo;

                fake_repo.settings.initialized = 1;
                fake_repo.gitdir = ".";
                parse_commit_graph(&fake_repo, (void *)data, size);
		...

Also, I feel somewhat uneasy to see these changes:

> -	if (get_configured_generation_version(r) >= 2) {
> +	if (s->commit_graph_generation_version >= 2) {
> -	if (r->settings.commit_graph_read_changed_paths) {
> +	if (s->commit_graph_read_changed_paths) {
> -	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
> +	ctx->write_generation_data = (r->settings.commit_graph_generation_version == 2);
>  	ctx->num_generation_data_overflows = 0;

that makes the production code bend over backwards to _avoid_
referencing 'r', only to cater to the test shim.  That's an
artificial limitation we are forcing on our developers who works on
this code.  It might be that what is in the repository settings is
sufficient for today's code to work, but I do not think needs for
fuzz tests should tie the hand of this production code by forbidding
it to look at other things in the repository in the future.  After
all, tests are to serve the production code, not the other way
around.

On the other hand, I think a change that is slightly smaller than
the posted patch, which justifies itself with a completely different
rationale, would be totally acceptable.  You can justify this change
with NO mention of fuzzers.

    The parse_commit_graph() function takes a "struct repository *"
    pointer, but all it cares about is the .settings member of it.

    Update the function and all its existing callers so that it
    takes "struct repo_settings *" instead.

Now, in the future, some developers _might_ find it necessary to
access stuff other than the repository settings to validate the
contents of the graph file, and we may need to change it to take a
full repository structure again.  The test should adjust to such
needs of the production code, not the other way around.  But until
then...

Thanks.
