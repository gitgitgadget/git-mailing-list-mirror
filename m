Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7503D1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 15:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbeHNSBQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 14:01:16 -0400
Received: from siwi.pair.com ([209.68.5.199]:41891 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbeHNSBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 14:01:16 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 192BB3F400E;
        Tue, 14 Aug 2018 11:13:40 -0400 (EDT)
Received: from [10.160.98.162] (unknown [167.220.148.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C54333F400C;
        Tue, 14 Aug 2018 11:13:39 -0400 (EDT)
Subject: Re: [PATCH v3 5/5] list-objects-filter: implement filter tree:0
To:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org
Cc:     jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com
References: <cover.1533854545.git.matvore@google.com>
 <cover.1534183648.git.matvore@google.com>
 <92faf2e011474bcc87b1b0974e7e232f6469dc4a.1534183648.git.matvore@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d751d56b-84bb-a03d-5f2a-7dbaf8d947cc@jeffhostetler.com>
Date:   Tue, 14 Aug 2018 11:13:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <92faf2e011474bcc87b1b0974e7e232f6469dc4a.1534183648.git.matvore@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/13/2018 2:14 PM, Matthew DeVore wrote:
> Teach list-objects the "tree:0" filter which allows for filtering
> out all tree and blob objects (unless other objects are explicitly
> specified by the user). The purpose of this patch is to allow smaller
> partial clones.
> 
> The name of this filter - tree:0 - does not explicitly specify that
> it also filters out all blobs, but this should not cause much confusion
> because blobs are not at all useful without the trees that refer to
> them.
> 
> I also consider only:commits as a name, but this is inaccurate because
> it suggests that annotated tags are omitted, but actually they are
> included.
> 
> The name "tree:0" allows later filtering based on depth, i.e. "tree:1"
> would filter out all but the root tree and blobs. In order to avoid
> confusion between 0 and capital O, the documentation was worded in a
> somewhat round-about way that also hints at this future improvement to
> the feature.
> 
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---
>   Documentation/rev-list-options.txt     |  3 ++
>   list-objects-filter-options.c          |  4 +++
>   list-objects-filter-options.h          |  1 +
>   list-objects-filter.c                  | 50 ++++++++++++++++++++++++++
>   t/t5317-pack-objects-filter-objects.sh | 27 ++++++++++++++
>   t/t5616-partial-clone.sh               | 27 ++++++++++++++
>   t/t6112-rev-list-filters-objects.sh    | 13 +++++++
>   7 files changed, 125 insertions(+)
> 
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 7b273635d..9e351ec2a 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -743,6 +743,9 @@ specification contained in <path>.
>   	A debug option to help with future "partial clone" development.
>   	This option specifies how missing objects are handled.
>   +
> +The form '--filter=tree:<depth>' omits all blobs and trees deeper than
> +<depth> from the root tree. Currently, only <depth>=0 is supported.
> ++
>   The form '--missing=error' requests that rev-list stop with an error if
>   a missing object is encountered.  This is the default action.
>   +
> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index c0e2bd6a0..a28382940 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -50,6 +50,10 @@ static int gently_parse_list_objects_filter(
>   			return 0;
>   		}
>   
> +	} else if (!strcmp(arg, "tree:0")) {
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
> index a0ba78b20..8e3caf5bf 100644
> --- a/list-objects-filter.c
> +++ b/list-objects-filter.c
> @@ -80,6 +80,55 @@ static void *filter_blobs_none__init(
>   	return d;
>   }
>   
> +/*
> + * A filter for list-objects to omit ALL trees and blobs from the traversal.
> + * Can OPTIONALLY collect a list of the omitted OIDs.
> + */
> +struct filter_trees_none_data {
> +	struct oidset *omits;
> +};
> +
> +static enum list_objects_filter_result filter_trees_none(
> +	enum list_objects_filter_situation filter_situation,
> +	struct object *obj,
> +	const char *pathname,
> +	const char *filename,
> +	void *filter_data_)
> +{
> +	struct filter_trees_none_data *filter_data = filter_data_;
> +
> +	switch (filter_situation) {
> +	default:
> +		die("unknown filter_situation");
> +		return LOFR_ZERO;
> +
> +	case LOFS_BEGIN_TREE:
> +	case LOFS_BLOB:
> +		if (filter_data->omits)
> +			oidset_insert(filter_data->omits, &obj->oid);
> +		return LOFR_MARK_SEEN; /* but not LOFR_DO_SHOW (hard omit) */
> +
> +	case LOFS_END_TREE:
> +		assert(obj->type == OBJ_TREE);
> +		return LOFR_ZERO;
> +
> +	}
> +}

There are a couple of options here:
[] If really want to omit all trees and blobs (and we DO NOT want
    the oidset of everything omitted), then we might be able to
    shortcut the traversal and speed things up.

    {} add a LOFR_SKIP_TREE bit to list_objects_filter_result
    {} test this bit process_tree() and avoid the init_tree_desc() and
       the while loop and some adjacent setup/tear-down code.
    {} make this filter something like:

	case LOFS_BEGIN_TREE:
		if (filter_data->omits) {
			oidset_insert(filter_data->omits, &obj->oid);
			return LOFR_MARK_SEEN; /* ... (hard omit) */
		} else
			return LOFR_SKIP_TREE;
	case LOFS_BLOB:
		if (filter_data->omits) {
			oidset_insert(filter_data->omits, &obj->oid);
			return LOFR_MARK_SEEN; /* ... (hard omit) */
		else
			assert(...should not happen...);

[] Later, if we choose to actually support a depth>0, we'll probably
    want a different filter function to conditionally include/exclude
    blobs, include shallow tree[node]s, and do some of the provisional-
    omit logic on deep tree[nodes] (in case a tree appears at multiple
    places/depths in the history).  But that can wait.

Jeff


> +
> +static void* filter_trees_none__init(
> +	struct oidset *omitted,
> +	struct list_objects_filter_options *filter_options,
> +	filter_object_fn *filter_fn,
> +	filter_free_fn *filter_free_fn)
> +{
> +	struct filter_trees_none_data *d = xcalloc(1, sizeof(*d));
> +	d->omits = omitted;
> +
> +	*filter_fn = filter_trees_none;
> +	*filter_free_fn = free;
> +	return d;
> +}
> +
>   /*
>    * A filter for list-objects to omit large blobs.
>    * And to OPTIONALLY collect a list of the omitted OIDs.
> @@ -374,6 +423,7 @@ static filter_init_fn s_filters[] = {
>   	NULL,
>   	filter_blobs_none__init,
>   	filter_blobs_limit__init,
> +	filter_trees_none__init,
>   	filter_sparse_oid__init,
>   	filter_sparse_path__init,
>   };
> diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
> index 5e35f33bf..65f2cf446 100755
> --- a/t/t5317-pack-objects-filter-objects.sh
> +++ b/t/t5317-pack-objects-filter-objects.sh
> @@ -72,6 +72,33 @@ test_expect_success 'get an error for missing tree object' '
>   	grep -q "bad tree object" bad_tree
>   '
>   
> +test_expect_success 'setup for tests of tree:0' '
> +	mkdir r1/subtree &&
> +	echo "This is a file in a subtree" > r1/subtree/file &&
> +	git -C r1 add subtree/file &&
> +	git -C r1 commit -m subtree
> +'
> +
> +test_expect_success 'verify tree:0 packfile has no blobs or trees' '
> +	git -C r1 pack-objects --rev --stdout --filter=tree:0 >commitsonly.pack <<-EOF &&
> +	HEAD
> +	EOF
> +	git -C r1 index-pack ../commitsonly.pack &&
> +	git -C r1 verify-pack -v ../commitsonly.pack >objs &&
> +	! grep -E "tree|blob" objs
> +'
> +
> +test_expect_success 'grab tree directly when using tree:0' '
> +	# We should get the tree specified directly but not its blobs or subtrees.
> +	git -C r1 pack-objects --rev --stdout --filter=tree:0 >commitsonly.pack <<-EOF &&
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
> index bbbe7537d..fc4d182c0 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -170,6 +170,33 @@ test_expect_success 'partial clone fetches blobs pointed to by refs even if norm
>   	git -C dst fsck
>   '
>   
> +test_expect_success 'can use tree:0 to filter partial clone' '
> +	rm -rf dst &&
> +	git clone --no-checkout --filter=tree:0 "file://$(pwd)/srv.bare" dst &&
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
> index 0a37dd5f9..6ccffddbc 100755
> --- a/t/t6112-rev-list-filters-objects.sh
> +++ b/t/t6112-rev-list-filters-objects.sh
> @@ -196,6 +196,19 @@ test_expect_success 'verify sparse:oid=oid-ish omits top-level files' '
>   	test_cmp observed expected
>   '
>   
> +# Test tree:0 filter.
> +
> +test_expect_success 'verify tree:0 includes trees in "filtered" output' '
> +	git -C r3 rev-list HEAD --quiet --objects --filter-print-omitted --filter=tree:0 \
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
