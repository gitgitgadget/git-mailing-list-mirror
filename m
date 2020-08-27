Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC757C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69FDB22BEB
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vZYbuAX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgH0RGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:06:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65156 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgH0RGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 13:06:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF921EFB99;
        Thu, 27 Aug 2020 13:06:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hwi/j74eWsh+RVEToUswHiQsAaY=; b=vZYbuA
        X21L5sscCxoKN3PI4lPK+BdYmVHlenEDG6x70h2YH6OfwkIsi3goGCQxEF+ly92A
        87BOos23hDBMQ7ldeBEdYKO2x6YCU/ZcgnP/TwJhng/kMAT5x33WeeSr5LQTn/hz
        4xesqXjUs7iR/0xFBSaAlKRINT1SaOqhbDAMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YWzvAvO8oTSaewer/O7h6qoHY48K6FCr
        ap+n0eEh3io+BBnQ6b7celpG+5cN125iqRbUhC1sMHYCkDUcotDXsz3XTj+HHb0H
        3v1JxByhEVWpOTuFlEeShyDGePwlEYop52Hhv+jbcztCFAB1qsXqTr5+51uLsbpM
        6XePapW3DkQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B7BA2EFB98;
        Thu, 27 Aug 2020 13:06:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F34F2EFB96;
        Thu, 27 Aug 2020 13:05:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Henr=C3=A9?= Botha <henrebotha@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] worktree: teach "repair" to fix worktree back-links to main worktree
References: <20200827082129.56149-1-sunshine@sunshineco.com>
        <20200827082129.56149-3-sunshine@sunshineco.com>
Date:   Thu, 27 Aug 2020 10:05:57 -0700
In-Reply-To: <20200827082129.56149-3-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Thu, 27 Aug 2020 04:21:26 -0400")
Message-ID: <xmqqlfi0qaru.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9409ACA4-E887-11EA-9C2A-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> The .git file in a linked worktree is a "gitlink" which points back to

Please never call it a "gitlink" (which is a word reserved for a
cache entry with 160000 mode that typically point at a commit
object, an implementation detail of the mechanism to bind a
submodule to its superproject) to avoid confusing future readers of
our code and documentation.  The setup.c code calls it as "gitfile",
since it was introduced at b44ebb19 (Add platform-independent .git
"symlink", 2008-02-20), I think, and that is how it has been described
in the glossary.

> the .git/worktrees/<id> entry in the main worktree or bare repository.
> If a worktree's .git file is deleted or becomes corrupted or outdated,
> then the linked worktree won't know how to find the repository or any of
> its own administrative files (such as 'index', 'HEAD', etc.). An easy
> way for the .git file to become outdated is for the user to move the
> main worktree or bare repository.

I am not sure if a directory that used to be a secondary worktree
would still appear to be a Git controlled worktree after its ".git"
removed, but I guess a ".git" pointing at a wrong place won't,
either.  I am just curious how much more involved in dealing with
the "is deleted" situation than "becomes corrupted" situation.  

An obvious way is to ask the users to say "Here in directory D
should be a gitfile that points at the primary copy X---D/.git may
be missing or corrupt so please go create or fix it" without letting
any "auto repository discovery" logic to kick in.  For that, I suspect
you may have to disable RUN_SETUP in git.c for "worktree" built-in,
and run the setup sequence manually for all the existing subcommands
except for this new "repair" subcommand.  We'll see.

> Although it is possible to manually
> update each linked worktree's .git file to reflect the new repository
> location, doing so requires a level of knowledge about worktree
> internals beyond what a user should be expected to know offhand.
>
> Therefore, teach "git worktree repair" how to repair broken or outdated
> worktree .git files automatically. (For this to work, the command must
> be invoked from within the main worktree or bare repository, or from
> within a worktree which has not become disconnected from the repository
> -- such as one which was created after the repository was moved.)

Hmph, ok, that is not quite satisfactory, but it would work.  So
instead of

    user goes to a directory D, thinking it is a valid secondary
    worktree and wanting to work in it, and finds that Git does not
    think it is.

    user tells "worktree repair" that X is the location of the
    primary copy, and cwd is supposed to be the top of the working
    tree of a secondary worktree of it.

    "worktree repair" creates/updates ./.git gitfile to point at X.

    user starts working.

