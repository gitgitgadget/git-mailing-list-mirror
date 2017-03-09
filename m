Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41612202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 12:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754048AbdCIMvg (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 07:51:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:41233 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752737AbdCIMvf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 07:51:35 -0500
Received: (qmail 16832 invoked by uid 109); 9 Mar 2017 12:51:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 12:51:34 +0000
Received: (qmail 32733 invoked by uid 111); 9 Mar 2017 12:51:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 07:51:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Mar 2017 07:51:32 -0500
Date:   Thu, 9 Mar 2017 07:51:32 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] branch & tag: Add a --no-contains option
Message-ID: <20170309125132.tubwxtneffok4nrc@sigill.intra.peff.net>
References: <20170308202025.17900-1-avarab@gmail.com>
 <20170309100910.z4h7bwqzxw2xynyu@sigill.intra.peff.net>
 <CACBZZX53rMiB5-cA_7-SeU2Dt7d_Cr7_GgyC0rjQQPPf4qyCqw@mail.gmail.com>
 <20170309104657.7pwreyozxo2tdhk4@sigill.intra.peff.net>
 <CACBZZX5i+8bQLhLB4DnUAaUw1vA_KQjhtNBvm7drLepPAFFbAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX5i+8bQLhLB4DnUAaUw1vA_KQjhtNBvm7drLepPAFFbAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2017 at 01:12:08PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > I'm almost certain this is because the contains_tag_algo one doesn't
> > clean up the flag bits it sets on the commit objects. So running it
> > twice in the same process is going to give you nonsense results.
> 
> Yeah indeed.
> 
> I tried to hack something up to avoid this, but the
> lookup_commit_reference_gently() we call will return the same
> object.parent pointer for two invocations, i.e. the underlying
> {commit,object}.c API has a cache of objects it returns, couldn't find
> some way to quickly make it burst that cache.

Yeah, you'll always get the same struct for a given sha1.

> The other approach of making contains_tag_algo() itself detect that
> it's been called before (or us passing a flag) and going around
> setting commit.object.flags on everything to 0 seemed even more
> brittle, particularly since I think between filter->with_commit &
> filter->no_commit we might end up visiting different commits, so it's
> not easy to just clear it.

You can clear the marks with clear_object_flags(). But I don't think
that type of solution will quite help us here. We consider each ref
independently and ask "does it match --contains" and "does it match
--no-contains?". So there is no moment where we are done with all of the
--contains marks, and can move on to the --no-contains ones. The lookups
are interleaved.

We could move to doing them in chunks (the way filter->merge_commit
works), and then clearing in between. Or we could use a separate bitset.
The patch below does that.

> I'm happy to hack on it given some pointers, will visit it again, but
> for now unless I'm missing something obvious / you can point out some
> way to hack this up I'll just submit v2 with the combination of
> --contains & --no-contains dying with a TODO message.
> 
> The patch without that functionality is still really useful, and we
> can implement that later.

I'm not opposed to that, though see what you think of the patch below.
It's a bit noisy but it's conceptually pretty straightforward. It should
hopefully be obvious how you'd add in a separate contains_cache for the
"without" case.

Looking at this, I'm pretty sure that using "--contains" with "--merged"
has similar problems, as they both use the UNINTERESTING bit. So even
without your patch, there is a lurking bug.

diff --git a/ref-filter.c b/ref-filter.c
index 3820b21cc..42b1bc463 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -14,6 +14,7 @@
 #include "git-compat-util.h"
 #include "version.h"
 #include "trailer.h"
+#include "commit-slab.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
@@ -1137,10 +1138,22 @@ static void get_ref_atom_value(struct ref_array_item *ref, int atom, struct atom
 	*v = &ref->value[atom];
 }
 
