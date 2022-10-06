Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D46DC433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 13:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJFNXs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 09:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiJFNXd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 09:23:33 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88DAA98E6
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 06:23:21 -0700 (PDT)
Received: (qmail 12049 invoked by uid 109); 6 Oct 2022 13:23:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Oct 2022 13:23:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26349 invoked by uid 111); 6 Oct 2022 13:23:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Oct 2022 09:23:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 Oct 2022 09:23:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4alt/4] attr: drop DEBUG_ATTR code
Message-ID: <Yz7Wx4kVbrZFfm0s@coredump.intra.peff.net>
References: <Yz7Tjy7Rh8cXVxYQ@coredump.intra.peff.net>
 <Yz7UhYXvNl6+1GbZ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz7UhYXvNl6+1GbZ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2022 at 09:13:41AM -0400, Jeff King wrote:

> The other obvious option is to just delete this debug code, and remove
> the unused parameter. I'm not sure if the trace would ever be useful or
> not, and I am mostly retaining it out of the logic of "well, somebody
> bothered to write it". I think the const issue has been there since
> e810e06357 (attr: tighten const correctness with git_attr and
> match_attr, 2017-01-27).

And here's what that would look like.

-- >8 --
Subject: [PATCH] attr: drop DEBUG_ATTR code

Since its inception in d0bfd026a8 (Add basic infrastructure to assign
attributes to paths, 2007-04-12), the attribute code carries a little
bit of debug code that is conditionally compiled only when DEBUG_ATTR is
set. But since you have to know about it and make a special build of Git
to use it, it's not clear that it's helping anyone (and there are very
few mentions of it on the list over the years).

Meanwhile, it causes slight headaches. Since it's not built as part of a
regular compile, it's subject to bitrot. E.g., this was dealt with in
712efb1a42 (attr: make it build with DEBUG_ATTR again, 2013-01-15), and
it currently fails to build with DEVELOPER=1 since e810e06357 (attr:
tighten const correctness with git_attr and match_attr, 2017-01-27).

And it causes confusion with -Wunused-parameter; the "what" parameter of
fill_one() is unused in a normal build, but needed in a debug build.

Let's just get rid of this code (and the now-useless parameter).

Signed-off-by: Jeff King <peff@peff.net>
---
 attr.c | 41 +++--------------------------------------
 1 file changed, 3 insertions(+), 38 deletions(-)

diff --git a/attr.c b/attr.c
index 8250b06953..42ad6de8c7 100644
--- a/attr.c
+++ b/attr.c
@@ -23,10 +23,6 @@ static const char git_attr__unknown[] = "(builtin)unknown";
 #define ATTR__UNSET NULL
 #define ATTR__UNKNOWN git_attr__unknown
 
-#ifndef DEBUG_ATTR
-#define DEBUG_ATTR 0
-#endif
-
 struct git_attr {
 	int attr_nr; /* unique attribute number */
 	char name[FLEX_ARRAY]; /* attribute name */
@@ -807,33 +803,6 @@ static struct attr_stack *read_attr(struct index_state *istate,
 	return res;
 }
 
-#if DEBUG_ATTR
-static void debug_info(const char *what, struct attr_stack *elem)
-{
-	fprintf(stderr, "%s: %s\n", what, elem->origin ? elem->origin : "()");
-}
-static void debug_set(const char *what, const char *match, struct git_attr *attr, const void *v)
-{
-	const char *value = v;
-
-	if (ATTR_TRUE(value))
-		value = "set";
-	else if (ATTR_FALSE(value))
-		value = "unset";
-	else if (ATTR_UNSET(value))
-		value = "unspecified";
-
-	fprintf(stderr, "%s: %s => %s (%s)\n",
-		what, attr->name, (char *) value, match);
-}
-#define debug_push(a) debug_info("push", (a))
-#define debug_pop(a) debug_info("pop", (a))
-#else
-#define debug_push(a) do { ; } while (0)
-#define debug_pop(a) do { ; } while (0)
-#define debug_set(a,b,c,d) do { ; } while (0)
-#endif /* DEBUG_ATTR */
-
 static const char *git_etc_gitattributes(void)
 {
 	static const char *system_wide;
@@ -954,7 +923,6 @@ static void prepare_attr_stack(struct index_state *istate,
 		    (!namelen || path[namelen] == '/'))
 			break;
 
-		debug_pop(elem);
 		*stack = elem->prev;
 		attr_stack_free(elem);
 	}
@@ -1028,7 +996,7 @@ static int path_matches(const char *pathname, int pathlen,
 
 static int macroexpand_one(struct all_attrs_item *all_attrs, int nr, int rem);
 
-static int fill_one(const char *what, struct all_attrs_item *all_attrs,
+static int fill_one(struct all_attrs_item *all_attrs,
 		    const struct match_attr *a, int rem)
 {
 	int i;
@@ -1039,9 +1007,6 @@ static int fill_one(const char *what, struct all_attrs_item *all_attrs,
 		const char *v = a->state[i].setto;
 
 		if (*n == ATTR__UNKNOWN) {
-			debug_set(what,
-				  a->is_macro ? a->u.attr->name : a->u.pat.pattern,
-				  attr, v);
 			*n = v;
 			rem--;
 			rem = macroexpand_one(all_attrs, attr->attr_nr, rem);
@@ -1064,7 +1029,7 @@ static int fill(const char *path, int pathlen, int basename_offset,
 				continue;
 			if (path_matches(path, pathlen, basename_offset,
 					 &a->u.pat, base, stack->originlen))
-				rem = fill_one("fill", all_attrs, a, rem);
+				rem = fill_one(all_attrs, a, rem);
 		}
 	}
 
@@ -1076,7 +1041,7 @@ static int macroexpand_one(struct all_attrs_item *all_attrs, int nr, int rem)
 	const struct all_attrs_item *item = &all_attrs[nr];
 
 	if (item->macro && item->value == ATTR__TRUE)
-		return fill_one("expand", all_attrs, item->macro, rem);
+		return fill_one(all_attrs, item->macro, rem);
 	else
 		return rem;
 }
-- 
2.38.0.661.g581b1c9920

