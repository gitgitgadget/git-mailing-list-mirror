From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Q on
 "index-pack: smarter memory usage during delta resolution, 2008-10-17"
Date: Thu, 03 Feb 2011 00:22:56 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102022330330.12104@xanadu.home>
References: <7vfws6xq5t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 06:23:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkrep-0000z1-9L
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 06:23:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082Ab1BCFW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 00:22:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:17540 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab1BCFW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 00:22:57 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz25.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG100LZA08JS6B0@vl-mh-mrz25.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 03 Feb 2011 00:21:56 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vfws6xq5t.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165950>

On Wed, 2 Feb 2011, Junio C Hamano wrote:

> In find_unresolved_deltas(), there are two loops that walk the range of deltas[]
> array that potentially share the same base object.  One loop for ref-delta
> looks like this:
> 
> 	for (i = ref_first; i <= ref_last; i++) {
> 		struct object_entry *child = objects + deltas[i].obj_no;
> 		if (child->real_type == OBJ_REF_DELTA) {
> 			struct base_data result;
> 			resolve_delta(child, base, &result);
> 			if (i == ref_last && ofs_last == -1)
> 				free_base_data(base);
> 			find_unresolved_deltas(&result, base);
> 		}
> 	}
> 
> I was wondering what happens when the entry at ref_last was a false match
> (i.e. the "union delta_base" happened to have the same 20-byte pattern but
> was of a wrong kind).

I've never seen that in practice.  You'd need at least one object with a 
SHA1 made of 12 trailing zero bytes out of 20 to start with. I'm 
challenging you to find such an object.  ;-)  But let's pretend this may 
happen in theory, and that's why the test is there.

> The other loop for ofs-delta has the same "if (i == ofs_last)" condition.

No, it is not exactly the same.  The first loop walk the deltas list in 
the range of deltas requiring the current object for base by SHA1 
reference.  Once it is done resolving all those deltas it may free this 
base object's memory, but _only_ if it is _not_ also required by the 
second loop.  That is expressed by ofs_last == -1 meaning that the ofs 
range is empty.

The second loop does the same, but in the range of deltas requiring this 
base by offset reference.  Once it is over with it then it may free the 
base right away.

Of course, in practice only one of those 2 loops will actually be 
entered, as only one between the SHA1 ref range or the offset ref range 
will possibly be non empty.

> Admittedly this is rather hard to trigger (you have to find an object
> as a ofs-delta base object, and then come up with another object whose
> object name is the same as the offset of the first base object followed
> by bunch of '\0' and use it as a ref-delta base), and even if it did, it
> will only retain the memory for slightly longer time in the function.

Right.  If you ever manage to create such a condition you're probably up 
for cracking SHA1 entirely.  But for all purposes this is probably never 
going to happen.

> Is a patch along the following line worth doing, I wonder.
> 
> -- >8 --
> Subject: index-pack: group the delta-base array entries also by type
> 
> Entries in the delta_base array are only grouped by the bytepattern in
> the delta_base union, some of which have 20-byte object name of the base
> object (i.e. base for REF_DELTA objects), while others have sizeof(off_t)
> bytes followed by enough NULs to fill 20-byte.  The loops to iterate
> through a range inside this array still needs to inspect the type of the
> delta, and skip over false hits.
> 
> Group the entries also by type to eliminate the potential of false hits.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

If the goal here is to eliminate the cost of the inner test on the 
object type in the loop then I don't think you actually gain anything.  
The same test is moved elsewhere instead (the assertion notwitstanding), 
but in a more costly form as the sort will test that condition more 
often than a linear walk, plus the extra argument passing in a couple 
places.

If instead the goal was to ensure that no delta gets wrongly unresolved 
for whatever reason then this is already covered once at the end with:

                if (nr_deltas != nr_resolved_deltas)
                        die("pack has %d unresolved deltas",
                            nr_deltas - nr_resolved_deltas);

So no, I don't think this patch brings any advantages.

