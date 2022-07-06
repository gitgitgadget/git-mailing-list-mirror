Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31851C433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 18:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiGFSTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 14:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiGFST3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 14:19:29 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0106340
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 11:19:28 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE76A1A6740;
        Wed,  6 Jul 2022 14:19:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UK0DXnk/E2S3MxjrnEIGQe6fsEWmvtbLcGfycI
        xb/hQ=; b=CMNJ+hOttCF1LkTVLQFeqVjvpCH/e0fYoIVQxvXoMPB/lxey/oXk+X
        GuWKHDMrUWtbvnek4zO7z45IersRW0c8ajDfRyL1Inmiq8gaUfoJfRruNVyRT1Kg
        5aobuQlk+1GmSAr8TMlETVJ2Z7UajYXwQf446zwa4trXPGuzDAxbM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A64241A673F;
        Wed,  6 Jul 2022 14:19:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CCAE31A673E;
        Wed,  6 Jul 2022 14:19:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 3/3] clone: propagate empty remote HEAD even with other
 branches
References: <YsVAfudoUA5YkQWH@coredump.intra.peff.net>
        <YsVB2eOMp5guQfVr@coredump.intra.peff.net>
Date:   Wed, 06 Jul 2022 11:19:22 -0700
In-Reply-To: <YsVB2eOMp5guQfVr@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 6 Jul 2022 04:03:37 -0400")
Message-ID: <xmqqr12ygl3p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2999D58C-FD58-11EC-A877-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Instead, we should try to use the remote's HEAD, even if its unborn, to
> be consistent with the other cases.

Makes sense.  I haven't read the implementation but the design
decision to base on what the remote HEAD points at (either by
symrefs capability, or unborn capability) regardless of how many
objects we have would make the logic more straight-forward, I would
imagine.

> Some notes on the implementation:
>
>  - we don't emit any specific warning here, which is unlike the
>    empty-repo case (which says "you appear to have cloned an empty
>    reopsitory"). For non-bare clones, checkout() will issue a warning

reopsitory -> repository

>    like:
>
>      warning: remote HEAD refers to nonexistent ref, unable to checkout

Makes sense.

>    For a bare clone, it won't emit any warning at all (but will still
>    set up HEAD appropriately). That's probably fine. There's no part of
>    the operation we were unable to perform, so any "by the way, the
>    remote HEAD wasn't there but we pointed our HEAD to it anyway"
>    message would be purely informational. Though perhaps one could argue
>    the same about the current "empty repository" message in a bare
>    clone.

I am kind of surprised that the code still behaves differently
between empty and non-empty cases.  Given the earlier decision above
to consistently use the remote's HEAD, I would have expected that
setting HEAD to point at an non-existent ref would be done at one
place, instead of being done for empty and non-empty clone
separately.  We'll find out why while reading the patch, I think.

>  - if the remote told us about its HEAD via the unborn extension, this
>    is obviously the right thing to do. If they didn't, we'll fall back
>    to our local default name. As the "unborn" extension was added in
>    v2.31.0, we'd expect hosts which don't support it to become
>    decreasingly common, and it may not be worth worrying too much about.

True.

>    But for the sake of completeness, here are some thoughts:
>
>      - if the remote has a non-HEAD "master", we may still end up with a
>        local "master" that isn't connected to it. This is because the
>        "how to set local unborn HEAD" code is independent from the "did
>        we find a remote HEAD we can checkout" code. This could be fixed,
>        but I'm not sure it's worth caring too much about, since you'd
>        have to really try hard to create such a situation.

Hmph.

>      - if the remote has branches but doesn't tell us about its HEAD,
>        we could pick one of those branches as our HEAD instead of
>        whatever our local default is. This feels on-balance worse to me.

Sorry, I do not quite get this.  Is this about an old version of the
server without symrefs, where we try to find the object name HEAD
(possibly indirectly) points at in the objects their refs/heads/*
point at to infer which branch they are on?

>        While it might do the right thing in some cases (especially if
>        there is only a single branch), it could certainly lead to
>        surprising and unintuitive outcomes in others.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/clone.c        |  7 +++++--
>  t/t5702-protocol-v2.sh | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index b7d3962c12..aa0729f62d 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1298,9 +1298,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			if (!our_head_points_at)
>  				die(_("Remote branch %s not found in upstream %s"),
>  				    option_branch, remote_name);
> -		}
> -		else
> +		} else {
>  			our_head_points_at = remote_head_points_at;
> +			if (!our_head_points_at)
> +				setup_unborn_head(transport_ls_refs_options.unborn_head_target,
> +						  reflog_msg.buf);
> +		}
>  	}
>  	else {
>  		if (option_branch)

OK.  This is sort-of expected.

> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 00ce9aec23..822ca334c4 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -250,6 +250,44 @@ test_expect_success 'bare clone propagates empty default branch' '
>  	grep "refs/heads/mydefaultbranch" file_empty_child.git/HEAD
>  '
>  
> +test_expect_success 'clone propagates empty default branch from non-empty repo' '
> +	test_when_finished "rm -rf file_empty_parent file_empty_child" &&
> +
> +	git init file_empty_parent &&
> +	(
> +		cd file_empty_parent &&
> +		git checkout -b branchwithstuff &&
> +		test_commit --no-tag stuff &&
> +		git symbolic-ref HEAD refs/heads/mydefaultbranch
> +	) &&

OK.

> +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
> +	git -c init.defaultBranch=main -c protocol.version=2 \
> +		clone "file://$(pwd)/file_empty_parent" \
> +		file_empty_child 2>stderr &&
> +	grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD &&
> +	grep "warning: remote HEAD refers to nonexistent ref" stderr
> +'

OK.  This is called "empty" but actually has objects with a branch
that are unrelated to the "current" branch which is unborn.

> +test_expect_success 'bare clone propagates empty default branch from non-empty repo' '
> +	test_when_finished "rm -rf file_empty_parent file_empty_child.git" &&
> +
> +	git init file_empty_parent &&
> +	(
> +		cd file_empty_parent &&
> +		git checkout -b branchwithstuff &&
> +		test_commit --no-tag stuff &&
> +		git symbolic-ref HEAD refs/heads/mydefaultbranch
> +	) &&
> +
> +	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
> +	git -c init.defaultBranch=main -c protocol.version=2 \
> +		clone --bare "file://$(pwd)/file_empty_parent" \
> +		file_empty_child.git 2>stderr &&
> +	grep "refs/heads/mydefaultbranch" file_empty_child.git/HEAD &&
> +	! grep "warning:" stderr
> +'

Likewise.

