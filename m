Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B735AC4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759FE206FC
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgLHVsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 16:48:45 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54402 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbgLHVsp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 16:48:45 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 62EACEF7D8;
        Tue,  8 Dec 2020 16:48:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dCFEDBI6z71+cnzei65+lIVLP70=; b=kRxDJH
        bWGCVQ8k1ZLkWG4GPQu1cN4OpYjQMinOPfdIse2mU/nTM96O1IuKijEANmpifeCr
        OaV07iy6tlghdnb4XNVT6q4yQF2LJOq+9bEcMIYi5kfIldjl1MH+ckE7ape++aWd
        of1WeCbH50N5GzevPjuRD1ag4GGRffS4DleEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S/i1LJ4i0MQ9mNCTJxG/VMQQnzlA/Dzy
        /gs6LbXdANHSldmoV6DfqI9YuflnhOPeF+zKCT3zp0xfWESG+bFD/MtiGGl2XcqI
        f8lAareimhZ8uw1aW0qL9O2h/b9Px96X1ujKyCA1zC6h0XZanv3daidLt+ABkWIg
        cX6eIJ1gjoI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B5A4EF7D6;
        Tue,  8 Dec 2020 16:48:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9DCB5EF7D5;
        Tue,  8 Dec 2020 16:47:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] worktree: teach `repair` to fix multi-directional breakage
References: <20201208173705.5770-1-sunshine@sunshineco.com>
Date:   Tue, 08 Dec 2020 13:47:56 -0800
In-Reply-To: <20201208173705.5770-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Tue, 8 Dec 2020 12:37:05 -0500")
Message-ID: <xmqqwnxs55rn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08E2B76A-399F-11EB-9982-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> However, if both the repository and the worktrees are moved, then links
> are severed in both directions, and no repair is possible. This is the
> case even when the new worktree locations are specified as arguments to
> `git worktree repair`. The reason for this limitation is twofold. First,
> when `repair` consults the worktree's gitfile (/path/to/worktree/.git)
> to determine the corresponding <repo>/worktrees/<id>/gitdir file to fix,
> <repo> is the old path to the repository, thus it is unable to fix the
> `gitdir` file at its new location since it doesn't know where it is.
> Second, when `repair` consults <repo>/worktrees/<id>/gitdir to find the
> location of the worktree's gitfile (/path/to/worktree/.git), the path
> recorded in `gitdir` is the old location of the worktree's gitfile, thus
> it is unable to repair the gitfile since it doesn't know where it is.

Third, when a worktree of an unrelated repository is moved to
location the worktree moved like that used to occupy, or an
unrelated repository is moved to the repository moved like that used
to occupy, the gitfile of the moved worktree would point at an
unrelated repository (which may not even be a clone of the same
project).

There probably are other failure cases possible.  Perhaps having to
notice and fail when both worktree and repository moved (i.e. the
case your patch handles) indicates that we would need to be able to
handle such a situation sensibly as well?  Do we leave some clue to
help us validate that the repository the gitfile points at indeed
corresponds to the one our worktree works with and vice versa?  If
we don't currently, should we?

> Fix these shortcomings by teaching `repair` to attempt to infer the new
> location of the <repo>/worktrees/<id>/gitdir file when the location
> recorded in the worktree's gitfile has become stale but the file is
> otherwise well-formed.

Hmph, after reading the "first" and "second" above a few times, it
is unclear how this "inference" would work.  The gitfile points at
the old location of the repository, which was moved to elsewhere
without telling the working tree (i.e. "First" problem), so...?

> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index af06128cc9..02a706c4c0 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -143,6 +143,11 @@ locate it. Running `repair` within the recently-moved working tree will
>  reestablish the connection. If multiple linked working trees are moved,
>  running `repair` from any working tree with each tree's new `<path>` as
>  an argument, will reestablish the connection to all the specified paths.
> ++
> +If both the main working tree and linked working trees have been moved
> +manually, then running `repair` in the main working tree and specifying the
> +new `<path>` of each linked working tree will reestablish all connections
> +in both directions.

This sounds like miracles, but it is perfectly the right thing to do
to say what we can do without telling users how we do so.

