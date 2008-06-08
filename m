From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH / RFC] cherry: cache commit to patch-id pairs to avoid
 repeating work
Date: Sun, 8 Jun 2008 18:24:45 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806081712101.1783@racer>
References: <7f9d599f0806071636j1df57b6eqb5808f083dafd6a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Sun Jun 08 19:27:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5OfX-00011z-RP
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 19:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbYFHR0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 13:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbYFHR0J
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 13:26:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:35604 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750826AbYFHR0I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 13:26:08 -0400
Received: (qmail invoked by alias); 08 Jun 2008 17:26:06 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp030) with SMTP; 08 Jun 2008 19:26:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+PEbZLZZ6PeWe4rHe3kWnJ467SdFbMuaSfAhWYuV
	CJn5SXgcnIz2gz
X-X-Sender: gene099@racer
In-Reply-To: <7f9d599f0806071636j1df57b6eqb5808f083dafd6a2@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84297>

Hi,

On Sat, 7 Jun 2008, Geoffrey Irving wrote:

> Added cached-sha-map.[hc] implementing a persistent hash map from sha1 to sha1.
> The map is read with mmap, and completely rewritten if any entries change.  It
> would be good to add incremental update to handle the usual case where only a
> few entries change.

Please keep your commit messages shorter than 77 columns/row, so that 
output of "git log" is cutting lines.

> This structure is used by patch-ids.c to cache the mapping from commit 
> to patch-id into $GIT_DIR/patch-id-cache.  In the one case I've tested 
> so far, this speeds up the second invocation of git-cherry by two orders 
> of magnitude.
> 
> Original code cannibalized from Johannes Schindelin's notes-index structure.

S-O-B?

> diff --git a/cached-sha1-map.c b/cached-sha1-map.c
> new file mode 100644
> index 0000000..e363745
> --- /dev/null
> +++ b/cached-sha1-map.c
>
> [...]
>
> +int get_cached_sha1_entry(struct cached_sha1_map *cache,
> +	const unsigned char *key, unsigned char *value)
> +{
> +	size_t i, mask;
> +
> +	if (!cache->initialized)
> +		init_cached_sha1_map(cache);
> +
> +	mask = cache->size - 1;
> +
> +	for (i = get_hash_index(key) & mask; ; i = (i+1) & mask) {

I think get_hash_index() should already return the correct index, IOW it 
should take a pointer to cached_sha1_map() and "& (cache->size - 1)".

> +		if (!hashcmp(key, cache->entries[i].key)) {
> +			hashcpy(value, cache->entries[i].value);
> +			return 0;
> +		} else if (is_null_sha1(cache->entries[i].key))
> +			return -1;
> +	}
> +}
> +
> +void set_cached_sha1_entry(struct cached_sha1_map *cache,
> +	const unsigned char *key, const unsigned char *value)
> +{
> +	size_t i, mask;
> +	struct cached_sha1_entry *entry;
> +
> +	if (!cache->initialized)
> +		init_cached_sha1_map(cache);
> +
> +	if (4*cache->count >= 3*cache->size)
> +		grow_map(cache);

IIRC the optimal size for a hash set was double the number of non-NULL 
entries.

> +	mask = cache->size - 1;
> +
> +	for (i = get_hash_index(key) & mask; ; i = (i+1) & mask) {
> +		entry = cache->entries+i;
> +
> +		if (is_null_sha1(entry->key)) {
> +			hashcpy(entry->key, key);
> +			hashcpy(entry->value, value);
> +			cache->count++;
> +			cache->dirty = 1;
> +			return;
> +		} else if(!hashcmp(key, entry->key)) {
> +			if (hashcmp(value, entry->value)) {
> +				hashcpy(entry->value, value);
> +				cache->dirty = 1;
> +			}
> +			return;
> +		}
> +	}
> +}

Would it not be better to avoid duplicating code here, by having a helper 
that returns the index if the entry exists, and the negative index of the 
next free entry otherwise?

> diff --git a/patch-ids.c b/patch-ids.c
> index 3be5d31..36332f3 100644
> --- a/patch-ids.c
> +++ b/patch-ids.c
> @@ -2,17 +2,31 @@
>  #include "diff.h"
>  #include "commit.h"
>  #include "patch-ids.h"
> +#include "cached-sha1-map.h"
> +
> +struct cached_sha1_map patch_id_cache;
> 
>  static int commit_patch_id(struct commit *commit, struct diff_options *options,
>  		    unsigned char *sha1)
>  {
> +	/* pull patch-id out of the cache if possible */
> +	patch_id_cache.filename = "patch-id-cache";
> +	if (!get_cached_sha1_entry(&patch_id_cache, commit->object.sha1, sha1))
> +		return 0;
> +
>  	if (commit->parents)
>  		diff_tree_sha1(commit->parents->item->object.sha1,
>  		               commit->object.sha1, "", options);
>  	else
>  		diff_root_tree_sha1(commit->object.sha1, "", options);
>  	diffcore_std(options);
> -	return diff_flush_patch_id(options, sha1);
> +	int ret = diff_flush_patch_id(options, sha1);
> +	if (ret)
> +		return ret;
> +
> +	/* record commit, patch-id pair in cache */
> +	set_cached_sha1_entry(&patch_id_cache, commit->object.sha1, sha1);
> +	return 0;
>  }
> 
>  static uint32_t take2(const unsigned char *id)
> @@ -136,6 +150,8 @@ int free_patch_ids(struct patch_ids *ids)
>  		next = patches->next;
>  		free(patches);
>  	}
> +
> +	write_cached_sha1_map(&patch_id_cache);
>  	return 0;

Ah, so here you ignore the error when writing.  Thank you.  Maybe a 
comment that we fail gracefully if the repository is write-protected?

Ciao,
Dscho