+/*
+ * Unknown has to be "0" here, because that's what unfilled entries in our slab
+ * will return.
+ */
 enum contains_result {
-	CONTAINS_UNKNOWN = -1,
-	CONTAINS_NO = 0,
-	CONTAINS_YES = 1
+	CONTAINS_UNKNOWN = 0,
+	CONTAINS_NO = 1,
+	CONTAINS_YES = 2,
+};
+
+define_commit_slab(contains_cache, enum contains_result);
+
+struct ref_filter_cbdata {
+	struct ref_array *array;
+	struct ref_filter *filter;
+	struct contains_cache contains_cache;
 };
 
 /*
@@ -1171,24 +1184,25 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
  * Do not recurse to find out, though, but return -1 if inconclusive.
  */
 static enum contains_result contains_test(struct commit *candidate,
-			    const struct commit_list *want)
+			    const struct commit_list *want,
+			    struct contains_cache *cache)
 {
-	/* was it previously marked as containing a want commit? */
-	if (candidate->object.flags & TMP_MARK)
-		return 1;
-	/* or marked as not possibly containing a want commit? */
-	if (candidate->object.flags & UNINTERESTING)
-		return 0;
+	enum contains_result *cached = contains_cache_at(cache, candidate);
+
+	/* if we already found the answer, return it without traversing */
+	if (*cached)
+		return *cached;
+
 	/* or are we it? */
 	if (in_commit_list(want, candidate)) {
-		candidate->object.flags |= TMP_MARK;
-		return 1;
+		*cached = CONTAINS_YES;
+		return *cached;
 	}
 
 	if (parse_commit(candidate) < 0)
-		return 0;
+		return CONTAINS_NO;
 
-	return -1;
+	return CONTAINS_UNKNOWN;
 }
 
 static void push_to_contains_stack(struct commit *candidate, struct contains_stack *contains_stack)
@@ -1199,10 +1213,11 @@ static void push_to_contains_stack(struct commit *candidate, struct contains_sta
 }
 
 static enum contains_result contains_tag_algo(struct commit *candidate,
-		const struct commit_list *want)
+					      const struct commit_list *want,
+					      struct contains_cache *cache)
 {
 	struct contains_stack contains_stack = { 0, 0, NULL };
-	int result = contains_test(candidate, want);
+	enum contains_result result = contains_test(candidate, want, cache);
 
 	if (result != CONTAINS_UNKNOWN)
 		return result;
@@ -1214,16 +1229,16 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 		struct commit_list *parents = entry->parents;
 
 		if (!parents) {
-			commit->object.flags |= UNINTERESTING;
+			*contains_cache_at(cache, commit) = CONTAINS_NO;
 			contains_stack.nr--;
 		}
 		/*
 		 * If we just popped the stack, parents->item has been marked,
-		 * therefore contains_test will return a meaningful 0 or 1.
+		 * therefore contains_test will return a meaningful yes/no.
 		 */
-		else switch (contains_test(parents->item, want)) {
+		else switch (contains_test(parents->item, want, cache)) {
 		case CONTAINS_YES:
-			commit->object.flags |= TMP_MARK;
+			*contains_cache_at(cache, commit) = CONTAINS_YES;
 			contains_stack.nr--;
 			break;
 		case CONTAINS_NO:
@@ -1235,13 +1250,14 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 		}
 	}
 	free(contains_stack.contains_stack);
-	return contains_test(candidate, want);
+	return contains_test(candidate, want, cache);
 }
 
-static int commit_contains(struct ref_filter *filter, struct commit *commit)
+static int commit_contains(struct ref_filter *filter, struct commit *commit,
+			   struct contains_cache *cache)
 {
 	if (filter->with_commit_tag_algo)
-		return contains_tag_algo(commit, filter->with_commit);
+		return contains_tag_algo(commit, filter->with_commit, cache) == CONTAINS_YES;
 	return is_descendant_of(commit, filter->with_commit);
 }
 
@@ -1438,7 +1454,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 			return 0;
 		/* We perform the filtering for the '--contains' option */
 		if (filter->with_commit &&
-		    !commit_contains(filter, commit))
+		    !commit_contains(filter, commit, &ref_cbdata->contains_cache))
 			return 0;
 	}
 
@@ -1538,6 +1554,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		broken = 1;
 	filter->kind = type & FILTER_REFS_KIND_MASK;
 
+	init_contains_cache(&ref_cbdata.contains_cache);
+
 	/*  Simple per-ref filtering */
 	if (!filter->kind)
 		die("filter_refs: invalid type");
@@ -1560,6 +1578,7 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 			head_ref(ref_filter_handler, &ref_cbdata);
 	}
 
+	clear_contains_cache(&ref_cbdata.contains_cache);
 
 	/*  Filters that need revision walking */
 	if (filter->merge_commit)
diff --git a/ref-filter.h b/ref-filter.h
index 7b05592ba..89af9f451 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -71,11 +71,6 @@ struct ref_filter {
 		verbose;
 };
 
-struct ref_filter_cbdata {
-	struct ref_array *array;
-	struct ref_filter *filter;
-};
-
 /*  Macros for checking --merged and --no-merged options */
 #define _OPT_MERGED_NO_MERGED(option, filter, h) \
 	{ OPTION_CALLBACK, 0, option, (filter), N_("commit"), (h), \
