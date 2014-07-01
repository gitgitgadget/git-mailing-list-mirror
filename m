From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] cache-tree: Create/update cache-tree on checkout
Date: Tue, 01 Jul 2014 13:15:38 -0700
Message-ID: <xmqq8uocx2c5.fsf@gitster.dls.corp.google.com>
References: <1404173597-24713-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 22:15:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X24T1-0004FY-Hn
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 22:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758656AbaGAUPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 16:15:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59491 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756278AbaGAUPq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 16:15:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3098324EC5;
	Tue,  1 Jul 2014 16:15:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=04LOi18hF5PxQfSmeCFt7fgA0bU=; b=Q3KKVC
	kr/tTUomrXMpmpX85T0xKGrdbkctLzsL+0f1v6MvXuLhP4ln9u0XiSJSARA+c4TU
	gph9HrnlBLxgnJ+zZ2kKfLG4wOpUVkTla+iyxlJ0nV/ZR8V33bDZVhymfNZPEnJR
	vc/iwHGOljWEtOt42MYSdE3p6qATL94EcjE3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HXueXZUIYrgpGYYWp5Xqs6fwvPzdh+xv
	lkARDG5cuwB5liUWYO0YaqfL5mYItim2gh4nmerm+ypA6bHbnzywcWZtccieC1gU
	KT3AHEGt9ziD/Tyvr96hN0o4hUwKGlF3nWPE+pEMi2QB0c5w1ur3y8do0YW09jSb
	oONOJ8Gs6tM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E80E624EC4;
	Tue,  1 Jul 2014 16:15:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 32EE024EB9;
	Tue,  1 Jul 2014 16:15:29 -0400 (EDT)
In-Reply-To: <1404173597-24713-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Mon, 30 Jun 2014 17:13:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 722DE10E-015C-11E4-AA03-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252741>

David Turner <dturner@twopensource.com> writes:

> When git checkout checks out a branch, create or update the
> cache-tree so that subsequent operations are faster.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  builtin/checkout.c    |  8 ++++++++
>  cache-tree.c          |  5 +++--
>  t/t0090-cache-tree.sh | 15 ++++++++++++++-
>  3 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 07cf555..a023a86 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -553,6 +553,14 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  		}
>  	}
>  
> +	if (!active_cache_tree)
> +		active_cache_tree = cache_tree();
> +
> +	if (!cache_tree_fully_valid(active_cache_tree))
> +		cache_tree_update(active_cache_tree,
> +				  (const struct cache_entry * const *)active_cache,
> +				  active_nr, 0);
> +

This looks much better than the previous round, but it still does
allow verify_cache() to throw noises against unmerged entries in the
cache, as WRITE_TREE_SILENT flag is not passed down, no?

	$ git checkout master^0
        $ git am $this_message
        $ make
        $ edit builtin/checkout.c ;# make changes to the above lines
        $ ./git checkout -m master^0
x       builtin/checkout.c: unmerged (972c8a7b28f16f88475268f9a714048c228e69db)
x       builtin/checkout.c: unmerged (f1dc56e55f7b2200412142b10517458ccfda2952)
x       builtin/checkout.c: unmerged (3b9753ba8c19e7dfe6e922f30eb85c83a92a4596)
        M       builtin/checkout.c
        Warning: you are leaving 1 commit behind, not connected to
        any of your branches:

          25fab54 cache-tree: Create/update cache-tree on checkout

        Switched to branch 'master'

Passing WRITE_TREE_SILENT in the flags parameter will get rid of the
conflict notice output from the above.

The user is not interested in writing a brand new tree object at all
in this case, so it feels wrong to actually let the call chain go
down to update_one() and create new tree objects.

	Side note.  And passing WRITE_TREE_DRY_RUN is not a good
	solution either, because a later write_cache_as_tree() will
	not create the necessary tree object once you stuff a tree
	object name in the cache-tree.

What we want in this code path is a way to repair a sub cache_tree
if it can be repaired without creating a new tree object and
otherwise leave that part invalid.  The existing cache-tree
framework is not prepared to do that kind of thing.  It wants to
start from the bottom and percolate things up, computing levels
nearer to the top-level only after it fully created the trees for
deeper levels, because it is meant to be used only when we really
want to write out trees.  We may want to reuse update_one() but

I am not convinced that doing an equivalent of write-tree when you
switch branches is the right approach in the first place.  You will
eventually write it out as a tree, and having a relatively undamaged
cache-tree will help you when you do so, but spending the cycles
necessary to compute a fully populated cache-tree, only to let it
degrade over time until you are ready to write it out as a tree,
somehow sounds like asking for a duplicated work upfront.

By the way, you seem to have touched write_cache_as_tree() in the
same patch, but I am not sure what makes the change necessary.  I do
not see a new caller to it that passes a NULL to its sha1 parameter.

> diff --git a/cache-tree.c b/cache-tree.c
> index 7fa524a..28d2356 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -612,9 +612,10 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
>  			cache_tree_find(active_cache_tree, prefix);
>  		if (!subtree)
>  			return WRITE_TREE_PREFIX_ERROR;
> -		hashcpy(sha1, subtree->sha1);
> +		if (sha1)
> +			hashcpy(sha1, subtree->sha1);
>  	}
> -	else
> +	else if (sha1)
>  		hashcpy(sha1, active_cache_tree->sha1);
>  
>  	if (0 <= newfd)
> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
> index 6c33e28..7c60675 100755
> --- a/t/t0090-cache-tree.sh
> +++ b/t/t0090-cache-tree.sh
> @@ -85,9 +85,22 @@ test_expect_success 'reset --hard without index gives cache-tree' '
>  	test_shallow_cache_tree
>  '
>  
> -test_expect_failure 'checkout gives cache-tree' '
> +test_expect_success 'checkout gives cache-tree' '
> +	git tag current
>  	git checkout HEAD^ &&
>  	test_shallow_cache_tree
>  '
>  
> +test_expect_success 'checkout -b gives cache-tree' '
> +	git checkout current &&
> +	git checkout -b prev HEAD^ &&
> +	test_shallow_cache_tree
> +'
> +
> +test_expect_success 'checkout -B gives cache-tree' '
> +	git checkout current &&
> +	git checkout -B prev HEAD^ &&
> +	test_shallow_cache_tree
> +'
> +
>  test_done
