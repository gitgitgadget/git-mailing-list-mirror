Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9496C6FA8F
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 16:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjH2QuC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 12:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237583AbjH2Qtm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 12:49:42 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9725B8
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 09:49:15 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3789D1AEBEF;
        Tue, 29 Aug 2023 12:49:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m2sMwLusymuX9lLRYsNZ1URt1dCQriD4m7yci0
        tOBWA=; b=lDn7h3M/ya/V8uCrBg3qawwK+XuEFC4u/B08tmIzzAOvzO8kWc3dn8
        0EIATAMHJ4Y18pk4ZUMK9nplgCq+Y31DuFvshUeoKCgCxh496w+VPdPCxllGdlOE
        naxw5l1uDGZnjUA0NnlACSTDcoVINYm93P0ezDQy6VVmkjaZnIEPI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F0F51AEBEE;
        Tue, 29 Aug 2023 12:49:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 20B5C1AEBED;
        Tue, 29 Aug 2023 12:49:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(linux-asan-ubsan): let's save some time
References: <pull.1578.git.1693304963963.gitgitgadget@gmail.com>
Date:   Tue, 29 Aug 2023 09:49:12 -0700
In-Reply-To: <pull.1578.git.1693304963963.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 29 Aug 2023 10:29:23
        +0000")
Message-ID: <xmqqzg29equv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC3FB092-468B-11EE-91F0-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Every once in a while, the `git-p4` tests flake for reasons outside of
> our control. It typically fails with "Connection refused" e.g. here:
> https://github.com/git/git/actions/runs/5969707156/job/16196057724
>
> 	[...]
> 	+ git p4 clone --dest=/home/runner/work/git/git/t/trash directory.t9807-git-p4-submit/git //depot
> 	  Initialized empty Git repository in /home/runner/work/git/git/t/trash directory.t9807-git-p4-submit/git/.git/
> 	  Perforce client error:
> 		Connect to server failed; check $P4PORT.
> 		TCP connect to localhost:9807 failed.
> 		connect: 127.0.0.1:9807: Connection refused
> 	  failure accessing depot: could not run p4
> 	  Importing from //depot into /home/runner/work/git/git/t/trash directory.t9807-git-p4-submit/git
> 	 [...]
>
> This happens in other jobs, too, but in the `linux-asan-ubsan` job it
> hurts the most because that job often takes over a full hour to run,
> therefore re-running a failed `linux-asan-ubsan` job is _very_ costly.
> ...
> For good measure, also skip the Subversion tests because debugging C
> code run via Perl scripts is as much fun as debugging C code run via
> Python scripts. And it will reduce the time this very expensive job
> takes, which is a big benefit.

Makes sense to me.

> diff --git a/ci/lib.sh b/ci/lib.sh
> index 369d462f130..8e4e6713344 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -280,6 +280,8 @@ linux-leaks)
>  	;;
>  linux-asan-ubsan)
>  	export SANITIZE=address,undefined
> +	export NO_SVN_TESTS=LetsSaveSomeTimeBack
> +	MAKEFLAGS="$MAKEFLAGS NO_PYTHON=YepItFlakesTooOften"
>  	;;
>  esac

Hmph, we do not have NO_P4_TESTS to match, which lead to the
apparent inconsistency that is a bit of shame, but I think blanket
exclusion of Python is OK because we are very unlikely to add new
Python dependencies.  s/ItFlakes/P4Flakes/ might be a good protection
against Python enthusiasts complaining, though ;-)

Thanks, will queue.
