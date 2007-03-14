From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Tue, 13 Mar 2007 21:56:01 -0700
Message-ID: <7v8xe0h19a.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 05:56:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRLXD-0000tS-0M
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 05:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933826AbXCNE4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 00:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933827AbXCNE4F
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 00:56:05 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:53271 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933826AbXCNE4E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 00:56:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314045603.ZCLJ2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 00:56:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aUw11W00p1kojtg0000000; Wed, 14 Mar 2007 00:56:02 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42172>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> diff --git a/builtin-diff.c b/builtin-diff.c
> index 4efbb82..5e6265f 100644
> --- a/builtin-diff.c
> +++ b/builtin-diff.c
> @@ -130,6 +130,7 @@ static int builtin_diff_tree(struct rev_info *revs,
>  {
>  	const unsigned char *(sha1[2]);
>  	int swap = 0;
> +	int result = 0;
>  
>  	if (argc > 1)
>  		usage(builtin_diff_usage);
> @@ -141,9 +142,9 @@ static int builtin_diff_tree(struct rev_info *revs,
>  		swap = 1;
>  	sha1[swap] = ent[0].item->sha1;
>  	sha1[1-swap] = ent[1].item->sha1;
> -	diff_tree_sha1(sha1[0], sha1[1], "", &revs->diffopt);
> +	result = diff_tree_sha1(sha1[0], sha1[1], "", &revs->diffopt);
>  	log_tree_diff_flush(revs);
> -	return 0;
> +	return result;
>  }
>  
>  static int builtin_diff_combined(struct rev_info *revs,

The change to diff-tree side is completely borked.  (1) You did
not notice compare_tree_entry() in tree-diff.c returns 0 only to
signal that it has dealt with an entry from both sides (so the
caller can do update_tree_entry() on both), and the return value
does not mean they are the same.  (2) You are checking if there
are differences at wrong level, before letting diffcore_std() to
process the queue.  Because of the bug (1) I cannot test that
but after you fix (1) you would notice that it would not work if
you say "-Spickaxe"; your changes to diff-files and diff-index
are correct on this regard.

A slight tangent, but what Linus recalled he thought he did but
he didn't is related to the parts you touched in diff-tree
above.  Because of the interaction with diffcore, these changes
should not be used for the purpose of -exit-code, but catching
the tree level change in the above places and leaving early
would be the right thing to do for comparing the whole tree for
the purpose of simplifying the parents.  Tomorrow will be my git
day so I might whip up a patch to speed that up.

> diff --git a/diff-lib.c b/diff-lib.c
> index 6abb981..f943b6f 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -433,8 +437,9 @@ int run_diff_files(struct rev_info *revs, int silent_on_removed)
>  
>  	}
>  	diffcore_std(&revs->diffopt);
> +	result = revs->diffopt.diff_exit_code && diff_queued_diff.nr ? 1: 0;
>  	diff_flush(&revs->diffopt);
> -	return 0;
> +	return result;
>  }
>  
>  /*
> @@ -664,9 +669,10 @@ int run_diff_index(struct rev_info *revs, int cached)
>  		return error("bad tree object %s", tree_name);
>  	if (read_tree(tree, 1, revs->prune_data))
>  		return error("unable to read tree object %s", tree_name);
> -	ret = diff_cache(revs, active_cache, active_nr, revs->prune_data,
> +	diff_cache(revs, active_cache, active_nr, revs->prune_data,
>  			 cached, match_missing);
>  	diffcore_std(&revs->diffopt);
> +	ret = revs->diffopt.diff_exit_code && diff_queued_diff.nr ? 1: 0;
>  	diff_flush(&revs->diffopt);
>  	return ret;
>  }

This side looks correct, as you are counting queued_diff.nr after
letting diffcore_std() to filter the results.

> +test_expect_failure 'git diff-tree HEAD^ HEAD' '
> +	git diff-tree --exit-code HEAD^ HEAD
> +'
> ...
> +test_expect_failure 'git diff-index --cached HEAD' '
> +	git update-index c &&
> +	git diff-index --exit-code --cached HEAD
> +'

In general, expect_failure should not be used for complex cases
like this.  The first one I quoted is fine, but the latter one
is not.  update-index may fail (perhaps somebody screwed up
while updating read-cache.c or sha1_file.c) and the whole test
would say "happy that the command chain as a whole failed".
