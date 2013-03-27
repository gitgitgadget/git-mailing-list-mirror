From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] sha1_file: remove recursion in unpack_entry
Date: Wed, 27 Mar 2013 13:29:23 -0700
Message-ID: <7vli98lh7g.fsf@alter.siamese.dyndns.org>
References: <cover.1364414442.git.trast@inf.ethz.ch>
 <1b5875495c959ba96848fcf9d3067e25e3c1e75b.1364414442.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Stefan Zager <szager@google.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"Nicolas Pitre" <nico@fluxnic.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 27 21:30:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKwyx-00023R-2S
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 21:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578Ab3C0U32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 16:29:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63161 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754563Ab3C0U30 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 16:29:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54D4AA4BD;
	Wed, 27 Mar 2013 16:29:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5rs4VUjAzQ2XPybw3qw2VGrHxzk=; b=jBewZt
	pONgyWp57PaNcJdCv7Y4VgSf3JlQT+rN/+d7Sp00l/b7L/23b6ufaJys+5yZnhR/
	VNmeWp8HNn9GXKEMrwkqY+aMEHu7y55KY8L8snI1YUtxwI4zTUWHuFnXva9gUaZr
	kTQEKANy/XQmW6o1IVhGEBMgwLGjz2ig6TO08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oSXjYiSX6L9As3f0dYLIJKDZ1eblDy1a
	cr96XBjjSlVrBzptPmApjcSHF7U5jWq0iJrXL1q1vtQpL91LuXkbXkDtdOXXO2FD
	GnSljsg36rRG7//3nxA6vDrHJnfGEKvfBuZ+j/m2/Ovf05kr9d3YLCJPWJG60AbB
	020Q8OeYKbg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 490BBA4BC;
	Wed, 27 Mar 2013 16:29:26 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49C13A4BA; Wed, 27 Mar 2013
 16:29:25 -0400 (EDT)
