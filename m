Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DC6B1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 23:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932840AbcLGXDl (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 18:03:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60111 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932339AbcLGXDk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 18:03:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36514563A7;
        Wed,  7 Dec 2016 18:03:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7eNWHgXw08/4SRKieDlHvgeBYCA=; b=cOHtvq
        6oW28qJRdeLAF7EFjw748f4IFQJguyBdU5kHGcEUqFaCGJ5Cq33YDlSfA9QE6xyx
        meXA6d7StKiMya3gCGpS4MLdF3lOk+Ts0TW+JIS12mQDPS+fkd5i9cu1da4KNnlq
        rs7HhfrmTpyJndjJDwfIbABYSOJYyK1yV1sNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XCQdut7NmfytcfxaZWzSGp6icQ4DArMA
        0UYrLkwcpWwFWTTESwjepsC7Iou+vdLNoeGmiHzK3bfpIfpLqn+7Pa8lQQYf6nzy
        Ar4vwcBU0IWsDWkPNtXZI9zoVfUQ7PeqgFJSELJG79CfrXTQXSQnAJXbpZ9czKKG
        yeH4ALVNHRI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B0E6563A6;
        Wed,  7 Dec 2016 18:03:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E6AA563A4;
        Wed,  7 Dec 2016 18:03:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCHv5 5/5] submodule: add embed-git-dir function
References: <20161207210157.18932-1-sbeller@google.com>
        <20161207210157.18932-6-sbeller@google.com>
Date:   Wed, 07 Dec 2016 15:03:37 -0800
In-Reply-To: <20161207210157.18932-6-sbeller@google.com> (Stefan Beller's
        message of "Wed, 7 Dec 2016 13:01:57 -0800")
Message-ID: <xmqqlgvruyt2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6386BAF8-BCD1-11E6-99CF-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> @@ -1093,7 +1129,8 @@ static struct cmd_struct commands[] = {
>  	{"resolve-relative-url", resolve_relative_url, 0},
>  	{"resolve-relative-url-test", resolve_relative_url_test, 0},
>  	{"init", module_init, 0},
> -	{"remote-branch", resolve_remote_submodule_branch, 0}
> +	{"remote-branch", resolve_remote_submodule_branch, 0},
> +	{"embed-git-dirs", embed_git_dir, SUPPORT_SUPER_PREFIX}
>  };

If you want to avoid patch noise like this, your 2/5 can add a
trailing comma after the entry for remote-branch.  It is OK to end
elements in an array literal with trailing comma, even though we
avoid doing similar in enum definition (which is only allowed in
newer C standards).

