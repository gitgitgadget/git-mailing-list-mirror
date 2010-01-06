From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Be more user-friendly when refusing to do something
 because of conflict.
Date: Wed, 06 Jan 2010 13:04:37 -0800
Message-ID: <7vskajq716.fsf@alter.siamese.dyndns.org>
References: <vpqhbqz6lcr.fsf@bauges.imag.fr>
 <1262809074-27137-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jan 06 22:04:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSd3l-00061o-MV
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 22:04:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932807Ab0AFVEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 16:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932805Ab0AFVEt
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 16:04:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932656Ab0AFVEs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 16:04:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8058A8EF18;
	Wed,  6 Jan 2010 16:04:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=myJzZiKKL+fvIYP27XAfgBUoE+k=; b=Spo50V
	liGqzKFAzS9U/TZzdUuq6LECoZ1f8xyAaMcV4WoAZNeXBoJ8262+Gb9VdusHYOI7
	Tk63747kP/9aLARvs7xf9sUoYaZYnzSrFYR5URbK8f7w3dPnn17EmuIMQTbaSnlb
	seaTdVFX8sSyhaibGkdMzPmEb1tPzR7FKIreg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MOaUDICs6dpxN4sKg8zt0m8KR7ZqDsIN
	rLOQz2IfntrM2BzgHmvFN0iLD5/rIAb+0s1D4J6m8OJ1z12ejccztmBMznkOoMVE
	4KmAz5S23Mnnm0TBlj2mAvttxzYwojcnm7ssJ6+y5vGtODJwylPWS3LohzAe8kzG
	qcKzvBRwWkw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E3E18EF13;
	Wed,  6 Jan 2010 16:04:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CB818EF0F; Wed,  6 Jan
 2010 16:04:39 -0500 (EST)
In-Reply-To: <1262809074-27137-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Wed\,  6 Jan 2010 21\:17\:54 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1C299146-FB07-11DE-99E5-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136298>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Various commands refuse to run in the presence of conflicts (commit,
> merge, pull, cherry-pick/revert). They all used to provide rough, and
> inconsistant error messages.
>
> A new variable advice.resolveconflict is introduced, and allows more
> verbose messages, pointing the user to the appropriate solution.
>
> For commit, the error message used to look like this:
>
> $ git commit
> foo.txt: needs merge
> foo.txt: unmerged (c34a92682e0394bc0d6f4d4a67a8e2d32395c169)
> foo.txt: unmerged (3afcd75de8de0bb5076942fcb17446be50451030)
> foo.txt: unmerged (c9785d77b76dfe4fb038bf927ee518f6ae45ede4)
> error: Error building trees
>
> The "need merge" line is given by refresh_cache. We add the IN_PORCELAIN
> option to make the output more consistant with the other porcelain
> commands, and catch the error in return, to stop with a clean error
> message. The next lines were displayed by a call to cache_tree_update(),
> which is not reached anymore if we noticed the conflict.

"The new output looks like this, which is much better..." is missing
here.

> @@ -27,3 +29,13 @@ int git_default_advice_config(const char *var, const char *value)
>  
>  	return 0;
>  }
> +
> +void NORETURN die_resolve_conflict(const char *me)
> +{
> +	if (advice_resolve_conflict)
> +		die("'%s' is not possible because you have unmerged files.\n"
> +		    "Please, fix them up in the work tree, and then use 'git add/rm <file>'\n"
> +		    "as appropriate to mark resolution, or use 'git commit -a'.", me);
> +	else
> +		die("'%s' is not possible because you have unmerged files.", me);
> +}

Nice, but the advice contrasts between squirrels and oranges.

One advice, "use add/rm as appropriate to mark resolution" goes only as
far as making the index in order, without recording it in a commit.  The
other, "commit -a", will make a commit, I suspect that "commit -a" needs
to be matched with "commit" if the user chooses to take the first advice
of resolving paths incrementally.  IOW

    use 'git add/rm <file>' as appropriate to mark resolution and make a
    commit, or use 'commit -a', before running me again.