> diff --git a/worktree.c b/worktree.c
> index f84ceae87d..821b233479 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -644,6 +644,42 @@ static int is_main_worktree_path(const char *path)
>  	return !cmp;
>  }
>  
> +/*
> + * If both the main worktree and linked worktree have been moved, then the
> + * gitfile /path/to/worktree/.git won't point into the repository, thus we
> + * won't know which <repo>/worktrees/<id>/gitdir to repair. However, we may
> + * be able to infer the gitdir by manually reading /path/to/worktree/.git,
> + * extracting the <id>, and checking if <repo>/worktrees/<id> exists.
> + */
> +static char *infer_backlink(const char *gitfile)
> +{
> +	struct strbuf actual = STRBUF_INIT;
> +	struct strbuf inferred = STRBUF_INIT;
> +	const char *id;
> +
> +	if (strbuf_read_file(&actual, gitfile, 0) < 0)
> +		goto error;
> +	if (!starts_with(actual.buf, "gitdir:"))
> +		goto error;
> +	if (!(id = find_last_dir_sep(actual.buf)))
> +		goto error;
> +	strbuf_trim(&actual);
> +	id++; /* advance past '/' to point at <id> */
> +	if (!*id)
> +		goto error;
> +	strbuf_git_common_path(&inferred, the_repository, "worktrees/%s", id);
> +	if (!is_directory(inferred.buf))
> +		goto error;
> +
> +	strbuf_release(&actual);
> +	return strbuf_detach(&inferred, NULL);
> +
> +error:
> +	strbuf_release(&actual);
> +	strbuf_release(&inferred);
> +	return NULL;
> +}
> +
>  /*
>   * Repair <repo>/worktrees/<id>/gitdir if missing, corrupt, or not pointing at
>   * the worktree's path.
> @@ -675,6 +711,11 @@ void repair_worktree_at_path(const char *path,
>  	if (err == READ_GITFILE_ERR_NOT_A_FILE) {
>  		fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
>  		goto done;
> +	} else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
> +		if (!(backlink = infer_backlink(realdotgit.buf))) {
> +			fn(1, realdotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
> +			goto done;
> +		}
>  	} else if (err) {
>  		fn(1, realdotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
>  		goto done;


> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 197fd24a55..71287b2da6 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -1052,10 +1052,10 @@ static int repair(int ac, const char **av, const char *prefix)
>  	int rc = 0;
>  
>  	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
> -	repair_worktrees(report_repair, &rc);
>  	p = ac > 0 ? av : self;
>  	for (; *p; p++)
>  		repair_worktree_at_path(*p, report_repair, &rc);
> +	repair_worktrees(report_repair, &rc);
>  	return rc;
>  }

The reason why repair_worktrees() has to wait until the individual
repairing is done for all the given paths in the new code is...?

> diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
> index 1fe468bfe8..687342bfa7 100755
> --- a/t/t2406-worktree-repair.sh
> +++ b/t/t2406-worktree-repair.sh
> @@ -104,6 +104,16 @@ test_expect_success 'repo not found; .git not file' '
>  	test_i18ngrep ".git is not a file" err
>  '
>  
> +test_expect_success 'repo not found; .git not referencing repo' '
> +	test_when_finished "rm -rf side not-a-repo && git worktree prune" &&
> +	git worktree add --detach side &&
> +	sed s,\.git/worktrees/side$,not-a-repo, side/.git >side/.newgit &&
> +	mv side/.newgit side/.git &&
> +	mkdir not-a-repo &&
> +	test_must_fail git worktree repair side 2>err &&
> +	test_i18ngrep ".git file does not reference a repository" err
> +'

Failing upon empty directory and things that do not make sense is
good.  A more interesting or realistic case would have the side/.git
gitlink points at an unrelated repository because the user moved the
repository and replaced it with another repository, which has the
".git/worktree/" directory and even ".git/worktree/side" directory.

> +test_expect_success 'repair moved main and linked worktrees' '
> +	test_when_finished "rm -rf orig moved" &&
> +	test_create_repo orig/main &&
> +	test_commit -C orig/main init &&
> +	git -C orig/main worktree add --detach ../side &&
> +	sed s,orig/side/\.git,moved/side/.git, \

The pattern needs anchored with '$' to the right, in order not to
get confused by a substring like "ooorig/side/.gitto/" that appears
in the $(cwd).

> +		orig/main/.git/worktrees/side/gitdir >expect-gitdir &&
> +	sed s,orig/main/.git/worktrees/side,moved/main/.git/worktrees/side, \
> +		orig/side/.git >expect-gitfile &&

> +	mv orig moved &&

Hmmm, so this single move is what moves both the repository with the
primary worktree and the secondary worktree.  Does the "fix" assume
that the relative location between them do not change?  How realistic
is that, I wonder?

In any case, I think the problem description in the proposed log
message is quite well written but the solution seems unclear.

Thanks.

> +	git -C moved/main worktree repair ../side &&
> +	test_cmp expect-gitdir moved/main/.git/worktrees/side/gitdir &&
> +	test_cmp expect-gitfile moved/side/.git
> +'
> +
>  test_done
