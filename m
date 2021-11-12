Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7216C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 16:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8404460ED5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 16:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhKLQk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 11:40:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62644 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhKLQk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 11:40:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A0EEF9288;
        Fri, 12 Nov 2021 11:38:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zguaIlINmYgC
        r7XmyeD2k/5C/373sThPg80RrQ4VzT4=; b=Y9MH5KT3Q5wI2CltX4mytP+2zu8r
        plmFsNOdkm7/8aCYSqZCowwDgRD0Z3a8BkOOlPHDaFfo9EknTyIRRINU49I2+SF2
        Cb9mRc7TQk6F4he7WRmbv4wXbmctw1My6V5u+Pjn0Yb2pBKChjsiB54pKAzVCt7G
        E5xtaqQgiIQQg0k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E4B1F9287;
        Fri, 12 Nov 2021 11:38:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 333C4F9286;
        Fri, 12 Nov 2021 11:38:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/8] built-ins: trust the "prefix" from run_builtin()
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
        <patch-v2-2.8-63cf2fe266d-20211110T013632Z-avarab@gmail.com>
Date:   Fri, 12 Nov 2021 08:38:02 -0800
In-Reply-To: <patch-v2-2.8-63cf2fe266d-20211110T013632Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 10 Nov
 2021 02:43:44
        +0100")
Message-ID: <xmqq7dddtjmd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E85F6AD6-43D6-11EC-9BC2-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 3a442631c71..84bed6d5612 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -147,16 +147,15 @@ int cmd_ls_tree(int argc, const char **argv, cons=
t char *prefix)
>  		OPT__ABBREV(&abbrev),
>  		OPT_END()
>  	};
> -
> -	git_config(git_default_config, NULL);
>  	ls_tree_prefix =3D prefix;

See below.

> -	if (prefix && *prefix)
> +	if (prefix)
>  		chomp_prefix =3D strlen(prefix);

We now assume a non-NULL prefix means a non-NUL *prefix, so this
change is understandable.

> +	git_config(git_default_config, NULL);

This moving down of git_config() call is not.  A necessary change,
or an unrelated churn?  If necessary, why?  By not checking if prefix[0]
is NUL, we now need to delay reading the configuration, because ...?

>  	argc =3D parse_options(argc, argv, prefix, ls_tree_options,
>  			     ls_tree_usage, 0);
>  	if (full_tree) {
> -		ls_tree_prefix =3D prefix =3D NULL;
> +		ls_tree_prefix =3D NULL;
>  		chomp_prefix =3D 0;
>  	}
>  	/* -d -r should imply -t, but -d by itself should not have to. */
> @@ -178,7 +177,7 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
>  	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC &
>  				  ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
>  		       PATHSPEC_PREFER_CWD,
> -		       prefix, argv + 1);
> +		       ls_tree_prefix, argv + 1);

The above two are unnecessary changes.

It was not like the introduction of ls_tree_prefix was made in order
to get rid of "prefix" altogether.  We still have and use prefix,
but we have ls_tree_prefix to expose the value of it to other
functions as a way to "cheat", without having to pass it through as
a parameter (and cheating is OK as its scope is limited to the file).

Perhaps make a conscious effort to refrain from making such
unnecessary changes, especially when working on a multi-patch
series, which may avoid wearing down reviewers?

> diff --git a/git.c b/git.c
> index 5ff21be21f3..611bf2f63eb 100644
> --- a/git.c
> +++ b/git.c
> @@ -420,9 +420,8 @@ static int run_builtin(struct cmd_struct *p, int ar=
gc, const char **argv)
>  {
>  	int status, help;
>  	struct stat st;
> -	const char *prefix;
> +	const char *prefix =3D NULL;
> =20
> -	prefix =3D NULL;
>  	help =3D argc =3D=3D 2 && !strcmp(argv[1], "-h");
>  	if (!help) {
>  		if (p->option & RUN_SETUP)

Likewise.  Little cuts accumulate.

> @@ -431,6 +430,7 @@ static int run_builtin(struct cmd_struct *p, int ar=
gc, const char **argv)
>  			int nongit_ok;
>  			prefix =3D setup_git_directory_gently(&nongit_ok);
>  		}
> +		assert(!prefix || *prefix);

Good.

> diff --git a/grep.h b/grep.h
> index 95cccb670f9..62deadb885f 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -134,8 +134,6 @@ struct grep_opt {
>  	 */
>  	struct repository *repo;
> =20
> -	const char *prefix;
> -	int prefix_length;

So, builtin/grep.c is the only user of the low-level grep machinery
that needs to touch these two, and we can lose these members now
that builtin/grep.c relies on the file-scope global instead.  OK.

> diff --git a/revision.c b/revision.c
> index ab7c1358042..9f9b0d2429e 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1833,7 +1833,7 @@ void repo_init_revisions(struct repository *r,
>  	revs->commit_format =3D CMIT_FMT_DEFAULT;
>  	revs->expand_tabs_in_log_default =3D 8;
> =20
> -	grep_init(&revs->grep_filter, revs->repo, prefix);
> +	grep_init(&revs->grep_filter, revs->repo);
>  	revs->grep_filter.status_only =3D 1;
> =20
>  	repo_diff_setup(revs->repo, &revs->diffopt);
