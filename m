Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3204BC433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 13:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiJFNNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 09:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJFNNn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 09:13:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC39A59A2
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 06:13:42 -0700 (PDT)
Received: (qmail 12000 invoked by uid 109); 6 Oct 2022 13:13:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Oct 2022 13:13:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26214 invoked by uid 111); 6 Oct 2022 13:13:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Oct 2022 09:13:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 Oct 2022 09:13:41 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/4] attr: convert DEBUG_ATTR to use trace API
Message-ID: <Yz7UhYXvNl6+1GbZ@coredump.intra.peff.net>
References: <Yz7Tjy7Rh8cXVxYQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz7Tjy7Rh8cXVxYQ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If DEBUG_ATTR is defined, we print some debugging information to stderr.
Compared to our usual trace infrastructure, this has a few downsides:

  - it's pretty inaccessible. You have to rebuild Git to enable it
    (compared to setting an environment variable)

  - the code isn't normally built, so it may bitrot. And indeed, it
    doesn't compile with -Werror now (one of the function parameters
    needs to be marked as const).

  - it confuses -Wunused-parameter; the "what" parameter to fill_one()
    is used only by the debug code, which is a noop macro in most builds

We can easily convert this to use the trace API, which solves all of
them. The runtime impact should be minimal, as it introduces only a few
extra conditionals when tracing is disabled.

Signed-off-by: Jeff King <peff@peff.net>
---
The other obvious option is to just delete this debug code, and remove
the unused parameter. I'm not sure if the trace would ever be useful or
not, and I am mostly retaining it out of the logic of "well, somebody
bothered to write it". I think the const issue has been there since
e810e06357 (attr: tighten const correctness with git_attr and
match_attr, 2017-01-27).

 attr.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/attr.c b/attr.c
index 8250b06953..5568294daa 100644
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
@@ -807,12 +803,16 @@ static struct attr_stack *read_attr(struct index_state *istate,
 	return res;
 }
 
-#if DEBUG_ATTR
-static void debug_info(const char *what, struct attr_stack *elem)
+static struct trace_key trace_attr = TRACE_KEY_INIT(ATTR);
+
+static void trace_attr_info(const char *what, struct attr_stack *elem)
 {
-	fprintf(stderr, "%s: %s\n", what, elem->origin ? elem->origin : "()");
+	trace_printf_key(&trace_attr, "%s: %s", what,
+			 elem->origin ? elem->origin : "()");
 }
-static void debug_set(const char *what, const char *match, struct git_attr *attr, const void *v)
+
+static void trace_attr_set(const char *what, const char *match,
+			   const struct git_attr *attr, const void *v)
 {
 	const char *value = v;
 
@@ -823,16 +823,12 @@ static void debug_set(const char *what, const char *match, struct git_attr *attr
 	else if (ATTR_UNSET(value))
 		value = "unspecified";
 
-	fprintf(stderr, "%s: %s => %s (%s)\n",
-		what, attr->name, (char *) value, match);
+	trace_printf_key(&trace_attr, "%s: %s => %s (%s)\n",
+			 what, attr->name, value, match);
 }
-#define debug_push(a) debug_info("push", (a))
-#define debug_pop(a) debug_info("pop", (a))
-#else
-#define debug_push(a) do { ; } while (0)
-#define debug_pop(a) do { ; } while (0)
-#define debug_set(a,b,c,d) do { ; } while (0)
-#endif /* DEBUG_ATTR */
+
+#define trace_attr_push(a) trace_attr_info("push", (a))
+#define trace_attr_pop(a) trace_attr_info("pop", (a))
 
 static const char *git_etc_gitattributes(void)
 {
@@ -954,7 +950,7 @@ static void prepare_attr_stack(struct index_state *istate,
 		    (!namelen || path[namelen] == '/'))
 			break;
 
-		debug_pop(elem);
+		trace_attr_pop(elem);
 		*stack = elem->prev;
 		attr_stack_free(elem);
 	}
@@ -1039,9 +1035,9 @@ static int fill_one(const char *what, struct all_attrs_item *all_attrs,
 		const char *v = a->state[i].setto;
 
 		if (*n == ATTR__UNKNOWN) {
-			debug_set(what,
-				  a->is_macro ? a->u.attr->name : a->u.pat.pattern,
-				  attr, v);
+			trace_attr_set(what,
+				       a->is_macro ? a->u.attr->name : a->u.pat.pattern,
+				       attr, v);
 			*n = v;
 			rem--;
 			rem = macroexpand_one(all_attrs, attr->attr_nr, rem);
-- 
2.38.0.661.g581b1c9920
