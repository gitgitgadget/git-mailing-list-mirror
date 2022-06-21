Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3484DC433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 15:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351952AbiFUP6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 11:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352731AbiFUP5j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 11:57:39 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FE22E9EE
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 08:56:37 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03AA11333E5;
        Tue, 21 Jun 2022 11:56:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aqrqoatEaGCaRk5CVQo8SmIbJWXTaAlGc2X+iK
        QY24I=; b=tisYqah/o1S1iTGXzjCsl3KFYlB0stnTPYrxnvYT9a6XPptMswATgW
        OCaGwVts1OmVOvY9Kn6dG6F6MRhM8+rGxvrlxq06TrN2hdV1NELcNJ4dPLywvgwS
        zkN7L/2O1FMbcAD4UZxKpF916H0C8P9meOJ6FJXgjpGoEo6lKmYb4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EEDBF1333E3;
        Tue, 21 Jun 2022 11:56:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 28E081333E2;
        Tue, 21 Jun 2022 11:56:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/2] branch: drop unused worktrees variable
References: <Yq6deQf96g8M5wdg@coredump.intra.peff.net>
        <Yq6eJFUPPTv/zc0o@coredump.intra.peff.net>
Date:   Tue, 21 Jun 2022 08:56:35 -0700
In-Reply-To: <Yq6eJFUPPTv/zc0o@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 18 Jun 2022 23:55:16 -0400")
Message-ID: <xmqqzgi6hux8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAACCD34-F17A-11EC-8E6D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> After b489b9d9aa (branch: use branch_checked_out() when deleting refs,
> 2022-06-14), we no longer look at our local "worktrees" variable, since
> branch_checked_out() handles it under the hood. The compiler didn't
> notice the unused variable because we call functions to initialize and
> free it (so it's not totally unused, it just doesn't do anything
> useful).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> It would be neat if there was some way to mark a function as "this is
> just allocating a structure, with no useful side effects" and another as
> "this is just freeing", which would let the compiler notice that we
> don't do anything useful with the structure in between the two. I have a
> feeling adding such annotations might be more work than occasionally
> finding and cleaning up such useless variables, though. :)

Also it may be tricky to write correctly ;-)

I recently got rid of a Coccinelle rule I wrote quite a while ago
that was suggesting a completely bogus rewrite, and found it quite
satisfying.  After that experience, I got allergic to the idea of
having to make sure a mechanical rewrite suggested by the tool if it
gets too large X-<.

For this particular pattern, presumably we won't have too many of
them, though.

Thanks.

>  builtin/branch.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index f875952e7b..55cd9a6e99 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -204,7 +204,6 @@ static void delete_branch_config(const char *branchname)
>  static int delete_branches(int argc, const char **argv, int force, int kinds,
>  			   int quiet)
>  {
> -	struct worktree **worktrees;
>  	struct commit *head_rev = NULL;
>  	struct object_id oid;
>  	char *name = NULL;
> @@ -242,8 +241,6 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  			die(_("Couldn't look up commit object for HEAD"));
>  	}
>  
> -	worktrees = get_worktrees();
> -
>  	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
>  		char *target = NULL;
>  		int flags = 0;
> @@ -314,7 +311,6 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  
>  	free(name);
>  	strbuf_release(&bname);
> -	free_worktrees(worktrees);
>  
>  	return ret;
>  }
