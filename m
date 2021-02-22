Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E97C433E6
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741FC60232
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 19:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhBVTAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:00:01 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53742 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhBVS7n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 13:59:43 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BD07B11ED25;
        Mon, 22 Feb 2021 13:58:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XghZHb3LB/xwELPYDobWHq31FZg=; b=HH6vup
        /MeWEVEBjvDrF0a5Hn8hYd76aN32Y0a5TsWAbgU4T2LMxWNpZtEHJAUiy6XLuDX1
        wDJhwvbOcWrbJWVAzgnweMfXpouS4aFMhGZg/QlInl04S33ZI3BWeT//LNXav2jt
        iSU9nGBTpLKnLmYQR9CsCvs2jslT+noTdAHIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GESZlxI0gPFENoDQ69TZ2i9YcM3AX34r
        LktNNomoQNJHk1aesDTT5hk2xqYyFJX/fa+1eX6C9lxYP785zGp/gssA4gKigTXq
        WXvNvYl0K+GzMvBj5/g6tVYDoFqfd/VXoUFWl57SA9yvPPJEhu3lm51lXsbcPqwo
        pZPLtuNEjUs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B401411ED24;
        Mon, 22 Feb 2021 13:58:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 094DD11ED23;
        Mon, 22 Feb 2021 13:58:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <periperidip@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        levraiphilippeblain@gmail.com,
        Javier Mora <javier.moradesambricio@rtx.com>
Subject: Re: [PATCH v2 1/1] rm: stage submodule removal from '.gitmodules'
 when using '--cached'
References: <20210218184931.83613-1-periperidip@gmail.com>
        <20210222172623.69313-1-periperidip@gmail.com>
        <20210222172623.69313-2-periperidip@gmail.com>
Date:   Mon, 22 Feb 2021 10:58:51 -0800
In-Reply-To: <20210222172623.69313-2-periperidip@gmail.com> (Shourya Shukla's
        message of "Mon, 22 Feb 2021 22:56:23 +0530")
Message-ID: <xmqqv9ak6iac.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01A00778-7540-11EB-87EF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <periperidip@gmail.com> writes:

> Currently, using 'git rm --cached <submodule>' removes the submodule
> <submodule> from the index and leaves the submodule working tree
> intact in the superproject working tree, but does not stage any
> changes to the '.gitmodules' file, in contrast to 'git rm <submodule>',
> which removes both the submodule and its configuration in '.gitmodules'
> from the worktree and index.
>
> Fix this inconsistency by also staging the removal of the entry of the
> submodule from the '.gitmodules' file, leaving the worktree copy intact,

The "also" above felt a bit puzzling, as we would be removing the
entry only from the indexed copy without touching the working tree
(by the way, I try to be precise in terminology between worktree and
working tree, and please follow suit.  A working tree is what you
have in a non-bare repository that let's you "less" "gcc" etc. on
the files checked out.  A worktree refers to the mechanism that lets
you have separate working tree by borrowing from a repository, or
refers to an instance of a working tree plus .git file created by
the mechanism.  You mean "working tree" in the above sentence), but
it refers to "remove the submodules directory and also entry", so it
is OK.

> diff --git a/builtin/rm.c b/builtin/rm.c
> index 4858631e0f..5854ef0996 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -254,7 +254,7 @@ static struct option builtin_rm_options[] = {
>  int cmd_rm(int argc, const char **argv, const char *prefix)
>  {
>  	struct lock_file lock_file = LOCK_INIT;
> -	int i;
> +	int i, removed = 0;
>  	struct pathspec pathspec;
>  	char *seen;
>  
> @@ -365,30 +365,33 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>  	if (show_only)
>  		return 0;
>  


> +	for (i = 0; i < list.nr; i++) {
> +		const char *path = list.entry[i].name;
> +		if (list.entry[i].is_submodule) {
> +			/*
> +			 * Then, unless we used "--cached", remove the filenames from
> +			 * the workspace. If we fail to remove the first one, we
> +			 * abort the "git rm" (but once we've successfully removed
> +			 * any file at all, we'll go ahead and commit to it all:
> +			 * by then we've already committed ourselves and can't fail
> +			 * in the middle)
> +			 */
> +			if (!index_only) {
> +				struct strbuf buf = STRBUF_INIT;
>  				strbuf_reset(&buf);
>  				strbuf_addstr(&buf, path);
>  				if (remove_dir_recursively(&buf, 0))
>  					die(_("could not remove '%s'"), path);
>  
>  				removed = 1;
> +				strbuf_release(&buf);

OK, so this part now only deals with the submodule directory.

>  			}
> +			if (!remove_path_from_gitmodules(path, index_only))
> +				stage_updated_gitmodules(&the_index);

And the entry for it in .gitmodules is handled by the helper,
whether --cached or not.

This somehow feels wrong for the index_only case; doesn't the helper
take contents from the .gitmodules in the working tree and add it to
the index?

Unless you touched stage_updated_gitmodules() not to do that in the
index_only case, that is.

> +			continue;

And that is all for what is done to a submodule.

Makes sense so far.

> +		}
> +		if (!index_only) {
>  			if (!remove_path(path)) {
>  				removed = 1;
>  				continue;
> @@ -396,9 +399,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>  			if (!removed)
>  				die_errno("git rm: '%s'", path);
>  		}
> -		strbuf_release(&buf);
> -		if (gitmodules_modified)
> -			stage_updated_gitmodules(&the_index);

OK, because this should have been done where we called
remove_path_from_gitmodules().

>  	}
>  
>  	if (write_locked_index(&the_index, &lock_file,
> diff --git a/submodule.c b/submodule.c
> index 9767ba9893..6ce8c8d0d8 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -131,7 +131,7 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
>   * path is configured. Return 0 only if a .gitmodules file was found, a section
>   * with the correct path=<path> setting was found and we could remove it.
>   */
> -int remove_path_from_gitmodules(const char *path)
> +int remove_path_from_gitmodules(const char *path, int index_only)
>  {
>  	struct strbuf sect = STRBUF_INIT;
>  	const struct submodule *submodule;
> @@ -149,7 +149,8 @@ int remove_path_from_gitmodules(const char *path)
>  	}
>  	strbuf_addstr(&sect, "submodule.");
>  	strbuf_addstr(&sect, submodule->name);
> -	if (git_config_rename_section_in_file(GITMODULES_FILE, sect.buf, NULL) < 0) {
> +	if (git_config_rename_section_in_file(index_only ? GITMODULES_INDEX :
> +					      GITMODULES_FILE, sect.buf, NULL) < 0) {
>  		/* Maybe the user already did that, don't error out here */
>  		warning(_("Could not remove .gitmodules entry for %s"), path);
>  		strbuf_release(&sect);

When !index_only, do we have any guarantee that .gitmodules in the
working tree and .gitmodules in the index are in sync?  I somehow
doubt it.  

I would have expected that the updated remove_path_from_gitmodules()
would look more like:

 - only if !index_only, nuke the section for the submodule in
   .gitmodules in the working tree.

 - nuke the section for the submodule in .gitmodules in the
   index.

IOW, there would be two git_config_rename_section_in_file() calls to
remove the section in !index_only case.

Doing so would also mean that you should not have the caller call
stage_updated_gitmodules() at all, even in !index_only case.
Imagine if the .gitmodules file in the working tree had local
changes (e.g. registered a few more submodules, or updated the url
field of a few submodules) that are not yet added to the index when
"git rm" removed a submodule.  The user does not want them to be in
the index yet and "git rm" should not add these unrelated local
changes to the index.

Thanks.
