Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7475D3C36
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708385961; cv=none; b=SVP8WMBRx3sOPGMkmTC7hOhjyNliu9fukucOaPXtWFSZ8Rfv88nL9ncfF+q6xJUpGwdaYQrdlNXIYszgb+cDjS96KiwIxqMFDAyK1h0pCLrbTFGOoRmIDzZJ724QDU8SK8wTUkfmn5hfX34SUmiFswT0/EHqCuwv8R6yd7wallE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708385961; c=relaxed/simple;
	bh=cjYPC41RmFjL6O05GnJ5InySvAxhgOguHuV1hijUZRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MU0l7tyguhZSdCSA0ZUHYGlzVdVjDFaBxM1A1YJle5neTeH3TmKbwZRGKIS/BZNvzNFtDe9WSH0ksiNfO3GhQeR56DBtTNG22aSRQbYYDwCPdYENiQR9ejNm9Pa2EekMpCta7Uifo7dZx/xtXYC0nSdONnzYogvDmpKnW4MuLfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gcrcr1xr; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gcrcr1xr"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C7F3B21407;
	Mon, 19 Feb 2024 18:39:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cjYPC41RmFjL6O05GnJ5InySvAxhgOguHuV1hi
	jUZRg=; b=gcrcr1xrtplFG7u9exSGKh6xiSJOD2XeFIW/C8/klGGqAafGrAwH6q
	K8Nj4eMnufeP1mpHksjgiAYG9uAEK7rdpphmjLLiBfS9W40EUv4JxegR3piUisYx
	c5dSOr/T1U6q6kVGBSU8Ezxh3ePgkfI7SCvQpHfrqiLId+72mij+c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B8DCE21406;
	Mon, 19 Feb 2024 18:39:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 624E321405;
	Mon, 19 Feb 2024 18:39:10 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] dir-iterator: support iteration in sorted order
In-Reply-To: <8a588175dbf23d1938db45507812aad8f3793dbb.1708353264.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 19 Feb 2024 15:35:22 +0100")
References: <cover.1708353264.git.ps@pks.im>
	<8a588175dbf23d1938db45507812aad8f3793dbb.1708353264.git.ps@pks.im>
Date: Mon, 19 Feb 2024 15:39:08 -0800
Message-ID: <xmqq8r3g10tf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 14A50B1E-CF80-11EE-98EF-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The `struct dir_iterator` is a helper that allows us to iterate through
> directory entries. This iterator returns entries in the exact same order
> as readdir(3P) does -- or in other words, it guarantees no specific
> order at all.
>
> This is about to become problematic as we are introducing a new reflog
> subcommand to list reflogs. As the "files" backend uses the directory
> iterator to enumerate reflogs, returning reflog names and exposing them
> to the user would inherit the indeterministic ordering. Naturally, it
> would make for a terrible user interface to show a list with no
> discernible order. While this could be handled at a higher level by the
> new subcommand itself by collecting and ordering the reflogs, this would
> be inefficient and introduce latency when there are many reflogs.

I do not quite understand this argument.  Why is sorting at higher
level less (or more, for that matter) efficient than doing so at
lower level?  We'd need to sort somewhere no matter what, and I of
course have no problem in listing in a deterministic order.

> Instead, introduce a new option into the directory iterator that asks
> for its entries to be yielded in lexicographical order. If set, the
> iterator will read all directory entries greedily end sort them before
> we start to iterate over them.

"end" -> "and".  And of course without such sorting option, this
codepath is allowed to yield entries in any order that is the
easiest to produce?  That makes sense.

> While this will of course also incur overhead as we cannot yield the
> directory entries immediately, it should at least be more efficient than
> having to sort the complete list of reflogs as we only need to sort one
> directory at a time.

True.  The initial latency before we see the first byte of the
output often matters more in perceived performance the throughput.
As we need to sort to give a reasonable output, that cannot be
avoided.

