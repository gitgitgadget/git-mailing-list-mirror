Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F24C0015E
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 02:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjHGCLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Aug 2023 22:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHGCLA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2023 22:11:00 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ECA1701
        for <git@vger.kernel.org>; Sun,  6 Aug 2023 19:10:59 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B615E19F693;
        Sun,  6 Aug 2023 22:10:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iKBKskJSifPZ
        Gvj+KNKBL8J0tohqoAwGbQjL2DzQ3e8=; b=NdiDPReWuoQIuQgZj9qDXETIfN2X
        Baf7OoXDPtsqI/vnxDo1mQ2DllOQfcMVsT7m0PdWrzEf8Q5J4o3BCCoinOVH+wuC
        Yp1zr+y/hWoBf000utjFe/lOnsuqmWQjOHZu5R5yQOSwE2KL8/OegTGTsbHWLJ9P
        l1ZRnwhcDrfliC0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AED6D19F692;
        Sun,  6 Aug 2023 22:10:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21A6919F690;
        Sun,  6 Aug 2023 22:10:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Izzy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Izzy <winglovet@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] merge-tree: add -X strategy option
References: <pull.1565.git.1691245481977.gitgitgadget@gmail.com>
Date:   Sun, 06 Aug 2023 19:10:57 -0700
In-Reply-To: <pull.1565.git.1691245481977.gitgitgadget@gmail.com> (Izzy via
        GitGitGadget's message of "Sat, 05 Aug 2023 14:24:41 +0000")
Message-ID: <xmqqfs4vioum.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A5E5DAC6-34C7-11EE-8840-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Izzy via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: winglovet <winglovet@gmail.com>
>
> Add merge strategy option to produce more customizable merge result suc=
h
> as automatically solve conflicts.
>
> Signed-off-by: winglovet <winglovet@gmail.com>

cf. Documentation/SubmittingPatches::[real-name], a part of the DCO
section of the document.

>  builtin/merge-tree.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

A new feature should be protected by new tests to make sure it will
not be broken accidentally by others.  Probably a couple of new
tests to both t4300 and t4301?

$ git shortlog -sn --no-merges --since=3D6.months builtin/merge-tree.c t/=
t430[01]*.sh

tells me that Elijah and =C3=86var had been active, but by looking at the
output of

$ git log --author=3D=C3=86var --since=3D6.months builtin/merge-tree.c t/=
t430[01]*.sh

shows that the contribution by the latter was solely about code
clean-up with Coccinelle and not about code features and correctness,
so for a new-feature change like this, I'd ask comments by Elijah if
I were writing this patch.

Thanks.

> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 0de42aecf4b..2ec6ec0d39a 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -19,6 +19,8 @@
>  #include "tree.h"
>  #include "config.h"
> =20
> +static const char **xopts;
> +static size_t xopts_nr, xopts_alloc;
>  static int line_termination =3D '\n';
> =20
>  struct merge_list {
> @@ -414,6 +416,7 @@ struct merge_tree_options {
>  	int show_messages;
>  	int name_only;
>  	int use_stdin;
> +	struct merge_options merge_options;
>  };
> =20
>  static int real_merge(struct merge_tree_options *o,
> @@ -439,6 +442,8 @@ static int real_merge(struct merge_tree_options *o,
> =20
>  	init_merge_options(&opt, the_repository);
> =20
> +	opt.recursive_variant =3D o->merge_options.recursive_variant;
> +
>  	opt.show_rename_progress =3D 0;
> =20
>  	opt.branch1 =3D branch1;
> @@ -510,6 +515,17 @@ static int real_merge(struct merge_tree_options *o=
,
>  	return !result.clean; /* result.clean < 0 handled above */
>  }
> =20
> +static int option_parse_x(const struct option *opt,
> +			  const char *arg, int unset)
> +{
> +	if (unset)
> +		return 0;
> +
> +	ALLOC_GROW(xopts, xopts_nr + 1, xopts_alloc);
> +	xopts[xopts_nr++] =3D xstrdup(arg);
> +	return 0;
> +}
> +
>  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  {
>  	struct merge_tree_options o =3D { .show_messages =3D -1 };
> @@ -548,6 +564,10 @@ int cmd_merge_tree(int argc, const char **argv, co=
nst char *prefix)
>  			   &merge_base,
>  			   N_("commit"),
>  			   N_("specify a merge-base for the merge")),
> +		OPT_CALLBACK('X', "strategy-option", &xopts,
> +			N_("option=3Dvalue"),
> +			N_("option for selected merge strategy"),
> +			option_parse_x),
>  		OPT_END()
>  	};
> =20
> @@ -556,6 +576,10 @@ int cmd_merge_tree(int argc, const char **argv, co=
nst char *prefix)
>  	argc =3D parse_options(argc, argv, prefix, mt_options,
>  			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
> =20
> +	for (int x =3D 0; x < xopts_nr; x++)
> +		if (parse_merge_opt(&o.merge_options, xopts[x]))
> +			die(_("unknown strategy option: -X%s"), xopts[x]);
> +
>  	/* Handle --stdin */
>  	if (o.use_stdin) {
>  		struct strbuf buf =3D STRBUF_INIT;
>
> base-commit: ac83bc5054c2ac489166072334b4147ce6d0fccb
