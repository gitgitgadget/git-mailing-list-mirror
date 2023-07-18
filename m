Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94478EB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 16:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjGRQhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 12:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjGRQhl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 12:37:41 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ABC1B3
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 09:37:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8930B262FB;
        Tue, 18 Jul 2023 12:37:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hvtGUVKqiaP8
        v9WnBu3GwL7sDl1km9bti7q2zSP2lrc=; b=tPontVjkeljIx26gqtv0oSVEYAS5
        gCsEuPSJwQkCSNSYMCZREj0oIOD4LmnAcs+CP+lJQVl4/Vsy44As+3ysr3lnDnyv
        VvW+IVT5Ml6e9U02QrwITc4BjhhYef3J4ExEbTdwGesbvl9/R0OVwDp6Ara0a1w9
        7KZiosDwnLz9PMs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8392D262FA;
        Tue, 18 Jul 2023 12:37:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 00577262F9;
        Tue, 18 Jul 2023 12:37:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] ls-tree: fix --no-full-name
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
Date:   Tue, 18 Jul 2023 09:37:30 -0700
In-Reply-To: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 18 Jul 2023 17:44:13 +0200")
Message-ID: <xmqqo7k9fa5x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 64654D40-2589-11EE-AAC9-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Since 61fdbcf98b (ls-tree: migrate to parse-options, 2009-11-13) git
> ls-tree has accepted the option --no-full-name, but it does the same
> as --full-name, contrary to convention.  That's because it's defined
> using OPT_SET_INT with a value of 0, where the negative variant sets
> 0 as well.

Ouch.  Well spotted.

> Turn --no-full-name into the opposite of --full-name by using OPT_BOOL
> instead and storing the option's status directly in a variable named
> "full_name" instead of in negated form in "chomp_prefix".

Good solution, especially the flipping of the polarity of the
variable is very sensible.

I wonder if there are cases where it makes sense to allow the
"--no-" variant to an option parsed with OPT_SET_INT() that sets '0'
as the value?

Some random findings while reading hits from "git grep OPT_SET_INT":

 * "git am --[no-]keep-cr" is implemented as a pair of explicit
   PARSE_OPT_NONEG entries in the option[] array, but wouldn't it be
   sufficient to have a single OPT_SET_INT("keep-cr")?

 * "git branch --list --no-all" is accepted, sets filter.kind to 0,
   and triggers "fatal: filter_refs: invalid type".  Shouldn't we
   detect error much earlier?

 * "git bundle create --no-quiet" is accepted and sets the progress
   variable to 0, just like "--quiet" does, which is the same issue
   as the one fixed by your patch.

 * "git clone (--no-ipv4|--no-ipv6)" are accepted and uses
   TRANSPORT_FAMILY_ALL, presumably allowing both v4 and v6.
   Shouldn't we reject these?  "fetch" and "push" share the same
   issue.

 * "git status --no-(short|long|porcelain)" are accepted and use
   STATUS_FORMAT_NONE, which probably is OK.

 * "git commit --[no-](short|long|porcelain)" are accepted and
   behave as "git status" without doing any "git commit" thing,
   which should be corrected, I think.

 * "git describe --no-exact-match" is the same as "--exact-match",
   which is the same issue as the one fixed by your patch.

 * "git remote add" has an OPT_SET_INT() entry whose short and long
   forms are (0, NULL).  What is this supposed to do?  Shouldn't
   parse-options.c:parse_options_check() notice it as an error?

 * "git reset --(soft|hard|mixed|merge|keep)" all take the negated
   form and they all become "--mixed".  It may make sense to give
   all of them PARSE_OPT_NONEG.

 * "git show-branch --no-sparse" is the same as "--sparse",
   which is the same issue as the one fixed by your patch.

 * "git show-branch --no-topo-order" is the same as "--topo-order";
   as it is the default, we probably should give PARSE_OPT_NONEG.

 * "git show-branch --no-date-order" is the same as "--topo-order",
   which does sort-of make sense.  This (and the previous one)
   relies on REV_SORT_IN_GRAPH_ORDER enum being 0, which smells a
   bit brittle.

 * "git stash push --no-all" is the same as "--no-include-untracked",
   which smells iffy but probably is OK.

Anyway, the patch looks good.  Will queue.

Thanks.

> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/ls-tree.c          | 7 +++----
>  t/t3101-ls-tree-dirname.sh | 8 ++++++++
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 53073d64cb..f558db5f3b 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -343,7 +343,7 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
>  	struct object_id oid;
>  	struct tree *tree;
>  	int i, full_tree =3D 0;
> -	int chomp_prefix =3D prefix && *prefix;
> +	int full_name =3D !prefix || !*prefix;
>  	read_tree_fn_t fn =3D NULL;
>  	enum ls_tree_cmdmode cmdmode =3D MODE_DEFAULT;
>  	int null_termination =3D 0;
> @@ -365,8 +365,7 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
>  			    MODE_NAME_STATUS),
>  		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
>  			    MODE_OBJECT_ONLY),
> -		OPT_SET_INT(0, "full-name", &chomp_prefix,
> -			    N_("use full path names"), 0),
> +		OPT_BOOL(0, "full-name", &full_name, N_("use full path names")),
>  		OPT_BOOL(0, "full-tree", &full_tree,
>  			 N_("list entire tree; not just current directory "
>  			    "(implies --full-name)")),
> @@ -387,7 +386,7 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
>
>  	if (full_tree)
>  		prefix =3D NULL;
> -	options.prefix =3D chomp_prefix ? prefix : NULL;
> +	options.prefix =3D full_name ? NULL : prefix;
>
>  	/*
>  	 * We wanted to detect conflicts between --name-only and
> diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
> index 217006d1bf..5af2dac0e4 100755
> --- a/t/t3101-ls-tree-dirname.sh
> +++ b/t/t3101-ls-tree-dirname.sh
> @@ -154,6 +154,14 @@ EOF
>  	test_output
>  '
>
> +test_expect_success 'ls-tree --no-full-name' '
> +	git -C path0 ls-tree --no-full-name $tree a >current &&
> +	cat >expected <<-EOF &&
> +	040000 tree X	a
> +	EOF
> +	test_output
> +'
> +
>  test_expect_success 'ls-tree --full-tree' '
>  	(
>  		cd path1/b/c &&
> --
> 2.41.0
