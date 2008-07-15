From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cherry: cache patch-ids to avoid repeating work
Date: Tue, 15 Jul 2008 23:52:22 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807152255020.2990@eeepc-johanness>
References: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>  <alpine.DEB.1.00.0807101526380.18205@racer>  <7f9d599f0807100733s4435a9bga89749f2f6e10cf@mail.gmail.com>  <7v3amglxmb.fsf@gitster.siamese.dyndns.org> 
 <7f9d599f0807110758y6c4ea7bepd726daf4fe5f074c@mail.gmail.com>  <alpine.DEB.1.00.0807111635400.8950@racer>  <7f9d599f0807110841r329dfb95g786a576bd981dd1b@mail.gmail.com>  <alpine.DEB.1.00.0807111647080.8950@racer>  <7vej60jln6.fsf@gitster.siamese.dyndns.org>
  <7f9d599f0807122014y5190463j62d106a01bf31c86@mail.gmail.com> <7f9d599f0807150957o78d46204x280668c763fba2bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Tue Jul 15 23:52:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIsS2-0003iJ-OA
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 23:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931AbYGOVvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 17:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbYGOVvs
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 17:51:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:34409 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751861AbYGOVvr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 17:51:47 -0400
Received: (qmail invoked by alias); 15 Jul 2008 21:51:45 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp022) with SMTP; 15 Jul 2008 23:51:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+q9OkSROWq7D+f0wEiQj7mddeFTa3FL/WrsV6Rde
	EzxInDbt4K34Qe
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7f9d599f0807150957o78d46204x280668c763fba2bf@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88603>

Hi,

Okay, it seems like I never have time to review this, so I'll just 
take a few minutes to comment on some aspects:

On Tue, 15 Jul 2008, Geoffrey Irving wrote:

> +static int git_cherry_config(const char *var, const char *value, void *cb)
> +{
> +	if (!strcmp(var, "cherry.cachepatchids")) {
> +		cache_patch_ids = git_config_bool(var, value);
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
>  static const char cherry_usage[] =
>  "git-cherry [-v] <upstream> [<head>] [<limit>]";
>  int cmd_cherry(int argc, const char **argv, const char *prefix)
> @@ -1094,6 +1104,8 @@ int cmd_cherry(int argc, const char **argv,
> const char *prefix)
>  	const char *limit = NULL;
>  	int verbose = 0;
> 
> +	git_config(git_cherry_config, NULL);
> +
>  	if (argc > 1 && !strcmp(argv[1], "-v")) {
>  		verbose = 1;
>  		argc--;

Is this really purely for cherry, and not at all for "log --cherry-pick"?  
Maybe it should be "cache.patchIds" to begin with.

> diff --git a/cached-sha1-map.c b/cached-sha1-map.c
> new file mode 100644
> index 0000000..9cf7252
> --- /dev/null
> +++ b/cached-sha1-map.c
> @@ -0,0 +1,293 @@
> +#include "cached-sha1-map.h"
> +
> +union cached_sha1_map_header {
> +	struct {
> +		char signature[4]; /* CS1M */
> +		uint32_t version;
> +		uint32_t count;
> +		uint32_t size;
> +		uint32_t pad; /* pad to 20 bytes */
> +	} u;
> +	/* pad header out to 40 bytes.  As a consistency
> +	 * check, pad.value stores the sha1 of pad.key. */
> +	struct cached_sha1_entry pad;

Why does it have to be a union?

> +};
> +
> +static const char *signature = "CS1M";

Carrie Scr*ws 1 Man?

> +static int init_empty_map(struct cached_sha1_map *cache, uint32_t size)
> +{
> +	cache->count = 0;
> +	cache->size = size;

We seem to call this "alloc" (almost) everywhere else.

> +	cache->initialized = 1;

Maybe we do not need that: when size is != 0, it was initialized.

> +	cache->mmapped = 0;
> +	cache->dirty = 1;

Is it already dirty?  I don't think so.

> +	cache->entries = calloc(size, sizeof(struct cached_sha1_entry));
> +	if (!cache->entries) {
> +		warning("failed to allocate empty map of size %"PRIu32" for %s",
> +			size, git_path(cache->filename));

xcalloc() to the rescue.

> +static int grow_map(struct cached_sha1_map *cache)
> +{
> +	struct cached_sha1_map new_cache;
> +	uint32_t i;
> +
> +	if (cache->size * 2 == 0) {
> +		warning("%s overflowed, so resetting to empty",
> +			git_path(cache->filename));

IMHO we can safely ignore that case: If that is true, we have seen at 
least 2^32 objects.  However, each object takes more than 4 bytes, so that 
is a literal impossibility.

I'd rather not bother with this case.

> +	/* allocate cache with twice the size */
> +	new_cache.filename = cache->filename;
> +	if (init_empty_map(&new_cache, cache->size * 2)) {

Really, I think that these checks should be _made_ unnecessary, by 
restricting the size of the cache.  IMO Caching more than 2^10 patch ids 
(completely made up on the spot) is probably even detrimental, and it 
might be better to just scratch them all and start with a new cache then.

Besides, the file would have a substantial size by then.

> +static int init_cached_sha1_map(struct cached_sha1_map *cache)
> +{
>
> [...]
>
> +	SHA1_Init(&ctx);
> +	SHA1_Update(&ctx, header.pad.key, 20);
> +	SHA1_Final(header.pad.key, &ctx); /* reuse pad.key to store its sha1 */
> +	if (hashcmp(header.pad.key, header.pad.value)) {
> +		warning("%s header has invalid sha1", filename);
> +		goto empty;
> +	}

I do not think that it is worth checking that.  If you do not trust your 
hard disk, you might just as well jump out the window.

Checking just takes too much time.

> +	/* mmap entire file so that file / memory blocks are aligned */
> +	map_size = sizeof(struct cached_sha1_entry) * (cache->size + 1);
> +	cache->entries = mmap(NULL, map_size,
> +		PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);

AFAIR there were _serious_ performance issues with mmap() on non-Linux 
platforms.  I chose pread() in my original implementation for a reason.

> +static int32_t find_helper(struct cached_sha1_map *cache,
> +	const unsigned char *key)
> +{
> +	int32_t i, mask, full;
> +
> +	mask = cache->size - 1;
> +	i = get_hash_index(key) & mask;
> +	full = (i-1) & mask;
> +
> +	for (; ; i = (i+1) & mask) {

Wow, that is ugly.

> +struct cached_sha1_map {
> +	const char *filename; /* relative to GIT_DIR */

Why does the map need to know its name?  The index does not.

> +static struct diff_options default_options;
> +#define IGNORED_DIFF_OPTS (DIFF_OPT_HAS_CHANGES | DIFF_OPT_CHECK_FAILED)
> 
>  static int commit_patch_id(struct commit *commit, struct diff_options *options,
>  		    unsigned char *sha1)
>  {
> +	int use_cache = 0;
> +	int ret;
> +
> +	/* only cache if diff options are defaults */
> +	if (cache_patch_ids) {
> +		default_options.found_changes = options->found_changes;
> +		default_options.flags = (options->flags & IGNORED_DIFF_OPTS)
> +			| (default_options.flags & ~IGNORED_DIFF_OPTS);
> +		use_cache = !memcmp(options, &default_options,
> +				    sizeof(struct diff_options));
> +	}

Hmm.

I'd rather set "revs.diff" late, and unset "cache_patch_ids" if it is set.  
IOW let the rev_opt parser decide.

Unfortunately, I do not have time to look into your patch in more detail, 
even if I like the idea.

Ciao,
Dscho
