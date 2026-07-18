Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D1A28BAB9
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784364753; cv=none; b=EkAhO2ODZ1hhDpr7uAN84FiDrEhsxQrLd/5fPgzmVhnT0QsarqkE71fzqWHC2FkdrYQDQ3T6y3O22CZubrA7U7TpouKZ8DujhiO1MNuA0waRcqZJMGZXejTDdnJbmHnskbqYNrcUYCKFesvU5CAsXY3ieTbCuIWg4+FLl3dnhDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784364753; c=relaxed/simple;
	bh=y0AYwGoHanQT0WXyzrBRtloP13C7oE6DwGrbfxHYSHU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=nuxJMJsxxuS2hrqoc6UDlEzqS3l3jQbtN4w4ENAcSClONIOuTHCU/qGowf5d7L1ZeH6pC5riHxBlMAk0xAkTl+xAcHij0Z8rpZN+VnWOC5S5ZSGu8uFK4dG9tS5e1gY1DdUU05FcN7usho337NOLe7oxU4x+1cDVqmYjQAbV+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=iyj5ilsJ; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="iyj5ilsJ"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id D33B960E06;
	Sat, 18 Jul 2026 08:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1784364745; bh=y0AYwGoHanQT0WXyzrBRtloP13C7oE6DwGrbfxHYSHU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=iyj5ilsJ14RVO7jRLmSrwpquQCVfYRvr6uZzHWO5htI2RepVdlulGiyhHDAwiTjsL
	 698OTdR683Y2ds+Rk4RgNkk7Of0B0BNAWqC8k6B1LvrRUDpyGLIaWJfor7Q2529EId
	 1I9FQzWVRxqCHyUlEv9ZcvsTiV8pGsVSvCy4BjMY=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Jul 2026 04:52:24 -0400
Message-Id: <DK1KIF2OI8IF.11188A3YEQV1C@lfurio.us>
Subject: Re: [PATCH v9 3/5] history: add squash subcommand to fold a range
Cc: "Phillip Wood" <phillip.wood123@gmail.com>, "D. Ben Knoble"
 <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>, "Harald Nordgren"
 <haraldnordgren@gmail.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>,
 <git@vger.kernel.org>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
 <pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com>
 <ead974c3173770f9230d2ba8442ff06dd9e91e00.1784128573.git.gitgitgadget@gmail.com>
In-Reply-To: <ead974c3173770f9230d2ba8442ff06dd9e91e00.1784128573.git.gitgitgadget@gmail.com>

Hi Harald,

The new functionality for amend! messages seems to be working well, so I
dug a little deeper and found the following...

On Wed Jul 15, 2026 at 11:16 AM EDT, Harald Nordgren via GitGitGadget wrote=
:
> ++
> +The range is given in the usual `<base>..<tip>` form, where _<base>_ is
> +the commit just below the oldest commit to squash. For example, `git
> +history squash HEAD~3..HEAD` folds the three most recent commits into
> +one, and `git history squash HEAD~5..HEAD~2` squashes an interior range
> +while leaving the two newest commits in place. Several revisions may be
> +given, for example `HEAD~3..HEAD ^topic` to additionally exclude what is
> +already on `topic`. Rev-list options may also be given, but any that wou=
ld
> +change how the range is walked are overridden with a warning.
> ++
> +The oldest commit's message is preserved by default, except that an `ame=
nd!`
> +commit targeting it replaces its message.

The new behavior from v9 is documented here, but...

>                                            Specify `--reedit-message` to =
edit
> +the resulting message. A merge commit inside the range is folded like an=
y
> +other, but the range must have a single base, so a range that reaches mo=
re
> +than one entry point (for example a side branch that forked before the r=
ange
> +and was later merged into it) is rejected.
> ++
> +A `fixup!`, `squash!`, or `amend!` commit is refused unless the commit i=
t
> +targets is also in the range, so the fold does not silently absorb a
> +marker meant for a commit outside it. The body after an `amend!` subject
> +replaces the oldest commit's message when the marker targets that commit=
.

...a redundant explanation appears here too.  Personally, I think this
paragraph flows better if the 'The body after an `amend!`...targets that
commit.' sentence were removed.

> +As an exception, a range made up entirely of markers for one target is c=
ombined
> +into a single commit, keeping the last `amend!` message if there is one.
> ++
> +A branch or tag that points at a commit inside the range would be left
> +dangling once those commits are folded away, so with the default
> +`--update-refs=3Dbranches` the command refuses. Rerun with
> +`--update-refs=3Dhead` to rewrite only the current branch and leave such
> +refs pointing at the old commits.
> +
>  OPTIONS
>  -------
> =20
> @@ -107,7 +147,8 @@ OPTIONS
>  	ref updates is generally safe.
> =20
>  `--reedit-message`::
> -	Open an editor to modify the target commit's message.
> +	Open an editor to modify the rewritten commit's message. For `squash`
> +	the editor is pre-filled with the messages of all the folded commits.

At the moment of this patch, this is a false statement, though it is
made true by patch 5/5 pre-filling all messages.

> diff --git a/builtin/history.c b/builtin/history.c
> index cbba25096f..edf98a21d3 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> +
> +	repo_init_revisions(repo, &revs, NULL);
> +	revs.reverse =3D 1;
> +	revs.topo_order =3D 1;
> +	revs.sort_order =3D REV_SORT_IN_GRAPH_ORDER;
> +	revs.simplify_history =3D 0;
> +	revs.boundary =3D 1;
> +
> +	strvec_push(&args, "ignored");
> +	strvec_push(&args, "--ancestry-path");
> +	strvec_pushv(&args, argv);
> +	setup_revisions_from_strvec(&args, &revs, NULL);
> +	if (args.nr !=3D 1) {
> +		ret =3D error(_("unrecognized argument: %s"), args.v[1]);
> +		goto out;
> +	}
> +
> +	if (revs.reverse !=3D 1 || revs.topo_order !=3D 1 ||
> +	    revs.sort_order !=3D REV_SORT_IN_GRAPH_ORDER ||
> +	    revs.simplify_history !=3D 0) {
> +		warning(_("ignoring rev-list options that would change how the "
> +			  "range is walked"));
> +		revs.reverse =3D 1;
> +		revs.topo_order =3D 1;
> +		revs.sort_order =3D REV_SORT_IN_GRAPH_ORDER;
> +		revs.simplify_history =3D 0;
> +	}

Should revs.boundary still =3D=3D 1 be asserted here too?

> +
> +	base_tree_oid =3D &repo_get_commit_tree(repo, base)->object.oid;
> +	tip_tree_oid =3D &repo_get_commit_tree(repo, tip)->object.oid;
> +	commit_list_append(base, &parents);
> +
> +	ret =3D commit_tree_ext(repo, "squash", msg_source, message_template,
> +			      parents,
> +			      base_tree_oid, tip_tree_oid, &rewritten, flags);
> +	if (ret < 0) {
> +		ret =3D error(_("failed writing squashed commit"));
> +		goto out;
> +	}
> +
> +	strbuf_addf(&reflog_msg, "squash: updating %s", argv[0]);

With this format string, the reflog will miss cases like:

    git history squash HEAD~5..HEAD ^origin/master

Only "squash: updating HEAD~5..HEAD" will be recorded in the log.
