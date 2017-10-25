Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5836D203F2
	for <e@80x24.org>; Wed, 25 Oct 2017 07:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbdJYHLD (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 03:11:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54191 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751576AbdJYHLC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 03:11:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD791AEF0F;
        Wed, 25 Oct 2017 03:11:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8D16T7pXTv0TH3KAaCdEupxopcg=; b=EBNP+6
        L7UGXMK/00LllJeom1vZtvxiopqTyRSTDZ0owIs655dRhbhJAZBt8/8h218D8IW9
        eOgD4iwjMnp7xIxOoO7l8BSlkxeEt87ivWDZ+4lND+pXnHvjAs4/H1EOb9EXOJSm
        htgjzlZDJO/2+cLuDX3I1wP0m1gvu5IP4uYeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=biCs4OwecPLjBRIajC2aQbrKIZBq6W3w
        cNuJNSYn/+3jySpNjoqCYPsP0Fh45zW1VEujdRnGCug+42y1Mjj4lxfQjjQ30Bej
        MChEZjsW+dCnY/nLDG0VQa/InGfU2LjiCGzXN6Eju7UFZ2bCbmC9PQto7HdlHJJV
        ukSjUDW5G+c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 757DCAEF0E;
        Wed, 25 Oct 2017 03:11:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4864AEF0D;
        Wed, 25 Oct 2017 03:10:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 02/13] list-objects-filter-map: extend oidmap to collect omitted objects
References: <20171024185332.57261-1-git@jeffhostetler.com>
        <20171024185332.57261-3-git@jeffhostetler.com>
Date:   Wed, 25 Oct 2017 16:10:58 +0900
In-Reply-To: <20171024185332.57261-3-git@jeffhostetler.com> (Jeff Hostetler's
        message of "Tue, 24 Oct 2017 18:53:21 +0000")
Message-ID: <xmqqwp3jhfct.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A754847A-B953-11E7-913F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Create helper class to extend oidmap to collect a list of
> omitted or missing objects during traversal.

The reason why oidmap itself cannot be used is because the code
wants to record not just the object name but something else about
the object.  And attributes that the code may care about we can see
in this patch are the object type and the path it found.  

Is the plan to extend this set of attributes over time as different
"omitter"s are added?  Why was "path" chosen as a member of the
initial set and how it will be useful (also, what path would we
record for tags and commits)?

These "future plans" needs revealed upfront, instead of (or in
addition to) "will be used in a later commit".  As it is hard to
judge if "filter map" is an appropriate name for this thing without
knowing _how_ it is envisioned to be used.  "filter map" sounds more
like a map function that is consulted when we decide if we want to
drop the object, but from the looks of the code, it is used more to
record what was done to these objects.

Is it really a "map" (i.e. whose primary focus is to find out what
an object name is "mapped to" when we get an object name---e.g. we
notice an otherwise connected object is missing, and consult this
"map" to learn what the type/path is because we want to do X)?  Or
is it more like a "set of known-to-be-missing object" (i.e. whose
primary point is to serve as a set of object names and what a name
maps to is primarily for debugging)?  These are easier to answer if
we know how it will be used.

> This will be used in a later commit by the list-object filtering
> code.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
> diff --git a/list-objects-filter-map.c b/list-objects-filter-map.c
> new file mode 100644
> index 0000000..7e496b3
> --- /dev/null
> +++ b/list-objects-filter-map.c
> @@ -0,0 +1,63 @@
> +#include "cache.h"
> +#include "list-objects-filter-map.h"
> +
> +int list_objects_filter_map_insert(struct oidmap *map,
> +				   const struct object_id *oid,
> +				   const char *pathname, enum object_type type)
> +{
> +	size_t len, size;
> +	struct list_objects_filter_map_entry *e;
> +
> +	if (oidmap_get(map, oid))
> +		return 1;

It is OK for the existing entry to record a path that is totally
different from what the caller has.  It is hard to judge without
knowing what pathname the callers are expected to call this function
with, but I am guessing that it is similar to the path shown in the
output from "rev-list --objects"---and if that is the case, it is
correct that the same object may be reached at different paths
depending on what tree the traversal begins at, so pathname recorded
in the map is merely "there is one tree somewhere that has this
object at this path".

For that matter, the caller may have a completely different type
from the object we saw earlier; not checking and flagging it as a
possible error makes me feel somewhat uneasy, but there probably is
little you can do at this layer of the code if you noticed such a
discrepancy so it may be OK to punt.

> +	len = ((pathname && *pathname) ? strlen(pathname) : 0);
> +	size = (offsetof(struct list_objects_filter_map_entry, pathname) + len + 1);
> +	e = xcalloc(1, size);
> +
> +	oidcpy(&e->entry.oid, oid);
> +	e->type = type;
> +	if (pathname && *pathname)
> +		strcpy(e->pathname, pathname);
> +
> +	oidmap_put(map, e);
> +	return 0;
> +}

