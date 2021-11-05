Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649C2C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 08:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E776125F
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 08:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhKEIky (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 04:40:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:53714 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhKEIkx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 04:40:53 -0400
Received: (qmail 11169 invoked by uid 109); 5 Nov 2021 08:38:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Nov 2021 08:38:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15703 invoked by uid 111); 5 Nov 2021 08:38:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Nov 2021 04:38:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Nov 2021 04:38:13 -0400
From:   Jeff King <peff@peff.net>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v2] fetch: Protect branches checked out in all worktrees
Message-ID: <YYTtdZblnHYgDgBq@coredump.intra.peff.net>
References: <9dfca5ec-4426-d3d4-988e-b81ebb087584@mit.edu>
 <alpine.DEB.2.21.999.2111041709080.94135@tardis-on-the-dome.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.999.2111041709080.94135@tardis-on-the-dome.mit.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 04, 2021 at 05:10:52PM -0400, Anders Kaseorg wrote:

> Refuse to fetch into the currently checked out branch of any working
> tree, not just the current one.

I think that makes sense as a goal.

>  #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
>  
> @@ -854,7 +855,6 @@ static int update_local_ref(struct ref *ref,
>  			    int summary_width)
>  {
>  	struct commit *current = NULL, *updated;
> -	struct branch *current_branch = branch_get(NULL);
>  	const char *pretty_ref = prettify_refname(ref->name);
>  	int fast_forward = 0;
>  
> @@ -868,9 +868,8 @@ static int update_local_ref(struct ref *ref,
>  		return 0;
>  	}
>  
> -	if (current_branch &&
> -	    !strcmp(ref->name, current_branch->name) &&
> -	    !(update_head_ok || is_bare_repository()) &&
> +	if (!update_head_ok &&
> +	    find_shared_symref("HEAD", ref->name) &&
>  	    !is_null_oid(&ref->old_oid)) {
>  		/*
>  		 * If this is the head, and it's not okay to update

OK, so this is where we'd say "no, I won't update the HEAD". That makes
sense, and the find_shared_symref() helper from worktree.h makes it
easy.

If we get the non-default worktree here, it might be nice to tell the
user which worktree has it checked out. Otherwise it may lead to
head-scratching as they peek at their current HEAD.

I also notice that find_shared_symref() will catch cases where we're on
a detached HEAD, but it's because we're rebasing or bisecting on a given
branch. Arguably that's a sensible thing to do for this check, but it is
a change from the current behavior (even if you are not using worktrees
at all).

> @@ -1387,16 +1386,13 @@ static int prune_refs(struct refspec *rs, struct ref *ref_map,
>  
>  static void check_not_current_branch(struct ref *ref_map)
>  {
> -	struct branch *current_branch = branch_get(NULL);
> -
> -	if (is_bare_repository() || !current_branch)
> -		return;
> -
> +	const struct worktree *wt;
> [...]

So if the earlier hunk covered this case, then what is this hunk for? :)

It looks like we call it from do_fetch() when update_head_ok isn't set.
I'm not clear why we have two distinct code paths that check
update_head_ok. It seems like this one is the one that _actually_ kicks
in, because it's only later that we call update_local_ref(), several
layers down. If I put a BUG() in that one, it is never reached in the
test suite. Hmm.

It looks like this situation is quite old, and certainly it's nothing
new in your patch. So let's file it as a curiosity for now, and we can
deal with it separately (if at all).

>  	for (; ref_map; ref_map = ref_map->next)
> -		if (ref_map->peer_ref && !strcmp(current_branch->refname,
> -					ref_map->peer_ref->name))
> -			die(_("Refusing to fetch into current branch %s "
> -			    "of non-bare repository"), current_branch->refname);
> +		if (ref_map->peer_ref &&
> +		    (wt = find_shared_symref("HEAD", ref_map->peer_ref->name)))
> +			die(_("Refusing to fetch into branch '%s' "
> +			      "checked out at '%s'"),
> +			    ref_map->peer_ref->name, wt->path);

This one does update the message, which is nice (and from my analysis
above, the message from the other hunk doesn't matter at all!). It's a
bit more verbose if you're not using worktrees at all, though. I used to get:

  $ git init
  $ git commit --allow-empty -qm foo
  $ git fetch . main:main
  fatal: Refusing to fetch into current branch refs/heads/main of non-bare repository

but now get:

  $ git fetch . main:main
  fatal: Refusing to fetch into branch 'refs/heads/main' checked out at '/home/peff/tmp'

It's technically correct, but perhaps it would be nicer to keep the old
message if the worktree we found is the current one.

-Peff
