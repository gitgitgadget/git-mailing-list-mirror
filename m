Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 817BF1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbeHMTV7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 15:21:59 -0400
Received: from siwi.pair.com ([209.68.5.199]:40009 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbeHMTV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 15:21:59 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0708D3F414A;
        Mon, 13 Aug 2018 12:38:58 -0400 (EDT)
Received: from [10.160.98.162] (unknown [167.220.148.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id AE22E3F400E;
        Mon, 13 Aug 2018 12:38:57 -0400 (EDT)
Subject: Re: [PATCH v2 5/5] list-objects-filter: implement filter tree:none
To:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org
Cc:     jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com
References: <cover.1533941986.git.matvore@google.com>
 <0af4ef64aa52d76a597b4e97c0626c70fb2a883b.1533941986.git.matvore@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ce743b3b-9d60-a6d7-9064-e9272c875e00@jeffhostetler.com>
Date:   Mon, 13 Aug 2018 12:38:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <0af4ef64aa52d76a597b4e97c0626c70fb2a883b.1533941986.git.matvore@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/10/2018 7:06 PM, Matthew DeVore wrote:
> Teach list-objects the "tree:none" filter which allows for filtering
> out all tree and blob objects (unless other objects are explicitly
> specified by the user). The purpose of this patch is to allow smaller
> partial clones.
> 
> The name of this filter - tree:none - does not explicitly specify that
> it also filters out all blobs, but this should not cause much confusion
> because blobs are not at all useful without the trees that refer to
> them.
> 
> I also consider only:commits as a name, but this is inaccurate because
> it suggests that annotated tags are omitted, but actually they are
> included.
> 
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---
>   Documentation/rev-list-options.txt     |  2 ++
>   list-objects-filter-options.c          |  4 +++
>   list-objects-filter-options.h          |  1 +
>   list-objects-filter.c                  | 49 +++++++++++++++++++-------
>   t/t5317-pack-objects-filter-objects.sh | 27 ++++++++++++++
>   t/t5616-partial-clone.sh               | 27 ++++++++++++++
>   t/t6112-rev-list-filters-objects.sh    | 13 +++++++
>   7 files changed, 110 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 7b273635d..68b4b9552 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -743,6 +743,8 @@ specification contained in <path>.
>   	A debug option to help with future "partial clone" development.
>   	This option specifies how missing objects are handled.
>   +
> +The form '--filter=tree:none' omits all blobs and trees.
> ++
>   The form '--missing=error' requests that rev-list stop with an error if
>   a missing object is encountered.  This is the default action.
>   +
> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index c0e2bd6a0..523cb00a0 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -50,6 +50,10 @@ static int gently_parse_list_objects_filter(
>   			return 0;
>   		}
>   
> +	} else if (!strcmp(arg, "tree:none")) {
> +		filter_options->choice = LOFC_TREE_NONE;
> +		return 0;
> +
>   	} else if (skip_prefix(arg, "sparse:oid=", &v0)) {
>   		struct object_context oc;
>   		struct object_id sparse_oid;
> diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
> index 0000a61f8..af64e5c66 100644
> --- a/list-objects-filter-options.h
> +++ b/list-objects-filter-options.h
> @@ -10,6 +10,7 @@ enum list_objects_filter_choice {
>   	LOFC_DISABLED = 0,
>   	LOFC_BLOB_NONE,
>   	LOFC_BLOB_LIMIT,
> +	LOFC_TREE_NONE,
>   	LOFC_SPARSE_OID,
>   	LOFC_SPARSE_PATH,
>   	LOFC__COUNT /* must be last */
> diff --git a/list-objects-filter.c b/list-objects-filter.c
> index a0ba78b20..22c894093 100644
> --- a/list-objects-filter.c
> +++ b/list-objects-filter.c
> @@ -26,38 +26,45 @@
>   #define FILTER_SHOWN_BUT_REVISIT (1<<21)
>   
>   /*
> - * A filter for list-objects to omit ALL blobs from the traversal.
> - * And to OPTIONALLY collect a list of the omitted OIDs.
> + * A filter for list-objects to omit ALL blobs from the traversal, and possibly
> + * trees as well.
> + * Can OPTIONALLY collect a list of the omitted OIDs.
>    */
> -struct filter_blobs_none_data {
> +struct filter_none_of_type_data {
> +	/* blobs are always omitted */
> +	unsigned omit_trees : 1;
>   	struct oidset *omits;
>   };
>   

I'm not sure I'd convert the existing filter types.
When I created this file, I created a set of function pairs
for each filter type:
     filter_<name>() and filter_<name>__init()

with the latter being added to the s_filters[] array and created
a choice enum having corresponding values
     LOFC_<name>

Here you're adding a new _init() and LOFC_ key, but mapping both
the original "blob:none" and the new "tree:none" to a combined
filter function and blends these 2 modes.

Style-wise, I'd keep the original filters as they were and add a
new function pair for the new tree:none filter.  Then you can
simplify the logic inside your new filter.  For example, in your
filter "filter_data->omit_trees" will always be true, so you can
just do the "if (filter_data->omits) oidset_insert(...); return _SEEN"
and not have the fallthru stuff -- or get rid of the asserts() and put
the case labels together.

One of the things I wanted to do (when I found some free time) was to
add a "tree:none" and maybe a "tree:root" filter.  (The latter only
including the root trees associated with the fetched commits, since
there are/were some places where we implicitly also load the root tree
when loading the commit object.)  So in that vein, it might be that we
would want a "tree:<depth>" filter instead with 0 = none and 1 = root.
I wasn't ready to propose that when I did the filtering, but I had that
in mind.  (And is partially why I suggest keeping your new filter
independent of the existing ones.)

Jeff


> -static enum list_objects_filter_result filter_blobs_none(
> +static enum list_objects_filter_result filter_none_of_type(
>   	enum list_objects_filter_situation filter_situation,
>   	struct object *obj,
>   	const char *pathname,
>   	const char *filename,
>   	void *filter_data_)
>   {
> -	struct filter_blobs_none_data *filter_data = filter_data_;
> +	struct filter_none_of_type_data *filter_data = filter_data_;
>   
>   	switch (filter_situation) {
>   	default:
>   		die("unknown filter_situation");
>   		return LOFR_ZERO;
>   
> -	case LOFS_BEGIN_TREE:
> -		assert(obj->type == OBJ_TREE);
> -		/* always include all tree objects */
> -		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> -
>   	case LOFS_END_TREE:
>   		assert(obj->type == OBJ_TREE);
>   		return LOFR_ZERO;
>   
> +	case LOFS_BEGIN_TREE:
> +		assert(obj->type == OBJ_TREE);
> +		if (!filter_data->omit_trees)
> +			return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> +
> +		/*
> +		 * Fallthrough to insert into omitted list for trees as well as
> +		 * blobs.
> +		 */
> +		/* fallthrough */
>   	case LOFS_BLOB:
> -		assert(obj->type == OBJ_BLOB);
>   		assert((obj->flags & SEEN) == 0);
>   
>   		if (filter_data->omits)
> @@ -72,10 +79,25 @@ static void *filter_blobs_none__init(
>   	filter_object_fn *filter_fn,
>   	filter_free_fn *filter_free_fn)
>   {
> -	struct filter_blobs_none_data *d = xcalloc(1, sizeof(*d));
> +	struct filter_none_of_type_data *d = xcalloc(1, sizeof(*d));
> +	d->omits = omitted;
> +
> +	*filter_fn = filter_none_of_type;
> +	*filter_free_fn = free;
> +	return d;
> +}
> +
> +static void* filter_tree_none__init(
> +	struct oidset *omitted,
> +	struct list_objects_filter_options *filter_options,
> +	filter_object_fn *filter_fn,
> +	filter_free_fn *filter_free_fn)
> +{
> +	struct filter_none_of_type_data *d = xcalloc(1, sizeof(*d));
> +	d->omit_trees = 1;
>   	d->omits = omitted;
>   
> -	*filter_fn = filter_blobs_none;
> +	*filter_fn = filter_none_of_type;
>   	*filter_free_fn = free;
>   	return d;
>   }
> @@ -374,6 +396,7 @@ static filter_init_fn s_filters[] = {
>   	NULL,
>   	filter_blobs_none__init,
>   	filter_blobs_limit__init,
> +	filter_tree_none__init,
>   	filter_sparse_oid__init,
>   	filter_sparse_path__init,
>   };
> diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
> index 5e35f33bf..28a8c916a 100755
> --- a/t/t5317-pack-objects-filter-objects.sh
> +++ b/t/t5317-pack-objects-filter-objects.sh
> @@ -72,6 +72,33 @@ test_expect_success 'get an error for missing tree object' '
>   	grep -q "bad tree object" bad_tree
>   '
>   
> +test_expect_success 'setup for tests of tree:none' '
> +	mkdir r1/subtree &&
> +	echo "This is a file in a subtree" > r1/subtree/file &&
> +	git -C r1 add subtree/file &&
> +	git -C r1 commit -m subtree
> +'
> +
> +test_expect_success 'verify tree:none packfile has no blobs or trees' '
> +	git -C r1 pack-objects --rev --stdout --filter=tree:none >commitsonly.pack <<-EOF &&
> +	HEAD
> +	EOF
> +	git -C r1 index-pack ../commitsonly.pack &&
> +	git -C r1 verify-pack -v ../commitsonly.pack >objs &&
> +	! grep -E "tree|blob" objs
> +'
> +
> +test_expect_success 'grab tree directly when using tree:none' '
> +	# We should get the tree specified directly but not its blobs or subtrees.
> +	git -C r1 pack-objects --rev --stdout --filter=tree:none >commitsonly.pack <<-EOF &&
> +	HEAD:
> +	EOF
> +	git -C r1 index-pack ../commitsonly.pack &&
> +	git -C r1 verify-pack -v ../commitsonly.pack >objs &&
> +	grep -E "tree|blob" objs >trees_and_blobs &&
> +	test_line_count = 1 trees_and_blobs
> +'
> +
>   # Test blob:limit=<n>[kmg] filter.
>   # We boundary test around the size parameter.  The filter is strictly less than
>   # the value, so size 500 and 1000 should have the same results, but 1001 should
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index bbbe7537d..4fc068716 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -170,6 +170,33 @@ test_expect_success 'partial clone fetches blobs pointed to by refs even if norm
>   	git -C dst fsck
>   '
>   
> +test_expect_success 'can use tree:none to filter partial clone' '
> +	rm -rf dst &&
> +	git clone --no-checkout --filter=tree:none "file://$(pwd)/srv.bare" dst &&
> +	git -C dst rev-list master --missing=allow-any --objects >fetched_objects &&
> +	cat fetched_objects \
> +		| awk -f print_1.awk \
> +		| xargs -n1 git -C dst cat-file -t >fetched_types &&
> +	sort fetched_types -u >unique_types.observed &&
> +	echo commit > unique_types.expected &&
> +	test_cmp unique_types.observed unique_types.expected
> +'
> +
> +test_expect_success 'show missing tree objects with --missing=print' '
> +	git -C dst rev-list master --missing=print --quiet --objects >missing_objs &&
> +	sed "s/?//" missing_objs \
> +		| xargs -n1 git -C srv.bare cat-file -t \
> +		>missing_types &&
> +	sort -u missing_types >missing_types.uniq &&
> +	echo tree >expected &&
> +	test_cmp missing_types.uniq expected
> +'
> +
> +test_expect_success 'do not complain when a missing tree cannot be parsed' '
> +	git -C dst rev-list master --missing=print --quiet --objects 2>rev_list_err >&2 &&
> +	! grep -q "Could not read " rev_list_err
> +'
> +
>   . "$TEST_DIRECTORY"/lib-httpd.sh
>   start_httpd
>   
> diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
> index 0a37dd5f9..ecdf6b4c3 100755
> --- a/t/t6112-rev-list-filters-objects.sh
> +++ b/t/t6112-rev-list-filters-objects.sh
> @@ -196,6 +196,19 @@ test_expect_success 'verify sparse:oid=oid-ish omits top-level files' '
>   	test_cmp observed expected
>   '
>   
> +# Test tree:none filter.
> +
> +test_expect_success 'verify tree:none includes trees in "filtered" output' '
> +	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=tree:none \
> +		| awk -f print_1.awk \
> +		| sed s/~// \
> +		| xargs -n1 git -C r3 cat-file -t \
> +		| sort -u >filtered_types &&
> +	printf "blob\ntree\n" > expected &&
> +	test_cmp filtered_types expected
> +'
> +
> +
>   # Delete some loose objects and use rev-list, but WITHOUT any filtering.
>   # This models previously omitted objects that we did not receive.
>   
> 
