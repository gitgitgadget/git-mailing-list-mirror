Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94B011F453
	for <e@80x24.org>; Thu, 18 Oct 2018 00:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeJRIiQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 04:38:16 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:40789 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeJRIiP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 04:38:15 -0400
Received: by mail-pf1-f202.google.com with SMTP id l1-v6so28281226pfb.7
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 17:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QM33cZQK01QVdBLdNfvVJe8H3jJmUv7fuIUYpXXryuU=;
        b=kHjtlQ211frkH+7rzBwVhCb1BGAfh8eoyvCoDsfMrcvdQBv+eG5iV5GM+CAobTPHio
         op08hPM/O1V5yEbeGdt1uMMm/nwm1jlcLpl2jxzeM6ZF9ev4wH8XMj5xKLGQhfMacQ5P
         +aGVJHL9weVy1AP0REqPhlvYyJnq8t+7KhE3wyFSlDhKM5BurphbhNCe1rTJtpu6yx0l
         Nu9M8jddIh/r3os2Hb9PTP+xJ0W2lAy90l2uIyldpBLtdgfP+IfIH7Q66rJZXeUkwcjI
         yuhe7V0ApO0SHEyp+mujL5WTetbuZ33PADiIKY9AKH2Qo8GL7a2Dm1xZpZG/5Du+roux
         lEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QM33cZQK01QVdBLdNfvVJe8H3jJmUv7fuIUYpXXryuU=;
        b=aP+O1anHSWq/SpiZuiQs87nx+UiFwyaWm7eAeUDtcln5EFaYCMryAEDuUB7C19WEg6
         g+JJQ9V6wZfdGqbnsVDavPuU4xJmGJTX61ZKxhZMlLzohJfgKIcPjdbWHiU7c2ISJDFN
         npKV0BC7xhn5mWqjg6BwfoHbuUOAH2VGczEdIifE+U2qKFDAZOW5lqemWqPhw9DBDzch
         8d46sbX1L2Dd6FIBzz04l88DHhaNa9qSlSfzRPH513JJe6hsehmQp8TaRLrsahIDaLbM
         qBiOZq4DgJRg0ll2BEgHCbu6BvC1HITpFqqBRDqHPQ6W+DeiVQ8nbGRoq+XorYGrCJjZ
         Hdbw==
X-Gm-Message-State: ABuFfohYasgMoHqufnNsSKTogME63sJdgDBhzVDUVYcL/pG3pKWnsEss
        cuLqcaW0v+j5U83O5ZT+L8TN9wZ8Hm8juP1cZctO
X-Google-Smtp-Source: ACcGV60+dcB6lvzLGXQ1KplDkOW6scKxKWiaPfUn8f2VbqYa6GWHJCVWmRBeEkWkENbryigVgu18clKu/Fv/3JL7aup1
X-Received: by 2002:a63:1343:: with SMTP id 3-v6mr13749938pgt.33.1539823198339;
 Wed, 17 Oct 2018 17:39:58 -0700 (PDT)
Date:   Wed, 17 Oct 2018 17:39:54 -0700
In-Reply-To: <20181016181327.107186-9-sbeller@google.com>
Message-Id: <20181018003954.139498-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181016181327.107186-9-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 8/9] fetch: retry fetching submodules if needed objects
 were not fetched
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Currently when git-fetch is asked to recurse into submodules, it dispatches
> a plain "git-fetch -C <submodule-dir>" (with some submodule related options
> such as prefix and recusing strategy, but) without any information of the
> remote or the tip that should be fetched.
> 
> This works surprisingly well in some workflows (such as using submodules
> as a third party library), while not so well in other scenarios, such
> as in a Gerrit topic-based workflow, that can tie together changes
> (potentially across repositories) on the server side. One of the parts
> of such a Gerrit workflow is to download a change when wanting to examine
> it, and you'd want to have its submodule changes that are in the same
> topic downloaded as well. However these submodule changes reside in their
> own repository in their own ref (refs/changes/<int>).

It seems that the pertinent situation is when, in the superproject, you
fetch a commit (which may be the target of a ref, or an ancestor of the
target of a ref) that points to a submodule commit that was not fetched
by the default refspec-less fetch that you describe in the first
paragraph. I would just describe it as follows:

  But this default fetch is not sufficient, as a newly fetched commit in
  the superproject could point to a commit in the submodule that is not
  in the default refspec. This is common in workflows like Gerrit's.
  When fetching a Gerrit change under review (from refs/changes/??), the
  commits in that change likely point to submodule commits that have not
  been merged to a branch yet.

Another thing you need to clarify is what happens if the fetch-by-commit
fails. Right now, it seems that it will make the whole thing fail, which
might be a surprising change in behavior.

> Retry fetching a submodule by object name if the object id that the
> superproject points to, cannot be found.

I don't really think of this as a retry - the first time, you're
fetching the default refspec, and the second time, with a specific list
of object IDs. Also, be consistent in the usage of "object name" and
"object id" - as far as I know, they are the same thing.

> This retrying does not happen when the "git fetch" done at the
> superproject is not storing the fetched results in remote
> tracking branches (i.e. instead just recording them to
> FETCH_HEAD) in this step. A later patch will fix this.