sequence, the user does

    user goes to a directory D, thinking it is a valid secondary
    worktree and wanting to work in it, and finds that Git does not
    think it is.

    user goes to X, which is the location of the primary copy, and
    tells "worktree repair" that the directory D ought to be the top
    of the working tree for a secondary worktree.

    "worktree repair" creates/updates D/.git gitfile to point at X.

    user comes back to D and starts working.

because "git worktree repair" wants to do the usual setup sequence
anyway.  

OK.

>  Move a working tree to a new location. Note that the main working tree
> -or linked working trees containing submodules cannot be moved.
> +or linked working trees containing submodules cannot be moved with this
> +command. (The `git worktree repair` command, however, can reestablish
> +the connection with linked working trees if you move the main working
> +tree manually.)

... meaning after moving the main working tree, repair can be used
to touch-up the submodule directories?

Ah, no.  You are saying "git worktree move" still cannot be used to
move the main working tree (the ones with submodules in it we do not
even care), but as a workaround, the user can "mv" it manually and
run "repair" to fix all the secondary worktrees.

Hopefully somewhere in the rest of this series it would become
automatic?  After all, instead of letting users "mv" things without
us knowing what is going on, if we let them say "worktree move" the
primary working tree, we know both the source and the destination
directories of such a move, and because we know all the secondary
worktrees, we can run "worktree repair" on them as part of this
"worktree move" of the primary working tree.

It is perfectly fine that it is not happening here in this step to
keep each step digestible, of course.

Let's read on.

> @@ -115,6 +118,11 @@ repair::
>  
>  Repair working tree administrative files, if possible, if they have
>  become corrupted or outdated due to external factors.
> ++
> +For instance, if the main working tree (or bare repository) is moved,
> +linked working trees will be unable to locate it. Running `repair` in
> +the recently-moved main working tree will reestablish the connection
> +from linked working trees back to the main working tree.

Does "recently-" have a positive value in this paragraph?  It makes
readers wonder how long the zombie would stay resurrectable, which
would encourage to run this command while s/he still remembers that
the primary copy got moved, but I am not sure if that is a plus.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 88af412d4f..62e33eb7f5 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -1030,6 +1030,16 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
>  	return ret;
>  }
>  
> +static void repair_cb(int iserr, const char *path, const char *msg, void *cb_data)

repair_cb as the name for a parameter to repair_worktrees() API
function is an excellent name, but as the name for a concrete
instance of such a callback function, it is a horrible one.  Name it
after what it does or what it is for in the context of this
particular use of that API function, e.g. "report repair status".

