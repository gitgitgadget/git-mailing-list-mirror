Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2541F18A959
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313429; cv=none; b=aa9dp0/XEt/bHY3iZfIvVNmPbVmt7A82ywpCukWYZc3UppbgjxeAMUxhBkixTUAy1cttiulvAxbv4rIreac/XCB+IcusMYHIpeufhV5gfVu3Cm6WxLcRrW2xAlsyMuLa2CbnlK5cF5X6sQ0iltI67AXBkT5khVGprFsmI+x9/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313429; c=relaxed/simple;
	bh=NWmHHLxVzBHIY4qs5JDs96JLkWcG8E+4MvwiOg7v5rY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=olQcGMHs2HsN9TxvbmMcTCpAsNbTRYCZtDVUfIU2JxsCpSCcUOnF833yK4EcvNO05zxc9kVD05BkRalQXexyF5cDS7IQsZ0CrehwBkvIbsEyrJvAIrFhH7qs2CywQEQz6z+ScjL/JSAlHXgxLXkTtORbgqpIutxXvnwSFBdm0sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=f81U3OQg; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="f81U3OQg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1742313420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HCynlV70QMD7Wl/dxpzaivPC7MdJRUF8kG3u5nIyM7o=;
	b=f81U3OQgPKemHWCLPS7YtHMeRlA96nABUGLYPrI/P7prJEgLJTR7IxrAwCs2wi2Kl70N3U
	3011S5RNov8EaI/lNiTy8dS06ocBG9kMg8P4rbmLDQhjo6Ush1ZiPuhsjRg1tNyD/GDLee
	DOAJzLuIcA7Pbkdl6L6yeEhi1jch4DQ=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, kristofferhaugsbakk@fastmail.com, gitster@pobox.com, Karthik
 Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 2/2] reflog: implement subcommand to drop reflogs
In-Reply-To: <20250314-493-add-command-to-purge-reflog-entries-v3-2-c24e23a6146d@gmail.com>
References: <20250314-493-add-command-to-purge-reflog-entries-v3-0-c24e23a6146d@gmail.com>
 <20250314-493-add-command-to-purge-reflog-entries-v3-2-c24e23a6146d@gmail.com>
