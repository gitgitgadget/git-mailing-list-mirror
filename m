Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEFEC433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 19:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243217AbiAFTLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 14:11:32 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64244 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiAFTLb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 14:11:31 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 80B41164240;
        Thu,  6 Jan 2022 14:11:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rGgY4jAgOJ+rhEowCuOb3gdKFk5t+giMcwpQsm
        61HVM=; b=o7T70vgPmW8KoawsNNU0y6yfyX5XFv/y91PuaSDs6o/N71G6Zyw1o+
        3G3BcVQ68i4WndMuijaP0EfroTVDlEhVxhSg7mZOOYgdfPeGYOrU4AqlJnhLuOfm
        86aitI2quItKLWrao1Ir9e2uLDJ0xQECtCMeFax+/P+cWwRHY5O9g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 795E816423F;
        Thu,  6 Jan 2022 14:11:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E287216423E;
        Thu,  6 Jan 2022 14:11:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     John Cai <johncai86@gmail.com>, git@vger.kernel.org,
        Tilman Vogel <tilman.vogel@web.de>
Subject: Re: [PATCH 1/1] builtin/pull.c: use config value of autostash
References: <20220104214522.10692-1-johncai86@gmail.com>
        <20220104214522.10692-2-johncai86@gmail.com>
        <xmqqbl0r9l0l.fsf@gitster.g>
        <4fe0e850-1c30-da70-5535-e2a4105ba734@gmail.com>
Date:   Thu, 06 Jan 2022 11:11:27 -0800
In-Reply-To: <4fe0e850-1c30-da70-5535-e2a4105ba734@gmail.com> (Philippe
        Blain's message of "Tue, 4 Jan 2022 22:58:32 -0500")
Message-ID: <xmqq35m0el28.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7387E7F0-6F24-11EC-8364-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> We already have a quite useless 'int autostash' local variable in cmd_pull
> a few lines up, so an equivalent fix, I think, would be the following:
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 1cfaf9f343..9f8a8dd716 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -1036,14 +1036,13 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  		oidclr(&orig_head);
>    	if (opt_rebase) {
> -		int autostash = config_autostash;
> -		if (opt_autostash != -1)
> -			autostash = opt_autostash;
> +		if (opt_autostash == -1)
> +			opt_autostash = config_autostash;
>    		if (is_null_oid(&orig_head) && !is_cache_unborn())
>  			die(_("Updating an unborn branch with changes added to the index."));
>  -		if (!autostash)
> +		if (!opt_autostash)
>  			require_clean_work_tree(the_repository,
>  				N_("pull with rebase"),
>  				_("please commit or stash them."), 1, 0);

OK, so the idea is to make opt_autostash the _primary_ thing that
matters when deciding to do the auto-stashing.  We may make it
affected by the value we read from the configuration, if there is no
command line option that sets it.

If there is no place that cares about what is in config_autostash
(which is rebase.autostash; nobody reads merge.autostash in this
command) other than this part, I think that is an even cleaner
approach than what I sent.  I very much like it.

Here is how I would explain your change.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: pull --rebase: honor rebase.autostash even when fast-forwarding

"pull --rebase" internally uses the merge machinery when the other
history is a descendant of ours (i.e. perform fast-forward).  This
came from [1], where the discussion was started from a feature
request to do so.  It is a bit hard to read the rationale behind it
in the discussion, but it seems that it was an established fact for
everybody involved that does not even need to be mentioned that
fast-forwarding done with "rebase" was much undesirable than done
with "merge", and more importantly, the result left by "merge" is as
good as (or better than) that by "rebase".

Except for one thing.  Because "git merge" does not (and should not)
honor rebase.autostash, "git pull" needs to read it and forward it
when we use "git merge" as a (hopefully better) substitute for "git
rebase" during the fast-forwarding.  But we forgot to do so (we only
add "--[no-]autostash" to the "git merge" command when "git pull" was
invoked with "--[no-]autostash" command line option, so that "git merge"
can honor merge.autostash in such a case).

Make sure "git merge" is run with "--autostash" when
rebase.autostash is set and used to fast-forward the history on
behalf of "git rebase".  Incidentally this change also takes care of
the case where

 - "git pull --rebase" (without other command line options) is run
 - "rebase.autostash" is not set
 - The history fast-forwards

In such a case, "git merge" is run with an explicit "--no-autostash"
to prevent it from honoring merge.autostash configuration, which is
what we want.  After all, we want the "git merge" to pretend as if
it is "git rebase" while being used for this purpose.

[1]
https://lore.kernel.org/git/xmqqa8cfbkeq.fsf_-_@gitster.mtv.corp.google.com/

