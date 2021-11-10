Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9684C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 22:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C754C6124C
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 22:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhKJWOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 17:14:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50793 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbhKJWMb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 17:12:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71A39101447;
        Wed, 10 Nov 2021 17:09:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zf6Hqhl7m9Tm7uGu/To2rNpdbojJw99kkWHtGR
        37bfw=; b=HXIAw3UFnUnZEoXgAZ2PLJQ27SfEfwHVgHU5+c3HXyZvcF8y4NdVpP
        /pvmjAWbgB+J3VVw1fDruNE10iFO4RhLP2gdTVucTM72DzSt7O1c204gAZlXFpJn
        8DsGY1r677YAUu89hirGwQ9KomGZ5HfCepPqQsn63TJoSWOWoAQWg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 680C5101446;
        Wed, 10 Nov 2021 17:09:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CBA75101445;
        Wed, 10 Nov 2021 17:09:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v5 1/4] fetch: Protect branches checked out in all
 worktrees
References: <2f983e36-532f-ac87-9ade-fba4c6b9d276@mit.edu>
        <20211109230941.2518143-1-andersk@mit.edu>
Date:   Wed, 10 Nov 2021 14:09:40 -0800
In-Reply-To: <20211109230941.2518143-1-andersk@mit.edu> (Anders Kaseorg's
        message of "Tue, 9 Nov 2021 15:09:38 -0800")
Message-ID: <xmqqr1bnwtln.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E774EFCA-4272-11EC-BDB5-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Kaseorg <andersk@mit.edu> writes:

> +	if (!update_head_ok &&
> +	    (wt = find_shared_symref("HEAD", ref->name)) &&
> +	    !wt->is_bare &&
>  	    !is_null_oid(&ref->old_oid)) {
>  		/*
>  		 * If this is the head, and it's not okay to update
>  		 * the head, and the old value of the head isn't empty...
>  		 */
>  		format_display(display, '!', _("[rejected]"),
> -			       _("can't fetch in current branch"),
> +			       wt->is_current ?
> +			       _("can't fetch in current branch") :
> +			       _("checked out in another worktree"),
>  			       remote, pretty_ref, summary_width);
>  		return 1;
>  	}
> @@ -1387,16 +1390,14 @@ static int prune_refs(struct refspec *rs, struct ref *ref_map,
>  
>  static void check_not_current_branch(struct ref *ref_map)
>  {
> -	struct branch *current_branch = branch_get(NULL);
> -
> -	if (is_bare_repository() || !current_branch)
> -		return;
> -
> +	const struct worktree *wt;
>  	for (; ref_map; ref_map = ref_map->next)
> -		if (ref_map->peer_ref && !strcmp(current_branch->refname,
> -					ref_map->peer_ref->name))
> -			die(_("Refusing to fetch into current branch %s "
> -			    "of non-bare repository"), current_branch->refname);
> +		if (ref_map->peer_ref &&
> +		    (wt = find_shared_symref("HEAD", ref_map->peer_ref->name)) &&
> +		    !wt->is_bare)
> +			die(_("Refusing to fetch into branch '%s' "
> +			      "checked out at '%s'"),
> +			    ref_map->peer_ref->name, wt->path);
>  }

Another thing for the next development cycle.

The find_shared_symref() function is handy (and more correct than
dereferencing HEAD in the current worktree alone, of course), but
its memory ownership model may need to be rethought.

The current semantics is a caller can call find_shared_symref() to
receive at most one worktree, and the caller can use it UNTIL
anybody makes another call to find_shared_symref(), at which point,
the worktree instance becomes unusable and off limit.  The caller
cannot, and should not attempt to, free the worktree instance.

Each time find_shared_symref() is called, we enumerate all the
worktrees and store them in a list that is static to the function.
The returned worktree instance points into that list.  It is not
technically leaked because the static "worktrees" list in the
function holds onto it, and each time the function is called, the
old list of worktrees is discarded and rebuilt anew.  What it means
is that a code like the above, a loop in check_not_current_branch(),
that repeatedly calls find_shared_symref() is both inefficient
(because it takes many "snapshots" of the worktrees attached to the
repository), and also risks an inconsistent view of the world
(because it takes many "snapshots", and each iteration uses
different ones).

I suspect that having a new API function that lets the above be
rewritten along the lines of ...

	struct worktree **all = get_worktrees();
	for ( ; ref_map; ref_map = ref_map->next) {
        	if (!ref_map->peer_ref)
			continue;
                wt = find_wt_with_HEAD(all, ref->map->peer_ref->name);
		if (!wt->is_bare)
			die(_("..."));
	}
	free_worktrees(all);

... would help.

Thanks.
