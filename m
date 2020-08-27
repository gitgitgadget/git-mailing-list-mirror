Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AD5C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 16:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69E92080C
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 16:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wU2oQUWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0QIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:08:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61948 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0QIK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 12:08:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BE458638B;
        Thu, 27 Aug 2020 12:08:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z1PJHO1b2PsZ5eETcWzGnnFxvLs=; b=wU2oQU
        WpGwajdlcdfAbxk5F7pIcIl9Eqbk9JFj6X2W1XntWklSsQCIw8OOr+1T/aBaKucU
        /LwllozFyy5185Nv8ETAavLLaz9iYnerEzOrET+rLpXjXBBGr64qvuZFqdM5fc8g
        FxETC4c/Go96OWpiTBtj59fMeJANo5WnkRsVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IVQsrFZQsxnam2N2/eoau99kNZ8HsK/x
        q1Ur/8p1lZZzZbzUHpb0P8elN4OQL3Qhya8BATjYWE83RwmQcz7mkLFrlSOkMQMd
        NVNGj++qXVUV80wnKTuqPO15kXGZ9R7HlVUfBmB7u+XJwWzasfs2Q33UFkunfYxt
        T7m/EuiTG1U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 130F38638A;
        Thu, 27 Aug 2020 12:08:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F96C86389;
        Thu, 27 Aug 2020 12:08:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Henr=C3=A9?= Botha <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] worktree: add skeleton "repair" command
References: <20200827082129.56149-1-sunshine@sunshineco.com>
        <20200827082129.56149-2-sunshine@sunshineco.com>
Date:   Thu, 27 Aug 2020 09:08:05 -0700
In-Reply-To: <20200827082129.56149-2-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Thu, 27 Aug 2020 04:21:25 -0400")
Message-ID: <xmqqr1rsqdga.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E3584B4-E87F-11EA-9E43-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Worktree administrative files can become corrupted or outdated due to
> external factors. Although, it is often possible to recover from such
> situations by hand-tweaking these files, doing so requires intimate
> knowledge of worktree internals. While information necessary to make
> such repairs manually can be obtained from git-worktree.txt and
> gitrepository-layout.txt, we can assist users more directly by teaching
> git-worktree how to repair its administrative files itself (at least to
> some extent). Therefore, add a "git worktree repair" command which
> attempts to correct common problems which may arise due to factors
> beyond Git's control.
>
> At this stage, the "repair" command is a mere skeleton; subsequent
> commits will flesh out the functionality.

Sounds good.  It looked a bit odd to have skeleton test script only
to reserve its test number, but it is just odd and not wrong.

Let's read on.

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  Documentation/git-worktree.txt |  6 ++++++
>  builtin/worktree.c             | 15 +++++++++++++++
>  t/t2406-worktree-repair.sh     | 11 +++++++++++
>  3 files changed, 32 insertions(+)
>  create mode 100755 t/t2406-worktree-repair.sh
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 6ee6ec7982..ae432d39a8 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -15,6 +15,7 @@ SYNOPSIS
>  'git worktree move' <worktree> <new-path>
>  'git worktree prune' [-n] [-v] [--expire <expire>]
>  'git worktree remove' [-f] <worktree>
> +'git worktree repair'
>  'git worktree unlock' <worktree>
>  
>  DESCRIPTION
> @@ -110,6 +111,11 @@ and no modification in tracked files) can be removed. Unclean working
>  trees or ones with submodules can be removed with `--force`. The main
>  working tree cannot be removed.
>  
> +repair::
> +
> +Repair working tree administrative files, if possible, if they have
> +become corrupted or outdated due to external factors.
> +
>  unlock::
>  
>  Unlock a working tree, allowing it to be pruned, moved or deleted.
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 378f332b5d..88af412d4f 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -1030,6 +1030,19 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
>  	return ret;
>  }
>  
> +static int repair(int ac, const char **av, const char *prefix)
> +{
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +	int rc = 0;
> +
> +	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
> +	if (ac)
> +		usage_with_options(worktree_usage, options);
> +	return rc;
> +}
> +
>  int cmd_worktree(int ac, const char **av, const char *prefix)
>  {
>  	struct option options[] = {
> @@ -1056,5 +1069,7 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
>  		return move_worktree(ac - 1, av + 1, prefix);
>  	if (!strcmp(av[1], "remove"))
>  		return remove_worktree(ac - 1, av + 1, prefix);
> +	if (!strcmp(av[1], "repair"))
> +		return repair(ac - 1, av + 1, prefix);
>  	usage_with_options(worktree_usage, options);
>  }
> diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
> new file mode 100755
> index 0000000000..cc679e1a21
> --- /dev/null
> +++ b/t/t2406-worktree-repair.sh
> @@ -0,0 +1,11 @@
> +#!/bin/sh
> +
> +test_description='test git worktree repair'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	test_commit init
> +'
> +
> +test_done