In-Reply-To: <1b5875495c959ba96848fcf9d3067e25e3c1e75b.1364414442.git.trast@inf.ethz.ch>
 (Thomas Rast's message of "Wed, 27 Mar 2013 21:03:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 041923A4-971D-11E2-A217-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219325>

Thomas Rast <trast@student.ethz.ch> writes:

> Similar to the recursion in packed_object_info(), this leads to
> problems on stack-space-constrained systems in the presence of long
> delta chains.
>
> We proceed in three phases:
>
> 1. Dig through the delta chain, saving each delta object's offsets and
>    size on an ad-hoc stack.
>
> 2. Unpack the base object at the bottom.
>
> 3. Unpack and apply the deltas from the stack.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---

Sounds sensible.

Do we keep the packfiles open that hold the deltas involved in the
chain so that they won't be removed by a concurrent repack?  I do
not think this rewrite changes anything with respect to that access
pattern, though.

Will replace and merge to 'next'.  Thanks.

>  sha1_file.c | 231 +++++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 150 insertions(+), 81 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index da41f51..f9191aa 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1943,68 +1943,6 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
>  static void *read_object(const unsigned char *sha1, enum object_type *type,
>  			 unsigned long *size);
>  
> -static void *unpack_delta_entry(struct packed_git *p,
> -				struct pack_window **w_curs,
> -				off_t curpos,
> -				unsigned long delta_size,
> -				off_t obj_offset,
> -				enum object_type *type,
> -				unsigned long *sizep)
> -{
> -	void *delta_data, *result, *base;
> -	unsigned long base_size;
> -	off_t base_offset;
> -
> -	base_offset = get_delta_base(p, w_curs, &curpos, *type, obj_offset);
> -	if (!base_offset) {
> -		error("failed to validate delta base reference "
> -		      "at offset %"PRIuMAX" from %s",
> -		      (uintmax_t)curpos, p->pack_name);
> -		return NULL;
> -	}
> -	unuse_pack(w_curs);
> -	base = cache_or_unpack_entry(p, base_offset, &base_size, type, 0);
> -	if (!base) {
> -		/*
> -		 * We're probably in deep shit, but let's try to fetch
> -		 * the required base anyway from another pack or loose.
> -		 * This is costly but should happen only in the presence
> -		 * of a corrupted pack, and is better than failing outright.
> -		 */
> -		struct revindex_entry *revidx;
> -		const unsigned char *base_sha1;
> -		revidx = find_pack_revindex(p, base_offset);
> -		if (!revidx)
> -			return NULL;
> -		base_sha1 = nth_packed_object_sha1(p, revidx->nr);
> -		error("failed to read delta base object %s"
> -		      " at offset %"PRIuMAX" from %s",
> -		      sha1_to_hex(base_sha1), (uintmax_t)base_offset,
> -		      p->pack_name);
> -		mark_bad_packed_object(p, base_sha1);
> -		base = read_object(base_sha1, type, &base_size);
> -		if (!base)
> -			return NULL;
> -	}
> -
> -	delta_data = unpack_compressed_entry(p, w_curs, curpos, delta_size);
> -	if (!delta_data) {
> -		error("failed to unpack compressed delta "
> -		      "at offset %"PRIuMAX" from %s",
> -		      (uintmax_t)curpos, p->pack_name);
> -		free(base);
> -		return NULL;
> -	}
> -	result = patch_delta(base, base_size,
> -			     delta_data, delta_size,
> -			     sizep);
> -	if (!result)
> -		die("failed to apply delta");
> -	free(delta_data);
> -	add_delta_base_cache(p, base_offset, base, base_size, *type);
> -	return result;
> -}
> -
>  static void write_pack_access_log(struct packed_git *p, off_t obj_offset)
>  {
>  	static FILE *log_file;
> @@ -2025,48 +1963,179 @@ static void write_pack_access_log(struct packed_git *p, off_t obj_offset)
>  
>  int do_check_packed_object_crc;
>  
> +#define UNPACK_ENTRY_STACK_PREALLOC 64
> +struct unpack_entry_stack_ent {
> +	off_t obj_offset;
> +	off_t curpos;
> +	unsigned long size;
> +};
> +
>  void *unpack_entry(struct packed_git *p, off_t obj_offset,
> -		   enum object_type *type, unsigned long *sizep)
> +		   enum object_type *final_type, unsigned long *final_size)
>  {
>  	struct pack_window *w_curs = NULL;
>  	off_t curpos = obj_offset;
> -	void *data;
> +	void *data = NULL;
> +	unsigned long size;
> +	enum object_type type;
> +	struct unpack_entry_stack_ent small_delta_stack[UNPACK_ENTRY_STACK_PREALLOC];
> +	struct unpack_entry_stack_ent *delta_stack = small_delta_stack;
> +	int delta_stack_nr = 0, delta_stack_alloc = UNPACK_ENTRY_STACK_PREALLOC;
> +	int base_from_cache = 0;
>  
>  	if (log_pack_access)
>  		write_pack_access_log(p, obj_offset);
>  
> -	if (do_check_packed_object_crc && p->index_version > 1) {
> -		struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
> -		unsigned long len = revidx[1].offset - obj_offset;
> -		if (check_pack_crc(p, &w_curs, obj_offset, len, revidx->nr)) {
> -			const unsigned char *sha1 =
> -				nth_packed_object_sha1(p, revidx->nr);
> -			error("bad packed object CRC for %s",
> -			      sha1_to_hex(sha1));
> -			mark_bad_packed_object(p, sha1);
> -			unuse_pack(&w_curs);
> -			return NULL;
> +	/* PHASE 1: drill down to the innermost base object */
> +	for (;;) {
> +		off_t base_offset;
> +		int i;
> +		struct delta_base_cache_entry *ent;
> +
> +		if (do_check_packed_object_crc && p->index_version > 1) {
> +			struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
> +			unsigned long len = revidx[1].offset - obj_offset;
> +			if (check_pack_crc(p, &w_curs, obj_offset, len, revidx->nr)) {
> +				const unsigned char *sha1 =
> +					nth_packed_object_sha1(p, revidx->nr);
> +				error("bad packed object CRC for %s",
> +				      sha1_to_hex(sha1));
> +				mark_bad_packed_object(p, sha1);
> +				unuse_pack(&w_curs);
> +				return NULL;
> +			}
> +		}
> +
> +		ent = get_delta_base_cache_entry(p, curpos);
> +		if (eq_delta_base_cache_entry(ent, p, curpos)) {
> +			type = ent->type;
> +			data = ent->data;
> +			size = ent->size;
> +			clear_delta_base_cache_entry(ent);
> +			base_from_cache = 1;
> +			break;
> +		}
> +
> +		type = unpack_object_header(p, &w_curs, &curpos, &size);
> +		if (type != OBJ_OFS_DELTA && type != OBJ_REF_DELTA)
> +			break;
> +
> +		base_offset = get_delta_base(p, &w_curs, &curpos, type, obj_offset);
> +		if (!base_offset) {
> +			error("failed to validate delta base reference "
> +			      "at offset %"PRIuMAX" from %s",
> +			      (uintmax_t)curpos, p->pack_name);
> +			/* bail to phase 2, in hopes of recovery */
> +			data = NULL;
> +			break;
>  		}
> +
> +		/* push object, proceed to base */
> +		if (delta_stack_nr >= delta_stack_alloc
> +		    && delta_stack == small_delta_stack) {
> +			delta_stack_alloc = alloc_nr(delta_stack_nr);
> +			delta_stack = xmalloc(sizeof(*delta_stack)*delta_stack_alloc);
> +			memcpy(delta_stack, small_delta_stack,
> +			       sizeof(*delta_stack)*delta_stack_nr);
> +		} else {
> +			ALLOC_GROW(delta_stack, delta_stack_nr+1, delta_stack_alloc);
> +		}
> +		i = delta_stack_nr++;
> +		delta_stack[i].obj_offset = obj_offset;
> +		delta_stack[i].curpos = curpos;
> +		delta_stack[i].size = size;
> +
> +		curpos = obj_offset = base_offset;
>  	}
>  
> -	*type = unpack_object_header(p, &w_curs, &curpos, sizep);
> -	switch (*type) {
> +	/* PHASE 2: handle the base */
> +	switch (type) {
>  	case OBJ_OFS_DELTA:
>  	case OBJ_REF_DELTA:
> -		data = unpack_delta_entry(p, &w_curs, curpos, *sizep,
> -					  obj_offset, type, sizep);
> +		if (data)
> +			die("BUG in unpack_entry: left loop at a valid delta");
>  		break;
>  	case OBJ_COMMIT:
>  	case OBJ_TREE:
>  	case OBJ_BLOB:
>  	case OBJ_TAG:
> -		data = unpack_compressed_entry(p, &w_curs, curpos, *sizep);
> +		if (!base_from_cache)
> +			data = unpack_compressed_entry(p, &w_curs, curpos, size);
>  		break;
>  	default:
>  		data = NULL;
>  		error("unknown object type %i at offset %"PRIuMAX" in %s",
> -		      *type, (uintmax_t)obj_offset, p->pack_name);
> +		      type, (uintmax_t)obj_offset, p->pack_name);
>  	}
> +
> +	/* PHASE 3: apply deltas in order */
> +
> +	/* invariants:
> +	 *   'data' holds the base data, or NULL if there was corruption
> +	 */
> +	while (delta_stack_nr) {
> +		void *delta_data;
> +		void *base = data;
> +		unsigned long delta_size, base_size = size;
> +		int i;
> +
> +		data = NULL;
> +
> +		if (base)
> +			add_delta_base_cache(p, obj_offset, base, base_size, type);
> +
> +		if (!base) {
> +			/*
> +			 * We're probably in deep shit, but let's try to fetch
> +			 * the required base anyway from another pack or loose.
> +			 * This is costly but should happen only in the presence
> +			 * of a corrupted pack, and is better than failing outright.
> +			 */
> +			struct revindex_entry *revidx;
> +			const unsigned char *base_sha1;
> +			revidx = find_pack_revindex(p, obj_offset);
> +			if (revidx) {
> +				base_sha1 = nth_packed_object_sha1(p, revidx->nr);
> +				error("failed to read delta base object %s"
> +				      " at offset %"PRIuMAX" from %s",
> +				      sha1_to_hex(base_sha1), (uintmax_t)obj_offset,
> +				      p->pack_name);
> +				mark_bad_packed_object(p, base_sha1);
> +				base = read_object(base_sha1, &type, &base_size);
> +			}
> +		}
> +
> +		i = --delta_stack_nr;
> +		obj_offset = delta_stack[i].obj_offset;
> +		curpos = delta_stack[i].curpos;
> +		delta_size = delta_stack[i].size;
> +
> +		if (!base)
> +			continue;
> +
> +		delta_data = unpack_compressed_entry(p, &w_curs, curpos, delta_size);
> +
> +		if (!delta_data) {
> +			error("failed to unpack compressed delta "
> +			      "at offset %"PRIuMAX" from %s",
> +			      (uintmax_t)curpos, p->pack_name);
> +			free(base);
> +			data = NULL;
> +			continue;
> +		}
> +
> +		data = patch_delta(base, base_size,
> +				   delta_data, delta_size,
> +				   &size);
> +		if (!data)
> +			die("failed to apply delta");
> +
> +		free (delta_data);
> +	}
> +
> +	*final_type = type;
> +	*final_size = size;
> +
>  	unuse_pack(&w_curs);
>  	return data;
>  }
