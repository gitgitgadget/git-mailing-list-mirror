Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C33EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 06:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjFTGZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 02:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjFTGZz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 02:25:55 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB0C1A4
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 23:25:54 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F21DB19076A;
        Tue, 20 Jun 2023 02:25:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=QVn9quUX6OxVrxIWhjm6rfLTjuKD59kEH2Qvvp6bB2I=; b=Kdn2
        x33tHNNSLrFZBLKgDE8i6t4UN/I0plT1EBdzVGZ/k/DXr3hnBfhbrx7XkZbLCm+E
        lNZ612qolz+SckqU5OEFDxpc9KfF/zZ5rlayYS8GA5k+Zcwl2CiLyd/QXC0pXRPI
        oNluKMRdeHw8YE+9dNPLhBVvk/BEdhOhBGE8KZw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCB2E190766;
        Tue, 20 Jun 2023 02:25:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 38114190764;
        Tue, 20 Jun 2023 02:25:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Nadav Goldstein via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Nadav Goldstein <nadav.goldstein96@gmail.com>
Subject: Re: [PATCH v3] Introduced force flag to the git stash clear
 subcommand.
References: <pull.1232.v2.git.1653286345.gitgitgadget@gmail.com>
        <pull.1232.v3.git.1687219414844.gitgitgadget@gmail.com>
Date:   Mon, 19 Jun 2023 23:25:52 -0700
Message-ID: <xmqqy1keodjj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EA7BCFC-0F33-11EE-ABD5-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Nadav Goldstein via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Nadav Goldstein <nadav.goldstein96@gmail.com>
>
> stash clean subcommand now support the force flag, along
> with the configuration var stash.requireforce, that if
> set to true, will make git stash clear fail unless supplied
> with force flag.

Documentation/SubmittingPatches gives many helpful hints on how to
write log messages for the project.

> @@ -208,6 +208,14 @@ to learn how to operate the `--patch` mode.
>  The `--patch` option implies `--keep-index`.  You can use
>  `--no-keep-index` to override this.
>  
> +-f::
> +--force::
> +	This option is only valid for `clear` command

Missing full-stop?

> ++
> +If the Git configuration variable stash.requireForce is set

Drop "Git" perhaps?  I haven't seen any other place that says "Git
configuration variable X" when talking about a single variable (it
probably is OK to call those defined in a Git configuration file
collectively as "Git configuration variables", though).

> +to true, 'git stash clear' will refuse to remove all the stash 
> +entries unless given -f.

I am not sure how much value users would get by requiring "--force",
though.  I know this was (partly) modeled after "git clean", but
over there, when the required "--force" is not given, the user would
give "--dry-run" (or "-n"), and the user will see what would be
removed if the user gave "--force".  If missing "--force" made "git
stash clear" show the stash entries that would be lost, then after
seeing an error message, it would be easier for the user to decide
if their next move should be to re-run the command with "--force",
or there are some precious entries and the user is not ready to do
"stash clear".

But just refusing to run without giving any other information will
just train the user to give "git stash clear --force" without
thinking, because getting "because you did not give the required
--force option, I am not doing anything" is only annoying without
giving any useful information.

> diff --git a/builtin/stash.c b/builtin/stash.c
> index a7e17ffe384..d037bc4f69c 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -53,7 +53,7 @@
>  #define BUILTIN_STASH_CREATE_USAGE \
>  	N_("git stash create [<message>]")
>  #define BUILTIN_STASH_CLEAR_USAGE \
> -	"git stash clear"
> +	"git stash clear [-f | --force]"
>  
>  static const char * const git_stash_usage[] = {
>  	BUILTIN_STASH_LIST_USAGE,
> @@ -122,6 +122,7 @@ static const char * const git_stash_save_usage[] = {
>  
>  static const char ref_stash[] = "refs/stash";
>  static struct strbuf stash_index_path = STRBUF_INIT;
> +static int clear_require_force = 0;

Do not explicitly initialize globals to 0 or NULL; let BSS take care
of the zero initialization, instead.

> @@ -246,7 +247,9 @@ static int do_clear_stash(void)
>  
>  static int clear_stash(int argc, const char **argv, const char *prefix)
>  {
> +	int force = 0;
>  	struct option options[] = {
> +		OPT__FORCE(&force, N_("force"), PARSE_OPT_NOCOMPLETE),
>  		OPT_END()
>  	};

As this topic focuses on "git stash clear", this is OK (and the
description in the documentation that says that "force" is currently
supported only by "clear" is also fine), but is "clear" the only
destructive subcommand and no other subcommand will want to learn
the "--force" for similar safety in the future?  The answer to this
question matters because ...

> @@ -258,6 +261,9 @@ static int clear_stash(int argc, const char **argv, const char *prefix)
>  		return error(_("git stash clear with arguments is "
>  			       "unimplemented"));
>  
> +	if (!force && clear_require_force)
> +		return error(_("fatal: stash.requireForce set to true and -f was not given; refusing to clear stash"));
> +
>  	return do_clear_stash();
>  }
>  
> @@ -851,6 +857,10 @@ static int git_stash_config(const char *var, const char *value, void *cb)
>  		show_include_untracked = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "stash.requireforce")) {

... the naming of this variable, facing the end users, does not
limit itself to "clear" at all.  It gives an impression that setting
this will require "--force" for all other subcommands that would
support it.  However ...

> +		clear_require_force = git_config_bool(var, value);

... inside the code, the variable is named in such a way that it is
only about the "clear" subcommand and nothing else.

I suspect that the end-user facing "stash.requireforce" should be
renamed to make it clear that it is about "stash clear" subcommand,
and not everywhere in "stash" requires "--force".  Nobody wants to
keep saying "git stash save --force" ;-)

> +		return 0;
> +	}

Thanks.
