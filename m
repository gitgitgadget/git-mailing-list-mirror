From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] cherry: cache patch-ids to avoid repeating work
Date: Tue, 08 Jul 2008 22:14:05 -0700
Message-ID: <7vfxqjmyg2.fsf@gitster.siamese.dyndns.org>
References: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Geoffrey Irving" <irving@naml.us>
X-From: git-owner@vger.kernel.org Wed Jul 09 07:17:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGS3K-0007CR-6o
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 07:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbYGIFOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 01:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbYGIFOT
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 01:14:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbYGIFOS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 01:14:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 07A791879E;
	Wed,  9 Jul 2008 01:14:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6C0C81879B; Wed,  9 Jul 2008 01:14:08 -0400 (EDT)
In-Reply-To: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>
 (Geoffrey Irving's message of "Tue, 8 Jul 2008 20:53:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E0DEC010-4D75-11DD-8D12-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87845>

"Geoffrey Irving" <irving@naml.us> writes:

> From a3afd1455d215a541e1481e0f064df743d9219cc Mon Sep 17 00:00:00 2001

Please drop this line.

> From: Geoffrey Irving <irving@naml.us>
> Date: Sat, 7 Jun 2008 16:03:49 -0700
> Subject: [PATCH 1/3] cherry: cache patch-ids to avoid repeating work

These are Ok _if_ the difference between them and what you have in your
e-mail header really matter (e.g. you are forwarding somebody else's
patch).  I don't think it is in this case, though.

> Added cached-sha-map.[hc] implementing a persistent hash map from sha1 to
> sha1.

"Add cached-sha1-map.[ch]" (imperative mood), not "(here is what I) _did_".

> diff --git a/cached-sha1-map.c b/cached-sha1-map.c
> new file mode 100644
> index 0000000..e363745
> --- /dev/null
> +++ b/cached-sha1-map.c
> @@ -0,0 +1,182 @@
> +#include "cached-sha1-map.h"
> +
> +union cached_sha1_map_header {
> +	struct {
> +		char signature[4]; /* HASH */
> +		off_t count, size;
> +	};
> +	struct cached_sha1_entry padding; /* pad header out to 40 bytes */
> +};
> +
> +static const char *signature = "HASH";

That sounds a bit too generic, doesn't it, to protect ourselves from
getting confused by some other filetype?

> +static void init_cached_sha1_map(struct cached_sha1_map *cache)
> +{
> +	int fd;
> +	union cached_sha1_map_header header;
> +
> +	if (cache->initialized)
> +		return;
> +
> +	fd = open(git_path(cache->filename), O_RDONLY);
> +	if (fd < 0) {
> +		init_empty_map(cache, 64);
> +		return;

Check errno and do this only when ENOENT.  Other errors should be caught
and reported.

> +	}
> +
> +	if (read_in_full(fd, &header, sizeof(header)) != sizeof(header))
> +		die("cannot read %s header", cache->filename);
> +
> +	if (memcmp(header.signature, signature, 4))
> +		die("%s has invalid header", cache->filename);
> +
> +	if (header.size & (header.size-1))
> +		die("%s size %lld is not a power of two", cache->filename,
> +			(long long)header.size);

Two issues and a half:

 - Isn't it gcc extension to be able to say header.signature, bypassing
   the anonymous structure inside the union that the "header" itself is?

 - The signature header (count and size) is defined to be off_t, which
   makes the cached file unusable across architectures.  The map header
   structure should be specified with explicit size:

	union {
		struct {
	                char sig[4];
			uint32_t version;
                        uint32_t count;
                        unit32_t size;
		} u;
                struct cached_sha1_entry pad;
        };

   the uint32_t fields should be treated as network byte order integers,
   e.g.

	cache->count = ntohl(header.u.count);
        header.u.size = htonl(cache->size);

 - If this file is truly intended as "cache", shouldn't corruption of it
   be detected, reported but otherwise ignored, so that the lookup would
   continue in degraded uncached mode?

> +	/* check off_t to size_t conversion */
> +	if (cache->count != header.count || cache->size != header.size)
> +		die("%s is too large to hold in memory", cache->filename);

This does not make sense to me.  What you are checking does not match the
error message.

If you are making the file format architecture dependent (which I would
suggest strongly against), you can use the same type and be done with it.
Otherwise, if you are making the format portable across architectures,
then you would know how large the on-disk integer will be, so as long as
you use appropriate type that is large enough for cache->count you should
be Ok.

What you may want to check is that (header.u.size + 1) * sizeof(entry)
does not wrap around, but you don't.

> +	/* mmap entire file so that file / memory blocks are aligned */
> +	cache->entries = xmmap(NULL,
> +		sizeof(struct cached_sha1_entry) * (header.size + 1),
> +		PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);

I think this will die() if the file is too large to map.  Ideally you
would want to allow this mmap to fail if the cache is too large, in which
case you can gracefully degrade to cacheless mode of operation, but that
can probably be left to 47th round.

> +int write_cached_sha1_map(struct cached_sha1_map *cache)
> +{
> +	union cached_sha1_map_header header;
> +	struct lock_file update_lock;
> +	int fd;
> +	size_t entry_size;
> +
> +	if (!cache->initialized || !cache->dirty)
> +		return 0;
> +
> +	fd = hold_lock_file_for_update(&update_lock,
> +			git_path(cache->filename), 0);
> +
> +	if (fd < 0)
> +		return error("could not construct %s", cache->filename);

Use a "const char *" to hold git_path(cache->filename) upfront in the
function, use it to obtain lock _and_ for reporting.

> +	memcpy(header.signature, signature, 4);
> +	header.count = cache->count;
> +	header.size = cache->size;

And here will be htonl().

> +	entry_size = sizeof(struct cached_sha1_entry) * cache->size;

Typically "entry_size" means the size of individual entry; this is the
size of the whole thing.

> +	if (write_in_full(fd, &header, sizeof(header)) != sizeof(header)
> +		|| write_in_full(fd, cache->entries, entry_size) != entry_size)
> +		return error("could not write %s", cache->filename);
> +
> +	if (commit_lock_file(&update_lock) < 0)
> +		return error("could not write %s", cache->filename);
> +
> +	cache->dirty = 0;
> +	return 0;
> +}

But it is good that you used this intermediate variable; the above
write_in_full() is much easier to read than the xmmap() above at the end
of init_cached_sha1_map() function.

> +static size_t get_hash_index(const unsigned char *sha1)
> +{
> +	return ntohl(*(size_t*)sha1);
> +}

Two issues:

 - I do not see any guarantee that sha1 is suitably aligned for reading
   size_t bytes off of;

 - size_t is architecture dependent, so you would get different hash value
   depending on the architecture, which again makes this file format
   unportable.

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

Does this have to be extern?

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

Decl-after-statement.

> +	if (ret)
> +		return ret;
> +
> +	/* record commit, patch-id pair in cache */
> +	set_cached_sha1_entry(&patch_id_cache, commit->object.sha1, sha1);
> +	return 0;
>  }