> This functionality will be used in a follow-up commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  dir-iterator.c | 87 ++++++++++++++++++++++++++++++++++++++++----------
>  dir-iterator.h |  3 ++
>  2 files changed, 73 insertions(+), 17 deletions(-)
>
> diff --git a/dir-iterator.c b/dir-iterator.c
> index f58a97e089..396c28178f 100644
> --- a/dir-iterator.c
> +++ b/dir-iterator.c
> @@ -2,9 +2,12 @@
>  #include "dir.h"
>  #include "iterator.h"
>  #include "dir-iterator.h"
> +#include "string-list.h"
>  
>  struct dir_iterator_level {
>  	DIR *dir;
> +	struct string_list entries;
> +	size_t entries_idx;

Does it deserve a comment that "dir == NULL" is used as a signal
that we have read the level and sorted its contents into the
"entries" list (and also we have already called closedir(), of
course)?

> @@ -72,6 +75,40 @@ static int push_level(struct dir_iterator_int *iter)
>  		return -1;
>  	}
>  
> +	string_list_init_dup(&level->entries);
> +	level->entries_idx = 0;
> +
> +	/*
> +	 * When the iterator is sorted we read and sort all directory entries
> +	 * directly.
> +	 */
> +	if (iter->flags & DIR_ITERATOR_SORTED) {
> +		while (1) {
> +			struct dirent *de;
> +
> +			errno = 0;
> +			de = readdir(level->dir);
> +			if (!de) {
> +				if (errno && errno != ENOENT) {
> +					warning_errno("error reading directory '%s'",
> +						      iter->base.path.buf);
> +					return -1;
> +				}
> +
> +				break;
> +			}
> +
> +			if (is_dot_or_dotdot(de->d_name))
> +				continue;

The condition to skip an entry currently is simple enough that "."
and ".." are the only ones that are skipped, but it must be kept in
sync with the condition in dir_iterator_advance().

If it becomes more complex than it is now (e.g., we may start to
skip any name that begins with a dot, like ".git" or ".dummy"), it
probably is a good idea *not* to add the same filtering logic here
and in dir_iterator_advance().  Instead, keep the filtering here to
an absolute minumum, and filter the name, whether it came from
readdir() or from the .entries string list, in a single copy of
filtering logic in dir_iterator_advance() function.

We could drop the dot-or-dotdot filter here, too, if we want to
ensure that unified filtering will be correctly done over there.

> +			string_list_append(&level->entries, de->d_name);
> +		}
> +		string_list_sort(&level->entries);
> +
> +		closedir(level->dir);
> +		level->dir = NULL;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -88,6 +125,7 @@ static int pop_level(struct dir_iterator_int *iter)
>  		warning_errno("error closing directory '%s'",
>  			      iter->base.path.buf);
>  	level->dir = NULL;
> +	string_list_clear(&level->entries, 0);
>  
>  	return --iter->levels_nr;
>  }

It is somewhat interesting that the original code already has
conditional call to closedir() and prepares .dir to be NULL,
so that we do not have to make it conditional here.

> @@ -136,30 +174,43 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  
>  	/* Loop until we find an entry that we can give back to the caller. */
>  	while (1) {
> -		struct dirent *de;
>  		struct dir_iterator_level *level =
>  			&iter->levels[iter->levels_nr - 1];
> +		struct dirent *de;
> +		const char *name;

Not a huge deal but this is an unnecessary reordering, right?

>  		strbuf_setlen(&iter->base.path, level->prefix_len);
> +
> +		if (level->dir) {
> +			errno = 0;
> +			de = readdir(level->dir);
> +			if (!de) {
> +				if (errno) {
> +					warning_errno("error reading directory '%s'",
> +						      iter->base.path.buf);
> +					if (iter->flags & DIR_ITERATOR_PEDANTIC)
> +						goto error_out;
> +				} else if (pop_level(iter) == 0) {
> +					return dir_iterator_abort(dir_iterator);
> +				}
> +				continue;
>  			}
>  
> +			if (is_dot_or_dotdot(de->d_name))
> +				continue;

This is the target of the "if we will end up filtering even more in
the future, it would probably be a good idea not to duplicate the
logic to decide what gets filtered in this function and in
push_level()" comment.  If we wanted to go that route, we can get
rid of the filtering from push_level(), and move this filter code
outside this if/else before calling prepare_next_entry_data().

The fact that .entries.nr represents the number of entries that are
shown is unusable (because there is an unsorted codepath that does
not even populate .entries), so I am not worried about correctness
gotchas caused by including names in .entries to be filtered out.
But an obvious downside is that the size of the list to be sorted
will become larger.

Or we could introduce a shared helper function that takes a name and
decides if it is to be included, and replace the is_dot_or_dotdot()
call here and in the push_level() with calls to that helper.

In any case, that is primarily a maintainability issue.  The code
posted as-is is correct.

> +			name = de->d_name;
> +		} else {
> +			if (level->entries_idx >= level->entries.nr) {
> +				if (pop_level(iter) == 0)
> +					return dir_iterator_abort(dir_iterator);
> +				continue;
> +			}
> +
> +			name = level->entries.items[level->entries_idx++].string;
> +		}
> +
> +		if (prepare_next_entry_data(iter, name)) {
>  			if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
>  				goto error_out;
>  			continue;
> @@ -188,6 +239,8 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
>  			warning_errno("error closing directory '%s'",
>  				      iter->base.path.buf);
>  		}
> +
> +		string_list_clear(&level->entries, 0);
>  	}
>  
>  	free(iter->levels);
> diff --git a/dir-iterator.h b/dir-iterator.h
> index 479e1ec784..6d438809b6 100644
> --- a/dir-iterator.h
> +++ b/dir-iterator.h
> @@ -54,8 +54,11 @@
>   *   and ITER_ERROR is returned immediately. In both cases, a meaningful
>   *   warning is emitted. Note: ENOENT errors are always ignored so that
>   *   the API users may remove files during iteration.
> + *
> + * - DIR_ITERATOR_SORTED: sort directory entries alphabetically.
>   */
>  #define DIR_ITERATOR_PEDANTIC (1 << 0)
> +#define DIR_ITERATOR_SORTED   (1 << 1)
>  
>  struct dir_iterator {
>  	/* The current path: */
