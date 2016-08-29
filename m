Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 657721FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 22:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755915AbcH2Wwu (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 18:52:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62984 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753932AbcH2Wwt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 18:52:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5C183902D;
        Mon, 29 Aug 2016 18:52:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZWIamZ45Wb2YPfq/V6iy+nSCZhc=; b=cppzju
        uSFi5ENsd8gqMbX5COx0gdKD2Mv/XZXMVm8qteh5ri60dF88Z/2dvV7ryeq3e91K
        6CKFnnimbTT57MX5SrWSJ+glhmb/imWJUz1/BUuSx/zV+vUMSwlmGX4XxbJlKzVi
        U6SJr1rI3T798Z5oubgdD5xwRpmdSKr6jhxNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uXplZyXqpAPeM1ynXPxaKJvIoElh3zQM
        HUxP1EJFy4IQah+6wWN1TIoynV/w0S69Jrz3dDLyi4p8hjHILwI95UNVWDqO/00/
        VK6vZc81dMlEtarKuNb617ZHNjRgBzcj89rMbobYkZluuXZJj8C0Irg22pam9awE
        qfilJLRLO0k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE44E3902C;
        Mon, 29 Aug 2016 18:52:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5543D3902B;
        Mon, 29 Aug 2016 18:52:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] pull: make code more similar to the shell script again
References: <cover.1472137582.git.johannes.schindelin@gmx.de>
        <9a7cc36eee651fe8be280920587e1f83538caf77.1472137582.git.johannes.schindelin@gmx.de>
Date:   Mon, 29 Aug 2016 15:52:45 -0700
In-Reply-To: <9a7cc36eee651fe8be280920587e1f83538caf77.1472137582.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 25 Aug 2016 17:06:48 +0200
        (CEST)")
Message-ID: <xmqqr3976vcy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E16D4E4-6E3B-11E6-A0AC-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +static int require_clean_work_tree(const char *action, const char *hint,
> +		int gently)
>  {
>  	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
> -	int do_die = 0;
> +	int err = 0;
>  
>  	hold_locked_index(lock_file, 0);
>  	refresh_cache(REFRESH_QUIET);
> @@ -376,20 +377,26 @@ static void die_on_unclean_work_tree(void)
>  	rollback_lock_file(lock_file);
>  
>  	if (has_unstaged_changes()) {
> -		error(_("Cannot pull with rebase: You have unstaged changes."));
> -		do_die = 1;
> +		error(_("Cannot %s: You have unstaged changes."), action);
> ...
>  		if (!autostash)
> -			die_on_unclean_work_tree();
> +			require_clean_work_tree("pull with rebase",
> +				"Please commit or stash them.", 0);
>  
>  		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
>  			hashclr(rebase_fork_point);

Splicing an English/C phrase 'pull with rebase' into a
_("localizable %s string") makes the life of i18n team hard.

Can we do this differently?

If you are eventually going to expose this function as public API, I
think the right approach would be to enumerate the possible error
conditions this function can diagnose and return them to the caller,
i.e.

    #define WT_STATUS_DIRTY_WORKTREE 01
    #define WT_STATUS_DIRTY_INDEX    02

    static int require_clean_work_tree(void)
    {
	int status = 0;
	...
        if (has_unstaged_changes())
        	status |= WT_STATUS_DIRTY_WORKTREE;
	if (has_uncommitted_changes())
        	status |= WT_STATUS_DIRTY_INDEX;
	return status;
    }

Then die_on_unclean_work_tree() can be made as a thin-wrapper that
calls it and shows the pull-specific error message.
