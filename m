From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Adding a cache of commit to patch-id pairs to speed up
 git-cherry
Date: Mon, 2 Jun 2008 07:13:14 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806020649110.13507@racer.site.net>
References: <7f9d599f0806012054y33b4fc10ha109aa4afbc7ca78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Mon Jun 02 08:15:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K33KC-0004tG-2u
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 08:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbYFBGO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 02:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbYFBGO1
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 02:14:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:58127 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751577AbYFBGOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 02:14:25 -0400
Received: (qmail invoked by alias); 02 Jun 2008 06:14:23 -0000
Received: from unknown (EHLO none.local) [128.177.17.254]
  by mail.gmx.net (mp026) with SMTP; 02 Jun 2008 08:14:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+coKN06g2cDLnfDqKbvMMr6lP2822en8rvPkPniU
	WF8SMEmkE4gAxW
X-X-Sender: gene099@racer.site.net
In-Reply-To: <7f9d599f0806012054y33b4fc10ha109aa4afbc7ca78@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83495>

Hi,

On Sun, 1 Jun 2008, Geoffrey Irving wrote:

> The dominant cost of git-cherry is the computation of patch-ids for each 
> relevant commit.  Once computed, these pairs are now stored in a hash 
> table in $GIT_DIR/patch-id-cache to speed up repeated invocations.
> 
> The basic structure of patch-id-cache.c was cannibalized from Johannes 
> Schindelin's notes-index structure, though most of the code was 
> rewritten. The hash table is still kept strictly sorted by commit, but 
> the entire table is now read into memory.

I do not think that this "read-the-entire-table-into-memory" paradigm is a 
wise choice. mmap()ing, I would have understood, but reading a potentially 
pretty large table into memory?

> See commit d56dbe8cb56ce9b4697d1f1c2425e2e133a932a5 for the original 
> code.

This is not in any official git.git repository.  And my branches are prone 
to be rebased.  So this is not a good reference.  The mailing list, 
however, would be one.

> diff --git a/Makefile b/Makefile
> index cce5a6e..3a5396d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -435,6 +435,7 @@ LIB_OBJS += pager.o
>  LIB_OBJS += parse-options.o
>  LIB_OBJS += patch-delta.o
>  LIB_OBJS += patch-ids.o
> +LIB_OBJS += patch-id-cache.o

If all you do is a hashmap from SHA-1 to SHA-1, then I think 
"patch-id-cache" is a misnomer for that file and structure.

Let's not repeat the same naming mistakes as we have for path_list and 
decoration.