> ---
>  builtin/index-pack.c |   61 ++++++++++++++++++++++++++++++++-----------------
>  1 files changed, 40 insertions(+), 21 deletions(-)
> 
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 8dc5c0b..1b5d83a 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -391,7 +391,18 @@ static void *get_data_from_pack(struct object_entry *obj)
>  	return data;
>  }
>  
> -static int find_delta(const union delta_base *base)
> +static int compare_delta_bases(const union delta_base *base1,
> +			       const union delta_base *base2,
> +			       enum object_type type1,
> +			       enum object_type type2)
> +{
> +	int cmp = type1 - type2;
> +	if (cmp)
> +		return cmp;
> +	return memcmp(base1, base2, UNION_BASE_SZ);
> +}
> +
> +static int find_delta(const union delta_base *base, enum object_type type)
>  {
>  	int first = 0, last = nr_deltas;
>  
> @@ -400,7 +411,8 @@ static int find_delta(const union delta_base *base)
>                  struct delta_entry *delta = &deltas[next];
>                  int cmp;
>  
> -                cmp = memcmp(base, &delta->base, UNION_BASE_SZ);
> +		cmp = compare_delta_bases(base, &delta->base,
> +					  type, objects[delta->obj_no].type);
>                  if (!cmp)
>                          return next;
>                  if (cmp < 0) {
> @@ -413,9 +425,10 @@ static int find_delta(const union delta_base *base)
>  }
>  
>  static void find_delta_children(const union delta_base *base,
> -				int *first_index, int *last_index)
> +				int *first_index, int *last_index,
> +				enum object_type type)
>  {
> -	int first = find_delta(base);
> +	int first = find_delta(base, type);
>  	int last = first;
>  	int end = nr_deltas - 1;
>  
> @@ -543,11 +556,13 @@ static void find_unresolved_deltas(struct base_data *base,
>  		union delta_base base_spec;
>  
>  		hashcpy(base_spec.sha1, base->obj->idx.sha1);
> -		find_delta_children(&base_spec, &ref_first, &ref_last);
> +		find_delta_children(&base_spec,
> +				    &ref_first, &ref_last, OBJ_REF_DELTA);
>  
>  		memset(&base_spec, 0, sizeof(base_spec));
>  		base_spec.offset = base->obj->idx.offset;
> -		find_delta_children(&base_spec, &ofs_first, &ofs_last);
> +		find_delta_children(&base_spec,
> +				    &ofs_first, &ofs_last, OBJ_OFS_DELTA);
>  	}
>  
>  	if (ref_last == -1 && ofs_last == -1) {
> @@ -559,24 +574,24 @@ static void find_unresolved_deltas(struct base_data *base,
>  
>  	for (i = ref_first; i <= ref_last; i++) {
>  		struct object_entry *child = objects + deltas[i].obj_no;
> -		if (child->real_type == OBJ_REF_DELTA) {
> -			struct base_data result;
> -			resolve_delta(child, base, &result);
> -			if (i == ref_last && ofs_last == -1)
> -				free_base_data(base);
> -			find_unresolved_deltas(&result, base);
> -		}
> +		struct base_data result;
> +
> +		assert(child->real_type == OBJ_REF_DELTA);
> +		resolve_delta(child, base, &result);
> +		if (i == ref_last && ofs_last == -1)
> +			free_base_data(base);
> +		find_unresolved_deltas(&result, base);
>  	}
>  
>  	for (i = ofs_first; i <= ofs_last; i++) {
>  		struct object_entry *child = objects + deltas[i].obj_no;
> -		if (child->real_type == OBJ_OFS_DELTA) {
> -			struct base_data result;
> -			resolve_delta(child, base, &result);
> -			if (i == ofs_last)
> -				free_base_data(base);
> -			find_unresolved_deltas(&result, base);
> -		}
> +		struct base_data result;
> +
> +		assert(child->real_type == OBJ_OFS_DELTA);
> +		resolve_delta(child, base, &result);
> +		if (i == ofs_last)
> +			free_base_data(base);
> +		find_unresolved_deltas(&result, base);
>  	}
>  
>  	unlink_base_data(base);
> @@ -586,7 +601,11 @@ static int compare_delta_entry(const void *a, const void *b)
>  {
>  	const struct delta_entry *delta_a = a;
>  	const struct delta_entry *delta_b = b;
> -	return memcmp(&delta_a->base, &delta_b->base, UNION_BASE_SZ);
> +
> +	/* group by type (ref vs ofs) and then by value (sha-1 or offset) */
> +	return compare_delta_bases(&delta_a->base, &delta_b->base,
> +				   objects[delta_a->obj_no].type,
> +				   objects[delta_b->obj_no].type);
>  }
>  
>  /* Parse all objects and return the pack content SHA1 hash */
> 
