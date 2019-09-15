Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8519C1F463
	for <e@80x24.org>; Sun, 15 Sep 2019 16:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387646AbfIOQMq (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 12:12:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:50754 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726147AbfIOQMq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 12:12:46 -0400
Received: (qmail 32734 invoked by uid 109); 15 Sep 2019 16:12:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 15 Sep 2019 16:12:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31991 invoked by uid 111); 15 Sep 2019 16:14:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Sep 2019 12:14:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 15 Sep 2019 12:12:44 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jon Simons <jon@jonsimons.org>, git@vger.kernel.org,
        me@ttaylorr.com, sunshine@sunshineco.com, stolee@gmail.com
Subject: Re: [PATCH 2/3] list-objects-filter: delay parsing of sparse oid
Message-ID: <20190915161244.GA2826@sigill.intra.peff.net>
References: <20190915010942.GA19787@sigill.intra.peff.net>
 <20190915011319.GB11208@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190915011319.GB11208@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 14, 2019 at 09:13:19PM -0400, Jeff King wrote:

> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -63,17 +63,8 @@ static int gently_parse_list_objects_filter(
>  		return 0;
>  
>  	} else if (skip_prefix(arg, "sparse:oid=", &v0)) {
> -		struct object_context oc;
> -		struct object_id sparse_oid;
> -
> -		/*
> -		 * Try to parse <oid-expression> into an OID for the current
> -		 * command, but DO NOT complain if we don't have the blob or
> -		 * ref locally.
> -		 */
> -		if (!get_oid_with_context(the_repository, v0, GET_OID_BLOB,
> -					  &sparse_oid, &oc))
> -			filter_options->sparse_oid_value = oiddup(&sparse_oid);
> +		/* v0 points into filter_options->filter_spec; no allocation needed */
> +		filter_options->sparse_oid_name = v0;

Looks like this comment is no longer true after merging with
md/list-objects-filter-combo, which is in 'next'.

We can obviously deal with it during the merge, but it probably makes
sense to just be more defensive from the start. Here's a revised version
of patch 2, with these changes:

    diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
    index 43f41f446c..adbea552a0 100644
    --- a/list-objects-filter-options.c
    +++ b/list-objects-filter-options.c
    @@ -63,8 +63,7 @@ static int gently_parse_list_objects_filter(
     		return 0;
     
     	} else if (skip_prefix(arg, "sparse:oid=", &v0)) {
    -		/* v0 points into filter_options->filter_spec; no allocation needed */
    -		filter_options->sparse_oid_name = v0;
    +		filter_options->sparse_oid_name = xstrdup(v0);
     		filter_options->choice = LOFC_SPARSE_OID;
     		return 0;
     
    @@ -129,6 +128,7 @@ void list_objects_filter_release(
     	struct list_objects_filter_options *filter_options)
     {
     	free(filter_options->filter_spec);
    +	free(filter_options->sparse_oid_name);
     	memset(filter_options, 0, sizeof(*filter_options));
     }
     
    diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
    index a819e42ffb..20b9d1e587 100644
    --- a/list-objects-filter-options.h
    +++ b/list-objects-filter-options.h
    @@ -42,7 +42,7 @@ struct list_objects_filter_options {
     	 * choice-specific; not all values will be defined for any given
     	 * choice.
     	 */
    -	const char *sparse_oid_name;
    +	char *sparse_oid_name;
     	unsigned long blob_limit_value;
     	unsigned long tree_exclude_depth;
     };

-- >8 --
Subject: [PATCH] list-objects-filter: delay parsing of sparse oid

The list-objects-filter code has two steps to its initialization:

  1. parse_list_objects_filter() makes sure the spec is a filter we know
     about and is syntactically correct. This step is done by "rev-list"
     or "upload-pack" that is going to apply a filter, but also by "git
     clone" or "git fetch" before they send the spec across the wire.

  2. list_objects_filter__init() runs the type-specific initialization
     (using function pointers established in step 1). This happens at
     the start of traverse_commit_list_filtered(), when we're about to
     actually use the filter.

It's a good idea to parse as much as we can in step 1, in order to catch
problems early (e.g., a blob size limit that isn't a number). But one
thing we _shouldn't_ do is resolve any oids at that step (e.g., for
sparse-file contents specified by oid). In the case of a fetch, the oid
has to be resolved on the remote side.

The current code does resolve the oid during the parse phase, but
ignores any error (which we must do, because we might just be sending
the spec across the wire). This leads to two bugs:

  - if we're not in a repository (e.g., because it's git-clone parsing
    the spec), then we trigger a BUG() trying to resolve the name

  - if we did hit the error case, we still have to notice that later and
    bail. The code path in rev-list handles this, but the one in
    upload-pack does not, leading to a segfault.

We can fix both by moving the oid resolution into the sparse-oid init
function. At that point we know we have a repository (because we're
about to traverse), and handling the error there fixes the segfault.

As a bonus, we can drop the NULL sparse_oid_value check in rev-list,
since this is now handled in the sparse-oid-filter init function.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c            |  4 ----
 list-objects-filter-options.c | 14 ++------------
 list-objects-filter-options.h |  2 +-
 list-objects-filter.c         | 11 +++++++++--
 t/t5616-partial-clone.sh      |  4 ++--
 5 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 301ccb970b..74dbfad73d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -471,10 +471,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			parse_list_objects_filter(&filter_options, arg);
 			if (filter_options.choice && !revs.blob_objects)
 				die(_("object filtering requires --objects"));
-			if (filter_options.choice == LOFC_SPARSE_OID &&
-			    !filter_options.sparse_oid_value)
-				die(_("invalid sparse value '%s'"),
-				    filter_options.filter_spec);
 			continue;
 		}
 		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 1cb20c659c..adbea552a0 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -63,17 +63,7 @@ static int gently_parse_list_objects_filter(
 		return 0;
 
 	} else if (skip_prefix(arg, "sparse:oid=", &v0)) {
-		struct object_context oc;
-		struct object_id sparse_oid;
-
-		/*
-		 * Try to parse <oid-expression> into an OID for the current
-		 * command, but DO NOT complain if we don't have the blob or
-		 * ref locally.
-		 */
-		if (!get_oid_with_context(the_repository, v0, GET_OID_BLOB,
-					  &sparse_oid, &oc))
-			filter_options->sparse_oid_value = oiddup(&sparse_oid);
+		filter_options->sparse_oid_name = xstrdup(v0);
 		filter_options->choice = LOFC_SPARSE_OID;
 		return 0;
 
@@ -138,7 +128,7 @@ void list_objects_filter_release(
 	struct list_objects_filter_options *filter_options)
 {
 	free(filter_options->filter_spec);
-	free(filter_options->sparse_oid_value);
+	free(filter_options->sparse_oid_name);
 	memset(filter_options, 0, sizeof(*filter_options));
 }
 
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index c54f0000fb..20b9d1e587 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -42,7 +42,7 @@ struct list_objects_filter_options {
 	 * choice-specific; not all values will be defined for any given
 	 * choice.
 	 */
-	struct object_id *sparse_oid_value;
+	char *sparse_oid_name;
 	unsigned long blob_limit_value;
 	unsigned long tree_exclude_depth;
 };
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 36e1f774bc..d2cdc03a73 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -463,9 +463,16 @@ static void *filter_sparse_oid__init(
 	filter_free_fn *filter_free_fn)
 {
 	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
+	struct object_context oc;
+	struct object_id sparse_oid;
+
+	if (get_oid_with_context(the_repository,
+				 filter_options->sparse_oid_name,
+				 GET_OID_BLOB, &sparse_oid, &oc))
+		die("unable to access sparse blob in '%s'",
+		    filter_options->sparse_oid_name);
 	d->omits = omitted;
-	if (add_excludes_from_blob_to_list(filter_options->sparse_oid_value,
-					   NULL, 0, &d->el) < 0)
+	if (add_excludes_from_blob_to_list(&sparse_oid, NULL, 0, &d->el) < 0)
 		die("could not load filter specification");
 
 	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 0bdbc819f1..84365b802a 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -252,7 +252,7 @@ test_expect_success 'setup src repo for sparse filter' '
 	git -C sparse-src commit -m "add sparse checkout files"
 '
 
-test_expect_failure 'partial clone with sparse filter succeeds' '
+test_expect_success 'partial clone with sparse filter succeeds' '
 	rm -rf dst.git &&
 	git clone --no-local --bare \
 		  --filter=sparse:oid=master:only-one \
@@ -265,7 +265,7 @@ test_expect_failure 'partial clone with sparse filter succeeds' '
 	)
 '
 
-test_expect_failure 'partial clone with unresolvable sparse filter fails cleanly' '
+test_expect_success 'partial clone with unresolvable sparse filter fails cleanly' '
 	rm -rf dst.git &&
 	test_must_fail git clone --no-local --bare \
 				 --filter=sparse:oid=master:no-such-name \
-- 
2.23.0.667.gcccf1fbb03

