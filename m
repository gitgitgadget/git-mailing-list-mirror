Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1244D100
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jTeWl01F"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 204F71C73B2;
	Wed, 10 Jan 2024 12:48:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pSPZitH2sE+M
	60uiuu/IOOaQb6pnk/dZXgkVGXrKEyc=; b=jTeWl01F+tyubrDAvGz73px2ajyW
	S2CB4PPv0bGamQXAG+Z+n/9hHRZlbo6nAXNAtOlaPjLpumb//JHA8tIUKueX3kf9
	J/2lwsiCKI8ZUkrlAEXjgd0tPQq6oN6VmfxSbGbH1nlPz59FoYIOmz87Am6iF9Id
	3Eg7BotyV931WQ4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 181611C73B1;
	Wed, 10 Jan 2024 12:48:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E00B1C73AF;
	Wed, 10 Jan 2024 12:48:53 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] branch: error description when deleting a not fully
 merged branch
In-Reply-To: <04c3556f-0242-4ac3-b94a-be824cd2004a@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Wed, 10 Jan 2024 15:55:28 +0100")
References: <04c3556f-0242-4ac3-b94a-be824cd2004a@gmail.com>
Date: Wed, 10 Jan 2024 09:48:52 -0800
Message-ID: <xmqqbk9tcc57.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 850AE3DE-AFE0-11EE-BB74-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> The error message we show when the user tries to delete a not fully
> merged branch describes the error and gives a hint to the user:
>
> 	error: the branch 'foo' is not fully merged.
> 	If you are sure you want to delete it, run 'git branch -D foo'.
>
> Let's move the hint part so that it takes advantage of the advice
> machinery:
>
> 	error: the branch 'foo' is not fully merged
> 	hint: If you are sure you want to delete it, run 'git branch -D foo'
> 	hint: Disable this message with "git config advice.forceDeleteBranch f=
alse"

This is probably one sensible step forward, so let's queue it as-is.

But with reservations for longer-term future direction.  Stepping
back a bit, when 'foo' is not fully merged and the user used "branch
-d" on it, is it sensible for us to suggest use of "branch -D"?

Especially now this is a "hint" to help less experienced folks, it
may be helpful to suggest how the user can answer "If you are sure
you want to delete" part.  As this knows what unique commits on the
branch being deleted are about to be lost, one way to do so may be
to tell the user about them ("you are about to lose 'branch: error
description when deleting a not fully merged branch' and other 47
commits that are not merged the target branch 'main'", for example).

Another possibility is to suggest merging the branch into the
target, instead of suggesting a destructive "deletion", but I
suspect that it goes too far second-guessing the end-user intention.

Thanks.

> Signed-off-by: Rub=C3=A9n Justo <rjusto@gmail.com>
> ---
>
> This change is a pending NEEDSWORK from a recent series about adjusting
> the error messages in branch.c
>
> Unfortunately the full message now becomes a three line message.
>
> Hopefully we can find a way in the near future to keep it at two.
>
>  Documentation/config/advice.txt | 3 +++
>  advice.c                        | 1 +
>  advice.h                        | 3 ++-
>  builtin/branch.c                | 9 ++++++---
>  4 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config/advice.txt b/Documentation/config/adv=
ice.txt
> index 4d7e5d8759..5814d659b9 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -142,4 +142,7 @@ advice.*::
>  		Advice shown when a user tries to create a worktree from an
>  		invalid reference, to instruct how to create a new unborn
>  		branch instead.
> +	forceDeleteBranch::
> +		Advice shown when a user tries to delete a not fully merged
> +		branch without the force option set.
>  --
> diff --git a/advice.c b/advice.c
> index 50c79443ba..e91f5d7ab8 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -79,6 +79,7 @@ static struct {
>  	[ADVICE_UPDATE_SPARSE_PATH]			=3D { "updateSparsePath", 1 },
>  	[ADVICE_WAITING_FOR_EDITOR]			=3D { "waitingForEditor", 1 },
>  	[ADVICE_WORKTREE_ADD_ORPHAN]			=3D { "worktreeAddOrphan", 1 },
> +	[ADVICE_FORCE_DELETE_BRANCH]			=3D { "forceDeleteBranch", 1 },
>  };
> =20
>  static const char turn_off_instructions[] =3D
> diff --git a/advice.h b/advice.h
> index 2affbe1426..5bef900142 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -10,7 +10,7 @@ struct string_list;
>   * Add the new config variable to Documentation/config/advice.txt.
>   * Call advise_if_enabled to print your advice.
>   */
> - enum advice_type {
> +enum advice_type {
>  	ADVICE_ADD_EMBEDDED_REPO,
>  	ADVICE_ADD_EMPTY_PATHSPEC,
>  	ADVICE_ADD_IGNORED_FILE,
> @@ -50,6 +50,7 @@ struct string_list;
>  	ADVICE_WAITING_FOR_EDITOR,
>  	ADVICE_SKIPPED_CHERRY_PICKS,
>  	ADVICE_WORKTREE_ADD_ORPHAN,
> +	ADVICE_FORCE_DELETE_BRANCH,
>  };
> =20
>  int git_default_advice_config(const char *var, const char *value);
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 0a32d1b6c8..2240433bc8 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -24,6 +24,7 @@
>  #include "ref-filter.h"
>  #include "worktree.h"
>  #include "help.h"
> +#include "advice.h"
>  #include "commit-reach.h"
> =20
>  static const char * const builtin_branch_usage[] =3D {
> @@ -190,9 +191,11 @@ static int check_branch_commit(const char *branchn=
ame, const char *refname,
>  		return -1;
>  	}
>  	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
> -		error(_("the branch '%s' is not fully merged.\n"
> -		      "If you are sure you want to delete it, "
> -		      "run 'git branch -D %s'"), branchname, branchname);
> +		error(_("the branch '%s' is not fully merged"),
> +		      branchname);
> +		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
> +				  _("If you are sure you want to delete it, "
> +				  "run 'git branch -D %s'"), branchname);
>  		return -1;
>  	}
>  	return 0;