Date: Tue, 18 Mar 2025 16:56:49 +0100
Message-ID: <8734fagwn2.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> While 'git-reflog(1)' currently allows users to expire reflogs and
> delete individual entries, it lacks functionality to completely remove
> reflogs for specific references. This becomes problematic in
> repositories where reflogs are not needed but continue to accumulate
> entries despite setting 'core.logAllRefUpdates=false'.
>
> Add a new 'drop' subcommand to git-reflog that allows users to delete
> the entire reflog for a specified reference. Include an '--all' flag to
> enable dropping all reflogs from all worktrees and an addon flag
> '--single-worktree', to only drop all reflogs from the current worktree.
>
> While here, remove an extraneous newline in the file.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-reflog.adoc |  23 ++++++--
>  builtin/reflog.c              |  66 ++++++++++++++++++++++-
>  t/t1410-reflog.sh             | 122 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 206 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
> index a929c52982..b55c060569 100644
> --- a/Documentation/git-reflog.adoc
> +++ b/Documentation/git-reflog.adoc
> @@ -16,6 +16,7 @@ SYNOPSIS
>  	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
>  'git reflog delete' [--rewrite] [--updateref]
>  	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
> +'git reflog drop' [--all [--single-worktree] | <refs>...]
>  'git reflog exists' <ref>
>  
>  DESCRIPTION
> @@ -48,10 +49,14 @@ and not reachable from the current tip, are removed from the reflog.
>  This is typically not used directly by end users -- instead, see
>  linkgit:git-gc[1].
>  
> -The "delete" subcommand deletes single entries from the reflog. Its
> -argument must be an _exact_ entry (e.g. "`git reflog delete
> -master@{2}`"). This subcommand is also typically not used directly by
> -end users.
> +The "delete" subcommand deletes single entries from the reflog, but
> +not the reflog itself. Its argument must be an _exact_ entry (e.g. "`git
> +reflog delete master@{2}`"). This subcommand is also typically not used
> +directly by end users.
> +
> +The "drop" subcommand completely removes the reflog for the specified
> +references. This is in contrast to "expire" and "delete", both of which
> +can be used to delete reflog entries, but not the reflog itself.
>  
>  The "exists" subcommand checks whether a ref has a reflog.  It exits
>  with zero status if the reflog exists, and non-zero status if it does
> @@ -132,6 +137,16 @@ Options for `delete`
>  `--dry-run`, and `--verbose`, with the same meanings as when they are
>  used with `expire`.
>  
> +Options for `drop`
> +~~~~~~~~~~~~~~~~~~~~
> +
> +--all::
> +	Drop the reflogs of all references from all worktrees.
> +
> +--single-worktree::
> +	By default when `--all` is specified, reflogs from all working
> +	trees are dropped. This option limits the processing to reflogs
> +	from the current working tree only.
>  
>  GIT
>  ---
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 762719315e..a3652e69f1 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -29,6 +29,9 @@
>  #define BUILTIN_REFLOG_EXISTS_USAGE \
>  	N_("git reflog exists <ref>")
>  
> +#define BUILTIN_REFLOG_DROP_USAGE \
> +	N_("git reflog drop [--all [--single-worktree] | <refs>...]")
> +
>  static const char *const reflog_show_usage[] = {
>  	BUILTIN_REFLOG_SHOW_USAGE,
>  	NULL,
> @@ -54,11 +57,17 @@ static const char *const reflog_exists_usage[] = {
>  	NULL,
>  };
>  
> +static const char *const reflog_drop_usage[] = {
> +	BUILTIN_REFLOG_DROP_USAGE,
> +	NULL,
> +};
> +
>  static const char *const reflog_usage[] = {
>  	BUILTIN_REFLOG_SHOW_USAGE,
>  	BUILTIN_REFLOG_LIST_USAGE,
>  	BUILTIN_REFLOG_EXPIRE_USAGE,
>  	BUILTIN_REFLOG_DELETE_USAGE,
> +	BUILTIN_REFLOG_DROP_USAGE,
>  	BUILTIN_REFLOG_EXISTS_USAGE,
>  	NULL
>  };
> @@ -449,10 +458,64 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix,
>  				   refname);
>  }
>  
> +static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
> +			   struct repository *repo)
> +{
> +	int ret = 0, do_all = 0, single_worktree = 0;
> +	const struct option options[] = {
> +		OPT_BOOL(0, "all", &do_all, N_("drop the reflogs of all references")),
> +		OPT_BOOL(0, "single-worktree", &single_worktree,
> +			 N_("drop reflogs from the current worktree only")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, reflog_drop_usage, 0);
> +
> +	if (argc && do_all)
> +		usage(_("references specified along with --all"));

What is the intended behavior when both `--all` and `<refs>` are
omitted? It seems nothing happens at the moment. And no error nor
warning is printed, that feels a bit odd to me.

Now, when you do `git reflog expire --expire=all` it also seems to be
doing nothing at all. I also think this is weird. And I don't see any
test coverage for `git reflog expire` without `--all`.

But what is the expected behavior when you omit `--all` and `<refs>`?
Should it give an error or warning? Should it use HEAD, just like `git
reflog show` does?

> +
> +	if (do_all) {
> +		struct worktree_reflogs collected = {
> +			.reflogs = STRING_LIST_INIT_DUP,
> +		};
> +		struct string_list_item *item;
> +		struct worktree **worktrees, **p;
> +
> +		worktrees = get_worktrees();
> +		for (p = worktrees; *p; p++) {
> +			if (single_worktree && !(*p)->is_current)
> +				continue;
> +			collected.worktree = *p;
> +			refs_for_each_reflog(get_worktree_ref_store(*p),
> +					     collect_reflog, &collected);
> +		}
> +		free_worktrees(worktrees);
> +
> +		for_each_string_list_item(item, &collected.reflogs)
> +			ret |= refs_delete_reflog(get_main_ref_store(repo),
> +						     item->string);
> +		string_list_clear(&collected.reflogs, 0);
> +
> +		return ret;
> +	}
> +
> +	for (int i = 0; i < argc; i++) {
> +		char *ref;
> +		if (!repo_dwim_log(repo, argv[i], strlen(argv[i]), NULL, &ref)) {
> +			ret |= error(_("reflog could not be found: '%s'"), argv[i]);
> +			continue;
> +		}
> +
> +		ret |= refs_delete_reflog(get_main_ref_store(repo), ref);
> +		free(ref);
> +	}
> +
> +	return ret;
> +}
> +
>  /*
>   * main "reflog"
>   */
> -
>  int cmd_reflog(int argc,
>  	       const char **argv,
>  	       const char *prefix,
> @@ -465,6 +528,7 @@ int cmd_reflog(int argc,
>  		OPT_SUBCOMMAND("expire", &fn, cmd_reflog_expire),
>  		OPT_SUBCOMMAND("delete", &fn, cmd_reflog_delete),
>  		OPT_SUBCOMMAND("exists", &fn, cmd_reflog_exists),
> +		OPT_SUBCOMMAND("drop", &fn, cmd_reflog_drop),
>  		OPT_END()
>  	};
>  
> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index 1f7249be76..42b501f163 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -551,4 +551,126 @@ test_expect_success 'reflog with invalid object ID can be listed' '
>  	)
>  '
>  
> +test_expect_success 'reflog drop non-existent ref' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_must_fail git reflog exists refs/heads/non-existent &&
> +		test_must_fail git reflog drop refs/heads/non-existent 2>stderr &&
> +		test_grep "error: reflog could not be found: ${SQ}refs/heads/non-existent${SQ}" stderr
> +	)
> +'
> +
> +test_expect_success 'reflog drop' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit A &&
> +		test_commit_bulk --ref=refs/heads/branch 1 &&
> +		git reflog exists refs/heads/main &&
> +		git reflog exists refs/heads/branch &&
> +		git reflog drop refs/heads/main &&
> +		test_must_fail git reflog exists refs/heads/main &&
> +		git reflog exists refs/heads/branch
> +	)
> +'
> +
> +test_expect_success 'reflog drop multiple references' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit A &&
> +		test_commit_bulk --ref=refs/heads/branch 1 &&
> +		git reflog exists refs/heads/main &&
> +		git reflog exists refs/heads/branch &&
> +		git reflog drop refs/heads/main refs/heads/branch &&
> +		test_must_fail git reflog exists refs/heads/main &&
> +		test_must_fail git reflog exists refs/heads/branch
> +	)
> +'
> +
> +test_expect_success 'reflog drop multiple references some non-existent' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit A &&
> +		test_commit_bulk --ref=refs/heads/branch 1 &&
> +		git reflog exists refs/heads/main &&
> +		git reflog exists refs/heads/branch &&
> +		test_must_fail git reflog exists refs/heads/non-existent &&
> +		test_must_fail git reflog drop refs/heads/main refs/heads/non-existent refs/heads/branch 2>stderr &&
> +		test_must_fail git reflog exists refs/heads/main &&
> +		test_must_fail git reflog exists refs/heads/branch &&
> +		test_must_fail git reflog exists refs/heads/non-existent &&
> +		test_grep "error: reflog could not be found: ${SQ}refs/heads/non-existent${SQ}" stderr
> +	)
> +'
> +
> +test_expect_success 'reflog drop --all' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit A &&
> +		test_commit_bulk --ref=refs/heads/branch 1 &&
> +		git reflog exists refs/heads/main &&
> +		git reflog exists refs/heads/branch &&
> +		git reflog drop --all &&
> +		test_must_fail git reflog exists refs/heads/main &&
> +		test_must_fail git reflog exists refs/heads/branch

Should we test output of `git reflog list`?

> +	)
> +'
> +
> +test_expect_success 'reflog drop --all multiple worktrees' '
> +	test_when_finished "rm -rf repo" &&
> +	test_when_finished "rm -rf wt" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit A &&
> +		git worktree add ../wt &&
> +		test_commit_bulk -C ../wt --ref=refs/heads/branch 1 &&
> +		git reflog exists refs/heads/main &&
> +		git reflog exists refs/heads/branch &&
> +		git reflog drop --all &&
> +		test_must_fail git reflog exists refs/heads/main &&
> +		test_must_fail git reflog exists refs/heads/branch

Shall we test HEAD in both worktrees does not exists?

> +	)
> +'
> +
> +test_expect_success 'reflog drop --all --single-worktree' '
> +	test_when_finished "rm -rf repo" &&
> +	test_when_finished "rm -rf wt" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit A &&
> +		git worktree add ../wt &&
> +		test_commit -C ../wt foobar &&
> +		git reflog exists refs/heads/main &&
> +		git reflog exists refs/heads/wt &&
> +		test-tool ref-store worktree:wt reflog-exists HEAD &&
> +		git reflog drop --all --single-worktree &&
> +		test_must_fail git reflog exists refs/heads/main &&
> +		test_must_fail git reflog exists refs/heads/wt &&
> +		test_must_fail test-tool ref-store worktree:main reflog-exists HEAD &&
> +		test-tool ref-store worktree:wt reflog-exists HEAD

Naive question: why is `test-tool ref-store` used and not
`git -C ../wt reflog exist`?

> +	)
> +'
> +
> +test_expect_success 'reflog drop --all with reference' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit A &&
> +		test_must_fail git reflog drop --all refs/heads/main 2>stderr &&
> +		test_grep "usage: references specified along with --all" stderr
> +	)
> +'
> +
>  test_done
>
> -- 
> 2.48.1