> +static void read_patch_id_cache()
> +{
> +	int fd = open(git_path("patch-id-cache"), O_RDONLY);
> +
> +	if (fd < 0) { // allocate a new cache
> +		size_t size = 64;
> +		cache = xcalloc(get_hash_size(size), 1);
> +		cache->key_size = cache->actual_size = size;
> +		return;
> +	}
> +
> +	struct patch_id_cache header;
> +	size_t len = read_in_full(fd, &header, sizeof(header));
> +	if (len != sizeof(header))
> +		die("cannot read patch-id-cache header");
> +	if (header.key_size & (header.key_size-1))
> +		die("patch-id-cache key size %lld is not a power of two", (long
> long)header.key_size);

Very long line.

Why does the key_size have to be a power of two?

> +	free(cache);
> +	cache = xmalloc(get_hash_size(header.actual_size));
> +	*cache = header;

This free() kind of defies the xmalloc in the if() clause above.

Besides, those three lines are a pretty awkward way to avoid writing 
xrealloc(), don't you think?

> +	size_t entry_size = header.actual_size * sizeof(struct patch_id_entry);

Declaration after statement.

> +	len = read_in_full(fd, cache->entries, entry_size);
> +	if (len != entry_size)
> +		die("cannot read patch-id-cache entries");
> +	written_count = cache->count;

Huh?  It is not written_count.  Besides, why do you use a global here?  
(Yes, I know, you probably just copied it from my code, but you could 
clean it up in the process ;-)

> +	// It's impossible to check whether the cache is actually accurate,

C++ style comments.

> +void write_patch_id_cache()
> +{
> +	if (!cache || cache->count == written_count)
> +		return;

Does that mean that the patch_id_cache is not updated when the number 
of commits stays the same after committing, branch -d and gc?

 > +
> +	struct lock_file update_lock;
> +	int fd = hold_lock_file_for_update(&update_lock,
> +			git_path("patch-id-cache"), 0);
> +
> +	if (fd < 0) {
> +		error("could not construct patch-id-cache");
> +		return;
> +	}

Not good.  Printing an error, but not returning any indicator of it.

> +int get_cached_commit_patch_id(const unsigned char *commit_sha1,
> +		unsigned char *patch_id_sha1)

Again, I do not think it is wise to name this function so focused on this 
particular purpose, when its use is clearly not limited to patch ids.

> +void cache_commit_patch_id(const unsigned char *commit_sha1,
> +		const unsigned char *patch_id_sha1)
> +{
> +	if (4*cache->count > 3*cache->key_size) { // resize

C++ comment.

> +		struct patch_id_cache *old_cache = cache;
> +		size_t new_key_size = 2*cache->key_size,
> +			new_actual_size = cache->key_size + cache->actual_size;
> +		cache = xcalloc(get_hash_size(new_actual_size), 1);
> +		cache->key_size = new_key_size;
> +		cache->actual_size = new_actual_size;
> +
> +		// reinsert all entries
> +		size_t i;
> +	 	for (i = 0; i < old_cache->actual_size; i++)
> +			cache_commit_patch_id(old_cache->entries[i].commit_sha1,
> +				old_cache->entries[i].patch_id_sha1);
> +	}

Does this not just _beg_ to live in an own function ("grow_hash")?

> +	struct patch_id_entry entry;

Declaration after statement.

> +	hashcpy(entry.commit_sha1, commit_sha1);
> +	hashcpy(entry.patch_id_sha1, patch_id_sha1);

It would be more elegant to copy the SHA-1s _after_ finding where to write 
them.

> +	size_t i = get_hash_index(commit_sha1);

Declaration after statement.

> +	for (;;) {
> +		if (i == cache->actual_size) {
> +			cache->actual_size++; // adding one suffices for expected O(1)

Long line.  C++ comment.  "one suffices"?

> +			cache = xrealloc(cache, get_hash_size(cache->actual_size));
> +			cache->entries[cache->actual_size-1] = entry;
> +			return;
> +		}
> +		int cmp = hashcmp(entry.commit_sha1, cache->entries[i].commit_sha1);

Declar... ah, well, suffice to say that you should read the 
CodingGuidelines, and try to fix up all the offending sites in your code.

> +		if (!cmp) {
> +			if (hashcmp(entry.patch_id_sha1, cache->entries[i].patch_id_sha1))
> +				die("found mismatched entry in patch-id-cache");

I wonder if that potentially expensive operation should not rather be 
wrapped in an assert() call (since I recently learnt that Git's source 
code has more than one instance of assert()).

> +			return;
> +		} else if (cmp < 0) {
> +			i++;
> +		} else if (is_null_sha1(cache->entries[i].commit_sha1)) {
> +			cache->entries[i] = entry;
> +			cache->count++;
> +			return;
> +		} else {
> +			struct patch_id_entry tmp = cache->entries[i];
> +			cache->entries[i] = entry;
> +			entry = tmp;
> +			i++;
> +		}

You seem to be wanting to implement a "sorted hashmap"... this is 
non-standard, and AFAICT affects performance negatively.

> diff --git a/patch-ids.c b/patch-ids.c
> index 3be5d31..91fabeb 100644
> --- a/patch-ids.c
> +++ b/patch-ids.c
> @@ -3,16 +3,30 @@
>  #include "commit.h"
>  #include "patch-ids.h"
> 
> +extern void write_patch_id_cache();
> +extern int get_cached_commit_patch_id(const unsigned char
> *commit_sha1, unsigned char *patch_id_sha1);
> +extern void cache_commit_patch_id(const unsigned char *commit_sha1,
> const unsigned char *patch_id_sha1);
> +

Uh oh.  This is not good.  If you do not have declarations like these in 
header files (that are included from the implementing .c file, of course), 
it is all too easy to have the signatures of the implementation and the 
declaration diverge.

So move them into an own header file, where they belong.  IIRC I did this 
in the notes code, so why did you choose not to imitate that?

>  static uint32_t take2(const unsigned char *id)
> @@ -136,6 +150,8 @@ int free_patch_ids(struct patch_ids *ids)
>  		next = patches->next;
>  		free(patches);
>  	}
> +
> +	write_patch_id_cache();
>  	return 0;

That's cute.

Ciao,
Dscho
