Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C81B28A
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721202261; cv=none; b=Wr40N3q1Hreunyry3Y4juV2mzH6ucOHyc+/jw8yQFGf8Jh/V6ZlShgFHU3JKt0NaiW7HlcGJpowW1yXPr6W8/7xBq8iMKtuGtI2ROkvcjMW1aZfUXdkMdrhwEY8rk51q23Ok0Pxhvdl5cvEqfCdwUh/ZzzpfBqlDQPWsD67eMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721202261; c=relaxed/simple;
	bh=fBnKfdijUAyyAOVXnq2U8mjF3XmCGKSysjPiBVg3wI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5UUErOpcC4Bsg3WIyhK6cNc9b6GHiu2eLi2qYfMOU7ruNGIZfGRm4SaHjiM20zGivNdIV4EgI32wfbjr7uzALW/5Fwv5mItiN8ovKs9RrQaJAPB3IhQnbQkfuMgW4xHrhOuukKqMIfXBIsz75PX6bnGI7ij9Ev8CwgriRldG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24812 invoked by uid 109); 17 Jul 2024 07:44:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Jul 2024 07:44:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19421 invoked by uid 111); 17 Jul 2024 07:44:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Jul 2024 03:44:16 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 17 Jul 2024 03:44:18 -0400
From: Jeff King <peff@peff.net>
To: Jullyana Ramos <jullyana.ramos@microsoft.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: rev-list does not output commit metadata (nor honor --format)
 when --use-bitmap-index is on
Message-ID: <20240717074418.GI547635@coredump.intra.peff.net>
References: <DM4PR21MB3537F74639094ECFA909880C85A52@DM4PR21MB3537.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM4PR21MB3537F74639094ECFA909880C85A52@DM4PR21MB3537.namprd21.prod.outlook.com>

On Thu, Jul 11, 2024 at 06:12:16PM +0000, Jullyana Ramos wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> I ran "git rev-list --use-bitmap-index HEAD" to see history while taking advantage of bitmap index.
> 
> What did you expect to happen? (Expected behavior)
> A list of commits to be output, including their metadata (message, author, etc.)
> 
> What happened instead? (Actual behavior)
> Only the commit SHAs are being output, no matter what I pass to --format.
> Note that this only reproduces if bitmap index has been created for the repository.
> 
> What's different between what you expected and what actually happened?
> The commit metadata is missing.

This is the expected output, but perhaps not by anybody who isn't
familiar with the rev-list and bitmap internals. ;) The --use-bitmap-index
option was introduced to produce answers as quickly as possible, and
typically for "--objects" (where the graph traversal is very expensive).
So it uses its own code paths for printing out the bitmap result. And
notably it will not show the results in any defined order (though I
think in practice it will often follow the order of objects in the pack,
which roughly corresponds with traversal order).

So I don't think anybody gave much thought to what it would do with
--format, or many other options. And then to make things doubly
confusing, --use-bitmap-index is best-effort: if there are no bitmaps,
or we can't load them for some reason, we'll fall back to the existing
code paths. So you would get the formatted output in that case!

So I'd mostly consider this to be a documentation bug (which does
mention one of the caveats, but definitely not the ordering or format
issues). That could certainly be improved.

Alternatively, or in addition, we could perhaps be more careful about
rejecting certain options used with --use-bitmap-index (but enumerating
the complete set feels like a maintenance nightmare).

And finally, we might consider giving more guidance in the documentation
on when to use --use-bitmap-index. If you're going to use --format
anyway, then bitmaps are not buying you much in the first place; you
still have to open every commit object to show it! They might help if
your query requires a lot of traversing but only outputs a few commits
(so "HEAD~3..HEAD" or similar). But I'd actually expect commit graphs to
do just as good a job (or better) these days.

All that said, I think you _could_ make it work as you expect with
something like the patch below. I'm hesitant to pursue that, though, as
it is probably just opening up even more opportunities for confusion
(e.g., --graph will be nonsense in this case due to the ordering issue).

> I do not know if this change was intentional, but I can reproduce the
> issue with version 2.34.1 (Ubuntu) and 2.45.2 (Windows) and I could
> not reproduce it with version 2.3.5 (Windows). (I know, huge gap, my
> apologies) I did make sure this was a Git issue, not a Git for Windows
> issue.  I can reproduce it with a brand new repository. Create a
> commit, run rev-list, commit metadata is there. Generate bitmap index
> and metadata goes missing.

I was surprised that it would have ever worked. But it is just that
2.3.5 predates 4eb707ebd6 (rev-list: allow commit-only bitmap
traversals, 2020-02-14). Before then we skipped bitmap traversal unless
--objects was specified.

But even back then, running "rev-list --use-bitmap-index --objects
--format=medium" would ignore "--format".

-Peff

---
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 97d077a994..ec1dfd8722 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -369,15 +369,32 @@ static int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 	return 0;
 }
 
+/*
+ * Gross hack. The show_reachable_fn type should really take a
+ * void pointer through which we'd pass this.
+ */
+static struct rev_list_info *fast_info;
+
 static int show_object_fast(
 	const struct object_id *oid,
-	enum object_type type UNUSED,
+	enum object_type type,
 	int exclude UNUSED,
 	uint32_t name_hash UNUSED,
 	struct packed_git *found_pack UNUSED,
 	off_t found_offset UNUSED)
 {
-	fprintf(stdout, "%s\n", oid_to_hex(oid));
+	if (fast_info->revs->commit_format == CMIT_FMT_UNSPECIFIED) {
+		fprintf(stdout, "%s\n", oid_to_hex(oid));
+	} else if (type == OBJ_COMMIT) {
+		struct commit *c = lookup_commit(the_repository, oid);
+		parse_commit_or_die(c);
+		show_commit(c, fast_info);
+		return 1;
+	} else {
+		struct object *obj =
+			lookup_object_by_type(the_repository, oid, type);
+		show_object(obj, "", fast_info);
+	}
 	return 1;
 }
 
@@ -472,9 +489,10 @@ static int try_bitmap_count(struct rev_info *revs,
 	return 0;
 }
 
-static int try_bitmap_traversal(struct rev_info *revs,
+static int try_bitmap_traversal(struct rev_list_info *info,
 				int filter_provided_objects)
 {
+	struct rev_info *revs = info->revs;
 	struct bitmap_index *bitmap_git;
 
 	/*
@@ -488,6 +506,7 @@ static int try_bitmap_traversal(struct rev_info *revs,
 	if (!bitmap_git)
 		return -1;
 
+	fast_info = info;
 	traverse_bitmap_commit_list(bitmap_git, revs, &show_object_fast);
 	free_bitmap_index(bitmap_git);
 	return 0;
@@ -729,7 +748,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			goto cleanup;
 		if (!try_bitmap_disk_usage(&revs, filter_provided_objects))
 			goto cleanup;
-		if (!try_bitmap_traversal(&revs, filter_provided_objects))
+		if (!try_bitmap_traversal(&info, filter_provided_objects))
 			goto cleanup;
 	}
 
