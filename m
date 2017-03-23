Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 999D720958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755871AbdCWPZx (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:25:53 -0400
Received: from avasout01.plus.net ([84.93.230.227]:34608 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753276AbdCWPZw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:25:52 -0400
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id zTRk1u00222aPyA01TRlxj; Thu, 23 Mar 2017 15:25:47 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=BZKo6vl2 c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=bt3WUTiwAAAA:8 a=yMhMjlubAAAA:8 a=0bM79WENdhfPxwPDoWcA:9
 a=w8-u1zSV2uUVaR3N:21 a=kEj7Xm8udrQa9GkX:21 a=QEXdDO2ut3YA:10
 a=OXx4ngWzwLx9h_IvVXMu:22 a=BKKCjISod1eDJeS0ORpz:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 5/7] name-hash: perf improvement for
 lazy_init_name_hash
To:     git@jeffhostetler.com, git@vger.kernel.org
References: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
 <1490276825-41544-6-git-send-email-git@jeffhostetler.com>
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <e987714e-473f-cad1-159b-18459ffeb241@ramsayjones.plus.com>
Date:   Thu, 23 Mar 2017 15:25:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <1490276825-41544-6-git-send-email-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/03/17 13:47, git@jeffhostetler.com wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
[snip]

> 
> diff --git a/name-hash.c b/name-hash.c
> index 3f7722a..71ef07e 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -23,15 +23,21 @@ static int dir_entry_cmp(const struct dir_entry *e1,
>  			name ? name : e2->name, e1->namelen);
>  }
>  
> -static struct dir_entry *find_dir_entry(struct index_state *istate,
> -		const char *name, unsigned int namelen)
> +static struct dir_entry *find_dir_entry__hash(struct index_state *istate,
> +		const char *name, unsigned int namelen, unsigned int hash)
>  {
>  	struct dir_entry key;
> -	hashmap_entry_init(&key, memihash(name, namelen));
> +	hashmap_entry_init(&key, hash);
>  	key.namelen = namelen;
>  	return hashmap_get(&istate->dir_hash, &key, name);
>  }
>  
> +static struct dir_entry *find_dir_entry(struct index_state *istate,
> +		const char *name, unsigned int namelen)
> +{
> +	return find_dir_entry__hash(istate, name, namelen, memihash(name, namelen));
> +}
> +
>  static struct dir_entry *hash_dir_entry(struct index_state *istate,
>  		struct cache_entry *ce, int namelen)
>  {
> @@ -112,21 +118,493 @@ static int cache_entry_cmp(const struct cache_entry *ce1,
>  	return remove ? !(ce1 == ce2) : 0;
>  }
>  
> -static void lazy_init_name_hash(struct index_state *istate)
> +static int lazy_try_threaded = 1;
> +static int lazy_nr_dir_threads;
> +
> +#ifdef NO_PTHREADS
> +
> +static inline int lookup_lazy_params(struct index_state *istate)
>  {
> -	int nr;
> +	return 0;
> +}
> +
> +static inline void threaded_lazy_init_name_hash(
> +	struct index_state *istate)
> +{
> +}
> +
> +#else
> +
> +#include "thread-utils.h"
> +
> +/*
> + * Set a minimum number of cache_entries that we will handle per
> + * thread and use that to decide how many threads to run (upto
> + * the number on the system).
> + *
> + * For guidance setting the lower per-thread bound, see:
> + *     t/helper/test-lazy-init-name-hash --analyze
> + */
> +#define LAZY_THREAD_COST (2000)
> +
> +/*
> + * We use n mutexes to guard n partitions of the "istate->dir_hash"
> + * hashtable.  Since "find" and "insert" operations will hash to a
> + * particular bucket and modify/search a single chain, we can say
> + * that "all chains mod n" are guarded by the same mutex -- rather
> + * than having a single mutex to guard the entire table.  (This does
> + * require that we disable "rehashing" on the hashtable.)
> + *
> + * So, a larger value here decreases the probability of a collision
> + * and the time that each thread must wait for the mutex.
> + */
> +#define LAZY_MAX_MUTEX   (32)
> +
> +static pthread_mutex_t *lazy_dir_mutex_array;
> +
> +/*
> + * An array of lazy_entry items is used by the n threads in
> + * the directory parse (first) phase to (lock-free) store the
> + * intermediate results.  These values are then referenced by
> + * the 2 threads in the second phase.
> + */
> +struct lazy_entry {
> +	struct dir_entry *dir;
> +	unsigned int hash_dir;
> +	unsigned int hash_name;
> +};
> +
> +/*
> + * Decide if we want to use threads (if available) to load
> + * the hash tables.  We set "lazy_nr_dir_threads" to zero when
> + * it is not worth it.
> + */
> +static int lookup_lazy_params(struct index_state *istate)
> +{
> +	int nr_cpus;
> +
> +	lazy_nr_dir_threads = 0;
> +
> +	if (!lazy_try_threaded)
> +		return 0;
> +
> +	/*
> +	 * If we are respecting case, just use the original
> +	 * code to build the "istate->name_hash".  We don't
> +	 * need the complexity here.
> +	 */
> +	if (!ignore_case)
> +		return 0;
> +
> +	nr_cpus = online_cpus();
> +	if (nr_cpus < 2)
> +		return 0;
> +
> +	if (istate->cache_nr < 2 * LAZY_THREAD_COST)
> +		return 0;
> +
> +	if (istate->cache_nr < nr_cpus * LAZY_THREAD_COST)
> +		nr_cpus = istate->cache_nr / LAZY_THREAD_COST;
> +	lazy_nr_dir_threads = nr_cpus;
> +	return lazy_nr_dir_threads;
> +}
> +
> +/*
> + * Initialize n mutexes for use when searching and inserting
> + * into "istate->dir_hash".  All "dir" threads are trying
> + * to insert partial pathnames into the hash as they iterate
> + * over their portions of the index, so lock contention is
> + * high.
> + *
> + * However, the hashmap is going to put items into bucket
> + * chains based on their hash values.  Use that to create n
> + * mutexes and lock on mutex[bucket(hash) % n].  This will
> + * decrease the collision rate by (hopefully) by a factor of n.
> + */
> +static void init_dir_mutex(void)
> +{
> +	int j;
> +
> +	lazy_dir_mutex_array = xcalloc(LAZY_MAX_MUTEX, sizeof(pthread_mutex_t));
> +
> +	for (j = 0; j < LAZY_MAX_MUTEX; j++)
> +		init_recursive_mutex(&lazy_dir_mutex_array[j]);
> +}
> +
> +static void cleanup_dir_mutex(void)
> +{
> +	int j;
> +
> +	for (j = 0; j < LAZY_MAX_MUTEX; j++)
> +		pthread_mutex_destroy(&lazy_dir_mutex_array[j]);
> +
> +	free(lazy_dir_mutex_array);
> +}
> +
> +static void lock_dir_mutex(int j)
> +{
> +	pthread_mutex_lock(&lazy_dir_mutex_array[j]);
> +}
> +
> +static void unlock_dir_mutex(int j)
> +{
> +	pthread_mutex_unlock(&lazy_dir_mutex_array[j]);
> +}
> +
> +static inline int compute_dir_lock_nr(
> +	const struct hashmap *map,
> +	unsigned int hash)
> +{
> +	return hashmap_bucket(map, hash) % LAZY_MAX_MUTEX;
> +}
> +
> +static struct dir_entry *hash_dir_entry_with_parent_and_prefix(
> +	struct index_state *istate,
> +	struct dir_entry *parent,
> +	struct strbuf *prefix)
> +{
> +	struct dir_entry *dir;
> +	unsigned int hash;
> +	int lock_nr;
> +
> +	/*
> +	 * Either we have a parent directory and path with slash(es)
> +	 * or the directory is an immediate child of the root directory.
> +	 */
> +	assert((parent != NULL) ^ (strchr(prefix->buf, '/') == 0));

sparse complains about 'Using plain integer as a NULL pointer', (the
return from strchr() is NULL, if '/' is not found) so maybe:

+	assert((parent != NULL) ^ (strchr(prefix->buf, '/') == NULL));


ATB,
Ramsay Jones
