Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85AAF20248
	for <e@80x24.org>; Thu, 18 Apr 2019 17:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389754AbfDRR5z (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 13:57:55 -0400
Received: from siwi.pair.com ([209.68.5.199]:56425 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388299AbfDRR5z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 13:57:55 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id DE22F3F408A;
        Thu, 18 Apr 2019 13:57:53 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:e120:4cef:6b87:913e] (unknown [IPv6:2001:4898:8010:0:ca56:4cef:6b87:913e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8D7DA3F4083;
        Thu, 18 Apr 2019 13:57:53 -0400 (EDT)
Subject: Re: [PATCH 07/11] Add a function to determine unique prefixes for a
 list of strings
To:     Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
 <db1ede363645b0620d4924639efe5ec708441aa7.1554917868.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1be9b470-6daa-a50e-ba3a-432520721b0f@jeffhostetler.com>
Date:   Thu, 18 Apr 2019 13:57:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <db1ede363645b0620d4924639efe5ec708441aa7.1554917868.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/10/2019 1:37 PM, Slavica Djukic via GitGitGadget wrote:
> From: Slavica Djukic <slawica92@hotmail.com>
> 
> In the `git add -i` command, we show unique prefixes of the commands and
> files, to give an indication what prefix would select them.
> 
> Naturally, the C implementation looks a lot different than the Perl
> implementation: in Perl, a trie is much easier implemented, while we
> already have a pretty neat hashmap implementation in C that we use for
> the purpose of storing (not necessarily unique) prefixes.
> 
> The idea: for each item that we add, we generate prefixes starting with
> the first letter, then the first two letters, then three, etc, until we
> find a prefix that is unique (or until the prefix length would be
> longer than we want). If we encounter a previously-unique prefix on the
> way, we adjust that item's prefix to make it unique again (or we mark it
> as having no unique prefix if we failed to find one). These partial
> prefixes are stored in a hash map (for quick lookup times).
> 
> To make sure that this function works as expected, we add a test using a
> special-purpose test helper that was added for that purpose.
> 
> Note: We expect the list of prefix items to be passed in as a list of
> pointers rather than as regular list to avoid having to copy information
> (the actual items will most likely contain more information than just
> the name and the length of the unique prefix, but passing in `struct
> prefix_item *` would not allow for that).
> 
> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   Makefile                   |   2 +
>   prefix-map.c               | 111 +++++++++++++++++++++++++++++++++++++
>   prefix-map.h               |  40 +++++++++++++
>   t/helper/test-prefix-map.c |  58 +++++++++++++++++++
>   t/helper/test-tool.c       |   1 +
>   t/helper/test-tool.h       |   1 +
>   t/t0016-prefix-map.sh      |  10 ++++
>   7 files changed, 223 insertions(+)
>   create mode 100644 prefix-map.c
>   create mode 100644 prefix-map.h
>   create mode 100644 t/helper/test-prefix-map.c
>   create mode 100755 t/t0016-prefix-map.sh
> 
> diff --git a/Makefile b/Makefile
> index 18e656a32f..8299b3f17d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -754,6 +754,7 @@ TEST_BUILTINS_OBJS += test-online-cpus.o
>   TEST_BUILTINS_OBJS += test-parse-options.o
>   TEST_BUILTINS_OBJS += test-path-utils.o
>   TEST_BUILTINS_OBJS += test-pkt-line.o
> +TEST_BUILTINS_OBJS += test-prefix-map.o
>   TEST_BUILTINS_OBJS += test-prio-queue.o
>   TEST_BUILTINS_OBJS += test-reach.o
>   TEST_BUILTINS_OBJS += test-read-cache.o
> @@ -967,6 +968,7 @@ LIB_OBJS += patch-ids.o
>   LIB_OBJS += path.o
>   LIB_OBJS += pathspec.o
>   LIB_OBJS += pkt-line.o
> +LIB_OBJS += prefix-map.o
>   LIB_OBJS += preload-index.o
>   LIB_OBJS += pretty.o
>   LIB_OBJS += prio-queue.o
> diff --git a/prefix-map.c b/prefix-map.c
> new file mode 100644
> index 0000000000..3c5ae4ae0a
> --- /dev/null
> +++ b/prefix-map.c
> @@ -0,0 +1,111 @@
> +#include "cache.h"
> +#include "prefix-map.h"
> +
> +static int map_cmp(const void *unused_cmp_data,
> +		   const void *entry,
> +		   const void *entry_or_key,
> +		   const void *unused_keydata)
> +{
> +	const struct prefix_map_entry *a = entry;
> +	const struct prefix_map_entry *b = entry_or_key;
> +
> +	return a->prefix_length != b->prefix_length ||
> +		strncmp(a->name, b->name, a->prefix_length);
> +}
> +
> +static void add_prefix_entry(struct hashmap *map, const char *name,
> +			     size_t prefix_length, struct prefix_item *item)
> +{
> +	struct prefix_map_entry *result = xmalloc(sizeof(*result));
> +	result->name = name;
> +	result->prefix_length = prefix_length;
> +	result->item = item;
> +	hashmap_entry_init(result, memhash(name, prefix_length));
> +	hashmap_add(map, result);
> +}
> +
> +static void init_prefix_map(struct prefix_map *prefix_map,
> +			    int min_prefix_length, int max_prefix_length)
> +{
> +	hashmap_init(&prefix_map->map, map_cmp, NULL, 0);
> +	prefix_map->min_length = min_prefix_length;
> +	prefix_map->max_length = max_prefix_length;
> +}
> +
> +static void add_prefix_item(struct prefix_map *prefix_map,
> +			    struct prefix_item *item)
> +{
> +	struct prefix_map_entry *e = xmalloc(sizeof(*e)), *e2;
> +	int j;
> +
> +	e->item = item;
> +	e->name = e->item->name;
> +
> +	for (j = prefix_map->min_length; j <= prefix_map->max_length; j++) {
> +		if (!isascii(e->name[j])) {

This feels odd, if I understand the intent.

First, why "isascii()" rather than just non-zero?

But mainly, can we walk off the end of the array and read
potentially uninitialized memory?  Shouldn't we have something
at the top of the function like:

     len = strlen(item->name);
     if (len < prefix_map->min_length)
         return;

(And maybe avoid the xmalloc() too?)

And maybe do " j <= min(len, max_length) " in the loop?
But I see you're modifying "j" down in the body of the loop,
so I'll wait on suggesting that.

> +			free(e);
> +			break;
> +		}
> +
> +		e->prefix_length = j;
> +		hashmap_entry_init(e, memhash(e->name, j));
> +		e2 = hashmap_get(&prefix_map->map, e, NULL);
> +		if (!e2) {
> +			/* prefix is unique so far */
> +			e->item->prefix_length = j;
> +			hashmap_add(&prefix_map->map, e);
> +			break;
> +		}
> +
> +		if (!e2->item)
> +			continue; /* non-unique prefix */
> +
> +		if (j != e2->item->prefix_length)
> +			BUG("unexpected prefix length: %d != %d",
> +			    (int)j, (int)e2->item->prefix_length);

IIUC, this assurance comes directly from map_cmp(), right?
We could strengthen this to
      (j != e2->item->prefix_length || strncmp(...))
if we wanted to, right?

> +
> +		/* skip common prefix */
> +		for (; j < prefix_map->max_length && e->name[j]; j++) {
> +			if (e->item->name[j] != e2->item->name[j])
> +				break;

Same comment here about walking off of the defined end of both arrays.

I'm going to stop here.  I'm getting confused.

> +			add_prefix_entry(&prefix_map->map, e->name, j + 1,
> +					 NULL);
> +		}
> +
> +		/* e2 no longer refers to a unique prefix */
> +		if (j < prefix_map->max_length && e2->name[j]) {
> +			/* found a new unique prefix for e2's item */
> +			e2->item->prefix_length = j + 1;
> +			add_prefix_entry(&prefix_map->map, e2->name, j + 1,
> +					 e2->item);
> +		}
> +		else
> +			e2->item->prefix_length = 0;
> +		e2->item = NULL;
> +
> +		if (j < prefix_map->max_length && e->name[j]) {
> +			/* found a unique prefix for the item */
> +			e->item->prefix_length = j + 1;
> +			add_prefix_entry(&prefix_map->map, e->name, j + 1,
> +					 e->item);
> +		} else {
> +			/* item has no (short enough) unique prefix */
> +			e->item->prefix_length = 0;
> +			free(e);
> +		}
> +
> +		break;
> +	}
> +}
> +
> +void find_unique_prefixes(struct prefix_item **list, size_t nr,
> +			  int min_length, int max_length)
> +{
> +	int i;
> +	struct prefix_map prefix_map;
> +
> +	init_prefix_map(&prefix_map, min_length, max_length);
> +	for (i = 0; i < nr; i++)
> +		add_prefix_item(&prefix_map, list[i]);
> +	hashmap_free(&prefix_map.map, 1);
> +}
> diff --git a/prefix-map.h b/prefix-map.h
> new file mode 100644
> index 0000000000..ce3b8a4a32
> --- /dev/null
> +++ b/prefix-map.h
> @@ -0,0 +1,40 @@
> +#ifndef PREFIX_MAP_H
> +#define PREFIX_MAP_H
> +
> +#include "hashmap.h"
> +
> +struct prefix_item {
> +	const char *name;
> +	size_t prefix_length;
> +};
> +
> +struct prefix_map_entry {
> +	struct hashmap_entry e;
> +	const char *name;
> +	size_t prefix_length;
> +	/* if item is NULL, the prefix is not unique */
> +	struct prefix_item *item;
> +};
> +
> +struct prefix_map {
> +	struct hashmap map;
> +	int min_length, max_length;
> +};
> +
> +/*
> + * Find unique prefixes in a given list of strings.
> + *
> + * Typically, the `struct prefix_item` information will be but a field in the
> + * actual item struct; For this reason, the `list` parameter is specified as a
> + * list of pointers to the items.
> + *
> + * The `min_length`/`max_length` parameters define what length the unique
> + * prefixes should have.
> + *
> + * If no unique prefix could be found for a given item, its `prefix_length`
> + * will be set to 0.
> + */
> +void find_unique_prefixes(struct prefix_item **list, size_t nr,
> +			  int min_length, int max_length);
> +
> +#endif
> diff --git a/t/helper/test-prefix-map.c b/t/helper/test-prefix-map.c
> new file mode 100644
> index 0000000000..3f1c90eaf0
> --- /dev/null
> +++ b/t/helper/test-prefix-map.c
> @@ -0,0 +1,58 @@
> +#include "test-tool.h"
> +#include "cache.h"
> +#include "prefix-map.h"
> +
> +static size_t test_count, failed_count;
> +
> +static void check(int succeeded, const char *file, size_t line_no,
> +		  const char *fmt, ...)
> +{
> +	va_list ap;
> +
> +	test_count++;
> +	if (succeeded)
> +		return;
> +
> +	va_start(ap, fmt);
> +	fprintf(stderr, "%s:%d: ", file, (int)line_no);
> +	vfprintf(stderr, fmt, ap);
> +	fputc('\n', stderr);
> +	va_end(ap);
> +
> +	failed_count++;
> +}
> +
> +#define EXPECT_SIZE_T_EQUALS(expect, actual, hint) \
> +	check(expect == actual, __FILE__, __LINE__, \
> +	      "size_t's do not match: %" \
> +	      PRIdMAX " != %" PRIdMAX " (%s) (%s)", \
> +	      (intmax_t)expect, (intmax_t)actual, #actual, hint)
> +
> +int cmd__prefix_map(int argc, const char **argv)
> +{
> +#define NR 5
> +	struct prefix_item items[NR] = {
> +		{ "unique" },
> +		{ "hell" },
> +		{ "hello" },
> +		{ "wok" },
> +		{ "world" },
> +	};
> +	struct prefix_item *list[NR] = {
> +		items, items + 1, items + 2, items + 3, items + 4
> +	};
> +
> +	find_unique_prefixes(list, NR, 1, 3);
> +
> +#define EXPECT_PREFIX_LENGTH_EQUALS(expect, index) \
> +	EXPECT_SIZE_T_EQUALS(expect, list[index]->prefix_length, \
> +			     list[index]->name)
> +
> +	EXPECT_PREFIX_LENGTH_EQUALS(1, 0);
> +	EXPECT_PREFIX_LENGTH_EQUALS(0, 1);
> +	EXPECT_PREFIX_LENGTH_EQUALS(0, 2);
> +	EXPECT_PREFIX_LENGTH_EQUALS(3, 3);
> +	EXPECT_PREFIX_LENGTH_EQUALS(3, 4);
> +
> +	return !!failed_count;
> +}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 99db7409b8..d6a92a8699 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -32,6 +32,7 @@ static struct test_cmd cmds[] = {
>   	{ "parse-options", cmd__parse_options },
>   	{ "path-utils", cmd__path_utils },
>   	{ "pkt-line", cmd__pkt_line },
> +	{ "prefix-map", cmd__prefix_map },
>   	{ "prio-queue", cmd__prio_queue },
>   	{ "reach", cmd__reach },
>   	{ "read-cache", cmd__read_cache },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index 25abed1cf2..33a089ee4e 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -29,6 +29,7 @@ int cmd__online_cpus(int argc, const char **argv);
>   int cmd__parse_options(int argc, const char **argv);
>   int cmd__path_utils(int argc, const char **argv);
>   int cmd__pkt_line(int argc, const char **argv);
> +int cmd__prefix_map(int argc, const char **argv);
>   int cmd__prio_queue(int argc, const char **argv);
>   int cmd__reach(int argc, const char **argv);
>   int cmd__read_cache(int argc, const char **argv);
> diff --git a/t/t0016-prefix-map.sh b/t/t0016-prefix-map.sh
> new file mode 100755
> index 0000000000..187fa92aec
> --- /dev/null
> +++ b/t/t0016-prefix-map.sh
> @@ -0,0 +1,10 @@
> +#!/bin/sh
> +
> +test_description='basic tests for prefix map'
> +. ./test-lib.sh
> +
> +test_expect_success 'prefix map' '
> +	test-tool prefix-map
> +'
> +
> +test_done
> 
