From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/3] small-alloc: add allocator for small objects
Date: Wed, 22 Jun 2011 13:49:25 -0700
Message-ID: <7vk4cd617u.fsf@alter.siamese.dyndns.org>
References: <1308728011-14136-1-git-send-email-davidbarr@google.com>
 <1308728011-14136-3-git-send-email-davidbarr@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 22:49:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZUMj-000533-53
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 22:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758541Ab1FVUtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 16:49:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758155Ab1FVUta (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 16:49:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A060C46DB;
	Wed, 22 Jun 2011 16:51:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DMFohzKpJE7RIlpJ8EzZbvZr/hM=; b=Thy4WZ
	z/wS0DUc3KF/4PdAQZ/LmFJgcMWuqJhivyS9ZIoX+IHgR47Bciad/LL7kaqj87wF
	949Gp1uPa+QzlWoKsl2gW2JvOn+fJaLZwe7159IzTMQuFHAdatWR0IfG71wCOJut
	lZPOblyqm4t8OK3Ghxf4ylK8VPCYHkAqgyY78=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CbUMA7DlLFyW3npUumqxWsyJtb1z42rr
	ioG8XmVg6ODW6I93eK69F5GeWGpF7fec3gCPBQxv80mZ1gZK/utxeILHMqx87dBG
	zyOY77S1IEXUW03G+imKH9DpeT8KJQjXO/KS4EaP017ibUM0EdBuRCdrst1q7Ugg
	puCknnuaqt4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 96A8046DA;
	Wed, 22 Jun 2011 16:51:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7486F46D9; Wed, 22 Jun 2011
 16:51:39 -0400 (EDT)
In-Reply-To: <1308728011-14136-3-git-send-email-davidbarr@google.com> (David
 Barr's message of "Wed, 22 Jun 2011 00:33:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D4C885A-9D11-11E0-ACCB-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176253>

David Barr <davidbarr@google.com> writes:

> This allocator assigns an integer handle to each allocation which
> can be used to retrieve the pointer to the start of the allocation
> and its length.
> On average, the per-allocation memory overhead is twice the length
> of the variable-length-encoding of the allocation size. For objects
> less than 128 bytes in size, this equates to 2 bytes of overhead.

> diff --git a/small-alloc.c b/small-alloc.c
> new file mode 100644
> index 0000000..936884e
> --- /dev/null
> +++ b/small-alloc.c
> @@ -0,0 +1,82 @@
> +#include "git-compat-util.h"
> +#include "cache.h"
> +#include "varint.h"
> +#include "small-alloc.h"
> +
> +static const size_t chunk_size = 2 * 1024 * 1024;
> +
> +void *pool_alloc(struct mem_pool *pool, size_t len, size_t *id_out)
> +{
> +	static size_t id = 1;

Does this mean that even though you can have more than one mem_pool object
active in the system, you won't have id collision throughout the system?
That is a nice property (e.g. given an ID that does not belong to a pool,
you won't risk returning a wrong chunk of <mem,len> pair from pool_ptr()),
but is there a downside using function-scope static like this, I wonder?

For example, if I have two pools A and B, and call pool_alloc on A and
then on B and then on A again, A's space[0] will have the first and the
third object, with id=1 and id=3. How does this interact with your
implementation of pool_ptr() which seems to assume that id's are
consecutive within a single pool->space[]?

> +	size_t n;
> +	void *r;
> +
> +	if ((pool->end - pool->next_free >= len) &&
> +	    (pool->len_free >= sizeof_varint(len)))
> +		n = pool->nr - 1;

Help me make sure I understand what is going on here.

A mem-pool has pool->nr chunks (and it can grow as more memory is asked
from this pool). A new memory request is satisfied by carving out of
pool->space[n] (where n is the "newest chunk" in the pool).
pool->len[n] is a fixed sized byte array and stores the length of each
memory block carved out of pool->space[n] as a sequence of varint.
If pool->space[n] has enough space to fit "len" bytes, and if pool->len[n]
still has enough space to record the length, you use the current chunk,
otherwise (i.e. the else clause) you add a new chunk.

Am I with you so far?

With the chunk_size of 2MB, you would fit roughly 16k allocation requests
for 128-byte memory, and you would need 2-bytes to express the length of
one piece of memory in your varint encoding, i.e. you would need to size
an element of pool->len[] to 32kB if you wanted to store 16k allocation of
128-byte for a chunk.

This would all depend on what the expected distribution of request size,
but it somehow feels wasteful to be limited by both space[] and len[]. If
you chose sizeof(*pool->len) that is too small for the workload, wouldn't
you end up allocating many 2MB space[], only to use potentially very
initial parts of them before len[] fills up?

> +	else {
> +		if ((pool->end - pool->next_free < len)) {
> +			size_t pool_size = chunk_size;
> +			if (len >= (chunk_size/2))
> +				pool_size = len;
> +			pool->total_allocd += pool_size;
> +			pool->next_free = malloc(pool_size);
> +			pool->end = pool->next_free + pool_size;
> +		}
> +		pool->total_allocd += sizeof(*pool->first_id) +
> +				sizeof(*pool->space) +
> +				sizeof(*pool->len);
> +		ALLOC_GROW(pool->first_id, pool->nr + 1, pool->f_alloc);
> +		ALLOC_GROW(pool->len, pool->nr + 1, pool->l_alloc);
> +		ALLOC_GROW(pool->space, pool->nr + 1, pool->s_alloc);
> +		pool->first_id[pool->nr] = id;
> +		pool->len_free = sizeof(*pool->len);
> +		bzero(pool->len[pool->nr], sizeof(*pool->len));
> +		pool->space[pool->nr] = pool->next_free;
> +		n = pool->nr++;
> +	}
> +
> +	if (id_out)
> +		*id_out = id;
> +	id++;
> +
> +	char *t = &pool->len[n][sizeof(*pool->len) - pool->len_free];

Please avoid decl_after_statement.

> +	if (encode_varint(&t, pool->len[n] + sizeof(*pool->len), len))
> +		return NULL;
> +	pool->len_free = pool->len[n] + sizeof(*pool->len) - t;
> +
> +	r = pool->next_free;
> +	pool->next_free += len;
> +	return r;
> +}
> +
> +void *pool_ptr(struct mem_pool *pool, size_t id, size_t *len_out)
> +{
> +	char *r;
> +	const char *t;
> +	uint64_t len = 0, cur;
> +
> +	if (!id || !pool->nr)
> +		return NULL;
> +
> +	size_t n = pool->nr * id / pool->first_id[pool->nr - 1];
> +	if (n >= pool->nr - 1)
> +		n = pool->nr - 1;
> +	while (n && pool->first_id[n] > id)
> +		n--;
> +	while (n + 1 < pool->nr && pool->first_id[n + 1] <= id)
> +		n++;

I was about to say "bsearch?", but perhaps it is not worth it.

> +	if (pool->first_id[n] > id)
> +		return NULL;
> +
> +	cur = pool->first_id[n];
> +	for (r = pool->space[n], t = (const char*) pool->len[n];
> +	     !decode_varint(&t, pool->len[n] + sizeof(*pool->len), &len);
> +	     r += len, cur++)
> +		if (cur == id) {
> +			if (len_out)
> +				*len_out = len;
> +			return r;
> +		}
> +	return NULL;
> +}
> diff --git a/small-alloc.h b/small-alloc.h
> new file mode 100644
> index 0000000..eb77491
> --- /dev/null
> +++ b/small-alloc.h
> @@ -0,0 +1,18 @@
> +#ifndef SMALL_ALLOC_H_
> +#define SMALL_ALLOC_H_
> +
> +struct mem_pool {
> +	size_t *first_id;
> +	char **space;
> +	char (*len)[sizeof(size_t) + sizeof(char*)];

Each element of pool->len[] is just a byte-array that stores varint, no?
It is very misleading to specify its size as sizeof(size_t)+sizeof(char*)
as if you would store a "struct { size_t some; char *thing; }" here.

Instead of having two independently depleted byte-buffer (space[] and
len[]), I wonder if it would be more space efficient (without being less
processing efficient) to use a single buffer space.  Your pool_ptr() would
start at the beginning of pool->space[n], decode a varint and take it as a
length, if that is not the object you are looking for, skip that many
bytes (i.e. payload immediately follows the length) to the next object,
and so on.

Also what kind of alignment guarantee would we _want_ to give the callers?
As far as I can tell, this implementation does not guarantee any alignment.

> +	size_t f_alloc, s_alloc, l_alloc, nr;
> +	char *next_free;
> +	char *end;
> +	int len_free;
> +	size_t total_allocd;
> +};
> +
> +void *pool_alloc(struct mem_pool *pool, size_t len, size_t *id_out);
> +void *pool_ptr(struct mem_pool *pool, size_t id, size_t *len_out);
> +
> +#endif
