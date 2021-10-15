Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD2BC433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D11060F9E
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242491AbhJOSA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 14:00:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63203 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242459AbhJOSA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 14:00:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6A07915F220;
        Fri, 15 Oct 2021 13:58:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lUOUePl7AkW2pk33NnAaeyIlPEqpySus15npDw
        hr1Rg=; b=C1On2H/mohQ7ZQvgpXzvbCPtaE4AydztGDUoQWTW15mnmccQ3mPzrN
        4bPx0ytRP14xisFwWHFpsvRY4IwHW7R7VgWB9VUbGKwtGvJHGkvIW8K5bh+1h3LT
        jflbbma4ofzaT8iC/26p9AwQlwbWANMIAaVqM+EQ79apzuR9PMGGk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 62D4415F21E;
        Fri, 15 Oct 2021 13:58:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BD6DE15F21C;
        Fri, 15 Oct 2021 13:58:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] stash: implement '--staged' option for 'push' and
 'save'
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
        <87fst2gwia.fsf_-_@osv.gnss.ru>
Date:   Fri, 15 Oct 2021 10:58:18 -0700
In-Reply-To: <87fst2gwia.fsf_-_@osv.gnss.ru> (Sergey Organov's message of
        "Fri, 15 Oct 2021 18:04:13 +0300")
Message-ID: <xmqq5yty6uh1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B1B353C-2DE1-11EC-AB4D-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> @@ -205,6 +205,16 @@ to learn how to operate the `--patch` mode.
>  The `--patch` option implies `--keep-index`.  You can use
>  `--no-keep-index` to override this.
>  
> +-S::
> +--staged::
> +	This option is only valid for `push` and `save` commands.
> ++
> +Stash only the changes that are currently staged. This is similar to
> +basic `git commit` except the state is committed to the stash instead
> +of current branch.
> ++
> +The `--patch` option has priority over this one.
> +
>  --pathspec-from-file=<file>::
>  	This option is only valid for `push` command.
>  +
> @@ -341,6 +351,24 @@ $ edit/build/test remaining parts
>  $ git commit foo -m 'Remaining parts'
>  ----------------------------------------------------------------
>  
> +Saving unrelated changes for future use::
> +
> +When you are in the middle of massive changes and you find some
> +unrelated issue that you don't want to forget to fix, you can do the
> +change(s), stage them, and use `git stash push --staged` to stash them
> +out for future use. This is similar to committing the staged changes,
> +only the commit ends-up being in the stash and not on the current branch.
> ++
> +----------------------------------------------------------------
> +# ... hack hack hack ...
> +$ git add --patch foo           # add unrelated changes to the index
> +$ git stash push --staged       # save these changes to the stash
> +# ... hack hack hack, finish curent changes ...
> +$ git commit -m 'Massive'       # commit fully tested changes
> +$ git switch fixup-branch       # switch to another branch
> +$ git stash pop                 # to finish work on the saved changes
> +----------------------------------------------------------------
> +

The last step would more like "to start working on top of the saved
changes", I would think, as the user did not want to bother thinking
about them earlier while working on the other theme.  Otherwise, the
user would have done

    git checkout -b fixup-branch
    git add -p
    git commit -m '[WIP] mostly done' -e
    git checkout -

to remember that the fixup is not quite but mostly done and what was
done so far.

But I'd agree that the new mode would fit in such a workflow.


> +static int stash_staged(struct stash_info *info, const struct pathspec *ps,
> +		       struct strbuf *out_patch, int quiet)
> +{
> +	int ret = 0;
> +	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
> +	struct index_state istate = { NULL };
> +
> +	if (write_index_as_tree(&info->w_tree, &istate, the_repository->index_file,
> +				0, NULL)) {
> +		ret = -1;
> +		goto done;
> +	}

OK.  So what is currently in the index becomes the w-tree.

> +	cp_diff_tree.git_cmd = 1;
> +	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
> +		     oid_to_hex(&info->w_tree), "--", NULL);
> +	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
> +		ret = -1;
> +		goto done;
> +	}
> +
> +	if (!out_patch->len) {
> +		if (!quiet)
> +			fprintf_ln(stderr, _("No changes selected"));
> +		ret = 1;
> +	}

This seems to have been taken from the "stash_patch()" flow, but
unlike the "stash -p" that goes interactive to let the user pick
hunks, in which context "oh, no, you did not SELECT anything" makes
perfect sense as an error message, this message would be confusing
to users who weren't offered a chance to select.

> +done:
> +	discard_index(&istate);
> +	return ret;
> +}
> +

Also, as stash_staged() and stash_patch() are _so_ close, I suspect
that we might want to make a common helper out of the original
stash_patch() and make stash_patch() a thin wrapper around it in the
step #1 of the series, and then add stash_staged() as a second
caller to the common helper.  That might result in a cleaner end
result.  And optionally the "do we really need to spawn diff-tree"
optimization can be done on top after the dust settles [*].

    [Side note] As we already have the tree object for the stashed
    state, I wonder if it is overkill to run "diff-tree" here,
    though.  Wouldn't it be a matter of comparing that tree object
    name with the tree object name of the HEAD?  Something like

            get_oid_treeish("HEAD:", &head_tree);
            if (oideq(&head_tree, &info->w_tree)) {
                    "Nothing staged";
                    ret -1;
            }

    may be a good starting point, perhaps?

    But as I hinted above, such an optimization is outside the scope
    of this topic.  As long as we do not duplicate the code to spawn
    diff-tree from stash_patch(), but use a shared helper between
    the two codepath, such an optimization is easily doable later.

>  static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_buf,
> -			   int include_untracked, int patch_mode,
> +			   int include_untracked, int patch_mode, int only_staged,

Let's not keep adding a parameter to represent just a bit (or less).
Can't we at least treat this as an auxiliary bit in the "patch_mode"
flag?  The traditional patch_mode may be variant #1 while the one
that does the same thing but skips the interactive hunk selection
(i.e. only-staged) becomes the variant #2, or something?

> @@ -1321,6 +1353,16 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>  		} else if (ret > 0) {
>  			goto done;
>  		}
> +	} else if (only_staged) {
> +		ret = stash_staged(info, ps, patch, quiet);
> +		if (ret < 0) {
> +			if (!quiet)
> +				fprintf_ln(stderr, _("Cannot save the current "
> +						     "staged state"));
> +			goto done;
> +		} else if (ret > 0) {
> +			goto done;
> +		}

... which would reduce the need to add yet another else-if to this
cascade.

> @@ -1379,7 +1421,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
>  	if (!check_changes_tracked_files(&ps))
>  		return 0;
>  
> -	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, &info,
> +	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, 0, &info,
>  			      NULL, 0);

and no need to touch this hunk.

> @@ -1389,7 +1431,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
>  }
>  
>  static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
> -			 int keep_index, int patch_mode, int include_untracked)
> +			 int keep_index, int patch_mode, int include_untracked, int only_staged)
>  {

nor this one.

I think I can agree with the motivation now (thanks for the
discussion); the code may want a bit more cleaning up.

Thanks.