The return value from the function needs to be documented in the
header to help callers.  It is not apparent why "we did already have
one" and "we now newly added" is interesting to the callers, for
example.  An obvious alternative implementation of this function
would return the pointer to an entry that records the object id
(i.e. either the one that was already there, or the one we created
because we saw this object for the first time), so that the caller
can do something interesting to it---again, because the reason why
we want this "filter map" is not explained at this stage, it is hard
to tell what that "sometehing interesting" would be.

> +static int my_cmp(const void *a, const void *b)
> +{
> +	const struct oidmap_entry *ea, *eb;
> +
> +	ea = *(const struct oidmap_entry **)a;
> +	eb = *(const struct oidmap_entry **)b;
> +
> +	return oidcmp(&ea->oid, &eb->oid);
> +}
> +
> +void list_objects_filter_map_foreach(struct oidmap *map,
> +				     list_objects_filter_map_foreach_cb cb,

Name a typedef of a function as something_fn, not something_cb;
something_cb is often the type of a struct to be fed to the callback
function.  And call such a parameter of type something_fn just fn.

> +				     void *cb_data)
> +{
> +	struct hashmap_iter iter;
> +	struct list_objects_filter_map_entry **array;
> +	struct list_objects_filter_map_entry *e;
> +	int k, nr;
> +
> +	nr = hashmap_get_size(&map->map);
> +	if (!nr)
> +		return;
> +
> +	array = xcalloc(nr, sizeof(*e));
> +
> +	k = 0;
> +	hashmap_iter_init(&map->map, &iter);
> +	while ((e = hashmap_iter_next(&iter)))
> +		array[k++] = e;
> +
> +	QSORT(array, nr, my_cmp);

It is entirely unclear why foreach() must return the object names in
order.

> +	for (k = 0; k < nr; k++)
> +		cb(k, nr, array[k], cb_data);

Also it is not clear if you wanted to expose the type of the
entry to the callback function.

An obvious alternative

	fn(&array[k].entry.oid, cb_data);

would allow you to keep the type of map-entry private to the map,
and also the callback does not need to know about k or nr.

I guess you are giving k and nr to allow the callers to do a
progress bar?  If that is the case, that's fine by me.  I still do
not understand why we uncondtionally sort, though.

> +
> +	free(array);
> +}
> diff --git a/list-objects-filter-map.h b/list-objects-filter-map.h
> new file mode 100644
> index 0000000..794fc81
> --- /dev/null
> +++ b/list-objects-filter-map.h
> @@ -0,0 +1,26 @@
> +#ifndef LIST_OBJECTS_FILTER_MAP_H
> +#define LIST_OBJECTS_FILTER_MAP_H
> +
> +#include "oidmap.h"
> +
> +struct list_objects_filter_map_entry {
> +	struct oidmap_entry entry; /* must be first */
> +	enum object_type type;
> +	char pathname[FLEX_ARRAY];
> +};
> +
> +extern int list_objects_filter_map_insert(
> +	struct oidmap *map,
> +	const struct object_id *oid,
> +	const char *pathname, enum object_type type);
> +
> +typedef void (*list_objects_filter_map_foreach_cb)(
> +	int i, int i_limit,
> +	struct list_objects_filter_map_entry *e, void *cb_data);
> +
> +extern void list_objects_filter_map_foreach(
> +	struct oidmap *map,
> +	list_objects_filter_map_foreach_cb cb,
> +	void *cb_data);
> +
> +#endif /* LIST_OBJECTS_FILTER_MAP_H */