> +{
> +	if (!iserr)
> +		printf_ln(_("repair: %s: %s"), msg, path);
> +	else {
> +		fprintf_ln(stderr, _("error: %s: %s"), msg, path);
> +		*(int *)cb_data = 1;
> +	}

Spend a local variable would pay for readability, e.g.

	{
		int *exit_status = (int *)cb_data;
		if (!iserr) {
			... report success ...
		} else {
			... report failure ...
			*exit_status = 1;
	        }
	}

would make it clearer that the number '1' is assigned to update the
value used as the exit status.  With the same callback API, the
caller could be counting the number of secondaries failed to be
resurrected, in which case assignment of 1 is a potential bug
that needs to be updated to 

		*(int *)cb_data += 1;

but the reader cannot tell from the generic name cb_data.

> +}
> +
>  static int repair(int ac, const char **av, const char *prefix)
>  {
>  	struct option options[] = {
> @@ -1040,6 +1050,7 @@ static int repair(int ac, const char **av, const char *prefix)
>  	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
>  	if (ac)
>  		usage_with_options(worktree_usage, options);
> +	repair_worktrees(repair_cb, &rc);
>  	return rc;
>  }
>  
> diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
> index cc679e1a21..9379a63130 100755
> --- a/t/t2406-worktree-repair.sh
> +++ b/t/t2406-worktree-repair.sh
> @@ -8,4 +8,76 @@ test_expect_success setup '
>  	test_commit init
>  '
>  
> +test_expect_success 'skip missing worktree' '
> +	test_when_finished "git worktree prune" &&
> +	git worktree add --detach missing &&
> +	rm -rf missing &&
> +	git worktree repair >out 2>err &&
> +	test_must_be_empty out &&
> +	test_must_be_empty err
> +'
> +
> +test_expect_success "don't clobber .git repo" '
> +	test_when_finished "rm -rf repo && git worktree prune" &&
> +	git worktree add --detach repo &&
> +	rm -rf repo &&
> +	test_create_repo repo &&
> +	test_must_fail git worktree repair >out 2>err &&
> +	test_must_be_empty out &&
> +	test_i18ngrep ".git is not a file" err
> +'
> +
> +test_corrupt_gitlink () {

See gitglossary::gitfile.  We'd need to find all references to
"gitlink" and "git link" in this series and decide which ones need
to be fixed (there might be genuine references to gitlink---I
haven't read the series through).

> diff --git a/worktree.c b/worktree.c
> index 62217b4a6b..029ce91fdf 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -571,3 +571,56 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
>  	free_worktrees(worktrees);
>  	return ret;
>  }
> +
> +/*
> + * Repair worktree's /path/to/worktree/.git link if missing, corrupt, or not
> + * pointing at <repo>/worktrees/<id>.
> + */
> +static void repair_dotgit(struct worktree *wt,
> +			  worktree_repair_cb *cb, void *cb_data)

"dotgit" is an OK name in this context, I would think.  repair_gitfile
is also fine, but "dotgit" may be more explicit.

It is customary to call the callback function "fn", not "cb", which
sometimes used as a short-hand for "cb_data".

> +{
> +	struct strbuf dotgit = STRBUF_INIT;
> +	struct strbuf repo = STRBUF_INIT;
> +	char *backlink;
> +	const char *repair = NULL;
> +	int err;
> +
> +	/* missing worktree can't be repaired */
> +	if (!file_exists(wt->path))
> +		return;

Shouldn't it be a bit stronger?  if wt->path is not a directory, it
cannot be the top of the working tree of a secondary worktree.

> +	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);

OK, the need to use git_common_path() is a good justification why it
is easier to implement if we initialize ourselves using the primary
copy's repository data (i.e. require the user to start "worktree
repair" in the primary copy or any working secondary worktrees, and
let the normal setup.c sequence to prime us in the repository),
instead of allowing the user to start at the secondary worktree
whose gitfile got broken.

> +	strbuf_addf(&dotgit, "%s/.git", wt->path);
> +	backlink = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
> +
> +	if (err == READ_GITFILE_ERR_NOT_A_FILE)
> +		cb(1, wt->path, _(".git is not a file"), cb_data);
> +	else if (err)
> +		repair = _(".git link broken");
> +	else if (fspathcmp(backlink, repo.buf))
> +		repair = _(".git link incorrect");
> +	if (repair) {
> +		cb(0, wt->path, repair, cb_data);
> +		write_file(dotgit.buf, "gitdir: %s", repo.buf);

Shouldn't write_file() be monitored for its failure, and the failure
reported back to the callback function?

> +	}
> +
> +	free(backlink);
> +	strbuf_release(&repo);
> +	strbuf_release(&dotgit);
> +}
> +
> +static void repair_noop_cb(int iserr, const char *path, const char *msg,
> +			   void *cb_data) {}

Even the body is empty, just follow the coding guidelines, i.e.

	static void function_name(parameter list)
	{
		/* nothing */
	}

> +void repair_worktrees(worktree_repair_cb *cb, void *cb_data)
> +{
> +	struct worktree **worktrees = get_worktrees();
> +	struct worktree **wt = worktrees + 1; /* +1 skips main worktree */
> +
> +	if (!cb)
> +		cb = repair_noop_cb;
> +	for (; *wt; wt++)
> +		repair_dotgit(*wt, cb, cb_data);
> +	free_worktrees(worktrees);
> +}

This "repair"s only in one direction.  Manual movement of secondary
worktrees, if we want to support repairing, needs the user to tell
where the new location of the secondary is, and we need a code to
update the record of the location of the secondary kept at the main
worktree, which is not needed in the repair implemented by this
step.

> diff --git a/worktree.h b/worktree.h
> index 516744c433..7d085c7b91 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -89,6 +89,17 @@ int validate_worktree(const struct worktree *wt,
>  void update_worktree_location(struct worktree *wt,
>  			      const char *path_);
>  
> +typedef void worktree_repair_cb(int iserr, const char *path, const char *msg,
> +				void *cb_data);
> +
> +/*
> + * Visit each registered linked worktree and repair corruptions. For each
> + * repair made or error encountered while attempting a repair, the callback, if
> + * non-NULL, is called with the path of the worktree and a description of the
> + * repair or error, along with the callback user-data.
> + */
> +void repair_worktrees(worktree_repair_cb *, void *cb_data);
> +
>  /*
>   * Free up the memory for worktree(s)
>   */

Looking good.

Thanks.
