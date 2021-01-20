Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C74C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 21:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCBB923443
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 21:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbhATVhH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 16:37:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54488 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbhATV1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 16:27:24 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BFCE0FEE6E;
        Wed, 20 Jan 2021 16:26:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uZkHzRox6ypBgkxp4SGtn5AqImc=; b=vJ4JPb
        Ik24hceJ0AxgBYNAItUhrHAOnjrYR4JtEswHzFpHyyHSpZSjwICgRc0JcxE3f6nS
        H/3wsQceSogkzysDph21/4p9A8nNaABBKJEzL3MHA3aEEN4tAUc+6YHOP6iI1HAH
        QJrXZ3GeqTVm68xcef7f1yst8kIxY3ljpf/4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VX35qae/KVO3R2q/BjMngJblZ4zeXBQC
        rfx0QMrkGAiHbxq2dRSTFjaW6NvMPHFPvxKRfx9CS+ivScWA8f1PqJUnH2rPbzzl
        DNZvt++2B0sQ8KgqIRj3gNSNb2Yq3uE5wRDAT5eBdipRoLR6ns3mPlunLUW9TmDZ
        gOkYatnKZWI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B8CB4FEE6D;
        Wed, 20 Jan 2021 16:26:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A500DFEE66;
        Wed, 20 Jan 2021 16:26:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Subject: Re: [PATCH v5 3/3] ls-files.c: add --deduplicate option
References: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
        <pull.832.v5.git.1611037846.gitgitgadget@gmail.com>
        <e9c5318670658b032ba921129859f9fb3b2ca017.1611037846.git.gitgitgadget@gmail.com>
Date:   Wed, 20 Jan 2021 13:26:00 -0800
In-Reply-To: <e9c5318670658b032ba921129859f9fb3b2ca017.1611037846.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Tue, 19 Jan 2021 06:30:46
        +0000")
Message-ID: <xmqq7do7fggn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18DDA466-5B66-11EB-AA99-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -321,30 +324,46 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
>  
>  		construct_fullname(&fullname, repo, ce);
>  
> +		if (skipping_duplicates && last_shown_ce &&
> +			!strcmp(last_shown_ce->name,ce->name))
> +				continue;

Style.  Missing SP after comma.

>  		if ((dir->flags & DIR_SHOW_IGNORED) &&
>  			!ce_excluded(dir, repo->index, fullname.buf, ce))
>  			continue;
>  		if (ce->ce_flags & CE_UPDATE)
>  			continue;
>  		if (show_cached || show_stage) {
> +			if (skipping_duplicates && last_shown_ce &&
> +				!strcmp(last_shown_ce->name,ce->name))
> +					continue;

OK.  When show_stage is set, skipping_duplicates is automatically
turned off (and show_unmerged is automatically covered as it turns
show_stage on automatically).  So this feature has really become
"are we showing only names, and if so, did we show an entry of the
same name before?".

>  			if (!show_unmerged || ce_stage(ce))
>  				show_ce(repo, dir, ce, fullname.buf,
>  					ce_stage(ce) ? tag_unmerged :
>  					(ce_skip_worktree(ce) ? tag_skip_worktree :
>  						tag_cached));
> +			if (show_cached && skipping_duplicates)
> +				last_shown_ce = ce;

The code that calls show_ce() belonging to a totally separate if()
statement makes my stomach hurt---how are we going to guarantee that
"last shown" really will keep track of what was shown last?

Shouldn't the above be more like this?

- 			if (!show_unmerged || ce_stage(ce))
+ 			if (!show_unmerged || ce_stage(ce)) {
 				show_ce(repo, dir, ce, fullname.buf,
 					ce_stage(ce) ? tag_unmerged :
 					(ce_skip_worktree(ce) ? tag_skip_worktree :
 						tag_cached));
+				last_shown_ce = ce;
+			}

It does maintain last_shown_ce even when skipping_duplicates is not
set, but I think that is overall win.  Assigning unconditionally
would be cheaper than making a conditional jump on the variable and
make assignment (or not).

>  		}
>  		if (ce_skip_worktree(ce))
>  			continue;
> +		if (skipping_duplicates && last_shown_ce &&
> +			!strcmp(last_shown_ce->name,ce->name))
> +				continue;

Style.  Missing SP after comma.

OK, if we've shown an entry of the same name under skip-duplicates
mode, and the code that follows will show the same entry (if they
decide to show it), so we can go to the next entry early.

>  		err = lstat(fullname.buf, &st);
>  		if (err) {
> -			if (errno != ENOENT && errno != ENOTDIR)
> -				error_errno("cannot lstat '%s'", fullname.buf);
> -			if (show_deleted)
> +			if (skipping_duplicates && show_deleted && show_modified)
>  				show_ce(repo, dir, ce, fullname.buf, tag_removed);
> -			if (show_modified)
> -				show_ce(repo, dir, ce, fullname.buf, tag_modified);
> +			else {
> +				if (errno != ENOENT && errno != ENOTDIR)
> +					error_errno("cannot lstat '%s'", fullname.buf);
> +				if (show_deleted)
> +					show_ce(repo, dir, ce, fullname.buf, tag_removed);
> +				if (show_modified)
> +					show_ce(repo, dir, ce, fullname.buf, tag_modified);
> +			}
>  		} else if (show_modified && ie_modified(repo->index, ce, &st, 0))
>  			show_ce(repo, dir, ce, fullname.buf, tag_modified);

This part will change shape quite a bit when we follow the
suggestion I made on 1/3, so I won't analyze how correct this
version is.

> +		last_shown_ce = ce;
>  	}
>  
>  	strbuf_release(&fullname);
> @@ -571,6 +590,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  			N_("pretend that paths removed since <tree-ish> are still present")),
>  		OPT__ABBREV(&abbrev),
>  		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
> +		OPT_BOOL(0,"deduplicate",&skipping_duplicates,N_("suppress duplicate entries")),
>  		OPT_END()
>  	};
>  
> @@ -610,6 +630,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  		 * you also show the stage information.
>  		 */
>  		show_stage = 1;
> +	if (show_tag || show_stage)
> +		skipping_duplicates = 0;

OK.

>  	if (dir.exclude_per_dir)
>  		exc_given = 1;
>  

Thanks.
