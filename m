Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A050BC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 20:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345403AbhLVURK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 15:17:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58109 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbhLVURJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 15:17:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C81C110DBEE;
        Wed, 22 Dec 2021 15:17:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x9l1NGtAMtm/b/kbczczSf7XQ6MuURctJAJcU6
        hdpkE=; b=YkworuiAx76VNGWZoy66QY2r2d8V4k/PyROZEvW84dSI1e4qIsV1nd
        T6ojymZTVpKcE77c6YmR+cCgAg85sGrHj+TvyCM3e5it4gmC4T2mYm6GkN7LUdiL
        wHL+XQFokBqk7l620aGNk4AmCGk+FN9Hd5qrehQKG7fVIg5j+ZryE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BDA2310DBED;
        Wed, 22 Dec 2021 15:17:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CEBD910DBEC;
        Wed, 22 Dec 2021 15:17:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 4/4] t7004: use "test-tool ref-store" for reflog inspection
References: <pull.1168.git.git.1640170784.gitgitgadget@gmail.com>
        <5d693273e5852ae9b302cb79e8dd986b6ffa10da.1640170784.git.gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 12:17:06 -0800
In-Reply-To: <5d693273e5852ae9b302cb79e8dd986b6ffa10da.1640170784.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Wed, 22 Dec 2021
        10:59:44 +0000")
Message-ID: <xmqqfsqkied9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2329C68C-6364-11EC-AEF7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This makes the test work with reftable.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ...
> -	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog2 >actual &&
> +	test-tool ref-store main for-each-reflog-ent refs/tags/tag_with_reflog2 | sed -e "s/^.*	//" >actual &&
>  	test_cmp expected actual
>  '

Yup, this makes perfect sense.  Purists may be bothered by having
anything _we_ write, like "test-tool" on the upstream of a pipe to
hide its exit code, though.

After applying these four patches on top of 'master', I still see
some mention of logs/refs in the t/ directory.  Some of them may
be a low-hanging fruit other people can take a look at and convert
to the test-helper calls to help us move the reftable topic forward
without stepping on your toes, hopefully?

Thanks.

t/t0060-path-utils.sh:test_git_path GIT_COMMON_DIR=bar logs/refs/bisect/foo     .git/logs/refs/bisect/foo
t/t0060-path-utils.sh:test_git_path GIT_COMMON_DIR=bar logs/refs                bar/logs/refs
t/t0060-path-utils.sh:test_git_path GIT_COMMON_DIR=bar logs/refs/               bar/logs/refs/
t/t0060-path-utils.sh:test_git_path GIT_COMMON_DIR=bar logs/refs/bisec/foo      bar/logs/refs/bisec/foo
t/t0060-path-utils.sh:test_git_path GIT_COMMON_DIR=bar logs/refs/bisec          bar/logs/refs/bisec
t/t0060-path-utils.sh:test_git_path GIT_COMMON_DIR=bar logs/refs/bisectfoo      bar/logs/refs/bisectfoo
t/t0060-path-utils.sh:test_git_path GIT_COMMON_DIR=bar logs/refs/heads/main     bar/logs/refs/heads/main
t/t1301-shared-repo.sh:	actual="$(ls -l .git/logs/refs/heads/main)" &&
t/t1301-shared-repo.sh:		echo Ooops, .git/logs/refs/heads/main is not 066x [$actual]
t/t1400-update-ref.sh:rm -f .git/logs/refs/heads/main
t/t1400-update-ref.sh:	test_path_is_file .git/logs/refs/heads/d1/d2/r1 &&
t/t1400-update-ref.sh:	test_must_fail git show-ref --verify -q logs/refs/heads/d1/d2 &&
t/t1400-update-ref.sh:	test_path_is_file .git/logs/refs/heads/d1/r2
t/t1400-update-ref.sh:	test_path_is_file .git/logs/refs/heads/e1/e2/r1 &&
t/t1400-update-ref.sh:	test_must_fail git show-ref --verify -q logs/refs/heads/e1/e2 &&
t/t1400-update-ref.sh:	test_path_is_file .git/logs/refs/heads/e1/r2 &&
t/t1407-worktree-ref-store.sh:	mkdir -p     .git/logs/refs/bisect &&
t/t1407-worktree-ref-store.sh:	echo $ZERO_OID > .git/logs/refs/bisect/random &&
t/t1407-worktree-ref-store.sh:	mkdir -p     .git/worktrees/wt/logs/refs/bisect &&
t/t1407-worktree-ref-store.sh:	echo $ZERO_OID > .git/worktrees/wt/logs/refs/bisect/wt-random &&
t/t1410-reflog.sh:	# now logs/refs/heads/one is a stale directory, but
t/t1410-reflog.sh:	done >.git/logs/refs/heads/reflogskip &&
t/t3200-branch.sh:	test_path_is_file .git/logs/refs/heads/d/e/f &&
t/t3200-branch.sh:	test_cmp expect .git/logs/refs/heads/d/e/f
t/t3200-branch.sh:	mv .git/logs/refs/heads/u real-u &&
t/t3200-branch.sh:	ln -s real-u .git/logs/refs/heads/u &&
t/t3200-branch.sh:	test_path_is_file .git/logs/refs/heads/g/h/i &&
t/t3200-branch.sh:	test_cmp expect .git/logs/refs/heads/g/h/i