might be more appropriate.

> diff --git a/builtin-commit.c b/builtin-commit.c
> index 3dfcd77..a4977ac 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -235,6 +235,17 @@ static void create_base_index(void)
>  		exit(128); /* We've already reported the error, finish dying */
>  }
>  
> +static void refresh_cache_or_die(int refresh_flags)
> +{
> +	/*
> +	 * refresh_flags contains REFRESH_QUIET, so the only errors
> +	 * are for unmerged entries.
> +	*/

Mixed indentation.

> +	if(refresh_cache(refresh_flags | REFRESH_IN_PORCELAIN)) {

SP after "if".

What should we see upon "commit --dry-run" and what does the code after
the patch produce?  Are we sure refresh_flags always lack REFRESH_UNMERGED
that allows unmerged entries and produces the unmerged error messages when
needed?

> diff --git a/builtin-merge.c b/builtin-merge.c
> index f1c84d7..abe6c03 100644
> --- a/builtin-merge.c
> +++ b/builtin-merge.c
> @@ -847,11 +847,16 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  	const char *best_strategy = NULL, *wt_strategy = NULL;
>  	struct commit_list **remotes = &remoteheads;
>  
> -	if (file_exists(git_path("MERGE_HEAD")))
> -		die("You have not concluded your merge. (MERGE_HEAD exists)");
> -	if (read_cache_unmerged())
> -		die("You are in the middle of a conflicted merge."
> -				" (index unmerged)");
> +	if (read_cache_unmerged()) {
> +		die_resolve_conflict("merge");
> +	}
> +	if (file_exists(git_path("MERGE_HEAD"))) {
> +		if (advice_resolve_conflict)
> +			die("You have not concluded your merge (MERGE_HEAD exists).\n"
> +			    "Please, commit your changes before you can merge.");
> +		else
> +			die("You have not concluded your merge (MERGE_HEAD exists).");
> +	}

It is not a very big deal, but why are these checked in different order
after the patch?  Unless the new order is justifiably better, I'd rather
see the order kept as before.  Otherwise please justify it in the proposed
commit log message.

Note that the user might have already run "add -u" to mark everything
resolved, in which case MERGE_HEAD will still exist even though the index
is free of ummerged entries.

> diff --git a/builtin-revert.c b/builtin-revert.c

Nice.

> diff --git a/git-pull.sh b/git-pull.sh
> index 9e69ada..54ce0af 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -13,8 +13,29 @@ set_reflog_action "pull $*"
>  require_work_tree
>  cd_to_toplevel
>  
> -test -z "$(git ls-files -u)" ||
> -	die "You are in the middle of a conflicted merge."
> +
> +die_conflict () {
> +    git diff-index --cached --name-status -r --ignore-submodules HEAD --
> +    if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
> +	die "Pull is not possible because you have unmerged files.
> +Please, fix them up in the work tree, and then use 'git add/rm <file>'
> +as appropriate to mark resolution, or use 'git commit -a'."
> +    else
> +	die "Pull is not possible because you have unmerged files."
> +    fi
> +}
> +
> +die_merge () {
> +    if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
> +	die "You have not concluded your merge (MERGE_HEAD exists).
> +Please, commit your changes before you can merge."
> +    else
> +	die "You have not concluded your merge (MERGE_HEAD exists)."
> +    fi
> +}
> +
> +test -z "$(git ls-files -u)" || die_conflict
> +test -f "$GIT_DIR/MERGE_HEAD" && die_merge

Nice.  Maybe we want to handle other cases like:

	$ git rebase master
        ... conflicted
        ... called away for a 30-minutes meeting
        ... forgot the user was in the middle of the rebase
        $ git pull

and the "pull" refused to run because the earlier "rebase" hasn't been
concluded (I suspect an earlier "am" failure would be the same issue).

Thanks.
