Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691A2C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B4364EB4
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhBRWEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 17:04:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65441 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhBRWER (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 17:04:17 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D091A9A877;
        Thu, 18 Feb 2021 17:03:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5OuRFJVULEmP1WAVLhYcDVfeA1g=; b=tD/Jh/
        d3GdL3wSwNtHx6VwYpVzNkTuo3AxIJn4vBYmiPwwmazkIVUOd02KgL9lyXUlJ0lm
        w26p1q4EieVnBREiCam1H4rD5z2OKf4nl546+iRomWUCouB+u8Yn+A4qd40f8akD
        R9PeyQ4C6NdU3Xnm0yhS5r9jMDRryeKGZ1Gu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aKncbtL9lnSM2Ng05u77U9soCPlfTOWy
        xeNmun6+USrPCoEEQkm6ZzoALljM/MsgTba7uzkmiCM/gOT6iRQV8igq8goCxKQy
        UpLAyaZLRQkDY0lToc5YfMEzTP/g6GCl4X3PxBqOc+hgwgnztQruQUapuA3uO00H
        3V/D3z2aFn0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C91A59A876;
        Thu, 18 Feb 2021 17:03:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F71E9A875;
        Thu, 18 Feb 2021 17:03:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <periperidip@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        levraiphilippeblain@gmail.com,
        Javier Mora <javier.moradesambricio@rtx.com>
Subject: Re: [PATCH 1/2] rm: changes in the '.gitmodules' are staged after
 using '--cached'
References: <20210218184931.83613-1-periperidip@gmail.com>
        <20210218184931.83613-2-periperidip@gmail.com>
Date:   Thu, 18 Feb 2021 14:03:32 -0800
In-Reply-To: <20210218184931.83613-2-periperidip@gmail.com> (Shourya Shukla's
        message of "Fri, 19 Feb 2021 00:19:30 +0530")
Message-ID: <xmqqblchdoej.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24387C38-7235-11EB-9BAC-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <periperidip@gmail.com> writes:

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
> -				if (!remove_path_from_gitmodules(path))
> -					gitmodules_modified = 1;
> -				continue;
> +				strbuf_release(&buf);

Since we won't come to this block when doing index_only, we are
allowed to touch the working tree contents and files.  We indeed do
"rm -rf" of the submodule working tree and touch .gitmodules file
that is in the working tree.

>  			}
> +			if (!remove_path_from_gitmodules(path))
> +				gitmodules_modified = 1;
> +			continue;

But this looks wrong.  It might be OK to remove from the .gitmodules
stored in the index, but I fail to see why it is justified to touch
the working tree file when "--cached" is given.

> +		}
> +		if (!index_only) {
>  			if (!remove_path(path)) {
>  				removed = 1;
>  				continue;
> @@ -396,11 +398,15 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>  			if (!removed)
>  				die_errno("git rm: '%s'", path);
>  		}
> -		strbuf_release(&buf);
> -		if (gitmodules_modified)
> -			stage_updated_gitmodules(&the_index);

Assuming that it is somehow justifiable that removing the entry from
the .gitmodules in the index (again, I do not think it is
justifiable to remove from the working tree file), we no longer can
use stage_updated_gitmodules() helper as-is.

I think you'd need to

 - Add a variant of remove_path_from_gitmodules() that can remove
   the given submodule from the .gitmodules in the index entry
   without touching the working tree.  The change could be to update
   the function to take an extra "index_only" parameter and a
   pointer to an index_state instance, and

   (1) if !index_only, then edit the .gitmodules file in the working
       tree to remove the entry for path;

   (2) in both !index_only and index_only cases, read .gitmodules
       file from the index, edit to remove the entry for path, and
       add the result to the index.

   and return 0 for success (e.g. if path is not a submoudle or no
   entry for it is found in .gitmodules, it may return -1).

 - Since the previous point will maintain the correct contents in
   the index in all cases, get rid of gitmodules_modified and calls
   to stage_updated_gitmodules().  The call to write_locked_index()
   at the end will take care of the actual writing out of the index.

if we want to teach "rm --cached" to update only the index, and "rm"
to update both the index and the working tree, of ".gitmodules".

Having said that, I still do not think it is a good direction to go
to teach low level "rm", "mv" etc. to know about ".gitmodules" (yes,
yes, I know that some changes that I consider to be mistakes have
already happened---that does not mean we cannot correct our course
and it does not mean it is OK to make things even worse).  Such a
"how does a submodule get managed" policy decision belongs to the
"git submodule" subcommand, I would think.

Thanks.

> +	/*
> +	 * Remove the entry of the submodule from the ".gitmodules" irrespective
> +	 * whether "--cached" was passed or not.
> +	 */
> +	if (gitmodules_modified)
> +		stage_updated_gitmodules(&the_index);
> +
>  	if (write_locked_index(&the_index, &lock_file,
>  			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
>  		die(_("Unable to write new index file"));
