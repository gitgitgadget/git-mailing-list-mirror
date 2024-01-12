Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070DC5C90C
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4TBCxz0Fcjz5tlF;
	Fri, 12 Jan 2024 08:35:50 +0100 (CET)
Message-ID: <ce46229d-8964-4445-9a17-cff40aca1cb4@kdbg.org>
Date: Fri, 12 Jan 2024 08:35:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] `log --merge` also for rebase/cherry pick/revert
To: Michael Lohmann <mi.al.lohmann@gmail.com>
Cc: phillip.wood123@gmail.com, git@vger.kernel.org
References: <20240111233311.64734-1-mi.al.lohmann@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20240111233311.64734-1-mi.al.lohmann@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 12.01.24 um 00:33 schrieb Michael Lohmann:
> This extends the functionality of `git log --merge` to also work with
> conflicts for rebase, cherry pick and revert.
> 
> Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
> ---
> Hi everybody!
> 
> When Phillip Wood gave me some nice hints on his workflow concerning
> conflicts [1] (we discussed if `--show-current-patch` would make sense
> for cherry pick/revert). When I learned about `git log --merge` I was a
> bit sad to discover that those do not exist for rebase/revert/cherry
> pick since they look really valuable for getting an understanding on
> what was changed. It is basically the counterpart to
> `git show ${ACTION}_HEAD` for understanding the source of the conflict.
> 
> I am curious if also other people would be interested in having an easy
> way to get a log of only the relevant commits touching conflicting files
> for said actions.
> 
> With this patch I think the functionality is there, just hijacking the
> `--merge` code - maybe an alias like `git log --conflict` or similar
> might be more descriptive now?
> 
> What do you think about this idea? (Or am I maybe missing an easy way to
> achieve it with the existing code as well?)

Ha! Very nice patch. For comparison, have a look at my patch to achieve
the same that I never submitted (in particular, the author date):
https://github.com/j6t/git/commit/2327526213bc2fc3c109c1d8b4b0d95032346ff0

This implementation is more complete than mine. I like it.

> 
> Michael
> 
> 
> [1] https://lore.kernel.org/git/cfba7098-3c23-4a81-933c-b7fefdedec8a@gmail.com/
> 
>  revision.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/revision.c b/revision.c
> index 2424c9bd67..2e5c00dabd 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1961,23 +1961,37 @@ static void add_pending_commit_list(struct rev_info *revs,
>  	}
>  }
>  
> +static char* get_action_head_name(struct object_id* oid)
> +{
> +	if (!repo_get_oid(the_repository, "MERGE_HEAD", oid)) {
> +		return "MERGE_HEAD";
> +	} else if (!repo_get_oid(the_repository, "REBASE_HEAD", oid)) {
> +		return "REBASE_HEAD";
> +	} else if (!repo_get_oid(the_repository, "CHERRY_PICK_HEAD", oid)) {
> +		return "CHERRY_PICK_HEAD";
> +	} else if (!repo_get_oid(the_repository, "REVERT_HEAD", oid)) {
> +		return "REVERT_HEAD";
> +	} else
> +		die("--merge without MERGE_HEAD, REBASE_HEAD, CHERRY_PICK_HEAD or REVERT_HEAD?");
> +}
> +
>  static void prepare_show_merge(struct rev_info *revs)
>  {
>  	struct commit_list *bases;
>  	struct commit *head, *other;
>  	struct object_id oid;
>  	const char **prune = NULL;
> +	const char *action_head_name;
>  	int i, prune_num = 1; /* counting terminating NULL */
>  	struct index_state *istate = revs->repo->index;
>  
>  	if (repo_get_oid(the_repository, "HEAD", &oid))
>  		die("--merge without HEAD?");
>  	head = lookup_commit_or_die(&oid, "HEAD");
> -	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
> -		die("--merge without MERGE_HEAD?");
> -	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
> +	action_head_name = get_action_head_name(&oid);
> +	other = lookup_commit_or_die(&oid, action_head_name);
>  	add_pending_object(revs, &head->object, "HEAD");
> -	add_pending_object(revs, &other->object, "MERGE_HEAD");
> +	add_pending_object(revs, &other->object, action_head_name);
>  	bases = repo_get_merge_bases(the_repository, head, other);
>  	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
>  	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);

