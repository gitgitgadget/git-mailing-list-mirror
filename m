Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by archive.lwn.net (Postfix) with ESMTP id 070E37D910
	for <lwn-git@archive.lwn.net>; Wed, 11 Mar 2020 16:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbgCKQe4 (ORCPT <rfc822;lwn-git@archive.lwn.net>);
        Wed, 11 Mar 2020 12:34:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:36424 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730174AbgCKQez (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 12:34:55 -0400
Received: (qmail 2207 invoked by uid 109); 11 Mar 2020 16:34:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Mar 2020 16:34:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20385 invoked by uid 111); 11 Mar 2020 16:44:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Mar 2020 12:44:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Mar 2020 12:34:54 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] sequencer: clear state upon dropping a
 become-empty commit
Message-ID: <20200311163454.GC27893@coredump.intra.peff.net>
References: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
 <pull.722.v2.git.git.1583940623.gitgitgadget@gmail.com>
 <84b89d7843527d7b1f3e00f122dc1e82f1ced381.1583940623.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84b89d7843527d7b1f3e00f122dc1e82f1ced381.1583940623.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://archive.lwn.net:8080/git/20200311163454.GC27893@coredump.intra.peff.net/>
List-Archive: <http://archive.lwn.net:8080/git/>
List-Post: <mailto:git@vger.kernel.org>

On Wed, Mar 11, 2020 at 03:30:22PM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> In commit e98c4269c8 ("rebase (interactive-backend): fix handling of
> commits that become empty", 2020-02-15), the merge backend was changed
> to drop commits that did not start empty but became so after being
> applied (because their changes were a subset of what was already
> upstream).  This new code path did not need to go through the process of
> creating a commit, since we were dropping the commit instead.
> Unfortunately, this also means we bypassed the clearing of the
> CHERRY_PICK_HEAD and MERGE_MSG files, which if there were no further
> commits to cherry-pick would mean that the rebase would end but assume
> there was still an operation in progress.  Ensure that we clear such
> state files when we decide to drop the commit.

Thanks, I can confirm this fixes my case (which is not surprising, as it
is the same as your new test). The patch looks good. Two minor comments
below, but I doubt there is anything to act on.

> diff --git a/sequencer.c b/sequencer.c
> index 7477b15422a..e528225e787 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1957,6 +1957,8 @@ static int do_pick_commit(struct repository *r,
>  		flags |= ALLOW_EMPTY;
>  	} else if (allow == 2) {
>  		drop_commit = 1;
> +		unlink(git_path_cherry_pick_head(r));
> +		unlink(git_path_merge_msg(r));
>  		fprintf(stderr,
>  			_("dropping %s %s -- patch contents already upstream\n"),
>  			oid_to_hex(&commit->object.oid), msg.subject);

It feels like the set of paths to be cleaned up would probably exist
elsewhere in a helper function for cleaning up real cherry-picks. But
I'll defer to your expertise there, as I don't know the sequencer code
very well.

> +test_expect_success 'rebase --merge does not leave state laying around' '
> +	git checkout -B testing localmods~2 &&
> +	git rebase --merge upstream &&
> +
> +	test_path_is_missing .git/CHERRY_PICK_HEAD &&
> +	test_path_is_missing .git/MERGE_MSG
> +'

This could check the output of git-status to avoid poking around in the
.git directory itself. But I doubt that the exact filenames are going to
change, and parsing the output of status is its own problem (I don't
think we give this "state" info in a machine-readable way).

-Peff