The test stores the result in a normal branch, not a remote tracking
branch. Is storing in a normal branch required?

Also, do you know why this is required? A naive reading of the patch
leads me to believe that this should work even if merely fetching to
FETCH_HEAD.

> +struct get_next_submodule_task {
> +	struct repository *repo;
> +	const struct submodule *sub;
> +	unsigned free_sub : 1; /* Do we need to free the submodule? */
> +	struct oid_array *commits;
> +};

Firstly, I don't think "commits" needs to be a pointer.

Document at least "commits". As far as I can tell, if NULL (or empty if
you take my suggestion), this means that this task is the first pass for
this particular submodule and the fetch needs to be done using the
default refspec. Otherwise, this task is the second pass for this
particular submodule and the fetch needs to be done passing the
contained OIDs.

> +static const struct submodule *get_default_submodule(const char *path)
> +{
> +	struct submodule *ret = NULL;
> +	const char *name = default_name_or_path(path);
> +
> +	if (!name)
> +		return NULL;
> +
> +	ret = xmalloc(sizeof(*ret));
> +	memset(ret, 0, sizeof(*ret));
> +	ret->path = name;
> +	ret->name = name;
> +
> +	return (const struct submodule *) ret;
> +}

What is a "default" submodule and why would you need one?

> +		task = get_next_submodule_task_create(spf->r, ce->name);
> +
> +		if (!task->sub) {
> +			free(task);
> +			continue;
>  		}

Will task->sub ever be NULL?

> +	if (spf->retry_nr) {
> +		struct get_next_submodule_task *task = spf->retry[spf->retry_nr - 1];
> +		struct strbuf submodule_prefix = STRBUF_INIT;
> +		spf->retry_nr--;
> +
> +		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, task->sub->path);
> +
> +		child_process_init(cp);
> +		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
> +		cp->git_cmd = 1;
> +		cp->dir = task->repo->gitdir;
> +
> +		argv_array_init(&cp->args);
> +		argv_array_pushv(&cp->args, spf->args.argv);
> +		argv_array_push(&cp->args, "on-demand");

This means that we need to trust that the last entry in spf->args can
take an "on-demand" parameter. Could we supply that argument here
explicitly instead?

> +		argv_array_push(&cp->args, "--submodule-prefix");
> +		argv_array_push(&cp->args, submodule_prefix.buf);
> +
> +		/* NEEDSWORK: have get_default_remote from s--h */

What is s--h?

> +static int commit_exists_in_sub(const struct object_id *oid, void *data)
> +{
> +	struct repository *subrepo = data;
> +
> +	enum object_type type = oid_object_info(subrepo, oid, NULL);
> +
> +	return type != OBJ_COMMIT;
> +}

Shouldn't the function name be commit_missing_in_sub?

>  static int fetch_finish(int retvalue, struct strbuf *err,
>  			void *cb, void *task_cb)
>  {
>  	struct submodule_parallel_fetch *spf = cb;
> +	struct get_next_submodule_task *task = task_cb;
> +	const struct submodule *sub;
> +
> +	struct string_list_item *it;
> +	struct oid_array *commits;
>  
>  	if (retvalue)
>  		spf->result = 1;
>  
> +	if (!task)
> +		return 0;

When will task be NULL?

> +
> +	sub = task->sub;
> +	if (!sub)
> +		goto out;

Same as above - when will sub be NULL?

> +	it = string_list_lookup(&spf->changed_submodule_names, sub->name);
> +	if (!it)
> +		goto out;

And "it" as well.

> +	commits = it->util;
> +	oid_array_filter(commits,
> +			 commit_exists_in_sub,
> +			 task->repo);
> +
> +	/* Are there commits that do not exist? */
> +	if (commits->nr) {
> +		/* We already tried fetching them, do not try again. */
> +		if (task->commits)
> +			return 0;

Clearer and more efficient if the check for task->commits was first
before all the filtering.

> +test_expect_success "fetch new commits on-demand when they are not reachable" '

"not reachable" confused me - they are indeed reachable, just not from
the default refspec.

> +	git checkout --detach &&
> +	C=$(git -C submodule commit-tree -m "new change outside refs/heads" HEAD^{tree}) &&
> +	git -C submodule update-ref refs/changes/1 $C &&
> +	git update-index --cacheinfo 160000 $C submodule &&
> +	git commit -m "updated submodule outside of refs/heads" &&
> +	D=$(git rev-parse HEAD) &&
> +	git update-ref refs/changes/2 $D &&
> +	(
> +		cd downstream &&
> +		git fetch --recurse-submodules --recurse-submodules-default on-demand origin refs/changes/2:refs/heads/my_branch &&
> +		git -C submodule cat-file -t $C &&
> +		git checkout --recurse-submodules FETCH_HEAD
> +	)
> +'

For maximum test coverage, I think this test should involve 2
submodules:

 B   C  E   F
  \ /    \ /
   A      D

and the upstream superproject having:

  G -> H -> I

The downstream superproject already has G, and is fetching I. In H, the
submodule gitlinks point to B and E respectively, and in I, the
submodule gitlinks point to C and F respectively. This ensures that both
multiple submodules work, and that submodule commits are also fetched
for interior superproject commits.