> diff --git a/dir.c b/dir.c
> index bfa8c8a9a5..e023b04407 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2748,3 +2748,30 @@ void untracked_cache_add_to_index(struct index_state *istate,
>  {
>  	untracked_cache_invalidate_path(istate, path);
>  }
> +
> +/*
> + * Migrate the git directory of the given `path` from `old_git_dir` to
> + * `new_git_dir`. If an error occurs, append it to `err` and return the
> + * error code.
> + */
> +int relocate_gitdir(const char *path, const char *old_git_dir,
> +		    const char *new_git_dir, const char *displaypath,
> +		    struct strbuf *err)
> +{
> +	int ret = 0;
> +
> +	printf("Migrating git directory of '%s' from\n'%s' to\n'%s'\n",
> +		displaypath, old_git_dir, new_git_dir);

By using "strbuf err", it looks like that the calling convention of
this function wants to cater to callers who want to have tight
control over their output and an unconditional printing to the
standard output looks somewhat out of place.

Besides, does it belong to the standard output?  It looks more like
a progress-bar eye candy that we send out to the standard error
stream (and only when we are talking to a tty).

> +/* Embeds a single submodule, non recursively. */
> +static void submodule_embed_git_dir_for_path(const char *prefix, const char *path)
> +{
> +	struct worktree **worktrees;
> +	struct strbuf pathbuf = STRBUF_INIT;
> +	struct strbuf errbuf = STRBUF_INIT;
> +	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
> +	const char *new_git_dir;
> +	const struct submodule *sub;
> +	int code;
> +
> +	worktrees = get_submodule_worktrees(path, 0);
> +	if (worktrees) {
> +		int i;
> +		for (i = 0; worktrees[i]; i++)
> +			;
> +		free_worktrees(worktrees);
> +		if (i > 1)
> +			die(_("relocate_gitdir for submodule '%s' with "
> +			    "more than one worktree not supported"), path);
> +	}

We may benefit from "does this have secondary worktrees?" boolean
helper function, perhaps?

> +	old_git_dir = xstrfmt("%s/.git", path);
> +	if (read_gitfile(old_git_dir))
> +		/* If it is an actual gitfile, it doesn't need migration. */
> +		return;

Isn't this "no-op return" a valid thing to do, even when the
submodule has secondary worktrees that borrow from it?  I am
wondering if the "ah, we don't do a repository that has secondary
worktrees" check should come after this one.

> +	real_old_git_dir = xstrdup(real_path(old_git_dir));
> +...
> +}

> +/*
> + * Migrate the git directory of the submodule given by path from
> + * having its git directory within the working tree to the git dir nested
> + * in its superprojects git dir under modules/.
> + */

I think that this operation removes the git directories that are
embedded in the working tree of the superproject and storing them
away to safer place, i.e. unembedding.

> +int submodule_embed_git_dir(const char *prefix,
> +			    const char *path,
> +			    unsigned flags)
> +{
> +	const char *sub_git_dir, *v;
> +	char *real_sub_git_dir = NULL, *real_common_git_dir = NULL;
> +	struct strbuf gitdir = STRBUF_INIT;
> +
> +

Lose the extra blank line here?

> +	strbuf_addf(&gitdir, "%s/.git", path);
> +	sub_git_dir = resolve_gitdir(gitdir.buf);
> +
> +	/* Not populated? */
> +	if (!sub_git_dir)
> +		goto out;
> +
> +	/* Is it already embedded? */
> +	real_sub_git_dir = xstrdup(real_path(sub_git_dir));
> +	real_common_git_dir = xstrdup(real_path(get_git_common_dir()));
> +	if (!skip_prefix(real_sub_git_dir, real_common_git_dir, &v))

Yeah, checking for NULL-ness with !skip_prefix() helps ;-)

> +		submodule_embed_git_dir_for_path(prefix, path);
> +
> +	if (flags & RELOCATE_GITDIR_RECURSE_SUBMODULES) {
> +		struct child_process cp = CHILD_PROCESS_INIT;
> +		struct strbuf sb = STRBUF_INIT;
> +
> +		if (flags & ~RELOCATE_GITDIR_RECURSE_SUBMODULES)
> +			die("BUG: we don't know how to pass the flags down?");
> +
> +		if (get_super_prefix())
> +			strbuf_addstr(&sb, get_super_prefix());
> +		strbuf_addstr(&sb, path);
> +		strbuf_addch(&sb, '/');
> +
> +		cp.dir = path;
> +		cp.git_cmd = 1;
> +		cp.no_stdin = 1;
> +		argv_array_pushl(&cp.args, "--super-prefix", sb.buf,
> +					    "submodule--helper",
> +					   "embed-git-dirs", NULL);
> +		prepare_submodule_repo_env(&cp.env_array);
> +		if (run_command(&cp))
> +			die(_("could not recurse into submodule '%s'"), path);
> +		strbuf_release(&sb);
> +	}

Hmph.  We cannot use run_processes_parallel() thing here?  Is its
API too hard to use to be worth it?

> +test_expect_success 'embedding does not fail for deinitalized submodules' '
> +	test_when_finished "git submodule update --init" &&
> +	git submodule deinit --all &&
> +	git submodule embedgitdirs &&
> +	test -d .git/modules/sub1 &&
> +	! test -f sub1/.git &&

Does this expect "sub1/.git is not a regular file (we want directory
instead)"?  Or "there is no filesystem entity at sub1/.git"?

If the former, write "test -d sub1/.git"; if the latter, you
probably want "! test -e sub1/.git" instead.
