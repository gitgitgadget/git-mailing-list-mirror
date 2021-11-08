Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C35C433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D837761177
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbhKHXbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 18:31:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59226 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240673AbhKHXbK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 18:31:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D9F5216A340;
        Mon,  8 Nov 2021 18:28:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rhcPl1F6BWus
        tDtwEn+CDS9WMu6/SRvh4bDHFjYkU+g=; b=L9DTsQMCSoVMDRynSKi9g494UIwp
        HjKuzjpc8xH+nVH/kDHj0lemZOx85Jp1V57GIPC+OJ0338f8jg2kyo36ityZHhf4
        YP3oIfhr4g109S8UkLQ86bVTQ6sU5VJNq1czZI3SUGfyy8pfPnRNLEeWkrOBaihc
        M6m4haRTlM/K10w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D363716A33F;
        Mon,  8 Nov 2021 18:28:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 245F516A33D;
        Mon,  8 Nov 2021 18:28:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v3 2/2] receive-pack: Protect current branch for bare
 repository worktree
References: <alpine.DEB.2.21.999.2111081515380.100671@scrubbing-bubbles.mit.edu>
Date:   Mon, 08 Nov 2021 15:28:21 -0800
In-Reply-To: <alpine.DEB.2.21.999.2111081515380.100671@scrubbing-bubbles.mit.edu>
        (Anders Kaseorg's message of "Mon, 8 Nov 2021 15:16:12 -0500 (EST)")
Message-ID: <xmqqzgqe448a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 90BFED16-40EB-11EC-BDD9-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Kaseorg <andersk@mit.edu> writes:

> A bare repository won=E2=80=99t have a working tree at .., but it may s=
till have

My reading hiccupped after "at"; perhaps enclose the double-dot
inside a pair of double quotes would make it easier to follow.

> separate working trees created with git worktree. We should protect the
> current branch of such working trees from being updated or deleted,
> according to receive.denyCurrentBranch.

Good point.  I was wondering about that exact thing while reading
the fetch side.

> @@ -1456,11 +1456,11 @@ static const char *update_worktree(unsigned cha=
r *sha1, const struct worktree *w
>  		work_tree =3D worktree->path;
>  	else if (git_work_tree_cfg)
>  		work_tree =3D git_work_tree_cfg;

Not a fault of this patch at all, but I am not sure if this existing
bit of code is correct.  Everything else in this function works by
assuming that the worktree that comes from the caller was checked
with find_shared_symref("HEAD", name) to ensure that, if not NULL,
it has the branch checked out and updating to the new commit given
as the other parameter makes sense.

But this "fall back to configured worktree" is taken when the gave
us NULL worktree or worktree without the .path member (i.e. no
checkout), and it must have come from a NULL return from the call to
find_shared_symref().  IOW, the function said "no worktree
associated with the repository checks out that branch being
updated."  I doubt it is a bug to update the working tree of the
repository with the commit pushed to some branch that is *not* HEAD,
only because core.worktree was set to point at an explicit location.

> -	else
> -		work_tree =3D "..";
> -
> -	if (is_bare_repository())
> +	else if (is_bare_repository())
>  		return "denyCurrentBranch =3D updateInstead needs a worktree";
> +	else
> +		work_tree =3D "..";
> +
>  	if (worktree)
>  		git_dir =3D get_worktree_git_dir(worktree);
>  	if (!git_dir)
> @@ -1486,7 +1486,7 @@ static const char *update(struct command *cmd, st=
ruct shallow_info *si)
>  	struct object_id *old_oid =3D &cmd->old_oid;
>  	struct object_id *new_oid =3D &cmd->new_oid;
>  	int do_update_worktree =3D 0;
> -	const struct worktree *worktree =3D is_bare_repository() ? NULL : fin=
d_shared_symref("HEAD", name);
> +	const struct worktree *worktree =3D find_shared_symref("HEAD", name);

OK.  This change does make sense.  The worktree we happen to be in
might be bare, but there can be other worktrees that have the branch
in question checked out, so find_shared_symref() must be called
regardless.

The callsite of the other function this patch modifies is in this
update() function much later, and I think it should be updated to
use the variable "worktree" instead of calling find_shared_symref()
again with the same parameters.

> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 4ef4ecbe71..52a4686afe 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1763,20 +1763,25 @@ test_expect_success 'updateInstead with push-to=
-checkout hook' '
> =20
>  test_expect_success 'denyCurrentBranch and worktrees' '
>  	git worktree add new-wt &&
> +	git clone --bare . bare.git &&
> +	git -C bare.git worktree add bare-wt &&

We create a bare.git bare repository with a bare-wt worktree that
has a working tree.  bare-wt branch must be protected now.

>  	git clone . cloned &&
>  	test_commit -C cloned first &&
>  	test_config receive.denyCurrentBranch refuse &&
>  	test_must_fail git -C cloned push origin HEAD:new-wt &&
> +	test_config -C bare.git receive.denyCurrentBranch refuse &&
> +	test_must_fail git -C cloned push ../bare.git HEAD:bare-wt &&

And pushing to that branch is refused (which is the default without
the receive.denyCurrentBranch configuration, too).  Good.

>  	test_config receive.denyCurrentBranch updateInstead &&
>  	git -C cloned push origin HEAD:new-wt &&
> -	test_must_fail git -C cloned push --delete origin new-wt
> +	test_must_fail git -C cloned push --delete origin new-wt &&

> +	test_config -C bare.git receive.denyCurrentBranch updateInstead &&
> +	git -C cloned push ../bare.git HEAD:bare-wt &&

And when set to update, it would update the working tree as expected.

We are not checking if we correctly update the working tree; we are
only seeing "git push" succeeds.  Which might want to be tightened
up.

> +	test_must_fail git -C cloned push --delete ../bare.git bare-wt

And even with updateInstead, we do not let the branch to be deleted.

>  '
> =20
>  test_expect_success 'refuse fetch to current branch of worktree' '
>  	test_commit -C cloned second &&
>  	test_must_fail git fetch cloned HEAD:new-wt &&
> -	git clone --bare . bare.git &&
> -	git -C bare.git worktree add bare-wt &&

It is a bit sad that these two tests are so inter-dependent.
Depending on an earlier failure of other tests, this may fail in an
unexpected way.

>  	test_must_fail git -C bare.git fetch ../cloned HEAD:bare-wt &&
>  	git fetch -u cloned HEAD:new-wt &&
>  	git -C bare.git fetch -u ../cloned HEAD:bare-wt

I think the core of the patch looks well thought out.  If the tests
are cleaned up a bit more, it would be perfect.

Thanks.
