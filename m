Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7EDC433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 18:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC9A611AE
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 18:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhKESlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 14:41:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57520 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbhKESlr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 14:41:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E663F6CC5;
        Fri,  5 Nov 2021 14:39:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+u04igWn1KivSVvnzR/s0UdEIioU0/iCtR0L7G
        1L0j4=; b=jVVYS9B+2QvxiObZc7YEwVaARr0NDeG3XIAUGd+mjh/QdcnnMhtAAb
        d1KEnl95uL79lDTPGfHU/K0Iexuw2i0ZuTZXldgaDfJNUqauvtkStwnNZvaISDLw
        oEhw98lm3rPG1zIodLNpy3eo9Ig0VAZBaDMsdI/8eLGmjW/5raWtE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB1F0F6CC4;
        Fri,  5 Nov 2021 14:39:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DFE00F6CC3;
        Fri,  5 Nov 2021 14:39:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Anders Kaseorg <andersk@mit.edu>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v2] fetch: Protect branches checked out in all worktrees
References: <9dfca5ec-4426-d3d4-988e-b81ebb087584@mit.edu>
        <alpine.DEB.2.21.999.2111041709080.94135@tardis-on-the-dome.mit.edu>
        <YYTtdZblnHYgDgBq@coredump.intra.peff.net>
        <991240f7-2a3e-8ae7-ae25-a1d9d96d55d4@mit.edu>
        <YYUbQqyYQDD5QEAz@coredump.intra.peff.net>
Date:   Fri, 05 Nov 2021 11:39:03 -0700
In-Reply-To: <YYUbQqyYQDD5QEAz@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 5 Nov 2021 07:53:38 -0400")
Message-ID: <xmqqbl2yxxa0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A733481C-3E67-11EC-9076-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But all of that means we could actually drop check_not_current_branch()
> in favor of the update_local_ref() check. Doing this:
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index f7abbc31ff..c52c44684a 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -869,7 +869,7 @@ static int update_local_ref(struct ref *ref,
>  	}
>  
>  	if (current_branch &&
> -	    !strcmp(ref->name, current_branch->name) &&
> +	    !strcmp(ref->name, current_branch->refname) &&
>  	    !(update_head_ok || is_bare_repository()) &&
>  	    !is_null_oid(&ref->old_oid)) {
>  		/*
> @@ -1385,20 +1385,6 @@ static int prune_refs(struct refspec *rs, struct ref *ref_map,
>  	return result;
>  }
>  
> -static void check_not_current_branch(struct ref *ref_map)
> -{
> -	struct branch *current_branch = branch_get(NULL);
> -
> -	if (is_bare_repository() || !current_branch)
> -		return;
> -
> -	for (; ref_map; ref_map = ref_map->next)
> -		if (ref_map->peer_ref && !strcmp(current_branch->refname,
> -					ref_map->peer_ref->name))
> -			die(_("Refusing to fetch into current branch %s "
> -			    "of non-bare repository"), current_branch->refname);
> -}
> -
>  static int truncate_fetch_head(void)
>  {
>  	const char *filename = git_path_fetch_head(the_repository);
> @@ -1587,8 +1573,6 @@ static int do_fetch(struct transport *transport,
>  
>  	ref_map = get_ref_map(transport->remote, remote_refs, rs,
>  			      tags, &autotags);
> -	if (!update_head_ok)
> -		check_not_current_branch(ref_map);
>  
>  	if (tags == TAGS_DEFAULT && autotags)
>  		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
>
> passes the entire test suite except for one test which expects:
>
>   git fetch . side:main
>
> to fail. But that is only because "side" and "main" point to the same
> commit, and thus the fetch is a noop. The code in update_local_ref()
> covers that case before checking the HEAD case (which I would argue is
> a completely reasonable outcome).

So we can lose redundant code that was added there only because the
original safety was broken by actually fixing the original safety?

That is very nice.

> The reason I bring this up is that I think doing the check in
> update_local_ref() makes much more sense. We don't abort the whole
> fetch, but just treat it as a normal per-ref failure. That gives us the
> usual status-table output (I thought it might also avoid wasting some
> work of actually fetching objects, but I think the current check kicks
> in before we actually fetch anything).

Yes I agree with that reasoning.  

Thanks for digging this to the bottom, both of you.
