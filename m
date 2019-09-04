Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF3DA1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 04:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfIDEy0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 00:54:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:38672 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725963AbfIDEy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 00:54:26 -0400
Received: (qmail 17642 invoked by uid 109); 4 Sep 2019 04:54:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Sep 2019 04:54:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11571 invoked by uid 111); 4 Sep 2019 04:56:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Sep 2019 00:56:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Sep 2019 00:54:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jon Simons <jon@jonsimons.org>, git@vger.kernel.org,
        me@ttaylorr.com, sunshine@sunshineco.com, stolee@gmail.com
Subject: Re: [PATCH v3 1/2] list-objects-filter: only parse sparse OID when
 'have_git_dir'
Message-ID: <20190904045424.GA6488@sigill.intra.peff.net>
References: <20190829231925.15223-1-jon@jonsimons.org>
 <20190829231925.15223-2-jon@jonsimons.org>
 <xmqqr252y199.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr252y199.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 30, 2019 at 11:08:34AM -0700, Junio C Hamano wrote:

> Jon Simons <jon@jonsimons.org> writes:
> 
> > diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> > index 1cb20c659c..aaba312edb 100644
> > --- a/list-objects-filter-options.c
> > +++ b/list-objects-filter-options.c
> > @@ -71,7 +71,8 @@ static int gently_parse_list_objects_filter(
> >  		 * command, but DO NOT complain if we don't have the blob or
> >  		 * ref locally.
> >  		 */
> > -		if (!get_oid_with_context(the_repository, v0, GET_OID_BLOB,
> > +		if (have_git_dir() &&
> > +		    !get_oid_with_context(the_repository, v0, GET_OID_BLOB,
> >  					  &sparse_oid, &oc))
> >  			filter_options->sparse_oid_value = oiddup(&sparse_oid);
> >  		filter_options->choice = LOFC_SPARSE_OID;
> 
> Sorry, I do not quite understand what this wants to do.  We say "we
> parsed this correctly, this filter is sparse:oid=<blob>" without
> filling sparse_oid_value field at all.  What do the consumers of
> such a filter_options instance do to such a half-read option?

Empirically, they either die() or segfault. ;)

I agree the code even before Jon's patch is pretty funny. Forgetting the
"not a repo" case for a moment, we know that get_oid_with_context()
might not find the name. In the case of rev-list, we manually check the
validity of sparse_oid_value later and die().  Which seems like a
layering violation, but at least gives the desired outcome.

In the case of clone, it gets parsed twice:

  1. On the client side, we don't have a repo yet, and so we BUG(). But
     once fixed, we don't care about the value at all! We never use it,
     and instead send the original filter spec over to the server, so at
     most this whole option-parsing is giving us an early syntax check.

  2. On the server side, upload-pack receives the filter spec, parses
     it, but doesn't remember to check whether it's a valid oid. It
     segfaults if it isn't (that's patch 2 here).

So these patches are punting on the greater question of why we want to
parse so early, and are not making anything worse. AFAICT, "clone
--filter=sparse:oid" has never worked (even though our tests did cover
the underlying rev-list and pack-objects code paths).

> If they say "ah, the parser wanted to do sparse:oid but we couldn't
> really figure the <blob> part out, so let's ignore it", that might
> be the best they could do anyway, but it somewhat feels iffy.  I
> wonder if we are better off inventing a new "we tried to parse but
> we lack sufficient info to make it useful" value to use in .choice
> field and return it instead.

TBH, I'm not sure why the original is so eager to parse early. I guess
it allows:

  - a dual use of the options parser; we can use it both to sanity-check
    the options before sending them to a server, and to actually use the
    filter ourselves.

  - earlier detection maybe gives us a cleaner error path (e.g.,
    rev-list can do its own error handling). But I'd think doing it when
    we actually initialize the filter would be enough.

I.e., if we want to go all the way, I think this two-patch series could
basically be replaced with something like the (totally untested)
approach below, which just pushes the parsing closer to the
point-of-use.

Adding Jeff Hostetler to the cc, in case he recalls any reason not to
use that approach.

> In the longer term, what do we want to happen in such a case where
> "read this blob to figure out what I want you to do" cannot be
> satisfied due to chicken-and-egg situation like this?  Can we
> postpone fetching or cloning that *wants* to use the named <blob>
> when we discover that the <blob> is not available (of which, your
> "!have_git_dir()" is a subset), grab that single <blob> first from
> the other side before doing the main transfer, and then resume the
> transfer that wants to use the <blob> after we successfully do so,
> or something?

I don't think there's any chicken-and-egg here. The client side of a
clone does not ever care about what's in sparse_oid_value at all, before
or after (and the name needs to be resolved from the server's view of
the refs, anyway). I think there could be a feature where we do a narrow
clone based on the spec in an oid, and then do a matching sparse
checkout. And that feature would want to make sure it knows how the
server resolved the spec in the first step. But AFAIK we don't yet have
such a feature (and the simplest thing would probably be a capability
where the server tells us the blob oid, and makes sure it is
transmitted).

-Peff

---
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
index 1cb20c659c..76a9a49a75 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -63,17 +63,8 @@ static int gently_parse_list_objects_filter(
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
+		/* v0 is durable because it points into our saved filter_spec */
+		filter_options->sparse_oid_name = v0;
 		filter_options->choice = LOFC_SPARSE_OID;
 		return 0;
 
@@ -138,7 +129,6 @@ void list_objects_filter_release(
 	struct list_objects_filter_options *filter_options)
 {
 	free(filter_options->filter_spec);
-	free(filter_options->sparse_oid_value);
 	memset(filter_options, 0, sizeof(*filter_options));
 }
 
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index c54f0000fb..a819e42ffb 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -42,7 +42,7 @@ struct list_objects_filter_options {
 	 * choice-specific; not all values will be defined for any given
 	 * choice.
 	 */
-	struct object_id *sparse_oid_value;
+	const char *sparse_oid_name;
 	unsigned long blob_limit_value;
 	unsigned long tree_exclude_depth;
 };
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 36e1f774bc..130c17b95c 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -463,9 +463,16 @@ static void *filter_sparse_oid__init(
 	filter_free_fn *filter_free_fn)
 {
 	struct filter_sparse_data *d = xcalloc(1, sizeof(*d));
+	struct object_context oc;
+	struct object_id sparse_oid;
+
+	if (!get_oid_with_context(the_repository,
+				  filter_options->sparse_oid_name,
+				  GET_OID_BLOB, &sparse_oid, &oc))
+		die("unable to access sparse blob in '%s'",
+		    filter_options->sparse_oid_name);
 	d->omits = omitted;
-	if (add_excludes_from_blob_to_list(filter_options->sparse_oid_value,
-					   NULL, 0, &d->el) < 0)
+	if (add_excludes_from_blob_to_list(&sparse_oid, NULL, 0, &d->el) < 0)
 		die("could not load filter specification");
 
 	ALLOC_GROW(d->array_frame, d->nr + 1, d->alloc);
