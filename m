From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] fix read-tree storing wrong tree reference with
	modified index
Date: Fri, 9 Jul 2010 12:04:34 +0200
Message-ID: <20100709100433.GA7829@book.hvoigt.net>
References: <20100708224653.GB50404@book.hvoigt.net> <7vvd8po804.fsf@alter.siamese.dyndns.org> <7v630po53r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 12:04:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXARm-0002hX-Ac
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 12:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315Ab0GIKEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 06:04:38 -0400
Received: from darksea.de ([83.133.111.250]:35651 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754516Ab0GIKEg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 06:04:36 -0400
Received: (qmail 26687 invoked from network); 9 Jul 2010 12:04:34 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 9 Jul 2010 12:04:34 +0200
Content-Disposition: inline
In-Reply-To: <7v630po53r.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150650>

On Thu, Jul 08, 2010 at 05:45:28PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Heiko Voigt <hvoigt@hvoigt.net> writes:
> >
> >>  	 * The same holds true if we are switching between two trees
> >> -	 * using read-tree -m A B.  The index must match B after that.
> >> +	 * using read-tree A B (without -m). The index must match B
> >> +	 * after that. With given -m it can be a mix of the old index
> >> +	 * and the read one.
> >
> > I think the justification of the original patch is completely bogus.  Why
> > not just drop the priming instead?  Two-tree read-tree without -m does not
> > make much sense but the result would look like an overlay of two trees,
> > and is not likely to match either of the trees.

If you say so I believe you. I was searching for the reason anyway.

> IOW, how about doing this (backported to 1.6.4 codebase) instead?

Looks good to me (from what I understand).

For the test code you can add my

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>


> -- >8 --
> Subject: [PATCH] Fix "read-tree -m A B" priming the cache-tree
> 
> In 456156d a shortcut to priming the index tree reference was
> introduced, but the justification for it was completely bogus.
> 
> "read-tree -m A B" is to take the index (and the working tree)
> that is largely based on (but does not have to match exactly) A
> and update it to B, while carrying the local change that does
> not overlap the difference between A and B, so there is no reason
> to expect that the resulting index should match the tree B.
> 
> Noticed and test provided by Heiko Voigt.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin-read-tree.c         |    5 -----
>  t/t1001-read-tree-m-2way.sh |   16 ++++++++++++++++
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin-read-tree.c b/builtin-read-tree.c
> index 82e25ea..4fbf5f8 100644
> --- a/builtin-read-tree.c
> +++ b/builtin-read-tree.c
> @@ -199,14 +199,9 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
>  	 * "-m ent" or "--reset ent" form), we can obtain a fully
>  	 * valid cache-tree because the index must match exactly
>  	 * what came from the tree.
> -	 *
> -	 * The same holds true if we are switching between two trees
> -	 * using read-tree -m A B.  The index must match B after that.
>  	 */
>  	if (nr_trees == 1 && !opts.prefix)
>  		prime_cache_tree(&active_cache_tree, trees[0]);
> -	else if (nr_trees == 2 && opts.merge)
> -		prime_cache_tree(&active_cache_tree, trees[1]);
>  
>  	if (write_cache(newfd, active_cache, active_nr) ||
>  	    commit_locked_index(&lock_file))
> diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
> index 271bc4e..6e3b601 100755
> --- a/t/t1001-read-tree-m-2way.sh
> +++ b/t/t1001-read-tree-m-2way.sh
> @@ -392,4 +392,20 @@ test_expect_success \
>       git ls-files --stage | tee >treeMcheck.out &&
>       test_cmp treeM.out treeMcheck.out'
>  
> +test_expect_success '-m references the correct modified tree' '
> +	echo >file-a &&
> +	echo >file-b &&
> +	git add file-a file-b &&
> +	git commit -a -m "test for correct modified tree"
> +	git branch initial-mod &&
> +	echo b >file-b &&
> +	git commit -a -m "B" &&
> +	echo a >file-a &&
> +	git add file-a &&
> +	git ls-tree $(git write-tree) file-a >expect &&
> +	git read-tree -m HEAD initial-mod &&
> +	git ls-tree $(git write-tree) file-a >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> -- 
> 1.7.2.rc2.191.gd2de1
> 
