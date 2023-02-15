Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF67FC636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 15:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBOPQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 10:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjBOPQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 10:16:28 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A263A85C
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 07:16:19 -0800 (PST)
Received: (qmail 11687 invoked by uid 109); 15 Feb 2023 15:16:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Feb 2023 15:16:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14346 invoked by uid 111); 15 Feb 2023 15:16:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Feb 2023 10:16:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Feb 2023 10:16:18 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH v2 2/3] shorten_unambiguous_ref(): use NUM_REV_PARSE_RULES
 constant
Message-ID: <Y+z3QgisHZS3l/c1@coredump.intra.peff.net>
References: <Y+z3MtgayoXsxaHA@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+z3MtgayoXsxaHA@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref_rev_parse_rules[] array is terminated with a NULL entry, and we
count it and store the result in the local nr_rules variable. But we
don't need to do so; since the array is a constant, we can compute its
size directly. The original code probably didn't do that because it was
written as part of for-each-ref, and saw the array only as a pointer. It
was migrated in 7c2b3029df (make get_short_ref a public function,
2009-04-07) and could have been updated then, but that subtlety was not
noticed.

We even have a constant that represents this value already, courtesy of
60650a48c0 (remote: make refspec follow the same disambiguation rule as
local refs, 2018-08-01), though again, nobody noticed at the time that
it could be used here, too.

The current count-up isn't a big deal, as we need to preprocess that
array anyway. But it will become more cumbersome as we refactor the
shortening code. So let's get rid of it and just use the constant
everywhere.

Note that there are two things here that aren't just simple text
replacements:

  1. We also use nr_rules to see if a previous call has initialized the
     static pre-processing variables. We can just use the scanf_fmts
     pointer to do the same thing, as it is non-NULL only after we've
     done that initialization.

  2. If nr_rules is zero after we've counted it up, we bail from the
     function. This code is unreachable, though, as the set of rules is
     hard-coded and non-empty. And that becomes even more apparent now
     that we are using the constant. So we can drop this conditional
     completely (and ironically, the code would have the same output if
     it _did_ trigger, as we'd simply skip the loop entirely and return
     the whole refname).

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 94d938390d..84f344d8af 100644
--- a/refs.c
+++ b/refs.c
@@ -1315,11 +1315,10 @@ char *refs_shorten_unambiguous_ref(struct ref_store *refs,
 {
 	int i;
 	static char **scanf_fmts;
-	static int nr_rules;
 	char *short_name;
 	struct strbuf resolved_buf = STRBUF_INIT;
 
-	if (!nr_rules) {
+	if (!scanf_fmts) {
 		/*
 		 * Pre-generate scanf formats from ref_rev_parse_rules[].
 		 * Generate a format suitable for scanf from a
@@ -1329,31 +1328,26 @@ char *refs_shorten_unambiguous_ref(struct ref_store *refs,
 		size_t total_len = 0;
 		size_t offset = 0;
 
-		/* the rule list is NULL terminated, count them first */
-		for (nr_rules = 0; ref_rev_parse_rules[nr_rules]; nr_rules++)
+		for (i = 0; i < NUM_REV_PARSE_RULES; i++)
 			/* -2 for strlen("%.*s") - strlen("%s"); +1 for NUL */
-			total_len += strlen(ref_rev_parse_rules[nr_rules]) - 2 + 1;
+			total_len += strlen(ref_rev_parse_rules[i]) - 2 + 1;
 
-		scanf_fmts = xmalloc(st_add(st_mult(sizeof(char *), nr_rules), total_len));
+		scanf_fmts = xmalloc(st_add(st_mult(sizeof(char *), NUM_REV_PARSE_RULES), total_len));
 
 		offset = 0;
-		for (i = 0; i < nr_rules; i++) {
+		for (i = 0; i < NUM_REV_PARSE_RULES; i++) {
 			assert(offset < total_len);
-			scanf_fmts[i] = (char *)&scanf_fmts[nr_rules] + offset;
+			scanf_fmts[i] = (char *)&scanf_fmts[NUM_REV_PARSE_RULES] + offset;
 			offset += xsnprintf(scanf_fmts[i], total_len - offset,
 					    ref_rev_parse_rules[i], 2, "%s") + 1;
 		}
 	}
 
-	/* bail out if there are no rules */
-	if (!nr_rules)
-		return xstrdup(refname);
-
 	/* buffer for scanf result, at most refname must fit */
 	short_name = xstrdup(refname);
 
 	/* skip first rule, it will always match */
-	for (i = nr_rules - 1; i > 0 ; --i) {
+	for (i = NUM_REV_PARSE_RULES - 1; i > 0 ; --i) {
 		int j;
 		int rules_to_fail = i;
 		size_t short_name_len;
@@ -1368,7 +1362,7 @@ char *refs_shorten_unambiguous_ref(struct ref_store *refs,
 		 * must fail to resolve to a valid non-ambiguous ref
 		 */
 		if (strict)
-			rules_to_fail = nr_rules;
+			rules_to_fail = NUM_REV_PARSE_RULES;
 
 		/*
 		 * check if the short name resolves to a valid ref,
-- 
2.39.2.881.gb6410a20aa

