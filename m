From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v8 1/4] cache-tree: Create/update cache-tree on checkou
Date: Sun, 31 Aug 2014 13:07:03 +0100
Message-ID: <20140831120703.GA1240@serenity.lan>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 14:07:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XO3ul-0008LW-Ih
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 14:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbaHaMHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 08:07:19 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:48663 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbaHaMHS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 08:07:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 2E578CDA557;
	Sun, 31 Aug 2014 13:07:17 +0100 (BST)
X-Quarantine-ID: <0xkRyvNP2m3S>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0xkRyvNP2m3S; Sun, 31 Aug 2014 13:07:16 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 01B4FCDA58A;
	Sun, 31 Aug 2014 13:07:08 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1405140276-32162-1-git-send-email-dturner@twitter.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256285>

On Fri, Jul 11, 2014 at 09:44:33PM -0700, David Turner wrote:
> When git checkout checks out a branch, create or update the
> cache-tree so that subsequent operations are faster.
> 
> update_main_cache_tree learned a new flag, WRITE_TREE_REPAIR.  When
> WRITE_TREE_REPAIR is set, portions of the cache-tree which do not
> correspond to existing tree objects are invalidated (and portions which
> do are marked as valid).  No new tree objects are created.
> 
> Signed-off-by: David Turner <dturner@twitter.com>
> ---

This causes an incorrect error message to be printed when switching
branches with staged changes in a subdirectory.  The test case is pretty
simple:

	git init test &&
	cd test &&
	mkdir sub &&
	echo one >sub/one &&
	git add sub/one &&
	git commit -m one &&
	echo two >sub/two &&
	git add sub/two &&
	git checkout -b test

After this commit the output is:

	error: invalid object 040000 0000000000000000000000000000000000000000 for 'bar'
	A       bar/quux
	Switched to branch 'test'

but the "error:" line should not be there.

Everything still works, but I think the error message is a bit scary
considering that this isn't actually an error.

>  builtin/checkout.c    |  8 ++++++++
>  cache-tree.c          | 12 +++++++++++-
>  cache-tree.h          |  1 +
>  t/t0090-cache-tree.sh | 19 ++++++++++++++++---
>  4 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 07cf555..054214f 100644
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
> +				  active_nr, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
> +
>  	if (write_cache(newfd, active_cache, active_nr) ||
>  	    commit_locked_index(lock_file))
>  		die(_("unable to write new index file"));
> diff --git a/cache-tree.c b/cache-tree.c
> index 7fa524a..f951d7d 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -239,9 +239,12 @@ static int update_one(struct cache_tree *it,
>  	struct strbuf buffer;
>  	int missing_ok = flags & WRITE_TREE_MISSING_OK;
>  	int dryrun = flags & WRITE_TREE_DRY_RUN;
> +	int repair = flags & WRITE_TREE_REPAIR;
>  	int to_invalidate = 0;
>  	int i;
>  
> +	assert(!(dryrun && repair));
> +
>  	*skip_count = 0;
>  
>  	if (0 <= it->entry_count && has_sha1_file(it->sha1))
> @@ -374,7 +377,14 @@ static int update_one(struct cache_tree *it,
>  #endif
>  	}
>  
> -	if (dryrun)
> +	if (repair) {
> +		unsigned char sha1[20];
> +		hash_sha1_file(buffer.buf, buffer.len, tree_type, sha1);
> +		if (has_sha1_file(sha1))
> +			hashcpy(it->sha1, sha1);
> +		else
> +			to_invalidate = 1;
> +	} else if (dryrun)
>  		hash_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1);
>  	else if (write_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1)) {
>  		strbuf_release(&buffer);
> diff --git a/cache-tree.h b/cache-tree.h
> index f1923ad..666d18f 100644
> --- a/cache-tree.h
> +++ b/cache-tree.h
> @@ -39,6 +39,7 @@ int update_main_cache_tree(int);
>  #define WRITE_TREE_IGNORE_CACHE_TREE 2
>  #define WRITE_TREE_DRY_RUN 4
>  #define WRITE_TREE_SILENT 8
> +#define WRITE_TREE_REPAIR 16
>  
>  /* error return codes */
>  #define WRITE_TREE_UNREADABLE_INDEX (-1)
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
> -- 
> 2.0.0.390.gcb682f8
