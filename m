From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] cache-tree: Create/update cache-tree on checkout
Date: Tue, 01 Jul 2014 14:08:48 -0700
Message-ID: <xmqqzjgsvlb3.fsf@gitster.dls.corp.google.com>
References: <1404242075-7068-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 23:09:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X25IS-0003mx-Eb
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 23:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983AbaGAVI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 17:08:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54090 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695AbaGAVIz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 17:08:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 83F0725F11;
	Tue,  1 Jul 2014 17:08:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a7XE1WfXTshP35d4ysl/q6pzqes=; b=Rp3ETl
	lE1f/1ZeAJHXzplDohRZTwyTTKft/EBh7o/tlcGB5sLS4hAdwjl71ME9oL9/KvGr
	9/OyWPACl7Dx5HO26oJkK9IkaE5eyXw6ylOdxv71AdSKoPhY3UqdMhTM2tXveMQ4
	TIcTrekBOBnlwouY4KBuDSaxAh5bJQDwewnKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GrYHoMJVimCbnnJY8nhj92xHk8rU0XxI
	23J5u6BFiqccLEG/9aqhhNDdewXzTxZpnVWsUet9pYbV8gHI3KHgXLHnOAHaU+/2
	aH86siygyFMpFSF/dyGU1uaUWhko+DJUmZO5fCoO/m5Vtma+KNCLybJDRXKpsOv/
	xSgcq6T0QwA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A8A325F10;
	Tue,  1 Jul 2014 17:08:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 948FB25F0A;
	Tue,  1 Jul 2014 17:08:39 -0400 (EDT)
In-Reply-To: <1404242075-7068-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Tue, 1 Jul 2014 12:14:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DFCEB7AE-0163-11E4-BE3B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252743>

David Turner <dturner@twopensource.com> writes:

> When git checkout checks out a branch, create or update the
> cache-tree so that subsequent operations are faster.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---

Could you number your patches e.g. [PATCH v4 1/3] and/or summarize
below the three-dash line what got updated since the last round?
The readers can guess without when one is sending a reroll every
other day or less frequently, but with rerolls more often than that,
it gets unwieldy to check which points raised during the review have
been addressed.

Thanks.

>  builtin/checkout.c    |  8 ++++++++
>  cache-tree.c          |  5 +++--
>  t/t0090-cache-tree.sh | 19 ++++++++++++++++---
>  3 files changed, 27 insertions(+), 5 deletions(-)
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
>  	if (write_cache(newfd, active_cache, active_nr) ||
>  	    commit_locked_index(lock_file))
>  		die(_("unable to write new index file"));
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
> index 6c33e28..98fb1ab 100755
> --- a/t/t0090-cache-tree.sh
> +++ b/t/t0090-cache-tree.sh
> @@ -44,14 +44,14 @@ test_expect_success 'read-tree HEAD establishes cache-tree' '
>  
>  test_expect_success 'git-add invalidates cache-tree' '
>  	test_when_finished "git reset --hard; git read-tree HEAD" &&
> -	echo "I changed this file" > foo &&
> +	echo "I changed this file" >foo &&
>  	git add foo &&
>  	test_invalid_cache_tree
>  '
>  
>  test_expect_success 'update-index invalidates cache-tree' '
>  	test_when_finished "git reset --hard; git read-tree HEAD" &&
> -	echo "I changed this file" > foo &&
> +	echo "I changed this file" >foo &&
>  	git update-index --add foo &&
>  	test_invalid_cache_tree
>  '
> @@ -85,9 +85,22 @@ test_expect_success 'reset --hard without index gives cache-tree' '
>  	test_shallow_cache_tree
>  '
>  
> -test_expect_failure 'checkout gives cache-tree' '
> +test_expect_success 'checkout gives cache-tree' '
> +	git tag current &&
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
